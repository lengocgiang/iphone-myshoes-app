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

//Only one section here
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
     //cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
     cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
   }
   
   // Set up the cell...
   ShoesCategory *category = [currentPageCategoriesArray objectAtIndex:indexPath.row];
   cell.textLabel.text = category.categoryName;
   cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
   return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  //Start animation
  id delegate = [[UIApplication sharedApplication] delegate];
  
	//Initialize the user selected category
  NSMutableArray *userSelectedCategoriesArray = [NSMutableArray arrayWithObjects:[currentPageCategoriesArray objectAtIndex:indexPath.row], [currentPageCategoriesArray objectAtIndex:indexPath.row], nil];
  
  [[delegate shoesSecondaryCategoryController] setUserSelectedCategoriesArray:userSelectedCategoriesArray];
  
  //Init the array for all categories in the secondary category view
  NSMutableDictionary *categoryDict = [ShoesCategoryDict dictionary];
  
  ShoesCategory *firstCategory = [userSelectedCategoriesArray objectAtIndex:0];
  if (firstCategory.categoryName == SHOES_CATEGORY_BAGS_NAME)
  {
    // Bag's secondary category is special
    [[delegate shoesSecondaryCategoryController] setCurrentPageCategoriesArray: [NSArray arrayWithObjects:
                                       [categoryDict objectForKey:SHOES_CATEGORY_BACKPACKE_NAME], 
                                       [categoryDict objectForKey:SHOES_CATEGORY_HANDBAGS_NAME], 
                                       [categoryDict objectForKey:SHOES_CATEGORY_SPORTS_AND_DUFFELS_NAME], 
                                       [categoryDict objectForKey:SHOES_CATEGORY_MESSENGER_BAGS_NAME], 
                                       nil]];
  }
  else
  {
    [[delegate shoesSecondaryCategoryController] setCurrentPageCategoriesArray:[NSArray arrayWithObjects:
                                       [categoryDict objectForKey:SHOES_CATEGORY_DRESS_NAME], 
                                       [categoryDict objectForKey:SHOES_CATEGORY_CASUAL_NAME], 
                                       [categoryDict objectForKey:SHOES_CATEGORY_ATHLETIC_NAME], 
                                       [categoryDict objectForKey:SHOES_CATEGORY_BOOTS_NAME], 
                                       [categoryDict objectForKey:SHOES_CATEGORY_SANDALS_NAME], 
                                       nil]];
  }

  [self.navigationController pushViewController:[delegate shoesSecondaryCategoryController] animated:YES];
  
  //Deselected the selected Row
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  //Deselected the selected Row
  [categoryTableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark ShowView common methods

- (void)resetView{
  //When user leaves this view and go back the view before. it should clean this view
  //For the category view, there is no need to hold reset since it is not loading data online
}

@end
