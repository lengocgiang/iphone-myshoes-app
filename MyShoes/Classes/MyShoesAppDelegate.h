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
#import "CustomNavigationController.h"
#import "SettingViewController.h"
#import "MyAccountViewController.h"
#import "SearchViewController.h"
#import "LoginViewController.h"
#import "SignupViewController.h"
#import "Debug.h"

//@class ShoesDetailViewController;
@class Reachability;

@interface MyShoesAppDelegate : NSObject <UIApplicationDelegate,CustomNavigationControllerDelegate> {
  UIWindow *window;
  
  UITabBarController *tabController;
  
  //UINavigationController *homeNavController;
  CustomNavigationController *homeNavController;
  CustomNavigationController *searchNavController;
  CustomNavigationController *myAccountNavController;
  CustomNavigationController *settingNavController;  
  
  //All sub views of the home navigator controller
  HomeViewController *homeViewController;  
  ShoesCategoryViewController *shoesCategoryController;
  ShoesSecondaryCategoryViewController *shoesSecondaryCategoryController;
	ShoesListViewController *shoesListController;
  ShoesDetailViewController *shoesDetailController;
  ShoppingCartViewController *shoppingCartController;
  
  //All sub views of the search navigator controller
  SearchViewController *searchController;
  
  //All sub views of the account navigator controller
  LoginViewController * loginViewController;
  SignupViewController * signupViewController;  
  MyAccountViewController *myAccountController;
  
  //All sub views of the setting navigator controller
  SettingViewController *settingController;
  
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
@property (nonatomic, retain) SettingViewController *settingController;
@property (nonatomic, retain) LoginViewController * loginViewController;
@property (nonatomic, retain) SignupViewController * signupViewController;
@property (nonatomic, retain) MyAccountViewController *myAccountController;
@property (nonatomic, retain) SearchViewController *searchController;
@property (nonatomic, retain) ShoppingCart *shoppingCart;

+ (BOOL) IsEnableWIFI;
+ (BOOL) IsEnable3G;

@end