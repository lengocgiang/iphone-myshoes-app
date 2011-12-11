//
//  ShoppingCartViewController.m
//  MyShoes
//
//  Created by Congpeng Ma on 25/10/11.
//  Copyright (c) 2011 18m. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "ShoesDetailViewController.h"
#import "ShoppingCartViewCell.h"
#import "MyShoesAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "Shoes.h"

@implementation ShoppingCartViewController

@synthesize shoppingCartListView;
@synthesize checkOutBtn;
@synthesize networkTool;
//@synthesize shoppingCartURL;
@synthesize viewState;
@synthesize previousPage;
@synthesize shoes;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      // Custom initialization
      shoppingCartURL = nil;
    }
    return self;
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
  
  // Do any additional setup after loading the view from its nib.
  
  //Shopping cart table list view
  float checkOutBtnHeight = 37.0f;
  float navigationBarHeight = 44.0f;
  
  shoppingCartListView = [[[UITableView alloc] initWithFrame:CGRectMake(0.0f,0.0f,320.0f,400.0f - checkOutBtnHeight - navigationBarHeight) 
                                                       style:UITableViewStylePlain] autorelease];
  shoppingCartListView.delegate = self;
  shoppingCartListView.dataSource = self;  
  shoppingCartListView.backgroundColor = [UIColor clearColor];
  
  //Enable selection in edit mode only like alarm app
  shoppingCartListView.allowsSelection = NO;
  //shoppingCartListView.allowsSelectionDuringEditing = YES;
  
  [self.view addSubview:shoppingCartListView];
  
  checkOutBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];//[[[UIButton alloc] initWithFrame:CGRectMake(30, self.chooseColor.frame.origin.y + self.chooseColor.frame.size.height + 30, 260, 80)] autorelease];
  checkOutBtn.frame = CGRectMake(0.0f, shoppingCartListView.frame.origin.y + shoppingCartListView.frame.size.height, 320.0f, checkOutBtnHeight);
  [checkOutBtn setTitle:@"Check out cart" forState:UIControlStateNormal];
  //UIImage *btnImage = [UIImage imageNamed:@"shopping_cart-32.png"];
  //[checkOutBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, btnImage.size.width , 0.0 , 0.0)]; // Left inset is the negative of image width.
  //[self.shoppingCartBtn setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -btnImage.size.width, -25.0, 0.0)]; // Left inset is the negative of image width.
  
  //[checkOutBtn setImage:btnImage forState:UIControlStateNormal];
  [checkOutBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 20)]; 
  [checkOutBtn setBackgroundImage:[[UIImage imageNamed:@"red_button.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0] 
                                  forState:UIControlStateNormal];
  [checkOutBtn addTarget:self action:@selector(checkOutCart) forControlEvents:UIControlEventTouchUpInside];
  
    
  [self.view addSubview:checkOutBtn];
  //Add the edit button to navigation bar. When the button is pressed, shopping cart table goes to edit mode
  UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" 
                                                                 style:UIBarButtonItemStyleBordered 
                                                                target:self 
                                                                action:@selector(EditButtonAction:)];
  [self.navigationItem setRightBarButtonItem:editButton];
  [editButton release];
  
  //Add the network tookit in charge of http communication
  networkTool = [[NetworkTool alloc] init];
  
  objMan = [[HJObjManager alloc] init];
  
  NSString* cacheDirectory = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/imgcache/myshoes/"] ;
  HJMOFileCache* fileCache = [[[HJMOFileCache alloc] initWithRootPath:cacheDirectory] autorelease];
  objMan.fileCache = fileCache;
  
  //Load the view if it's new
  viewRest = TRUE;
    
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

- (void)dealloc {    
  [shoppingCartURL release];
  [objMan release];
  [networkTool release];
  [shoppingCartListView release];
  [super dealloc];
}

- (void)setShoppingCartURL:(NSString *)cartUrl {
  if(shoppingCartURL != nil) {
    [shoppingCartURL release];
    shoppingCartURL = nil;
  }
  shoppingCartURL = [cartUrl retain];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  //Load shopping cart view
  if(viewRest){
    //If the shoes detail view is reset, will load the info when show the view
    [self loadCartDetail];
    viewRest = FALSE;
  }
  else{
    //Render shoes detail info directly
    [self renderCartDetail];
  }
  
  //Refresh shopping cart list view
  //[shoppingCartListView reloadData];
}

#pragma mark Network related methods
- (void)loadCartDetail {

  /*NSString *newUrl;

  if(!shoppingCartURL){
    //Load shopping cart info using the default product info url
    //Check if the shoes detail link is available
    
    newUrl = SHOES_CART_URL_DEFAULT;    
  }
  else{
    //Add shoes to the shopping cart
    newUrl = shoppingCartURL;
  }*/
  //Load shoes info using the default product info url
  [self loadCartDetailWithProductUrl:shoppingCartURL];
  
}

- (void)loadCartDetailWithProductUrl:(NSString *)url {
  
  NSString *newUrl;

  if(!url){

    //Start progress indicator
    HUD = [[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES] retain];
    HUD.labelText = @"Loading cart detail";
    [HUD setOpaque:YES];

    //Load shopping cart info using the default product info url
    //Check if the shoes detail link is available
    
    newUrl = [NSString stringWithFormat:@"%@%@",MYSHOES_URL,SHOES_CART_URL_DEFAULT];
    [networkTool getContent:url withDelegate:self requestSelector:@selector(addToCartCallBack:)];

  }
  else{
    //Start progress indicator
    HUD = [[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES] retain];
    HUD.labelText = @"Adding to cart";
    [HUD setOpaque:YES];
    
    //Add shoes to the shopping cart
    newUrl = [NSString stringWithFormat:@"http://%@%@",MYSHOES_HOSTNAME,url];
    //Remove any \ in the url which is invalid
    newUrl = [newUrl stringByReplacingOccurrencesOfString:@"\\" withString:@""];

    //Add the shoes to shopping cart by submitting add to cart form 
    //(value, key) pairs
    //The login form inputs
    //Are they all needed? -Yes!
    NSDictionary *cartFormDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                  SHOES_LOGIN_VALUE_EMPTY, SHOES_LOGIN_INPUT_EVENTTARGET_ID, 
                                  SHOES_LOGIN_VALUE_EMPTY, SHOES_LOGIN_INPUT_EVENTARGUMENT_ID, 
                                  self.viewState,SHOES_LOGIN_INPUT_VIEWSTATE_ID, 
                                  SHOES_LOGIN_VALUE_EMPTY, SHOES_LOGIN_INPUT_VIEWSTATEENCRYPTED_ID,
                                  [self.shoes getShoesColorValue],SHOES_CART_INPUT_COLOR,
                                  [self.shoes getShoesSize],SHOES_CART_INPUT_SIZENWIDTH,
                                  self.previousPage,SHOES_CART_INPUT_PREVIOUSPAGE,
                                  CART_INPUT_BTN_X_VALUE_DEFAULT, SHOES_CART_INPUT_BTN_X_ID, 
                                  CART_INPUT_BTN_Y_VALUE_DEFAULT, SHOES_CART_INPUT_BTN_Y_ID,                         
                                  nil];
    
    [self.networkTool addToCart:newUrl
                          WithDelegate:self
                       requestSelector:@selector(addToCartCallBack:)
                          cartFormDict:cartFormDict];
  }
}

