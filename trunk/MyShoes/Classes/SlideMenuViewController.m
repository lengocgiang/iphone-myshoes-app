    //
//  SlideMenuViewController.m
//  MyShoes
//
//  Created by Denny Ma on 7/02/11.
//  Copyright 2011 Mbi. All rights reserved.
//

#import "SlideMenuViewController.h"
#import "Shoes.h"
#import "ShoesCategory.h"
#import "MyShoesAppDelegate.h"
#import "ShoesListViewController.h"
#import "TFHpple.h"
#import "TFHppleElement+AccessChildren.h"


@implementation SlideMenuViewController

@synthesize slideMenuView;
@synthesize previousButton = _previousButton;
@synthesize shoesCategoryDict = _shoesCategoryDict;
@synthesize shoesArray = _shoesArray;
@synthesize categoryButtons = _categoryButtons;
@synthesize cu = _cu;


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

- (id)init {
	
	self = [super init];
    if (self) {
        // Custom initialization.
    }
    return self;
}

- (id)initWithCategories:(NSDictionary*) dict {
	
	self = [super init];
    if (self) {
        // Custom initialization.
		_shoesCategoryDict = dict;
		
		//init the network module.
		_cu = [[NetworkTool alloc] init];
    }
    return self;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	
	self.view = [[[UIView alloc] initWithFrame:CGRectMake(0, 380, 320, 80)] autorelease];
	
	NSMutableArray* buttonArray = [NSMutableArray arrayWithCapacity:CAPACITY_SCROLL_BAR];
	
	for(NSString* scategoryName in [self.shoesCategoryDict allKeys])
	{
		// Rounded rect is nice
		UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		
		// Give the buttons a width of 100 and a height of 30. The slide menu will take care of positioning the buttons.
		// If you don't know that 100 will be enough, use my function to calculate the length of a string. You find it on my blog.
		[btn setFrame:CGRectMake(0.0f, 20.0f, 50.0f, 50.0f)];
		[btn setTitle:scategoryName forState:UIControlStateNormal];		
		[btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[buttonArray addObject:btn];
    
    //set the font of unselected btns
    btn.titleLabel.font = [UIFont systemFontOfSize:SHOES_CATEGORY_BUTTON_UNSELECTED_SIZE];
		
		//[btn release];
	}
	self.categoryButtons = buttonArray;//[[buttonArray copy] autorelease];
  // initialize the slide menu by passing a suitable frame, background color and an array of buttons.
  //slideMenuView = [[SlideMenuView alloc] initWithFrameColorAndButtons:CGRectMake(0.0f, [self.view bounds].size.height - 80.0f, [self.view bounds].size.width,  80.0f) backgroundColor:[UIColor grayColor]  buttons:buttonArray];
	self.slideMenuView = [[[SlideMenuView alloc] initWithFrameColorAndButtons:CGRectMake(0.0f, 0.0f, [self.view bounds].size.width,  [self.view bounds].size.height) 
                                                           backgroundColor:[UIColor grayColor]  
                                                                   buttons:self.categoryButtons] autorelease];

	// Add the slide menu to the window.
	[self.view addSubview:slideMenuView];
	
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)buttonPressed:(id)sender {
  //Check if there is any network available
  if(![MyShoesAppDelegate IsEnableWIFI] && ![MyShoesAppDelegate IsEnable3G]){
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"www.shoes.com"
                                                    message:@"There is no network, Check your system"
                                                   delegate:nil
                                          cancelButtonTitle:@"YES" otherButtonTitles:nil];
    [alert show];
    [alert release];

    return;
  }
  
  //Disable all buttons
  for(UIButton *btn in self.categoryButtons){
    [btn setEnabled:FALSE];
  }
  
  //Start animation
  MyShoesAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
  
  [delegate.shoesListController hideShoesListInfoLabels];
  [delegate.shoesListController startAnimation];
  
	//screenLabel.text = ((UIButton*)sender).currentTitle;
	NSLog(@"The button pressed is:%@",((UIButton*)sender).currentTitle);
	
	//set the previous button to original size
	if (self.previousButton != nil) {
		[self.previousButton setFrame:CGRectMake(5.0f, 5.0f, 50.0f, 50.0f)];
    //Change the font size of previously selected button to small one
    self.previousButton.titleLabel.font = [UIFont systemFontOfSize:SHOES_CATEGORY_BUTTON_UNSELECTED_SIZE];
	}
  
  //Change the font size of newly selected button to big one
  ((UIButton*)sender).titleLabel.font = [UIFont systemFontOfSize:SHOES_CATEGORY_BUTTON_SELECTED_SIZE];
	//add an effect showing the button bigger	
	[(UIButton*)sender setFrame:CGRectMake(0.0f, 0.0f, 60.0f, 60.0f)];
	self.previousButton = (UIButton*)sender;
	
	//get the uri for the selected category
	NSString *scategoryName = ((UIButton*)sender).currentTitle;
	ShoesCategory * category = [self.shoesCategoryDict objectForKey:scategoryName];
	
	NSString *uri = category.categoryURI;

	NSString *newUrl = [NSString stringWithFormat:@"%@%@",MYSHOES_URL,uri];
	//Issue the request of the selected category
	[_cu getContent:newUrl withDelegate:self requestSelector:@selector(shoesCategoryUdateCallbackWithData:)];
}

- (void)shoesCategoryUdateCallbackWithData: (NSData *) content {
	
	//debug_NSLog(@"%@",[[[NSString alloc] initWithData:content encoding:NSASCIIStringEncoding] autorelease]);
  NSMutableArray *shoesList = [NSMutableArray arrayWithCapacity:CAPACITY_SHOES_LIST];
  
	// Create parser
	TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:content];
	
	NSArray *elements  = [xpathParser search:SHOES_CATEGORY_PRODUCT_LIST_XPATH];
	
	// Get the link information within the cell tag
	//NSString *value = [element objectForKey:HREF_TAG];
	//NSString *str;
	
	for (TFHppleElement *element in elements) {

    Shoes *shoes = [[[Shoes alloc] initWithShoesNode:element] autorelease];
    [shoesList addObject:shoes];

		/*NSArray *children = [element childNodes];
		for (TFHppleElement *child in children) {
		}*/
	}
	
  //[self.shoesArray autorelease];
  //self.shoesArray = [shoesList copy];
  self.shoesArray = shoesList;

  //Stop Animation
  MyShoesAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
  
	[xpathParser release];
  
  //If there is any shoes come back, show the first shoes
  if ([self.shoesArray count] > 0){
    //Show the first shoes in the list
    /*Shoes *shoes = [self.shoesArray objectAtIndex:0];
    NSString *imageName = shoes.shoesImageName;
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@",MYSHOES_URL,imageName];*/
    [delegate.shoesListController showShoesList/*:self.shoesArray*/];
  }
  [delegate.shoesListController stopAnimation];
  if ([self.shoesArray count] >= 1){
    [delegate.shoesListController showShoesListInfo:[self.shoesArray objectAtIndex:0]];
  }
  
  //Enable all buttons
  //Disable all buttons
  for(UIButton *btn in self.categoryButtons){
    [btn setEnabled:TRUE];
  }

}


- (void)dealloc {
	[_cu release];
	//[slideMenuView release];
	
  [super dealloc];
}


@end
