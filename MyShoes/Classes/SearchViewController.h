//
//  SecondViewController.h
//  LoginShoes
//
//  Created by Yi Shen on 10/19/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkTool.h"

@interface SearchViewController : UIViewController

@property (retain, nonatomic) IBOutlet UIWebView *webview;
@property (nonatomic, retain) NetworkTool *networkTool;
@property (retain, nonatomic) UIActivityIndicatorView *loadingIndicator;

- (IBAction)refresh:(id)sender;

@end
