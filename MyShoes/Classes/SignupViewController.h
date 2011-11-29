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

@interface SignupViewController : UIViewController




@property (nonatomic, retain) NetworkTool *networkTool;
@property (nonatomic, retain) NetworkTool *networkTool2;
@property (retain, nonatomic) UIActivityIndicatorView *loadingIndicator;
@property (nonatomic, assign) id <SignupViewControllerDelegate>   delegate;

- (IBAction)cancelSignup:(id)sender;
- (IBAction)confirmSignup:(id)sender;
//- (IBAction)usernameChanged:(id)sender;

@end
