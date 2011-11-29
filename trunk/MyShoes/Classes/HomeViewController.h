//
//  HomeViewController.h
//  MyShoes
//
//  Created by Congpeng Ma on 19/09/11.
//  Copyright 2011 18m. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewBtnCell.h"
#import "CustomNavigationController.h"
#import "LoginViewController.h"
#import "SignupViewController.h"

@interface HomeViewController : UIViewController <UITableViewDelegate, 
                                UITableViewDataSource, 
                                ShoesViewProtocol, 
                                LoginViewControllerDelegate, 
                                SignupViewControllerDelegate>{
  
  UIButton *browserCategoryBtn;
  UIButton *onSaleBtn;
  
  NSArray  *btnNameArray;
  UITableView *aTableViewBtn;
  IBOutlet HomeViewBtnCell *btnCell;
}

@property (nonatomic, retain) IBOutlet UIButton *browserCategoryBtn;
@property (nonatomic, retain) IBOutlet UIButton *onSaleBtn;
@property (nonatomic, retain) UITableView *aTableViewBtn;
@property (retain, nonatomic) IBOutlet UIToolbar *loginToolbar;

+ (UIImage *)scale:(UIImage *)image toSize:(CGSize)size;
- (IBAction) browserCategory;
- (IBAction) browserOnSale;

- (IBAction)launchLogin:(id)sender;
- (IBAction)launchSignup:(id)sender;

@end
