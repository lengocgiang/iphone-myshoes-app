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
#import "ShoesListViewController.h"
#import "HomeViewController.h"
#import "ShoesCategoryViewController.h"
#import "Debug.h"

@class Reachability;

@interface MyShoesAppDelegate : NSObject <UIApplicationDelegate> {
  UIWindow *window;
  
  UITabBarController *tabController;
  
  UINavigationController *homeNavController;
  
	ShoesListViewController *shoesListController;
  ShoesCategoryViewController *shoesCategoryController;
  HomeViewController *homeViewController;
  
  //Reachability object
  Reachability *_hostReach;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet HomeViewController *homeViewController;
@property (nonatomic, retain) ShoesListViewController *shoesListController;
@property (nonatomic, retain) ShoesCategoryViewController *shoesCategoryController;

+ (BOOL) IsEnableWIFI;
+ (BOOL) IsEnable3G;

@end

