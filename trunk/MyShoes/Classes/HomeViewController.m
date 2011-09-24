//
//  HomeViewController.m
//  MyShoes
//
//  Created by Congpeng Ma on 19/09/11.
//  Copyright 2011 18m. All rights reserved.
//

#import "HomeViewController.h"
#import "ShoesListViewController.h"
#import "MyShoesAppDelegate.h"

@implementation HomeViewController

@synthesize browserCategoryBtn;
@synthesize onSaleBtn;
@synthesize aTableViewBtn;

+ (UIImage *)scale:(UIImage *)image toSize:(CGSize)size
{
  UIGraphicsBeginImageContext(size);
  [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
  UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return scaledImage;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction) browserCategory{
  
}

- (IBAction) browserOnSale{
  
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  [aTableViewBtn deselectRowAtIndexPath:[aTableViewBtn indexPathForSelectedRow] animated:YES];
}*/

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  // Load table view for the button group of Category and OnSale
  /*aTableViewBtn = [[[ShoesTableView alloc] initWithFrame:CGRectMake(0.0f,0.0f,320.0f,300.0f) 
                                           withDataSource:self] autorelease];
  
  [self.view addSubview:aTableViewBtn]; */
  aTableViewBtn = [[[UITableView alloc] initWithFrame:CGRectMake(0.0f,100.0f,320.0f,200.0f) 
                                                style:UITableViewStyleGrouped] autorelease];
  aTableViewBtn.delegate = self;
  aTableViewBtn.dataSource = self;
  
  aTableViewBtn.backgroundColor = [UIColor clearColor];
  
  [self.view addSubview:aTableViewBtn];

  btnNameArray = [NSArray arrayWithObjects:@"Category", @"OnSale", nil];
  
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
  return 2;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  switch(section){
      case 0:
        return 1;
      case 1:
        return 1;
      default:
        return 0;
  }
  //return [btnNameArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  /* 
   static NSString *CellIdentifier = @"Cell";
   
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   if (cell == nil) {
   cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
   }
   
   // Set up the cell...
   cell.text = [arryData objectAtIndex:indexPath.row];
   return cell;*/
	static NSString *MyIdentifier = @"MyIdentifier";
	MyIdentifier = @"tblCellView";
	
	HomeViewBtnCell *cell = (HomeViewBtnCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if(cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"HomeViewBtnCell" owner:self options:nil];
		cell = btnCell;
	}
	
  if(indexPath.section == 0){
    //Set the Name of the cell is @"Category"
    [cell setBtnLableTxt:[btnNameArray objectAtIndex:0]];
    //Set the Image of the cell
    UIImage *catImg = [UIImage imageNamed:@"category.png"];
    
    CGSize sz = HOME_CATEGORY_BTN_IMG_SIZE;
    
    UIImage *resized = [HomeViewController scale:catImg toSize:sz];
      
    cell.imageView.image = resized;
  }
  else{
    [cell setBtnLableTxt:[btnNameArray objectAtIndex:1]];        
    UIImage *onSaleImg = [UIImage imageNamed:@"sale.png"];
    
    CGSize sz = HOME_CATEGORY_BTN_IMG_SIZE;
    
    UIImage *resized = [HomeViewController scale:onSaleImg toSize:sz];
    
    cell.imageView.image = resized;
  }
	//[cell setBtnLableTxt:[btnNameArray objectAtIndex:indexPath.row]];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
	/*NextViewController *nextController = [[NextViewController alloc] initWithNibName:@"NextView" bundle:nil];
	[self.navigationController pushViewController:nextController animated:YES];
	[nextController changeProductText:[arryData objectAtIndex:indexPath.row]];*/
  
  if(indexPath.section == 0){
    //Set the Name of the cell is @"Category"
    //[cell setBtnLableTxt:[btnNameArray objectAtIndex:0]];
    if(indexPath.row == 0) {
      /*MyShoesViewController *shoesCategoryController = [[[MyShoesViewController alloc]
                                                         initWithNibName:@"MyShoesViewController" 
                                                                  bundle:nil] autorelease];*/
      MyShoesAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
            
      [self.navigationController pushViewController:delegate.shoesCategoryController animated:YES];
      
      //Deselected the selected Row
      [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
  }
  
}

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
  if(section == 0)
    return 6;
  return 1.0;
}


-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
  return 5.0;
}

-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
  return [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)] autorelease];
}

-(UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section
{
  return [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)] autorelease];
}

@end
