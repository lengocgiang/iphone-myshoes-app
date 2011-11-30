//
//  SecondViewController.h
//  LoginShoes
//
//  Created by Yi Shen on 10/19/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkTool.h"

@interface SearchViewController : UIViewController<UITableViewDelegate, 
                                  UITableViewDataSource,
                                  UITextFieldDelegate>

@property (nonatomic, retain) NetworkTool *networkTool;
@property (retain, nonatomic) UIActivityIndicatorView *loadingIndicator;
@property (retain, nonatomic) IBOutlet UITextField *searchKey;
@property (retain, nonatomic) NSMutableArray *searchKeyArray;
@property (retain, nonatomic) IBOutlet UITableView *searchHistory;


- (IBAction)cancelSearch:(id)sender;
- (IBAction)clearSearch:(id)sender;
- (void)loadSearchResultWithKey:(NSString *)key;

@end