- (void)addToCartCallBack:(NSData *)content {
  
  //Hide HUD progress indicator
  [HUD hide:YES];
  
  
  //Shoes verify if the shoes added to shopping cart
  //Do nothing at the moment
  /*
  if (![NetworkTool hasUserLoggedIn]) {
    UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Error!" 
                                                         message:@"We're sorry the login information you entered does not match our records." 
                                                        delegate:self 
                                               cancelButtonTitle:@"OK" 
                                               otherButtonTitles:nil, nil] autorelease];
    [alertView show];
  }*/
  //Process shopping cart list
  NSString *bodyDataString = [[[NSString alloc] initWithData:content 
                                                    encoding:NSASCIIStringEncoding] autorelease];

  NSLog(@"bodyDataString=%@", bodyDataString);
  
  //Clean up add cart specific values
  self.shoes = nil;
  self.viewState = nil;
  self.shoppingCartURL = nil;
  
  //Render cart list
  [self renderCartDetail];
}  

- (void)renderCartDetail {
  //Refresh shopping cart list view
  [shoppingCartListView reloadData];
  
}

#pragma mark Table view methods

//Only one sections here
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //Locate the shopping cart object in MyShoesApplicationDelegate
    id delegate = [[UIApplication sharedApplication] delegate];
    
    ShoppingCart *shoppingCart = nil;
    if ([delegate respondsToSelector:@selector(shoppingCart)]){
        shoppingCart = [delegate shoppingCart];
    }
    
    return [shoppingCart getCount];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
  static NSString *CellIdentifier = @"CartCell";
  
  id cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    //cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    cell = [[[ShoppingCartViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
  }
  
  // Set up the cell...
  id delegate = [[UIApplication sharedApplication] delegate];
  
  ShoppingCart *shoppingCart = nil;
  if ([delegate respondsToSelector:@selector(shoppingCart)]){
    shoppingCart = [delegate shoppingCart];
  }
  
  Shoes *tmpShoes = [shoppingCart getShoesAtIndex:indexPath.row];
  
  //imageView.image = shoes.shoesImage;
  NSString *imageName = tmpShoes.shoesImageName;
  NSString *imageUrlStr = [NSString stringWithFormat:@"%@%@",MYSHOES_URL,imageName];
  
  NSURL *imageUrl = [NSURL URLWithString:imageUrlStr];
  //NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
  
  /*UIImage *shoesImage = [UIImage imageWithData: [NSData dataWithContentsOfURL: imageUrl]];
  
  CGSize sz = SHOES_LIST_IMG_SIZE;
  
  UIImage *resized = [HomeViewController scale:shoesImage toSize:sz];
  [cell imageView].image = resized;*/
  
  // To improve performance
  [[cell imageView] setOpaque:YES];
  CGRect frame;
	frame.size.width = SHOES_LIST_CELL_IMG_WIDTH;//CART_LIST_CELL_IMG_WIDTH;
  frame.size.height = SHOES_LIST_CELL_HEIGHT;//CART_LIST_CELL_HEIGHT;
	frame.origin.x = 0;
  frame.origin.y = 0;
  HJManagedImageV *managedImage = [[[HJManagedImageV alloc] initWithFrame:frame] autorelease];
  managedImage.url = imageUrl;
  [objMan manage:managedImage];
  
  // To improve performance
  [managedImage setOpaque:YES];
  
	[[cell contentView] addSubview:managedImage];


  [cell setShoes:tmpShoes];
  [cell setShoesInfo:tmpShoes.productStyle];
  [cell setShoesSizeInfo:[tmpShoes getShoesSizeInfo]];
  
  //If the shopping cart list view is not in edit mode, just show Image of the shoes
  if(!tableView.editing){
    [cell setEditing:NO];
    NSUInteger quantity = [shoppingCart getQuantity:indexPath.row];
    NSString *price = tmpShoes.productPrice;
    
    [cell setShoesDetail:[NSString stringWithFormat:@"%@ %d", price, quantity]];
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %d", price, quantity];
    //cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:(10.0)];
    //cell.detailTextLabel.textAlignment = UITextAlignmentRight;
  }
  else
  {
    [cell setEditing:YES];
    [cell setShoesQuantity:[shoppingCart getQuantity:indexPath.row]];
  }

  //cell.editingStyle
  //cell.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  //View mode is just to view the list of shopping cart
  //Edit mode let user delete/modify items in shopping cart
  
  /*
  id delegate = [[UIApplication sharedApplication] delegate];
  
  ShoppingCart *shoppingCart = nil;
  if ([delegate respondsToSelector:@selector(shoppingCart)]){
    shoppingCart = [delegate shoppingCart];
  }

  //Here, we push a brand new ShoesDetailController instance since it's different than
  //the one from ShoesListView
  ShoesDetailViewController *shoesDetailView = [[[ShoesDetailViewController alloc]
                                                initWithNibName:@"ShoesDetailViewController"
                                                bundle:nil] autorelease];
  
  [shoesDetailView setShoes:[shoppingCart getShoesAtIndex:indexPath.row]];
  //Set the shoesDetailView to be editing mode
  //There is no more editing mode for shoesDetailView
  //[shoesDetailView setEditing:YES];
  [self.navigationController pushViewController:shoesDetailView animated:YES];*/
}

