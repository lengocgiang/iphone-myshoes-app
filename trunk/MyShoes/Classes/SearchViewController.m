//
//  SecondViewController.m
//  LoginShoes
//
//  Created by Yi Shen on 10/19/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchViewController.h"
#import "MyShoesAppDelegate.h"
#import "ShoesListViewController.h"

@implementation SearchViewController

@synthesize networkTool;
@synthesize loadingIndicator;
@synthesize searchKey;
@synthesize searchKeyArray;
@synthesize searchHistory;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = NSLocalizedString(@"Search", @"Search");
    self.tabBarItem.image = [UIImage imageNamed:@"search"];
  }
  return self;
}

- (void)dealloc {
  [networkTool release];   
  [loadingIndicator release];
  
  [searchKey release];
  [searchKeyArray release];
  [searchHistory release];
  [super dealloc];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  
  searchKeyArray = [[NSMutableArray alloc] initWithCapacity: 10];
  
}

- (void)viewDidUnload
{
  [self setLoadingIndicator:nil];
  [self setNetworkTool:nil];
  [self setSearchKey:nil];
  [self setSearchKeyArray:nil];  
  [self setSearchHistory:nil];
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  // Return YES for supported orientations
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (IBAction)cancelSearch:(id)sender {
  [searchKey setText:@""];
  [searchKey resignFirstResponder];
}

- (IBAction)clearSearch:(id)sender {
  [searchKeyArray removeAllObjects];
  [[self searchHistory] reloadData];
}

- (void)loadSearchResultWithKey:(NSString *)key{
  NSLog(@"searchKey=%@", key);
  
  
  id delegate = [[UIApplication sharedApplication] delegate];
  if ([delegate respondsToSelector:@selector(shoesDetailController)]){
    ShoesListViewController *shoesListController = (ShoesListViewController *)([delegate shoesListController]); 
    [shoesListController setListType:@"search"];
    [shoesListController setListKey:key];
    [shoesListController resetView];
    [self.navigationController pushViewController:shoesListController animated:YES];
  }
  
}

#pragma mark - UITextFieldDelegate method
- (BOOL) textFieldShouldReturn:(UITextField *)textField {
  if (textField.text.length == 0) {
    return NO;
  }
  
  // check duplicate key first
  int dupIndex = -1;
  NSString * tempItem;
  for (int i=0; i<[searchKeyArray count]; i++) {
    tempItem = [searchKeyArray objectAtIndex:i];
    if ([tempItem isEqualToString:textField.text]) {
      dupIndex = i;
      break;
    }
  }
  
  if (dupIndex >= 0) {
    // remove key from array and push it on top
    [searchKeyArray removeObjectAtIndex:dupIndex];
    [searchKeyArray addObject:textField.text];
  }else{
    if ([searchKeyArray count] == 10) {
      [searchKeyArray removeObjectAtIndex:0];
    }
    [searchKeyArray addObject:textField.text];
  }
  
  [[self searchHistory] reloadData];
  
  [self loadSearchResultWithKey:textField.text];
  
  return YES;
}

#pragma mark - table view method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return [searchKeyArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
  return @"Recent Searches";
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  int count = [searchKeyArray count];
  int rowNumber = [indexPath row];
  
  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:CellIdentifier] autorelease]; 
  }
  
  // show search history in reverse order
  cell.textLabel.text = [searchKeyArray objectAtIndex:(count -1 - rowNumber)];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  NSString *selectedKey = [[self searchKeyArray] objectAtIndex:([searchKeyArray count] - 1 - [indexPath row])];
  
  [self loadSearchResultWithKey:selectedKey];
  
}


@end
