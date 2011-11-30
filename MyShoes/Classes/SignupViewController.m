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

@synthesize firstName;
@synthesize lastName;
@synthesize emailAddress;
@synthesize password;
@synthesize passwordConfirm;
@synthesize passwordAnswer;
@synthesize receiveMail;

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
  
  [firstName release];
  [lastName release];
  [emailAddress release];
  [password release];
  [passwordConfirm release];
  [passwordAnswer release];
  [receiveMail release];
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
  [firstName becomeFirstResponder];
}

- (void)viewDidUnload
{
  [self setFirstName:nil];
  [self setLastName:nil];
  [self setEmailAddress:nil];
  [self setPassword:nil];
  [self setPasswordConfirm:nil];
  [self setPasswordAnswer:nil];
  [self setReceiveMail:nil];
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
  [self.networkTool getContent:SHOES_SIGNUP_URL 
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
    viewState = SHOES_SIGNUP_INPUT_VIEWSTATE_VALUE;
  }
  [xpathParser release];
  
  if (!self.networkTool2) {
    self.networkTool2 = [[NetworkTool alloc] init];
  }
  
  //(value, key) pairs
  NSDictionary *signupFormDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                  viewState, SHOES_LOGIN_INPUT_VIEWSTATE_ID, 
                                  firstName.text, SHOES_SIGNUP_INPUT_FIRSTNAME, 
                                  lastName.text, SHOES_SIGNUP_INPUT_LASTNAME,
                                  emailAddress.text, SHOES_SIGNUP_INPUT_EMAIL,
                                  password.text, SHOES_SIGNUP_INPUT_PASSWORD,
                                  passwordConfirm.text, SHOES_SIGNUP_INPUT_PASSWORD_CONFIRM,
                                  
                                  //disable password question for now, use password as the default value instead
                                  @"1", SHOES_SIGNUP_INPUT_PASSWORD_QUESTION,
                                  //passwordAnswer.text, SHOES_SIGNUP_INPUT_PASSWORD_ANSWER,
                                  password.text, SHOES_SIGNUP_INPUT_PASSWORD_ANSWER,
                                  receiveMail.isOn?@"on":@"off", SHOES_SIGNUP_INPUT_SUBSCRIBE,
                                  @"35", SHOES_SIGNUP_INPUT_BTN_X_ID, 
                                  @"12", SHOES_SIGNUP_INPUT_BTN_Y_ID,                         
                                  SHOES_LOGIN_VALUE_EMPTY, SHOES_LOGIN_INPUT_EVENTTARGET_ID, 
                                  SHOES_LOGIN_VALUE_EMPTY, SHOES_LOGIN_INPUT_EVENTARGUMENT_ID, 
                                  SHOES_LOGIN_VALUE_EMPTY, SHOES_LOGIN_INPUT_VIEWSTATEENCRYPTED_ID,                         
                                  nil];
  
  [self.networkTool2 sendFormWithDelegate:self 
                          requestSelector:@selector(updateData:) 
                                 formDict:signupFormDict
                            formActionUrl:[NSURL URLWithString:SHOES_SIGNUP_URL]
   ];
}


