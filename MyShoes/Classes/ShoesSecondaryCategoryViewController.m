//
//  ShoesSecondaryCategoryViewController.m
//  MyShoes
//
//  Created by Kevin Liu on 4/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyShoesAppDelegate.h"
#import "ShoesSecondaryCategoryViewController.h"
#import "ShoesCategoryDict.h"
#import "Config.h"

// The position of the secodnary category in the user selected category array
#define POSITION_OF_SECONDARY_CATEGORY 1

@implementation ShoesSecondaryCategoryViewController

@synthesize currentPageCategoriesArray;
@synthesize userSelectedCategoriesArray;

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
  // we may not need to release the array specifically as it is auto-managed
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
  categoryTableView = [[[UITableView alloc] initWithFrame:CGRectMake(0.0f,0.0f,320.0f,400.0f) style:UITableViewStyleGrouped] autorelease];
  categoryTableView.delegate = self;
  categoryTableView.dataSource = self;
  
  categoryTableView.backgroundColor = [UIColor clearColor];
  
  [self.view addSubview:categoryTableView];
  
  /*self.categoryNameArray = [NSArray arrayWithObjects:@"women", @"men", @"girls", @"boys", @"juniors", 
   @"bags&more", @"sale", nil];*/
  

}

- (void)viewDidUnload
{
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  [categoryTableView reloadData];
  
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
  
	[userSelectedCategoriesArray replaceObjectAtIndex:POSITION_OF_SECONDARY_CATEGORY withObject:[currentPageCategoriesArray objectAtIndex:indexPath.row]];
  
  [delegate.shoesListController setUserSelectedCategoriesArray:userSelectedCategoriesArray];
  [self.navigationController pushViewController:delegate.shoesListController animated:YES];
  
  //Deselected the selected Row
  [categoryTableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end