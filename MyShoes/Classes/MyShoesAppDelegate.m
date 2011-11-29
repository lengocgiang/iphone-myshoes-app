//
//  MyShoesAppDelegate.m
//  MyShoes
//
//  Created by Denny Ma on 27/01/11.
//  Copyright 2011 Mbi. All rights reserved.
//

#import "MyShoesAppDelegate.h"
#import "ShoesListViewController.h"
#import "TFHpple.h"

@implementation MyShoesAppDelegate

@synthesize window;
@synthesize homeViewController;
@synthesize shoesCategoryController;
@synthesize shoesSecondaryCategoryController;
@synthesize shoesListController;
@synthesize shoesDetailController;
@synthesize shoppingCartController;
@synthesize settingController;
@synthesize loginViewController;
@synthesize signupViewController;
@synthesize myAccountController;
@synthesize searchController;
@synthesize shoppingCart;

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
  
  shoesSecondaryCategoryController = [[ShoesSecondaryCategoryViewController alloc]
                             initWithNibName:@"ShoesSecondaryCategoryViewController" 
                             bundle:nil];
  shoesSecondaryCategoryController.title = SECONDARY_CATEGORY_NAV_TITLE_NAME;
  
  shoesListController = [[ShoesListViewController alloc]
                              initWithNibName:@"ShoesListViewController" 
                                       bundle:nil];
  shoesListController.title = SHOESLIST_NAV_TITLE_NAME;
  
  shoesDetailController = [[ShoesDetailViewController alloc]
                              initWithNibName:@"ShoesDetailViewController"
                                       bundle:nil];
  
  shoppingCartController = [[ShoppingCartViewController alloc]
                           initWithNibName:@"ShoppingCartViewController"
                           bundle:nil];
  shoppingCartController.title = CART_NAV_TITLE_NAME;


  //shoesDetailController.title = 
  //Add tabBar Controller
  tabController = [[UITabBarController alloc] init];
  
  homeNavController = [[CustomNavigationController alloc] init];
  //homeNavController = [[UINavigationController alloc] init];
  homeNavController.delegate = self;
  [homeNavController pushViewController:homeViewController animated:NO];
  
  homeViewController.title = HOME_NAVE_TITLE_NAME;
  
  UIBarButtonItem *backButton = [[[UIBarButtonItem alloc] initWithTitle:TAB_HOME_NAV_NAME	 
                                                                  style:UIBarButtonItemStyleBordered	 
                                                                 target:nil action:nil] autorelease];
  homeViewController.navigationItem.backBarButtonItem = backButton;
  
  //Init the search navigator and sub views
  searchNavController = [[CustomNavigationController alloc] init];
  searchNavController.delegate = self;
  searchController = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
  [searchNavController pushViewController:searchController animated:NO];

  //Init the myAccount navigator and sub views
  myAccountNavController = [[CustomNavigationController alloc] init];
  myAccountNavController.delegate = self;
  myAccountController = [[MyAccountViewController alloc] initWithNibName:@"MyAccountViewController" bundle:nil];
  [myAccountNavController pushViewController:myAccountController animated:NO];
  
  //Init the login View which can be reused
  loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" 
                                                              bundle:nil];
  //loginViewController.title = LOGIN_NAV_TITLE_NAME;
  
  
  //Init the signup View which can be reused
  signupViewController = [[SignupViewController alloc] initWithNibName:@"SignupViewController" 
                                                              bundle:nil];
  
  //Init the setting navigator and sub views
  settingNavController = [[CustomNavigationController alloc] init];
  settingNavController.delegate = self;
  settingController = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
  [settingNavController pushViewController:settingController animated:NO];
  
  //Add the UITabBarItem for home navigator
  UITabBarItem *homeItem = [[UITabBarItem alloc] initWithTitle:TAB_HOME_NAV_NAME 
                                                          image:[UIImage imageNamed:TAB_HOME_NAV_PNG] 
                                                            tag:0];
  homeNavController.tabBarItem = homeItem;

  //Add the UITabBarItem for search navigator
  UITabBarItem *searchItem = [[UITabBarItem alloc] initWithTitle:TAB_SEARCH_NAV_NAME 
                                                         image:[UIImage imageNamed:TAB_SEARCH_NAV_PNG] 
                                                           tag:0];
  searchNavController.tabBarItem = searchItem;

  //Add the UITabBarItem for myAccount navigator
  UITabBarItem *myAccountItem = [[UITabBarItem alloc] initWithTitle:TAB_MYACCOUNT_NAV_NAME 
                                                             image:[UIImage imageNamed:TAB_MYACCOUNT_NAV_PNG] 
                                                               tag:1];
  myAccountNavController.tabBarItem = myAccountItem;

  //Add the UITabBarItem for setting navigator
  UITabBarItem *settingItem = [[UITabBarItem alloc] initWithTitle:TAB_SETTING_NAV_NAME 
                                                          image:[UIImage imageNamed:TAB_SETTING_NAV_PNG] 
                                                            tag:2];
  settingNavController.tabBarItem = settingItem;
  
  [homeItem release];
  [searchItem release];
  [myAccountItem release];
  [settingItem release];
  //[rightButton 
  //[rightButton release];
  
  tabController.viewControllers = [NSArray arrayWithObjects:
                                   homeNavController,
                                   searchNavController,
                                   myAccountNavController, 
                                   settingNavController, nil];
  
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
  
  //Init shopping cart object
  shoppingCart = [[ShoppingCart alloc] init];

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
  [shoppingCart release];
  [shoesDetailController release];
  [shoesListController release];
  [shoesCategoryController release];
  [homeNavController release];
  [settingNavController release];
  [settingController release];
  [myAccountNavController release];
  [loginViewController release];
  [signupViewController release];
  [myAccountController release];
  [searchController release];
  [searchNavController release];
  [tabController release];
  [window release];
	
  [super dealloc];
}

#pragma mark -
#pragma mark track back btn of navigation bar methods

//After the new shows up, it will be set as a previous view
- (void)navigationController:(UINavigationController *)navigationController didPopViewController:(UIViewController *)viewController animated:(BOOL)animated
{
  id currentView;
  
  currentView = viewController;
  
  if (navigationController == homeNavController){
    //Reset previous View
    if ([currentView conformsToProtocol:@protocol(ShoesViewProtocol)]){
      [currentView resetView];
    }
  }
}

@end
