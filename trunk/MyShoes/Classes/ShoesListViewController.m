//
//  MyShoesViewController.m
//  MyShoes
//
//  Created by Denny Ma on 27/01/11.
//  Copyright 2011 Mbi. All rights reserved.
//

#import "MyShoesAppDelegate.h"
#import "ShoesListViewController.h"
#import "HomeViewController.h"
//#import "UIImage+Alpha.h"
//#import "UIImage+Resize.h"
//#import "UIImage+RoundedCorner.h"
#import <QuartzCore/QuartzCore.h>
#import "Shoes.h"
//#import "ShoesTableView.h"
#import "ShoesDataSource.h"
#import "TFHpple.h"
#import "TFHppleElement+AccessChildren.h"


@implementation ShoesListViewController

@synthesize contentView;
@synthesize shoesScrollingView;
//@synthesize shoesTableView;
@synthesize progressIndicator;
//@synthesize shoesImage;
@synthesize slideImageView;
@synthesize shoesListView;
@synthesize shoesListCell;
@synthesize loadMoreSearchResultsCell;
//@synthesize shoesList = _shoesList;
@synthesize shoesDict = _shoesDict;
@synthesize shoesBrandName;
@synthesize shoesStyle;
@synthesize shoesColor;
@synthesize shoesPrice;
@synthesize toolBar;
@synthesize imageArray = _imageArray;
//@synthesize slideMenuViewController;
@synthesize userSelectedCategoriesArray;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self loadShoesList];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
  [super viewDidLoad];
  slideImageView.delegate = self;

  //Default shoes list view is table view
  _isTableView = YES;
  
  //Init and add slide button menu Image View
  _shoesCategoryDict = [[OrderedDictionary alloc] init];
  //Setup category for women
  ShoesCategory *category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_WOMEN_NAME] autorelease];
  category.categoryURI = SHOES_CATEGORY_WOMEN_URI_12ITEM;
	[_shoesCategoryDict setObject: category forKey:SHOES_CATEGORY_WOMEN_NAME];
  //Setup category for men
  category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_MEN_NAME] autorelease];
  category.categoryURI = SHOES_CATEGORY_MEN_URI_12ITEM;
	[_shoesCategoryDict setObject:category forKey:SHOES_CATEGORY_MEN_NAME];
  //Setup category for girls
  category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_GIRLS_NAME] autorelease];
  category.categoryURI = SHOES_CATEGORY_GIRLS_URI_12ITEM;
	[_shoesCategoryDict setObject: category forKey:SHOES_CATEGORY_GIRLS_NAME];
  //Setup category for boys
  category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_BOYS_NAME] autorelease];
  category.categoryURI = SHOES_CATEGORY_BOYS_URI_12ITEM;
	[_shoesCategoryDict setObject:category forKey:SHOES_CATEGORY_BOYS_NAME];

  //Setup category for Juniors
  category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_JUNIORS_NAME] autorelease];
  category.categoryURI = SHOES_CATEGORY_JUNIORS_URI_12ITEM;
	[_shoesCategoryDict setObject:category forKey:SHOES_CATEGORY_JUNIORS_NAME];
  
  //Setup category for bags
  category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_BAGS_NAME] autorelease];
  category.categoryURI = SHOES_CATEGORY_BAGS_URI_12ITEM;
	[_shoesCategoryDict setObject:category forKey:SHOES_CATEGORY_BAGS_NAME];

  //Add slide Image View

  NSMutableArray* images = [NSMutableArray arrayWithCapacity:CAPACITY_SHOES_LIST];
	for(int i=0; i<CATEGORY_SHOES_COUNT; i++)
	{
		// Rounded rect is nice
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-320.0f, 0.0f, 135.0f, 135.0f)];
		
		// Give the buttons a width of 100 and a height of 30. The slide menu will take care of positioning the buttons.
		// If you don't know that 100 will be enough, use my function to calculate the length of a string. You find it on my blog.
		/*[btn setFrame:CGRectMake(0.0f, 20.0f, 50.0f, 50.0f)];
     [btn setTitle:scategoryName forState:UIControlStateNormal];		
     [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];*/
    //imageView.scalesPageToFit = YES;
    imageView.backgroundColor = [UIColor clearColor];
    imageView.layer.cornerRadius = ((imageView.frame.size.width)/135.0f)*SHOES_IMAGE_CORNER_RADIUS;
    imageView.clipsToBounds = YES;
		[images addObject:imageView];
    imageView.contentMode = UIViewContentModeScaleToFill;
    
    //hide all imageview in the very beginning
    imageView.hidden = YES;
		
    [imageView release];
	}

	
  self.imageArray = [images copy];//[[images copy] autorelease];
  /*self.slideImageView = [[SlideImageView alloc] initWithFrameColorAndImages:CGRectMake(0.0f, 0.0f, 320.0f,  280.0f) 
                                                            backgroundColor:[UIColor grayColor]  
                                                                     images:self.imageArray];*/
  [self.slideImageView setupImages:self.imageArray];
  //[self.contentView addSubview:self.slideImageView];
  
  networkTool = [[NetworkTool alloc] init];
  
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void) startAnimation {
  //[shoesTableView setHidden:YES];
  //[self hideShoesInfoLabels];
  slideImageView.hidden = YES;
  progressIndicator.hidden = NO;
  [progressIndicator startAnimating];
}

