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


@implementation ShoesListViewController

@synthesize contentView;
@synthesize shoesScrollingView;
//@synthesize shoesTableView;
@synthesize progressIndicator;
//@synthesize shoesImage;
@synthesize slideImageView;
@synthesize shoesListView;
@synthesize shoesListCell;
//@synthesize shoesList = _shoesList;
@synthesize shoesDict = _shoesDict;
@synthesize shoesBrandName;
@synthesize shoesStyle;
@synthesize shoesColor;
@synthesize shoesPrice;
@synthesize toolBar;
@synthesize imageArray = _imageArray;
//@synthesize slideMenuViewController;
@synthesize shoesCategoryDict = _shoesCategoryDict;

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



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
  [super viewDidLoad];
  slideImageView.delegate = self;

  //Default shoes list view is table view
  _isTableView = YES;
  
  //Init and add slide button menu Image View
  _shoesCategoryDict = [[OrderedDictionary alloc] init];
  //Setup category for women
  ShoesCategory *category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_WOMEN_NAME/* andXPath:SHOES_CATEGORY_WOMEN_XPATH*/] autorelease];
  category.categoryURI = SHOES_CATEGORY_WOMEN_URI_12ITEM;
	[_shoesCategoryDict setObject: category forKey:SHOES_CATEGORY_WOMEN_NAME];
  //Setup category for men
  //[category autorelease];
  category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_MEN_NAME/* andXPath:SHOES_CATEGORY_MEN_XPATH*/] autorelease];
  category.categoryURI = SHOES_CATEGORY_MEN_URI_12ITEM;
	[_shoesCategoryDict setObject:category forKey:SHOES_CATEGORY_MEN_NAME];
  //Setup category for girls
  //[category autorelease];
  category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_GIRLS_NAME/* andXPath:SHOES_CATEGORY_GIRLS_XPATH*/] autorelease];
  category.categoryURI = SHOES_CATEGORY_GIRLS_URI_12ITEM;
	[_shoesCategoryDict setObject: category forKey:SHOES_CATEGORY_GIRLS_NAME];
  //Setup category for boys
  //[category autorelease];
  category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_BOYS_NAME/* andXPath:SHOES_CATEGORY_BOYS_XPATH*/] autorelease];
  category.categoryURI = SHOES_CATEGORY_BOYS_URI_12ITEM;
	[_shoesCategoryDict setObject:category forKey:SHOES_CATEGORY_BOYS_NAME];

  //Setup category for Juniors
  //[category autorelease];
  category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_JUNIORS_NAME/* andXPath:SHOES_CATEGORY_JUNIORS_XPATH*/] autorelease];
  category.categoryURI = SHOES_CATEGORY_JUNIORS_URI_12ITEM;
	[_shoesCategoryDict setObject:category forKey:SHOES_CATEGORY_JUNIORS_NAME];
  
  //Setup category for bags
  //[category autorelease];
  category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_BAGS_NAME/* andXPath:SHOES_CATEGORY_BAGS_XPATH*/] autorelease];
  category.categoryURI = SHOES_CATEGORY_BAGS_URI_12ITEM;
	[_shoesCategoryDict setObject:category forKey:SHOES_CATEGORY_BAGS_NAME];

  //[self.window addSubview:contentViewController.view];
	//self.slideMenuViewController = [[SlideMenuViewController alloc] initWithCategories:_shoesCategoryDict];
  
  //[self.view addSubview:slideMenuViewController.view];
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
		//[btn release];
	}
	
  self.imageArray = [[images copy] autorelease];
  /*self.slideImageView = [[SlideImageView alloc] initWithFrameColorAndImages:CGRectMake(0.0f, 0.0f, 320.0f,  280.0f) 
                                                            backgroundColor:[UIColor grayColor]  
                                                                     images:self.imageArray];*/
  [self.slideImageView setupImages:self.imageArray];
  //[self.contentView addSubview:self.slideImageView];
  
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

