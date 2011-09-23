//
//  MyShoesAppDelegate.m
//  MyShoes
//
//  Created by Denny Ma on 27/01/11.
//  Copyright 2011 Mbi. All rights reserved.
//

#import "MyShoesAppDelegate.h"
#import "MyShoesViewController.h"
#import "TFHpple.h"

@implementation MyShoesAppDelegate

@synthesize window;
@synthesize shoesListController;
@synthesize shoesCategoryController;
@synthesize homeViewController;
//@synthesize slideMenuViewController;
//@synthesize shoesCategoryDict = _shoesCategoryDict;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.

	debug_NSLog(@"This is the start point of init data and fetching all data refreshed");
  //Create Content Category list view controller
  shoesCategoryController = [[ShoesCategoryViewController alloc]
                                initWithNibName:@"ShoesCategoryViewController" 
                                         bundle:nil];
  shoesCategoryController.title = CATEGORY_NAV_TITLE_NAME;
  shoesListController = [[MyShoesViewController alloc]
                              initWithNibName:@"MyShoesViewController" 
                                       bundle:nil];
  shoesListController.title = SHOESLIST_NAV_TITLE_NAME;

  //Add tabBar Controller
  tabController = [[UITabBarController alloc] init];
  
  homeNavController = [[UINavigationController alloc] init];
  [homeNavController pushViewController:homeViewController animated:NO];
  
  /*UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                  style:UIBarButtonSystemItemDone 
                                                                 target:nil action:nil];
  homeViewController.navigationItem.rightBarButtonItem = rightButton;*/
  //homeNavController.title = TAB_HOME_NAV_NAME;
  homeViewController.title = HOME_NAVE_TITLE_NAME;
  
  UIBarButtonItem *backButton = [[[UIBarButtonItem alloc] initWithTitle:TAB_HOME_NAV_NAME	 
                                                                  style:UIBarButtonItemStyleBordered	 
                                                                 target:nil action:nil] autorelease];
  homeViewController.navigationItem.backBarButtonItem = backButton;
  
  UITabBarItem *homeItme = [[UITabBarItem alloc] initWithTitle:TAB_HOME_NAV_NAME image:[UIImage imageNamed:TAB_HOME_NAV_PNG] tag:0];
  homeNavController.tabBarItem = homeItme;
  [homeItme release];
  //[rightButton 
  //[rightButton release];
  
  tabController.viewControllers = [NSArray arrayWithObjects:homeNavController, nil];
  
  //[self.window addSubview:self.contentViewController.view];
  [window addSubview:tabController.view];
  [window makeKeyAndVisible];
  
  //[shoesViewController release];
  //Test network reachability
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(reachabilityChanged:)
                                               name: kReachabilityChangedNotification
                                             object: nil];
  _hostReach = [[Reachability reachabilityWithHostName:MYSHOES_HOSTNAME] retain];
  [_hostReach startNotifier];
  [_hostReach release];

  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}

- (void)reachabilityChanged:(NSNotification *)note {
  Reachability* curReach = [note object];
  NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
  NetworkStatus status = [curReach currentReachabilityStatus];
  
  if (status == NotReachable) {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"www.shoes.com"
                          message:@"Shoes.com can NOT be Reached"
                          delegate:nil
                          cancelButtonTitle:@"YES" otherButtonTitles:nil];
                          [alert show];
                          [alert release];
  }
}

// If WIFI ready
+ (BOOL) IsEnableWIFI {
  return ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable);
}

// If 3G ready
+ (BOOL) IsEnable3G {
  return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    //[viewController release];
	//[slideMenuViewController release];
  [shoesListController release];
  [shoesCategoryController release];
  [homeNavController release];
  [tabController release];
  [window release];
	
	//[_shoesCategoryDict release];
  [super dealloc];
}


@end