- (void) stopAnimation {
  [progressIndicator stopAnimating];
  progressIndicator.hidden = YES;
  [UIView beginAnimations:nil context:nil];
  [slideImageView setHidden:YES];
  //[shoesTableView setHidden:YES];
  [UIView commitAnimations];
}

#pragma mark Network related methods
/* Load shoes list from network. Retrieve only part of shoes one time to improve perfomance. */
- (void)loadShoesList {
	//Issue the request of the selected category
  
	[networkTool getContent:[self generateUrl] withDelegate:self requestSelector:@selector(shoesCategoryUdateCallbackWithData:)];
}

/* Generate the intial url to load the first part of shoes list. */
- (NSString *)generateUrl {
  ShoesCategory *firstCategory = [userSelectedCategoriesArray objectAtIndex:0];
  ShoesCategory *secondaryCategory = [userSelectedCategoriesArray objectAtIndex:1];
  NSMutableString *initialUrl = [NSMutableString stringWithFormat:MYSHOES_URL];
  [initialUrl appendString:@"en-US/"];
  
  [initialUrl appendString:firstCategory.categoryName];
  
	[initialUrl appendString:@"/_/_/"];
  
  [initialUrl appendString:secondaryCategory.categoryName];
  
  // Bag's url doesn't has "+Shoes"
  if (firstCategory.categoryName != SHOES_CATEGORY_BAGS_NAME)
  {
    [initialUrl appendString:@"+Shoes"];
  }
     
  [initialUrl appendString:@"/View+12/Products.aspx"];
  
  return initialUrl;
}

- (void)shoesCategoryUdateCallbackWithData: (NSData *) content {
	
  NSMutableArray *shoesList = [NSMutableArray arrayWithCapacity:CAPACITY_SHOES_LIST];
  
	// Create parser
	TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:content];
	
	NSArray *elements  = [xpathParser search:SHOES_CATEGORY_PRODUCT_LIST_XPATH];
	
	// Get the link information within the cell tag
	//NSString *value = [element objectForKey:HREF_TAG];
	//NSString *str;
	
	for (TFHppleElement *element in elements) {
    
    Shoes *shoes = [[[Shoes alloc] initWithShoesNode:element] autorelease];
    [shoesList addObject:shoes];
    
		/*NSArray *children = [element childNodes];
     for (TFHppleElement *child in children) {
     }*/
	}
	
  [_shoesArray release];
  _shoesArray = nil;
  _shoesArray = [shoesList copy];
  
  //Stop Animation
  //MyShoesAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
  
	[xpathParser release];
  
  //If there is any shoes come back, show the first shoes
  if ([_shoesArray count] > 0){
    [self showShoesList];
  }
  [self stopAnimation];
  if ([_shoesArray count] >= 1){
    [self showShoesListInfo:[_shoesArray objectAtIndex:0]];
  }
  
}

