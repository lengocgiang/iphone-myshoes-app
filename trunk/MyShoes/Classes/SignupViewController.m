//
//  SignupViewController.m
//  MyShoes
//
//  Created by Yi Shen on 11/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SignupViewController.h"
#import "TFHpple.h"
#import "TFHppleElement+AccessChildren.h"
#import "Config.h"

@implementation SignupViewController

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

- (void)viewDidUnload
{
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
  
  [self setLoadingIndicator:nil];
  [self setNetworkTool:nil];
  [self setNetworkTool2:nil];  
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  // Return YES for supported orientations
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - sign up related

- (IBAction)cancelSignup:(id)sender{
  [self.delegate signupViewCancel:self];
}

- (IBAction)confirmSignup:(id)sender{
  NSLog(@"confirmSignup");
  // hide keyboard
  //[userID resignFirstResponder];
  //[password resignFirstResponder];
  
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
    self.networkTool = [[NetworkTool alloc] init];
  }
  
  //Issue the request of the selected category
  [self.networkTool getContent:@"https://secure.shoes.com/Profiles/CreateAccount.aspx" 
                  withDelegate:self 
               requestSelector:@selector(buildSignupFormDict:)];
  
  //[self buildSignupFormDict:nil];
}

#pragma mark - network method

- (void)buildSignupFormDict:(NSData *)content {
  NSString *viewState;
  // Create parser
  TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:content];
  NSArray *elements  = [xpathParser search:@"//*[@id='__VIEWSTATE']"];
  if((elements != nil) && ([elements count] > 0)){
    TFHppleElement *targetNode = [elements objectAtIndex:0];
    viewState = [targetNode objectForKey:VALUE_TAG];
  }else{
    // set default value here
    NSLog(@"======= NOT found viewState!!!!");
    viewState = @"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";
  }
  [xpathParser release];
  
  if (!self.networkTool2) {
    self.networkTool2 = [[NetworkTool alloc] init];
  }
  
  //(value, key) pairs
  NSDictionary *signupFormDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                 viewState, SHOES_LOGIN_INPUT_VIEWSTATE_ID, 
                                 @"779", @"ctl00$cphPageMain$ucCustomerInfo$txtFirstName", 
                                 @"y", @"ctl00$cphPageMain$ucCustomerInfo$txtLastName",
                                  @"772@777.com", @"ctl00$cphPageMain$ucCustomerInfo$txtEmailAddress",
                                  @"777777", @"ctl00$cphPageMain$ucCustomerInfo$txtPassword",
                                  @"777777", @"ctl00$cphPageMain$ucCustomerInfo$txtConfirmPassword",
                                  @"1", @"ctl00$cphPageMain$ucCustomerInfo$ddlPasswordQuestion",
                                  @"777", @"ctl00$cphPageMain$ucCustomerInfo$txtPasswordAnswer",
                                  @"on", @"ctl00$cphPageMain$ucCustomerInfo$cbSubscribe",
                                 @"35", @"ctl00$cphPageMain$imgBtnCreate.x", 
                                 @"12", @"ctl00$cphPageMain$imgBtnCreate.y",                         
                                 SHOES_LOGIN_VALUE_EMPTY, SHOES_LOGIN_INPUT_EVENTTARGET_ID, 
                                 SHOES_LOGIN_VALUE_EMPTY, SHOES_LOGIN_INPUT_EVENTARGUMENT_ID, 
                                 SHOES_LOGIN_VALUE_EMPTY, SHOES_LOGIN_INPUT_VIEWSTATEENCRYPTED_ID,                         
                                 nil];
  
  [self.networkTool2 sendFormWithDelegate:self 
                          requestSelector:@selector(updateData:) 
                                 formDict:signupFormDict
                            formActionUrl:[NSURL URLWithString:@"https://secure.shoes.com/Profiles/CreateAccount.aspx"]
   ];
}


- (void)updateData:(NSData *)content {
  [loadingIndicator stopAnimating];
  [loadingIndicator removeFromSuperview];
  
  /*
  NSString *bodyDataString = [[[NSString alloc] initWithData:content 
                                                    encoding:NSASCIIStringEncoding] autorelease];
  NSLog(@"bodyData=%@", bodyDataString);
  */
  
  // Create parser
  NSString *errorMessage = nil;
  TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:content];
  
  NSArray *elements  = [xpathParser search:@"//span[@id='ctl00_cphPageMain_ucCustomerInfo_EmailExists']"];
  if((elements != nil) && ([elements count] > 0)){
    errorMessage = @"The email address you entered already exists in our records. Please log in to your account or enter a different email address to create a new account.";
  }else{
    elements  = [xpathParser search:@"//span[@id='ctl00_cphPageMain_ucCustomerInfo_PasswordRegEx']"];
    if((elements != nil) && ([elements count] > 0)){
      errorMessage = @"The Password you entered did not meet the required format. Passwords must be 6-12 alphanumeric characters. Please select a new Password and try again.";
    }else{
      elements  = [xpathParser search:@"//span[@id='ctl00_cphPageMain_ucCustomerInfo_ComparePasswords']"];
      if((elements != nil) && ([elements count] > 0)){
        errorMessage = @"The new Password and new password confirmation you entered do not match.  Please re-enter them and try again.";
      }
      // could add more check here in the future...
    }
  
  }
  [xpathParser release];
  
  // show alert when signup failed
  if (errorMessage != nil){
    UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Sorry!" 
                                                         message:errorMessage
                                                        delegate:self 
                                               cancelButtonTitle:@"OK" 
                                               otherButtonTitles:nil, nil] autorelease] ;
    [alertView show];
    return;
  }else{
    UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Welcome!" 
                                                         message:@"Your account has been created successfully, you can sign in now!"
                                                        delegate:self 
                                               cancelButtonTitle:@"OK" 
                                               otherButtonTitles:nil, nil] autorelease] ;
    [alertView show];
  }
  
  [self.delegate signupViewConfirm:self];
}

@end
