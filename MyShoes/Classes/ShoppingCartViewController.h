//
//  ShoppingCartViewController.h
//  MyShoes
//
//  Created by Congpeng Ma on 25/10/11.
//  Copyright (c) 2011 18m. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkTool.h"
#import "CustomNavigationController.h"
#import "LoginViewController.h"
#import "MBProgressHUD.h"
#import "HJManagedImageV.h"
#import "Shoes.h"

@interface ShoppingCartViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, 
ShoesViewProtocol, UITextFieldDelegate, LoginViewControllerDelegate> {
  //Table view for shopping cart
  UITableView *shoppingCartListView;
  UIButton *checkOutBtn;

  /* The NetworkTool instance to do network communications. */
  NetworkTool *networkTool;

  //HJCache library for asynchronous image loading and caching
  HJObjManager *objMan;
  
  //The flag to show if the view is reset. If it's still in the stack of navigator, the value
  //should be false. So it won't reset it view when users come back
  //The default value is TRUE
  BOOL viewRest;
  
  //Progress indicator
  MBProgressHUD *HUD;
  //The url for shopping cart
  //It can be in two formats
  //One is when user adds shoes to shopping cart
  //The other is when user just check shopping cart
  NSString *shoppingCartURL;
  
  //Input of viewstate value in add to shopping cart form                    
  NSString *viewState;
  NSString *previousPage;
  Shoes *shoes;
}

@property (nonatomic, retain) UITableView *shoppingCartListView;
@property (nonatomic, retain) UIButton *checkOutBtn;
@property (nonatomic, retain) NetworkTool *networkTool;
//@property (nonatomic, retain) NSString *shoppingCartURL;
@property (nonatomic, retain) NSString *viewState;
@property (nonatomic, retain) NSString *previousPage;
@property (nonatomic, retain) Shoes *shoes;

- (void)EditButtonAction:(id)sender;
- (void)loadCartDetail;
- (void)loadCartDetailWithProductUrl:(NSString *)url;
- (void)renderCartDetail;
- (void)setShoppingCartURL:(NSString *)cartUrl;

@end
