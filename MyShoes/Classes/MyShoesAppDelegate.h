//
//  MyShoesAppDelegate.h
//  MyShoes
//
//  Created by Denny Ma on 27/01/11.
//  Copyright 2011 Mbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "Config.h"
#import "NetworkTool.h"
#import "HomeViewController.h"
#import "ShoesCategoryViewController.h"
#import "ShoesSecondaryCategoryViewController.h"
#import "ShoesListViewController.h"
#import "ShoesDetailViewController.h"
#import "ShoppingCartViewController.h"
#import "ShoppingCart.h"
#import "Debug.h"

@class Reachability;

@interface MyShoesAppDelegate : NSObject <UIApplicationDelegate> {
  UIWindow *window;
  
  UITabBarController *tabController;
  
  UINavigationController *homeNavController;
  
  HomeViewController *homeViewController;
  ShoesCategoryViewController *shoesCategoryController;
  ShoesSecondaryCategoryViewController *shoesSecondaryCategoryController;
	ShoesListViewController *shoesListController;
  ShoesDetailViewController *shoesDetailController;
  ShoppingCartViewController *shoppingCartController;
  ShoppingCart *shoppingCart;
  
  
  //Reachability object
  Reachability *_hostReach;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet HomeViewController *homeViewController;
@property (nonatomic, retain) ShoesCategoryViewController *shoesCategoryController;
@property (nonatomic, retain) ShoesSecondaryCategoryViewController *shoesSecondaryCategoryController;
@property (nonatomic, retain) ShoesListViewController *shoesListController;
@property (nonatomic, retain) ShoesDetailViewController *shoesDetailController;
@property (nonatomic, retain) ShoppingCartViewController *shoppingCartController;
@property (nonatomic, retain) ShoppingCart *shoppingCart;

+ (BOOL) IsEnableWIFI;
+ (BOOL) IsEnable3G;

@end

