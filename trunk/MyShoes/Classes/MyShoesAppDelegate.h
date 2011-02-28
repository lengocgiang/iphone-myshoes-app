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
#import "ContentUpdater.h"
//#import "SlideMenuView.h"
//#import "SlideMenuViewController.h"
#import "MyShoesViewController.h"
#import "Debug.h"

//#import "OrderedDictionary.h"

//@class MyShoesViewController;
@class Reachability;

@interface MyShoesAppDelegate : NSObject <UIApplicationDelegate> {
  UIWindow *window;
	MyShoesViewController *contentViewController;
	//SlideMenuViewController *slideMenuViewController;
	//key value:XPATH value of category, url of the category
	//NSMutableDictionary *_shoesCategoryDict;
  
  //Reachability object
  Reachability *_hostReach;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MyShoesViewController *contentViewController;
//@property (nonatomic, retain) SlideMenuViewController *slideMenuViewController;
//@property (nonatomic, retain) NSMutableDictionary *shoesCategoryDict;

+ (BOOL) IsEnableWIFI;
+ (BOOL) IsEnable3G;

@end

