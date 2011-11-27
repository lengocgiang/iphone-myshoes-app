//
//  ThirdViewController.m
//  LoginShoes
//
//  Created by Yi Shen on 10/19/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MyAccountViewController.h"
#import "MyShoesAppDelegate.h"

@implementation MyAccountViewController

@synthesize webview;
@synthesize networkTool;
//@synthesize loginViewController;
@synthesize loginButton;
@synthesize loadingIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = NSLocalizedString(@"My Account", @"MyAccount");
    //self.tabBarItem.image = [UIImage imageNamed:@"account"];    
  }
  return self;
}

- (void)dealloc {
  [loadingIndicator release];
  [webview release];
  [networkTool release];
  //[loginViewController release];
  [loginButton release];
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
  // add the spinner to the table cell
}

- (void)viewDidUnload
{
  [self setLoadingIndicator:nil];
  [self setWebview:nil];
  [self setNetworkTool:nil];
  //[self setLoginViewController:nil];
  [self setLoginButton:nil];
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (void) viewWillAppear:(BOOL)animated{
  
  // check whether the user already log in
  // hasUserLoggedIn is moved to NetworkTool
  /*if (!loginViewController){
    loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" 
                                                                bundle:nil];
  }*/
  if ([NetworkTool hasUserLoggedIn]) {
    loginButton.title = @"Sign out";
  }else{
    // launch login view if not
    [self launchLoginView];
  }
  
  [super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Login view related
- (void)launchLoginView {
  /*if (!loginViewController){
    loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" 
                                                                bundle:nil];
  }*/
  
  LoginViewController *loginView;
  id delegate = [[UIApplication sharedApplication] delegate];
  
  if ([delegate respondsToSelector:@selector(loginViewController)]){
    loginView = (LoginViewController *)([delegate loginViewController]); 
  }

  NSLog(@"loginButton.title=%@", loginButton.title);
  if ([loginButton.title isEqualToString:@"Sign In"]){
    loginView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    loginView.modalPresentationStyle = UIModalPresentationPageSheet;
    loginView.delegate = self;
    [self presentModalViewController:loginView animated:YES];
  }else{
    // sign out
    NSLog(@"rrrrrrrrr");
    [self logout];
    
  }

}

- (void)logout {
  // show activity indicator view
  if (!loadingIndicator){
    loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
  }
  [loadingIndicator startAnimating];    
  [loadingIndicator setFrame:CGRectMake(self.view.center.x - 11, self.view.center.y - 11, 22.0, 22.0)];
  [loadingIndicator setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin
                                      | UIViewAutoresizingFlexibleRightMargin];
  [self.view addSubview:loadingIndicator];
  
  // load web page
  if (!self.networkTool) {
    NSLog(@"create networkTool");
    self.networkTool = [[NetworkTool alloc] init];
  }
  NSString *newUrl = [NSString stringWithFormat:@"%@",@"http://www.shoes.com/profiles/login.aspx?ResetUser=Y&returnURL=http://www.shoes.com/"];
	[self.networkTool getContent:newUrl 
                  withDelegate:self 
               requestSelector:@selector(updateData:)];
}


- (void)updateData:(NSData *)content {
  //NSString *result = [[[NSString alloc] initWithData:content encoding:NSUTF8StringEncoding] autorelease];
  //[self.webview loadHTMLString:result baseURL:nil];
  
  [loadingIndicator stopAnimating];
  [loadingIndicator removeFromSuperview];
  
  NSLog(@"has user logged in? %d", [NetworkTool hasUserLoggedIn]);
  loginButton.title = @"Sign In";

  [NetworkTool showAllSavedCookies];
}

- (IBAction)signin:(id)sender {
    [self launchLoginView];
}

#pragma mask - Login view delegate method
- (void)loginViewConfirm:(id)sender{
  [self dismissModalViewControllerAnimated:YES];
  //NSLog(@"userID=%@", loginViewController.userID.text);
  //NSLog(@"password=%@", loginViewController.password.text);
}

- (void)loginViewCancel:(id)sender{
  // go back to tab1 first so we don't stuck here. Otherwise, dismissModalView
  // will throw exception since viewWillAppear() in this view will keep
  // launching modalView which prevent dismiss itself.
  [self.tabBarController setSelectedIndex:0];
  
  [self dismissModalViewControllerAnimated:YES];
}
@end
