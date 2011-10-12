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
#import "ShoesCategoryDict.h"


@implementation ShoesCategoryViewController

@synthesize categoryTableView;
@synthesize currentPageCategoriesArray;

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
  [currentPageCategoriesArray release];
  
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
  
  //Init the array for all categories in current page
  NSMutableDictionary *categoryDict = [ShoesCategoryDict dictionary];
  self.currentPageCategoriesArray = [NSArray arrayWithObjects:
                                     [categoryDict objectForKey:SHOES_CATEGORY_WOMEN_NAME], 
                                     [categoryDict objectForKey:SHOES_CATEGORY_MEN_NAME], 
                                     [categoryDict objectForKey:SHOES_CATEGORY_GIRLS_NAME], 
                                     [categoryDict objectForKey:SHOES_CATEGORY_BOYS_NAME], 
                                     [categoryDict objectForKey:SHOES_CATEGORY_JUNIORS_NAME], 
                                     [categoryDict objectForKey:SHOES_CATEGORY_BAGS_NAME], 
                                     nil];

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
  return [currentPageCategoriesArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
   static NSString *CellIdentifier = @"CategoryCell";
   
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   if (cell == nil) {
     cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
   }
   
   // Set up the cell...
   ShoesCategory *category = [currentPageCategoriesArray objectAtIndex:indexPath.row];
   cell.textLabel.text = category.categoryName;
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
  
	//Initialize the user selected category
  NSMutableArray *userSelectedCategoriesArray = [NSArray arrayWithObjects:[currentPageCategoriesArray objectAtIndex:indexPath.row], nil];
  
  [delegate.shoesSecondaryCategoryController setUserSelectedCategoriesArray:userSelectedCategoriesArray];

  [self.navigationController pushViewController:delegate.shoesSecondaryCategoryController animated:YES];
  
  //Deselected the selected Row
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  //Deselected the selected Row
  [categoryTableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
