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
@synthesize loginToolbar;

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
  [loginToolbar release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  //[aTableViewBtn deselectRowAtIndexPath:[aTableViewBtn indexPathForSelectedRow] animated:YES];
  
  
  if ([NetworkTool hasUserLoggedIn]){
    [loginToolbar removeFromSuperview];
  }else{
    // add "sign up" and "log in" toolbar at bottom
    [loginToolbar setFrame:CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44.0)];
    [self.view addSubview:loginToolbar];
  }
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  // Load table view for the button group of Category and OnSale
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
  [self setLoginToolbar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Login/Signup view methods

- (IBAction)launchLogin:(id)sender {
  LoginViewController *loginView;
  id delegate = [[UIApplication sharedApplication] delegate];
  
  if ([delegate respondsToSelector:@selector(loginViewController)]){
    loginView = (LoginViewController *)([delegate loginViewController]); 
  }
  
  loginView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
  loginView.modalPresentationStyle = UIModalPresentationPageSheet;
  loginView.delegate = self;
  [self presentModalViewController:loginView animated:YES];
}

- (IBAction)launchSignup:(id)sender {
  SignupViewController *signupView;
  id delegate = [[UIApplication sharedApplication] delegate];
  
  if ([delegate respondsToSelector:@selector(signupViewController)]){
    signupView = (SignupViewController *)([delegate signupViewController]); 
  }
  
  signupView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
  signupView.modalPresentationStyle = UIModalPresentationPageSheet;
  signupView.delegate = self;
  [self presentModalViewController:signupView animated:YES];
  
}

#pragma mark - Login/Signup delegate method

- (void)loginViewConfirm:(id)sender{
  [self dismissModalViewControllerAnimated:YES];
}

- (void)loginViewCancel:(id)sender{
  // go back to tab1 first so we don't stuck here. Otherwise, dismissModalView
  // will throw exception since viewWillAppear() in this view will keep
  // launching modalView which prevent dismiss itself.
  [self.tabBarController setSelectedIndex:0];
  
  [self dismissModalViewControllerAnimated:YES];
}

- (void)signupViewConfirm:(id)sender{
  [self dismissModalViewControllerAnimated:YES];
  // maybe we should login automatically after sign up?
  // below code not work yet, not sure why login view doesn't show up
  //[self showLoginView];
}

- (void)signupViewCancel:(id)sender{
  // go back to tab1 first so we don't stuck here. Otherwise, dismissModalView
  // will throw exception since viewWillAppear() in this view will keep
  // launching modalView which prevent dismiss itself.
  [self.tabBarController setSelectedIndex:0];
  
  [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Table view methods

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
      id delegate = [[UIApplication sharedApplication] delegate];
            
      
      if ([delegate respondsToSelector:@selector(shoppingCartController)]){
        [self.navigationController pushViewController:[delegate shoesCategoryController] animated:YES];
      }
      
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

#pragma mark -
#pragma mark ShowView common methods

- (void)resetView{
  //When user leaves this view and go back the view before. it should clean this view
  //For the Home view, there is no need to hold reset since it is not loading data online
}

@end
