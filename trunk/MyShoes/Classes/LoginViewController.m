//
//  LoginViewController.m
//  LoginShoes
//
//  Created by Yi Shen on 10/19/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "TFHpple.h"
#import "TFHppleElement+AccessChildren.h"
#import "Config.h"


@implementation LoginViewController

@synthesize loginButton;
@synthesize userID;
@synthesize password;
@synthesize delegate;
@synthesize networkTool;
@synthesize networkTool2;
@synthesize loadingIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc {
  [networkTool release];  
  [networkTool2 release];
  [loadingIndicator release];
  
  [userID release];
  [password release];
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

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [userID becomeFirstResponder];
    
    NSString *emailValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    NSString *passwordValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"];
    NSLog(@"login view: email=%@, password=%@", emailValue, passwordValue);
  
    if (emailValue) {
        userID.text = emailValue;
        password.text = passwordValue;
    }
    
    if (userID.text.length == 0 || password.text.length ==0) {
        // disable Sign In button 
        [loginButton setEnabled:NO];
        
    }else{
        // highlight Sign In button
        [loginButton setHighlighted:YES];
    }
}

- (void)viewDidUnload
{
  [self setLoadingIndicator:nil];
  [self setNetworkTool:nil];
  [self setNetworkTool2:nil];  
  [self setUserID:nil];
  [self setPassword:nil];
  [self setLoginButton:nil];
  
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)cancelLogin:(id)sender {
  [self.delegate loginViewCancel:self];
}

- (IBAction)confirmLogin:(id)sender {
  // hide keyboard
  [userID resignFirstResponder];
  [password resignFirstResponder];
  
  // show activity indicator view
  if (!loadingIndicator){
    loadingIndicator = [[UIActivityIndicatorView alloc] 
                        initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
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
  
  //Issue the request of the selected category
  [self.networkTool getContent:SHOES_LOGIN_URL 
                  withDelegate:self 
               requestSelector:@selector(buildLoginFormDict:)];
  
}

- (IBAction)usernameChanged:(id)sender {
    if (userID.text.length == 0 || password.text.length ==0) {
        // disable Sign In button 
        [loginButton setEnabled:NO];
        [loginButton setHighlighted:NO];
        
    }else{
        // highlight Sign In button
        [loginButton setHighlighted:YES];
        [loginButton setEnabled:YES];
    }
}


#pragma mark - network method


- (void)buildLoginFormDict:(NSData *)content {
  NSString *viewState;
  // Create parser
  TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:content];
  NSArray *elements  = [xpathParser search:@"//*[@id='__VIEWSTATE']"];
  if((elements != nil) && ([elements count] > 0)){
    TFHppleElement *targetNode = [elements objectAtIndex:0];
    viewState = [targetNode objectForKey:VALUE_TAG];
  }else{
    // set default value here
    NSLog(@"======= NOT found!!!!");
    viewState = SHOES_LOGIN_INPUT_VIEWSTATE_VALUE;
  }
  [xpathParser release];
  
  if (!self.networkTool2) {
    self.networkTool2 = [[NetworkTool alloc] init];
  }
  
  //(value, key) pairs
  //The login form inputs
  //Are they all needed? -Yes!
  NSDictionary *loginFormDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                 self.userID.text, SHOES_LOGIN_INPUT_USERNAME_ID, 
                                 self.password.text, SHOES_LOGIN_INPUT_PASSWORD_ID, 
                                 viewState, SHOES_LOGIN_INPUT_VIEWSTATE_ID, 
                                 @"25", SHOES_LOGIN_INPUT_BTN_X_ID, 
                                 @"16", SHOES_LOGIN_INPUT_BTN_Y_ID,                         
                                 SHOES_LOGIN_VALUE_EMPTY, SHOES_LOGIN_INPUT_EVENTTARGET_ID, 
                                 SHOES_LOGIN_VALUE_EMPTY, SHOES_LOGIN_INPUT_EVENTARGUMENT_ID, 
                                 SHOES_LOGIN_VALUE_EMPTY, SHOES_LOGIN_INPUT_VIEWSTATEENCRYPTED_ID,                         
                                 nil];
  
  [self.networkTool2 loginWithDelegate:self 
                       requestSelector:@selector(updateData:) 
                         loginFormDict:loginFormDict];
  
}


- (void)updateData:(NSData *)content {
  [loadingIndicator stopAnimating];
  [loadingIndicator removeFromSuperview];
  
  // show alert when login failed
    if (![NetworkTool hasUserLoggedIn]) {
        UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Error!" 
                                                             message:@"We're sorry the login information you entered does not match our records." 
                                                            delegate:self 
                                                   cancelButtonTitle:@"OK" 
                                                   otherButtonTitles:nil, nil] autorelease];
        [alertView show];
    }
    
  [self.delegate loginViewConfirm:self];
  [NetworkTool showAllSavedCookies];

}

/*- (BOOL)hasUserLoggedIn {
  BOOL hasFoundUserNameInCookie = NO;
  BOOL hasFoundRememberMe = NO;
  BOOL loginIsTrue = NO;
  
  NSArray * cookies  = [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies;
  NSString *cookieName, *cookieValue;
  
  for (int i = 0; i < cookies.count; i++){
    cookieName = [[cookies objectAtIndex:i] name];
    cookieValue = [(NSHTTPCookie *)[cookies objectAtIndex:i] value];
    if ([cookieName isEqualToString:@"UserName"]) {
      hasFoundUserNameInCookie = YES;
      NSLog(@"Found cookie \"%@=%@\" in sharedHTTPCookieStorage!", cookieName, cookieValue);
    }else if([cookieName isEqualToString:@"rememberMe"]){
      hasFoundRememberMe = YES;
      NSLog(@"Found cookie \"%@=%@\" in sharedHTTPCookieStorage!", cookieName, cookieValue);
    }else if([cookieName isEqualToString:@"Login"]){
      if ([cookieValue isEqualToString:@"true"]){
        loginIsTrue = YES;
      }
    }
  }
  
  if (hasFoundUserNameInCookie && hasFoundRememberMe && loginIsTrue) {
    NSLog(@"User already logged in!");
    return YES;
  }else{
    NSLog(@"User needs to log in!");
    return NO;
  }
}

- (void)showAllSavedCookies {
  NSArray * cookies  = [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies;
  NSString *cookieName, *cookieValue;
  
  NSLog(@"Dump save cookies start: ===========");
  for (int i = 0; i < cookies.count; i++){
    cookieName = [[cookies objectAtIndex:i] name];
    cookieValue = [(NSHTTPCookie *)[cookies objectAtIndex:i] value];
    NSLog(@"Found cookie \"%@=%@\" in sharedHTTPCookieStorage!", cookieName, cookieValue);
  }
  NSLog(@"Dump save cookies end: ===========");
}*/

@end
