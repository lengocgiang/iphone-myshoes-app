//
//  LoginViewController.h
//  LoginShoes
//
//  Created by Yi Shen on 10/19/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkTool.h"

@protocol LoginViewControllerDelegate 
- (void)loginViewConfirm:(id)sender;
- (void)loginViewCancel:(id)sender;
@end 

@interface LoginViewController : UIViewController{
  id <LoginViewControllerDelegate>   delegate;
}

@property (retain, nonatomic) IBOutlet UITextField *userID;
@property (retain, nonatomic) IBOutlet UITextField *password;
@property (retain, nonatomic) IBOutlet UIButton *loginButton;

@property (nonatomic, retain) NetworkTool *networkTool;
@property (nonatomic, retain) NetworkTool *networkTool2;
@property (retain, nonatomic) UIActivityIndicatorView *loadingIndicator;
@property (nonatomic, assign) id <LoginViewControllerDelegate>   delegate;

- (IBAction)cancelLogin:(id)sender;
- (IBAction)confirmLogin:(id)sender;
- (IBAction)usernameChanged:(id)sender;

//- (BOOL)hasUserLoggedIn;
//- (void)showAllSavedCookies;

@end
