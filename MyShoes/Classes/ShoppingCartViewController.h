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

@interface ShoppingCartViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, ShoesViewProtocol> {
  //Table view for shopping cart
  UITableView *shoppingCartListView;
  
  /* The NetworkTool instance to do network communications. */
  NetworkTool *networkTool;

  //BOOL viewRested;
}

@property (nonatomic, retain) UITableView *shoppingCartListView;
@property (nonatomic, retain) NetworkTool *networkTool;

- (void)EditButtonAction:(id)sender;

@end