- (void) showShoesList/*:(NSArray *) shoesArray*/ {

  //If scrolling view, shows shoes list in scrolling mode
  if (!_isTableView){
    
    int i=0;
  
    for (Shoes *shoes in _shoesArray){
    
      NSString *imageName = shoes.shoesImageName;
      NSString *imageUrlStr = [NSString stringWithFormat:@"%@%@",MYSHOES_URL,imageName];
    
      NSURL *imageUrl = [NSURL URLWithString:imageUrlStr];
      //NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
  
      UIImage *image = [[UIImage imageWithData: [NSData dataWithContentsOfURL: imageUrl]] retain];
      //UIImage *roundImage = [image roundedCornerImage:SHOES_IMAGE_CORNER_RADIUS borderSize:SHOES_IMAGE_BORDER_SIZE];
    
      if (i< [self.imageArray count]){
        UIImageView *imageView;
        imageView = [self.imageArray objectAtIndex:i++];
        //[imageView loadRequest:requestObj];
        imageView.image = image;
      
        imageView.hidden = NO;
      
        //Add shoes imageView pair to shoesDict (key is the imageView)
        [self.shoesDict setObject:shoes forKey:imageView.image];

      }
      [image release];
    }
    
    //[shoesTableView setHidden:YES];
    [shoesListView setHidden:YES];
    [shoesScrollingView setHidden:NO];
    
    /*if ([shoesArray count] >= 1){
     [self showShoesInfo:[shoesArray objectAtIndex:0]];
     }*/
    //[self stopAnimation];
  }
  else{
    
    if(_shoesArray != nil){
      
      /*[shoesTableView removeFromSuperview];

      id shoesSource = [[ShoesDataSource alloc] init];
      [shoesSource setDataSourceShoesArray:_shoesArray];
      
      //shoesTableView.dataSource = shoesSource;

      shoesTableView = [[[ShoesTableView alloc] initWithFrame:CGRectMake(0.0f,0.0f,320.0f,367.0f) 
                                               withDataSource:(id)shoesSource] autorelease];
  
      //[self.contentView addSubview:shoesTableView];
      
      //Get the progress indicator on the top as always.
      [self.contentView insertSubview:shoesTableView belowSubview:progressIndicator ];*/
      shoesListView.dataSource = self;
      shoesListView.delegate = self;
      [shoesListView reloadData];
      [shoesListView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
      [shoesListView setHidden:NO];
      
    }
  
    //[shoesTableView release];
    //Hide scrolling shoes list view
    [shoesScrollingView setHidden:YES];
    //[shoesTableView setHidden:NO];
  }
}

/*- (void)scrollViewDidScroll:(UIImageView *)selectedView{
  //locate the actually shoes selected
  Shoes *shoes = [self.shoesDict objectForKey:selectedView.image];
  
  [self showShoesListInfo:shoes];
}

- (void)scrollViewBeganScroll{
  //When users begin scrolling, hide all the four labels
  [self hideShoesListInfoLabels];
}*/

- (void)showShoesListInfo:(Shoes *)shoes{
  shoesBrandName.text = shoes.productCategory;
  shoesStyle.text = shoes.productStyle;
  shoesColor.text = shoes.productColor;
  shoesPrice.text = shoes.productPrice;
  //Show shoes info
  shoesBrandName.hidden = NO;
  shoesStyle.hidden = NO;
  shoesColor.hidden = NO;
  shoesPrice.hidden = NO;
  
}

- (void)hideShoesListInfoLabels{
  
  //Hide shoes info when changing shoes category
  if(!_isTableView){
    shoesBrandName.hidden = YES;
    shoesStyle.hidden = YES;
    shoesColor.hidden = YES;
    shoesPrice.hidden = YES;
  }
  else{
    //[shoesTableView setHidden:YES]; 
    [shoesListView setHidden:YES];
  }
}

- (void)openSearchView{
  NSLog(@"Gonna open search view");
}

- (void)switchShoesListView{
  NSLog(@"Gonna switch shoes list view from table to scroll images or vice versa");
  if (_isTableView) {
    _isTableView = NO;
  }
  else{
    _isTableView = YES;
  }
  
  //Just refresh the view with existing shoes data
  [self showShoesList/*:nil*/];
}

- (void)dealloc {
  //[slideMenuViewController release];
  //[shoesTableView release];
  //[progressIndicator release];
  [_shoesDict release];
  [_shoesCategoryDict release];
  [_imageArray release];
  [_shoesArray release];
  [networkTool release];
  
  [super dealloc];
}

#pragma mark Table view methods

//Only one section here
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// Return 1 section which will be used to display the giant blank UITableViewCell as defined
	// in the tableView:cellForRowAtIndexPath: method below
	if ([_shoesArray count] == 0){
		
		return 1;
		
	} else if ([_shoesArray count] < CATEGORY_SHOES_COUNT) {
        
		// Add an object to the end of the array for the "Load more..." table cell.
		return [_shoesArray count];
        
	}	
	// Return the number of rows as there are in the searchResults array.
	return [_shoesArray count] + 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	// Special cases:
	// 1: if search results count == 0, display giant blank UITableViewCell, and disable user interaction.
	// 2: if last cell, display the "Load More" search results UITableViewCell.
	
	if ([_shoesArray count] == 0){ // Special Case 1
        
		// Disable user interaction for this cell.
		UITableViewCell *cell = [[[UITableViewCell alloc] init] autorelease]; 
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		return cell;
		
	} else if (indexPath.row == [_shoesArray count]){ // Special Case 2		
		static NSString *loadMoreIdentifier = @"LoadMoreResultsCell";
		LoadMoreSearchResultsTableViewCell *cell = (LoadMoreSearchResultsTableViewCell *) [tableView dequeueReusableCellWithIdentifier:loadMoreIdentifier];
		if (cell == nil) {
			cell = [[[LoadMoreSearchResultsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:loadMoreIdentifier] autorelease];
			//cell.textLabel.text = @"Load More Results...";
            
            self.loadMoreSearchResultsCell = cell;
            
		}
		
		// Return a standard cell
		cell.textLabel.text = @"Load More Results...";

    cell.textLabel.textAlignment = UITextAlignmentCenter;
		return cell;
		
	}
    
//    static NSString *CellIdentifier = @"SearchResultsCell";
//    
//	SearchResultsTableViewCell *cell = (SearchResultsTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//		[[NSBundle mainBundle] loadNibNamed:@"SearchResultsTableCell" owner:self options:nil];
//		cell = self.searchResultsCell;
//    }

    
	static NSString *MyIdentifier = @"MyIdentifier";
	
  ShoesListViewCell *cell = (ShoesListViewCell *)[shoesListView dequeueReusableCellWithIdentifier:MyIdentifier];
  
	if(cell == nil) {
    
    cell = [[[ShoesListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
  
  Shoes *shoes = [_shoesArray objectAtIndex:indexPath.row];
  
	//imageView.image = shoes.shoesImage;
  NSString *imageName = shoes.shoesImageName;
  NSString *imageUrlStr = [NSString stringWithFormat:@"%@%@",MYSHOES_URL,imageName];
  
  NSURL *imageUrl = [NSURL URLWithString:imageUrlStr];
  //NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
  
  UIImage *shoesImage = [UIImage imageWithData: [NSData dataWithContentsOfURL: imageUrl]];
  
  CGSize sz = SHOES_LIST_IMG_SIZE;
  
  UIImage *resized = [HomeViewController scale:shoesImage toSize:sz];

  cell.imageView.image = resized;

  [cell setShoesBrandName:shoes.productBrandName];
  [cell setShoesColor:shoes.productColor];
  [cell setShoesStyle:shoes.productStyle];
  [cell setShoesPrice:shoes.productPrice];
  
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if ([_shoesArray count] == 0){
		return;
		
        // Special Case for the "Load More Results..." button for paging.
	} else if (indexPath.row == [_shoesArray count]) {
        
		// Register for the notification
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(employeeDataReceived:)
													 name:@"WebServiceCallCompleted" object:nil];        
	} else {
        
		// Slide in the a details view.
      //Set the Name of the cell is @"Category"
        MyShoesAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
            
        [delegate.shoesDetailController setShoes:[_shoesArray objectAtIndex:indexPath.row]];
        [self.navigationController pushViewController:delegate.shoesDetailController animated:YES];
            
        //Deselected the selected Row
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
  }
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return SHOES_LIST_CELL_HEIGHT;//[indexPath row] * 20;
}

@end