- (void) showShoesList:(NSArray *) shoesArray {

  //Start animation
  //[self startAnimation];
  //[self hideShoesInfoLabels];
  
  
  if(shoesArray != nil){
    [self.shoesDict autorelease];
    self.shoesDict = [[NSMutableDictionary dictionaryWithCapacity:CAPACITY_SHOES_LIST] retain];
    
    if(_shoesArray != nil){
      [_shoesArray release];
      _shoesArray = nil;
    }
    _shoesArray = [shoesArray retain];
  }
  
  //If scrolling view, shows shoes list in scrolling mode
  if (!_isTableView){
    
    int i=0;
  
    for (Shoes *shoes in _shoesArray){
    
      NSString *imageName = shoes.shoesImageName;
      NSString *imageUrl = [NSString stringWithFormat:@"%@%@",MYSHOES_URL,imageName];
    
      NSURL *url = [NSURL URLWithString:imageUrl];
      //NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
  
      UIImage *image = [[UIImage imageWithData: [NSData dataWithContentsOfURL: url]] retain];
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
  [self showShoesList:nil];
}

- (void)dealloc {
  //[slideMenuViewController release];
  //[shoesTableView release];
  //[progressIndicator release];
  [_shoesDict release];
  [_shoesCategoryDict release];
  [_imageArray release];
  [_shoesArray release];
  
  [super dealloc];
}

#pragma mark Table view methods

//Two sections here
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [_shoesArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	static NSString *MyIdentifier = @"MyIdentifier";
	MyIdentifier = @"listViewCell";
  
  /*static NSInteger BrandTag = 1;
  static NSInteger StyleTag = 2;
  static NSInteger ColorTag = 3;
  static NSInteger PriceTag = 4;*/
	
	//ShoesListViewCell *cell = (ShoesListViewCell *)[shoesListView dequeueReusableCellWithIdentifier:MyIdentifier];
  ShoesListViewCell *cell = (ShoesListViewCell *)[shoesListView dequeueReusableCellWithIdentifier:MyIdentifier];
  
	if(cell == nil) {
    /*cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
    
    float indicatorSize = 25;//cell.accessoryView.frame.size.width;
    
    CGRect frame;
    frame.origin.x = 10 + SHOES_LIST_CELL_IMG_WIDTH;
    frame.origin.y = 0;
    frame.size.height = 30;
    frame.size.width = 150;
    
    //Create Lable for BrandName
    UILabel *brandLabel = [[[UILabel alloc] initWithFrame:frame] autorelease];
    brandLabel.tag = BrandTag;
    brandLabel.font = [UIFont fontWithName:@"Helvetica" size:(14.0)];
   [cell.contentView addSubview:brandLabel];
    
    //The position of the Color label
    frame.origin.x = cell.contentView.frame.size.width - 80 - indicatorSize;
    frame.origin.y = 0;
    frame.size.height = 20;
    frame.size.width = 80;   
    //Create Lable for Color
    UILabel *colorLabel = [[[UILabel alloc] initWithFrame:frame] autorelease];
    colorLabel.tag = ColorTag;
    colorLabel.textAlignment = UITextAlignmentRight;
    colorLabel.font = [UIFont fontWithName:@"Helvetica" size:(12.0)];
    [cell.contentView addSubview:colorLabel];
    
    //The position of the Style label
    frame.origin.x = 10 + SHOES_LIST_CELL_IMG_WIDTH;
    frame.origin.y = 30;
    frame.size.height = 30;
    frame.size.width = 150;
    //Create Lable for Style
    UILabel *styleLabel = [[[UILabel alloc] initWithFrame:frame] autorelease];
    styleLabel.tag = StyleTag;
    styleLabel.font = [UIFont fontWithName:@"Helvetica" size:(12.0)];
    [cell.contentView addSubview:styleLabel];
    
    //The position of the price label
    frame.origin.x = cell.contentView.frame.size.width - 80 - indicatorSize;
    frame.origin.y = 20;
    frame.size.height = 40;
    frame.size.width = 80;
    //Create Lable for Style
    UILabel *priceLabel = [[[UILabel alloc] initWithFrame:frame] autorelease];
    priceLabel.tag = PriceTag;
    priceLabel.textAlignment = UITextAlignmentRight;
    priceLabel.font = [UIFont fontWithName:@"Helvetica" size:(20.0)];
    [cell.contentView addSubview:priceLabel];*/
    
    cell = [[[ShoesListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
  
  Shoes *shoes = [_shoesArray objectAtIndex:indexPath.row];
  
	//imageView.image = shoes.shoesImage;
  NSString *imageName = shoes.shoesImageName;
  NSString *imageUrl = [NSString stringWithFormat:@"%@%@",MYSHOES_URL,imageName];
  
  NSURL *url = [NSURL URLWithString:imageUrl];
  //NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
  
  UIImage *shoesImage = [[UIImage imageWithData: [NSData dataWithContentsOfURL: url]] retain];
  
  CGSize sz = SHOES_LIST_IMG_SIZE;
  
  UIImage *resized = [HomeViewController scale:shoesImage toSize:sz];

  cell.imageView.image = resized;

  /*UILabel *brandLabel = (UILabel *)[cell.contentView viewWithTag:BrandTag];
  UILabel *styleLabel = (UILabel *)[cell.contentView viewWithTag:StyleTag];
  UILabel *colorLabel = (UILabel *)[cell.contentView viewWithTag:ColorTag];
  UILabel *priceLabel = (UILabel *)[cell.contentView viewWithTag:PriceTag];
  
  brandLabel.text = shoes.productBrandName;
  styleLabel.text = shoes.productStyle;
  colorLabel.text = shoes.productColor;
  priceLabel.text = shoes.productPrice;*/
  [cell setShoesBrandName:shoes.productBrandName];
  [cell setShoesColor:shoes.productColor];
  [cell setShoesStyle:shoes.productStyle];
  [cell setShoesPrice:shoes.productPrice];
  
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  //Set the Name of the cell is @"Category"
  //[cell setBtnLableTxt:[btnNameArray objectAtIndex:0]];
  MyShoesAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
      
  [delegate.shoesDetailController setShoes:[_shoesArray objectAtIndex:indexPath.row]];
  //[delegate.shoesDetailController loadShoesDetail];
  [self.navigationController pushViewController:delegate.shoesDetailController animated:YES];
      
  //Deselected the selected Row
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return SHOES_LIST_CELL_HEIGHT;//[indexPath row] * 20;
}

@end
