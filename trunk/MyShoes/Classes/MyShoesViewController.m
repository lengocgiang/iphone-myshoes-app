//
//  MyShoesViewController.m
//  MyShoes
//
//  Created by Denny Ma on 27/01/11.
//  Copyright 2011 Mbi. All rights reserved.
//

#import "MyShoesViewController.h"

@implementation MyShoesViewController

@synthesize contentView;
@synthesize progressIndicator;
@synthesize shoesImage;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
  [super viewDidLoad];
  //Hide progress indicator
  //[progressIndicator removeFromSuperview];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void) startAnimation {
  [contentView addSubview:progressIndicator];
  [progressIndicator startAnimating];
}

- (void) stopAnimation {
  [progressIndicator stopAnimating];
  [progressIndicator removeFromSuperview];
}

- (void) showShoesImage:(NSString *) imageUrl {
  //Start animation
  [self startAnimation];
  
  NSURL *url = [NSURL URLWithString:imageUrl];
  NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
  
  [shoesImage loadRequest:requestObj];
  [self stopAnimation];
}

- (void)dealloc {
    [super dealloc];
}

@end
