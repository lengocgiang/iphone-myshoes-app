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
#import <QuartzCore/QuartzCore.h>
#import "Shoes.h"
#import "TFHpple.h"
#import "TFHppleElement+AccessChildren.h"
#import "HJManagedImageV.h"


@implementation ShoesListViewController

@synthesize contentView;
@synthesize shoesScrollingView;
@synthesize progressIndicator;
@synthesize shoesListView;
@synthesize shoesListCell;
@synthesize loadMoreSearchResultsCell;
@synthesize shoesDict = _shoesDict;
@synthesize imageArray = _imageArray;
@synthesize userSelectedCategoriesArray;
@synthesize viewRest;

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
  
  //If the view has been reset, load the list online
  if (viewRest){
    [_shoesArray removeAllObjects];
    [shoesListView reloadData];
    currentPages = 1;
    [self loadShoesList];
    
    viewRest = FALSE;
  }
  else{
    //Show the list directly
//    [shoesListView reloadData];
//    currentPages = 1;
  }
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
  [super viewDidLoad];
  
  //Init the value of viewReset
  viewRest = TRUE;
  
  
  //Default shoes list view is table view
  _isTableView = YES;
  
  networkTool = [[NetworkTool alloc] init];
  
  _shoesArray = [[NSMutableArray alloc] init];
  
  objMan = [[HJObjManager alloc] init];  
  NSString* cacheDirectory = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/imgcache/myshoes/"] ;
  HJMOFileCache* fileCache = [[[HJMOFileCache alloc] initWithRootPath:cacheDirectory] autorelease];
  objMan.fileCache = fileCache;
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
  [super viewDidUnload];

  [networkTool release];
  [_shoesArray release];
  [objMan release];
}

- (void) startAnimation {
  progressIndicator.hidden = NO;
  [progressIndicator startAnimating];
}

- (void) stopAnimation {
  [progressIndicator stopAnimating];
  progressIndicator.hidden = YES;
  [UIView beginAnimations:nil context:nil];
  [UIView commitAnimations];
}

#pragma mark Network related methods
/* Load shoes list from network. Retrieve only part of shoes one time to improve perfomance. */
- (void)loadShoesList {
  HUD = [[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES] retain];
  HUD.labelText = @"Fetching Shoes";
  
	//Issue the request of the selected category
	[networkTool getContent:[self generateUrl] withDelegate:self requestSelector:@selector(shoesCategoryUdateCallbackWithData:)];
}

/* Generate the url to load the next page of shoes list. */
- (NSString *)generateUrl {
  ShoesCategory *firstCategory = [userSelectedCategoriesArray objectAtIndex:0];
  ShoesCategory *secondaryCategory = [userSelectedCategoriesArray objectAtIndex:1];
  NSMutableString *url = [NSMutableString stringWithFormat:MYSHOES_URL];
  [url appendString:@"en-US/"];
  
  [url appendString:firstCategory.categoryName];
  
	[url appendString:@"/_/_/"];
  
  [url appendString:secondaryCategory.categoryName];
  
  // Bag's url doesn't has "+Shoes"
  if (firstCategory.categoryName != SHOES_CATEGORY_BAGS_NAME)
  {
    [url appendString:@"+Shoes"];
  }
  
  [url appendString:@"/View+"];
  [url appendString:[NSString stringWithFormat:@"%d", CATEGORY_SHOES_COUNT]];
  if (currentPages != 1)
  {
    [url appendString:@"-Num+"];
    [url appendString:[NSString stringWithFormat:@"%d", CATEGORY_SHOES_COUNT * (currentPages - 1)]];
  }
  [url appendString:@"/Products.aspx"];
  
  return url;
}

