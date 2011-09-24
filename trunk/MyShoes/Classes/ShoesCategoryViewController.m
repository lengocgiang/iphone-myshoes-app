//
//  ShoesCategoryViewController.m
//  MyShoes
//
//  Created by Congpeng Ma on 23/09/11.
//  Copyright 2011 18m. All rights reserved.
//

#import "MyShoesAppDelegate.h"
#import "Shoes.h"
#import "ShoesCategoryViewController.h"
#import "ShoesCategory.h"
#import "TFHpple.h"
#import "TFHppleElement+AccessChildren.h"


@implementation ShoesCategoryViewController

@synthesize categoryTableView;
//@synthesize categoryNameArray;
@synthesize shoesCategoryDict;
@synthesize shoesArray;
@synthesize networkTool;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
  [networkTool release];
  [shoesArray release];
  
  [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  self.categoryTableView = [[[UITableView alloc] initWithFrame:CGRectMake(0.0f,0.0f,320.0f,400.0f) style:UITableViewStyleGrouped] autorelease];
  categoryTableView.delegate = self;
  categoryTableView.dataSource = self;
  
  categoryTableView.backgroundColor = [UIColor clearColor];
  
  [self.view addSubview:categoryTableView];
  
  /*self.categoryNameArray = [NSArray arrayWithObjects:@"women", @"men", @"girls", @"boys", @"juniors", 
                                                @"bags&more", @"sale", nil];*/
  
  //Init all the shoes category and put them in a directory
  //Init and add slide button menu Image View
  self.shoesCategoryDict = [[OrderedDictionary alloc] init];
  //Setup category for women
  ShoesCategory *category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_WOMEN_NAME/* andXPath:SHOES_CATEGORY_WOMEN_XPATH*/] autorelease];
  category.categoryURI = SHOES_CATEGORY_WOMEN_URI_12ITEM;
	[self.shoesCategoryDict setObject: category forKey:SHOES_CATEGORY_WOMEN_NAME];
  //Setup category for men
  //[category autorelease];
  category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_MEN_NAME/* andXPath:SHOES_CATEGORY_MEN_XPATH*/] autorelease];
  category.categoryURI = SHOES_CATEGORY_MEN_URI_12ITEM;
	[self.shoesCategoryDict setObject:category forKey:SHOES_CATEGORY_MEN_NAME];
  //Setup category for girls
  //[category autorelease];
  category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_GIRLS_NAME/* andXPath:SHOES_CATEGORY_GIRLS_XPATH*/] autorelease];
  category.categoryURI = SHOES_CATEGORY_GIRLS_URI_12ITEM;
	[self.shoesCategoryDict setObject: category forKey:SHOES_CATEGORY_GIRLS_NAME];
  //Setup category for boys
  //[category autorelease];
  category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_BOYS_NAME/* andXPath:SHOES_CATEGORY_BOYS_XPATH*/] autorelease];
  category.categoryURI = SHOES_CATEGORY_BOYS_URI_12ITEM;
	[self.shoesCategoryDict setObject:category forKey:SHOES_CATEGORY_BOYS_NAME];
  
  //Setup category for Juniors
  //[category autorelease];
  category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_JUNIORS_NAME/* andXPath:SHOES_CATEGORY_JUNIORS_XPATH*/] autorelease];
  category.categoryURI = SHOES_CATEGORY_JUNIORS_URI_12ITEM;
	[self.shoesCategoryDict setObject:category forKey:SHOES_CATEGORY_JUNIORS_NAME];
  
  //Setup category for bags
  //[category autorelease];
  category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_BAGS_NAME/* andXPath:SHOES_CATEGORY_BAGS_XPATH*/] autorelease];
  category.categoryURI = SHOES_CATEGORY_BAGS_URI_12ITEM;
	[self.shoesCategoryDict setObject:category forKey:SHOES_CATEGORY_BAGS_NAME];
  
  self.networkTool = [[NetworkTool alloc] init];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark Table view methods

//Two sections here
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  /*switch(section){
    case 0:
      return 1;
    case 1:
      return 1;
    default:
      return 0;
  }*/
  return [[self.shoesCategoryDict allKeys] count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
   static NSString *CellIdentifier = @"CategoryCell";
   
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   if (cell == nil) {
     cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
   }
   
   // Set up the cell...
   cell.textLabel.text = [[self.shoesCategoryDict allKeys] objectAtIndex:indexPath.row];
   cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
   return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if(![MyShoesAppDelegate IsEnableWIFI] && ![MyShoesAppDelegate IsEnable3G]){
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"www.shoes.com"
                                                    message:@"There is no network, Check your system"
                                                   delegate:nil
                                          cancelButtonTitle:@"YES" otherButtonTitles:nil];
    [alert show];
    [alert release];
    
    return;
  }
  
  //Start animation
  MyShoesAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
  
  [delegate.shoesListController hideShoesListInfoLabels];
  [delegate.shoesListController startAnimation];
  
	//get the uri for the selected category
	NSString *scategoryName = [[self.shoesCategoryDict allKeys] objectAtIndex:indexPath.row];
	ShoesCategory * category = [self.shoesCategoryDict objectForKey:scategoryName];
	
	NSString *uri = category.categoryURI;
  
	NSString *newUrl = [NSString stringWithFormat:@"%@%@",MYSHOES_URL,uri];
	//Issue the request of the selected category
	[networkTool getContent:newUrl withDelegate:self requestSelector:@selector(shoesCategoryUdateCallbackWithData:)];
  
  [self.navigationController pushViewController:delegate.shoesListController animated:YES];
  
  //Deselected the selected Row
  [categoryTableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)shoesCategoryUdateCallbackWithData: (NSData *) content {
	
	//debug_NSLog(@"%@",[[[NSString alloc] initWithData:content encoding:NSASCIIStringEncoding] autorelease]);
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
	
  [self.shoesArray autorelease];
  self.shoesArray = [shoesList copy];
  
  //Stop Animation
  MyShoesAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
  
	[xpathParser release];
  
  //If there is any shoes come back, show the first shoes
  if ([self.shoesArray count] > 0){
    //Show the first shoes in the list
    /*Shoes *shoes = [self.shoesArray objectAtIndex:0];
     NSString *imageName = shoes.shoesImageName;
     NSString *imageUrl = [NSString stringWithFormat:@"%@%@",MYSHOES_URL,imageName];*/
    [delegate.shoesListController showShoesList:self.shoesArray];
  }
  [delegate.shoesListController stopAnimation];
  if ([self.shoesArray count] >= 1){
    [delegate.shoesListController showShoesListInfo:[self.shoesArray objectAtIndex:0]];
  }
    
}

@end