- (void)updateData:(NSData *)content {
  [loadingIndicator stopAnimating];
  [loadingIndicator removeFromSuperview];
  
  
  NSString *bodyDataString = [[[NSString alloc] initWithData:content 
                                                    encoding:NSASCIIStringEncoding] autorelease];
  NSLog(@"bodyData=%@", bodyDataString);
  
  // Create parser
  NSString *errorMessage = nil;
  TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:content];
  
  NSArray *elements  = [xpathParser search:SHOES_SIGNUP_XPATH_EMAIL_EXIST];
  if((elements != nil) && ([elements count] > 0)){
    errorMessage = @"The email address you entered already exists in our records. Please log in to your account or enter a different email address to create a new account.";
  }else{
    elements  = [xpathParser search:SHOES_SIGNUP_XPATH_PASSWORD_REG];
    if((elements != nil) && ([elements count] > 0)){
      errorMessage = @"The Password you entered did not meet the required format. Passwords must be 6-12 alphanumeric characters. Please select a new Password and try again.";
    }else{
      elements  = [xpathParser search:SHOES_SIGNUP_XPATH_PASSWORD_COMPARE];
      if((elements != nil) && ([elements count] > 0)){
        errorMessage = @"The new Password and new password confirmation you entered do not match.  Please re-enter them and try again.";
      }else{
        // check whether we are still in sign up page
        elements  = [xpathParser search:SHOES_SIGNUP_XPATH_EMAIL_ADDRESS];
        if((elements != nil) && ([elements count] > 0)){
          errorMessage = @"We're sorry, we were unable to submit your information because some required fields were left blank or contained errors. Please complete the areas and try again.";
        }
      }
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

#pragma mark - UITextFieldDelegate method
- (BOOL) textFieldShouldReturn:(UITextField *)textField {
  switch (textField.tag) {
    case 0:
      if (firstName.text.length == 0) {
        return NO;
      }
      [lastName becomeFirstResponder];
      break;
    case 1:
      if (lastName.text.length == 0) {
        return NO;
      }
      [emailAddress becomeFirstResponder];
      break;
    case 2:
      if (emailAddress.text.length == 0) {
        return NO;
      }
      [password becomeFirstResponder];
      break;
    case 3:
      [passwordConfirm becomeFirstResponder];
      break;
    case 4:
      //[receiveMail becomeFirstResponder];
      [textField resignFirstResponder];
      break;
    default:
      [textField resignFirstResponder];
      break;
  }
  return YES;
}

- (BOOL) textFieldShouldEndEditing:(UITextField *)textField{
  
  switch (textField.tag) {
    case 0:
      if (firstName.text.length == 0) {
        UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Sorry!" 
                                                             message:@"This is a required field which could not be left blank."
                                                            delegate:self 
                                                   cancelButtonTitle:@"OK" 
                                                   otherButtonTitles:nil, nil] autorelease] ;
        [alertView show];
        return NO;
      }
      break;
    case 1:
      if (lastName.text.length == 0) {
        UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Sorry!" 
                                                             message:@"This is a required field which could not be left blank."
                                                            delegate:self 
                                                   cancelButtonTitle:@"OK" 
                                                   otherButtonTitles:nil, nil] autorelease] ;
        [alertView show];
        return NO;
      }
      break;
    case 2:
      if (emailAddress.text.length == 0) {
        UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Sorry!" 
                                                             message:@"This is a required field which could not be left blank."
                                                            delegate:self 
                                                   cancelButtonTitle:@"OK" 
                                                   otherButtonTitles:nil, nil] autorelease] ;
        [alertView show];
        return NO;
      }
      break;
    case 3:
      if (password.text.length < 6 || password.text.length > 12) {
        UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Sorry!" 
                                                             message:@"The Password you entered did not meet the required format. Passwords must be 6-12 alphanumeric characters. Please select a new Password and try again."
                                                            delegate:self 
                                                   cancelButtonTitle:@"OK" 
                                                   otherButtonTitles:nil, nil] autorelease] ;
        [alertView show];
        return NO;
      }
      break;
    case 4:
      if (![passwordConfirm.text isEqualToString:password.text]) {
        UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Sorry!" 
                                                             message:@"The new Password and new password confirmation you entered do not match.  Please re-enter them and try again."
                                                            delegate:self 
                                                   cancelButtonTitle:@"OK" 
                                                   otherButtonTitles:nil, nil] autorelease] ;
        [alertView show];
        // return YES here so we allow user to change the password instead of sticking here
        // if he already forget the password he set in above field.
        return YES;
      }
      break;
    default:
      break;
  }
  return YES;
}

@end