- (void)shoesCategoryUdateCallbackWithData: (NSData *) content {
	[HUD hide:YES];
  
	//debug_NSLog(@"%@",[[[NSString alloc] initWithData:content encoding:NSASCIIStringEncoding] autorelease]);
  NSMutableArray *shoesList = [NSMutableArray arrayWithCapacity:CAPACITY_SHOES_LIST];
  
	// Create parser
	TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:content];
	
	NSArray *elements  = [xpathParser search:SHOES_CATEGORY_PRODUCT_LIST_XPATH];
	
	// Get the link information within the cell tag
	
	for (TFHppleElement *element in elements) {
    
    Shoes *shoes = [[[Shoes alloc] initWithShoesNode:element] autorelease];
    [shoesList addObject:shoes];
    
	}

  [_shoesArray addObjectsFromArray:shoesList];
  
  //Stop Animation
  //MyShoesAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
  
	[xpathParser release];
  
  //If there is any shoes come back, show the first shoes
  if ([_shoesArray count] > 0){
    //Show the first shoes in the list
    [self showShoesList];
  }
  [self stopAnimation];
  
  NSUInteger index = (currentPages-1)*CATEGORY_SHOES_COUNT;
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
  NSArray *array = [NSArray arrayWithObject:indexPath]; 
  if (currentPages != 1)
  {
    [shoesListView reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationNone];
    [shoesListView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
  }
  [shoesListView setUserInteractionEnabled:YES];
  
  currentPages++;
}

- (void)showShoesList {
  
  if(_shoesArray != nil){

    shoesListView.dataSource = self;
    shoesListView.delegate = self;
    [shoesListView reloadData];
    [shoesListView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [shoesListView setHidden:NO];
      
    //Hide scrolling shoes list view
    [shoesScrollingView setHidden:YES];
  }
}


- (void)hideShoesListInfoLabels{
  
  [shoesListView setHidden:YES];
}

- (void)openSearchView{
  NSLog(@"Gonna open search view");
}

- (void)dealloc {
  [_shoesDict release];
  [_shoesCategoryDict release];
  [_imageArray release];
  [_shoesArray release];
  [networkTool release];
  [objMan release];
  
  [super dealloc];
}

#pragma mark Table view methods

//Two sections here
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
      self.loadMoreSearchResultsCell = cell;
      
		}
		
		// Return a standard cell
		cell.textLabel.text = @"Load More Results...";
    
    cell.textLabel.textAlignment = UITextAlignmentCenter;
		return cell;
		
	}
  
	static NSString *MyIdentifier = @"MyIdentifier";
	
  ShoesListViewCell *cell = (ShoesListViewCell *)[shoesListView dequeueReusableCellWithIdentifier:MyIdentifier];
  
	if(cell == nil) {
    
    cell = [[[ShoesListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
  
  Shoes *shoes = [_shoesArray objectAtIndex:indexPath.row];
  
  NSString *imageName = shoes.shoesImageName;
  NSString *imageUrlStr = [NSString stringWithFormat:@"%@%@",MYSHOES_URL,imageName];
  
  NSURL *imageUrl = [NSURL URLWithString:imageUrlStr];
  
  CGRect frame;
	frame.size.width=60; frame.size.height=60;
	frame.origin.x=0; frame.origin.y=0;
  HJManagedImageV *managedImage = [[[HJManagedImageV alloc] initWithFrame:frame] autorelease];
  managedImage.url = imageUrl;
  [objMan manage:managedImage];
  
  // To improve performance
  [managedImage setOpaque:YES];
  
	[cell.contentView addSubview:managedImage];
  
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
    self.loadMoreSearchResultsCell.textLabel.text = @"Loading...";
    self.loadMoreSearchResultsCell.textLabel.textAlignment = UITextAlignmentCenter;
		
		// load the next page of shoe list.
    [self loadShoesList];
		
		// Disable user interaction if/when the loading/search results view appears.
		[self.shoesListView setUserInteractionEnabled:NO];
    
	} else {
    
		// Slide in the a details view.
    //Set the Name of the cell is @"Category"
    id delegate = [[UIApplication sharedApplication] delegate];
    
    if ([delegate respondsToSelector:@selector(shoesDetailController)]){
      [[delegate shoesDetailController] setShoes:[_shoesArray objectAtIndex:indexPath.row]];
      [self.navigationController pushViewController:[delegate shoesDetailController] animated:YES];
    }
  }
  //Deselected the selected Row
  [tableView deselectRowAtIndexPath:indexPath animated:YES];  
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return SHOES_LIST_CELL_HEIGHT;//[indexPath row] * 20;
}

#pragma mark -
#pragma mark ShowView common methods

- (void)resetView{
  //Set flag which shows the view has been reset;
  viewRest = FALSE;
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
  // Remove HUD from screen when the HUD was hidded
  [HUD removeFromSuperview];
  [HUD release];
	HUD = nil;
}

@end