// Update the data model according to edit actions delete or insert.
- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    id delegate = [[UIApplication sharedApplication] delegate];
    
    ShoppingCart *shoppingCart = nil;
    if ([delegate respondsToSelector:@selector(shoppingCart)]){
      shoppingCart = [delegate shoppingCart];
    }

    [shoppingCart removeShoesAtIndex:indexPath.row];
    [shoppingCartListView reloadData];
  } 
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return SHOES_LIST_CELL_HEIGHT;
}

#pragma mark navigation bar button methods

- (void)EditButtonAction:(id)sender {
  if(shoppingCartListView.editing)
  {
    [shoppingCartListView setEditing:NO animated:NO];
    [shoppingCartListView reloadData];
    [self.navigationItem.rightBarButtonItem setTitle:@"Edit"];
    [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStylePlain];
  }
  else
  {
    [shoppingCartListView setEditing:YES animated:YES];
    [shoppingCartListView reloadData];
    [self.navigationItem.rightBarButtonItem setTitle:@"Done"];
    [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStyleDone];
  }
  
  //[shoppingCartListView reloadData];
}

#pragma mark -
#pragma mark ShowView common methods

- (void)resetView{
  //Anything here need to clean this view
  //Set flag which shows the view has been reseted;
  viewRest = TRUE;
}

