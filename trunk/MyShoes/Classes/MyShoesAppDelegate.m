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
@synthesize contentViewController;
@synthesize slideMenuViewController;
@synthesize shoesCategoryDict = _shoesCategoryDict;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.

	debug_NSLog(@"This is the start point of init data and fetching all data refreshed");	

	//ContentUpdater * cu = [[[ContentUpdater alloc] init] autorelease];
	// initialize the slide menu by passing a suitable frame, background color and an array of buttons.
  /* slideMenuView = [[SlideMenuView alloc] initWithFrameColorAndButtons:CGRectMake(0.0f, [window bounds].size.height - 80.0f, [window bounds].size.width,  80.0f) backgroundColor:[UIColor grayColor]  buttons:buttonArray];
	
	// Add the slide menu to the window.
	[self.window addSubview:slideMenuView];*/
	// Add the view controller's view to the window and display.
	_shoesCategoryDict = [[OrderedDictionary alloc] init];
/*	[_shoesCategoryDict setObject:[[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_WOMEN_NAME andXPath:SHOES_CATEGORY_WOMEN_XPATH] autorelease] forKey:SHOES_CATEGORY_WOMEN_NAME];
	[_shoesCategoryDict setObject:[[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_MEN_NAME andXPath:SHOES_CATEGORY_MEN_XPATH] autorelease] forKey:SHOES_CATEGORY_MEN_NAME];
	[_shoesCategoryDict setObject:[[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_GIRLS_NAME andXPath:SHOES_CATEGORY_GIRLS_XPATH] autorelease] forKey:SHOES_CATEGORY_GIRLS_NAME];
	[_shoesCategoryDict setObject:[[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_BOYS_NAME andXPath:SHOES_CATEGORY_BOYS_XPATH] autorelease] forKey:SHOES_CATEGORY_BOYS_NAME];*/
  //Setup category for women
  ShoesCategory *category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_WOMEN_NAME andXPath:SHOES_CATEGORY_WOMEN_XPATH] autorelease];
  category.categoryURI = SHOES_CATEGORY_WOMEN_URI_12ITEM;
	[_shoesCategoryDict setObject: category forKey:SHOES_CATEGORY_WOMEN_NAME];
  //Setup category for men
  //[category autorelease];
  category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_MEN_NAME andXPath:SHOES_CATEGORY_MEN_XPATH] autorelease];
  category.categoryURI = SHOES_CATEGORY_MEN_URI_12ITEM;
	[_shoesCategoryDict setObject:category forKey:SHOES_CATEGORY_MEN_NAME];
  //Setup category for girls
  //[category autorelease];
  category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_GIRLS_NAME andXPath:SHOES_CATEGORY_GIRLS_XPATH] autorelease];
  category.categoryURI = SHOES_CATEGORY_GIRLS_URI_12ITEM;
	[_shoesCategoryDict setObject: category forKey:SHOES_CATEGORY_GIRLS_NAME];
  //Setup category for boys
  //[category autorelease];
  category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_BOYS_NAME andXPath:SHOES_CATEGORY_BOYS_XPATH] autorelease];
  category.categoryURI = SHOES_CATEGORY_BOYS_URI_12ITEM;
	[_shoesCategoryDict setObject:category forKey:SHOES_CATEGORY_BOYS_NAME];
  
  [self.window addSubview:contentViewController.view];
	slideMenuViewController = [[SlideMenuViewController alloc] initWithCategories:_shoesCategoryDict];
  
	[self.window addSubview:slideMenuViewController.view];
  [self.window makeKeyAndVisible];
  
  //Test network reachability
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(reachabilityChanged:)
                                               name: kReachabilityChangedNotification
                                             object: nil];
  _hostReach = [[Reachability reachabilityWithHostName:@"www.shoes.com"] retain];
  [_hostReach startNotifier];
  [_hostReach release];
	
  //The shoes category link is hard coded
  
	//[cu getContent:MYSHOES_URL withDelegate:self requestSelector:@selector(shoesCategoryUdateCallbackWithData:)];
  //[contentViewController startAnimation];
	
  //[contentViewController stopAnimation];
  return YES;
}

/*- (void)shoesCategoryUdateCallbackWithData: (NSData *) content {
	
	//debug_NSLog(@"%@",[[[NSString alloc] initWithData:content encoding:NSASCIIStringEncoding] autorelease]);
	// Create parser
	TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:content];
	
	//Init all categories in the dictionary
	for(NSString* scategoryName in [self.shoesCategoryDict allKeys]){
		//Get sublink to Women category
		ShoesCategory * category = [self.shoesCategoryDict objectForKey:scategoryName];
		
		NSArray *elements  = [xpathParser search:category.categoryXPath];
		
		// Access the first cell
		TFHppleElement *element = [elements objectAtIndex:0];
		
		// Get the link information within the cell tag
		NSString *value = [element objectForKey:HREF_TAG];
		//update the value of category directory
		//[self.shoesCategoryDict setObject:value forKey:scategory];
		category.categoryURI = value;
	}
	
  [contentViewController stopAnimation];
	
	[xpathParser release];
	//[content release];
}*/

/*- (void)buttonPressed:(id)sender {
	//screenLabel.text = ((UIButton*)sender).currentTitle;
	NSLog(@"The button pressed is:%@",((UIButton*)sender).currentTitle);
	
	//add an effect showing the button bigger	
	[(UIButton*)sender setFrame:CGRectMake(5.0f, 0.0f, 60.0f, 60.0f)];
}*/

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
	[slideMenuViewController release];
    [window release];
	
	[_shoesCategoryDict release];
    [super dealloc];
}


@end
