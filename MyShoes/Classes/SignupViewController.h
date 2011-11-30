//
//  SignupViewController.h
//  MyShoes
//
//  Created by Yi Shen on 11/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkTool.h"

@protocol SignupViewControllerDelegate 
- (void)signupViewConfirm:(id)sender;
- (void)signupViewCancel:(id)sender;
@end 

@interface SignupViewController : UIViewController<UITextFieldDelegate>




@property (nonatomic, retain) NetworkTool *networkTool;
@property (nonatomic, retain) NetworkTool *networkTool2;
@property (retain, nonatomic) UIActivityIndicatorView *loadingIndicator;
@property (nonatomic, assign) id <SignupViewControllerDelegate>   delegate;

@property (retain, nonatomic) IBOutlet UITextField *firstName;
@property (retain, nonatomic) IBOutlet UITextField *lastName;
@property (retain, nonatomic) IBOutlet UITextField *emailAddress;
@property (retain, nonatomic) IBOutlet UITextField *password;
@property (retain, nonatomic) IBOutlet UITextField *passwordConfirm;
@property (retain, nonatomic) IBOutlet UITextField *passwordAnswer;
@property (retain, nonatomic) IBOutlet UISwitch *receiveMail;


- (IBAction)cancelSignup:(id)sender;
- (IBAction)confirmSignup:(id)sender;
//- (IBAction)usernameChanged:(id)sender;

@end
