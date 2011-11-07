//
//  ThirdViewController.h
//  LoginShoes
//
//  Created by Yi Shen on 10/19/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkTool.h"
#import "LoginViewController.h"

@interface MyAccountViewController : UIViewController<LoginViewControllerDelegate>

@property (retain, nonatomic) IBOutlet UIWebView *webview;
@property (nonatomic, retain) NetworkTool *networkTool;
@property (retain, nonatomic) LoginViewController * loginViewController;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *loginButton;
@property (retain, nonatomic) UIActivityIndicatorView *loadingIndicator;

- (IBAction)signin:(id)sender;

- (void)launchLoginView;
- (void)logout;

@end