#pragma mark UITextFieldDelegate methods

/*- (BOOL)textFieldShouldReturn:(UITextField *)textField {
 
 }*/

- (void)textFieldDidEndEditing:(UITextField *)textField {
  //Grab the number that user set for quantity
  //For the moment, don't do any valid check
  id delegate = [[UIApplication sharedApplication] delegate];
  
  ShoppingCart *shoppingCart = nil;
  if ([delegate respondsToSelector:@selector(shoppingCart)]){
    shoppingCart = [delegate shoppingCart];
  }
  
  NSString *str = textField.text;
  
  //Convert the String to number
  NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
  [f setNumberStyle:NSNumberFormatterNoStyle];
  NSNumber * myNumber = [f numberFromString:str];
  [f release];
  
  //Set the updated number of shoppingCart
  UITableViewCell *cell = (UITableViewCell*) [[textField superview] superview];
  NSUInteger i = [shoppingCartListView indexPathForCell:cell].row;
  
  Shoes *tmpShoes = [shoppingCart getShoesAtIndex:i];
  [shoppingCart updateShoes:tmpShoes withQuantity:myNumber.integerValue];
  
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return NO;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField {
  shoppingCartListView.contentInset =  UIEdgeInsetsMake(0, 0, 300, 0);
  
  UITableViewCell *cell = (UITableViewCell*) [[textField superview] superview];
  [shoppingCartListView scrollToRowAtIndexPath:[shoppingCartListView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

#pragma mark -
#pragma mark Checkout cart button methods
// Add the current shoes to the cart and go to shopping cart view
- (void)checkOutCart {
  
  //Locate the shopping cart object in MyShoesApplicationDelegate
  id delegate = [[UIApplication sharedApplication] delegate];
  
  ShoppingCart *shoppingCart = nil;
  if ([delegate respondsToSelector:@selector(shoppingCart)]){
    shoppingCart = [delegate shoppingCart];
  }
  
  //Check if user log in
  if(![NetworkTool hasUserLoggedIn]) {
    LoginViewController *loginView;
    
    if ([delegate respondsToSelector:@selector(loginViewController)]){
      loginView = [delegate loginViewController]; 
    }
    
    loginView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    loginView.modalPresentationStyle = UIModalPresentationPageSheet;
    loginView.delegate = self;
    [self presentModalViewController:loginView animated:YES];
    
    [loginView setInfo:LOGIN_VIEW_CHECKOUT_REMINDER];
  }    
}

#pragma mask - Login view delegate method
- (void)loginViewConfirm:(id)sender{
  //Reset loginView info, sender is the loginView
  [sender setInfo:@""];
  [self dismissModalViewControllerAnimated:YES];
  
  //Got to check out view
  
}

- (void)loginViewCancel:(id)sender{
  // go back to tab1 first so we don't stuck here. Otherwise, dismissModalView
  // will throw exception since viewWillAppear() in this view will keep
  // launching modalView which prevent dismiss itself.
  [self.tabBarController setSelectedIndex:0];
  
  [self dismissModalViewControllerAnimated:YES];
}

@end
