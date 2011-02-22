//
//  MyShoesViewController.m
//  MyShoes
//
//  Created by Denny Ma on 27/01/11.
//  Copyright 2011 Mbi. All rights reserved.
//

#import "MyShoesViewController.h"
#import "UIImage+Alpha.h"
#import "UIImage+Resize.h"
#import "UIImage+RoundedCorner.h"
#import <QuartzCore/QuartzCore.h>

@implementation MyShoesViewController

@synthesize contentView;
@synthesize progressIndicator;
//@synthesize shoesImage;
@synthesize slideImageView;
@synthesize imageArray = _imageArray;
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
  //Add slide Image View

  NSMutableArray* images = [NSMutableArray arrayWithCapacity:CAPACITY_SHOES_LIST];
	
	for(int i=0; i<CATEGORY_SHOES_COUNT; i++)
	{
		// Rounded rect is nice
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-320.0f, 0.0f, 135.0f, 135.0f)];
		
		// Give the buttons a width of 100 and a height of 30. The slide menu will take care of positioning the buttons.
		// If you don't know that 100 will be enough, use my function to calculate the length of a string. You find it on my blog.
		/*[btn setFrame:CGRectMake(0.0f, 20.0f, 50.0f, 50.0f)];
		[btn setTitle:scategoryName forState:UIControlStateNormal];		
		[btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];*/
    //imageView.scalesPageToFit = YES;
    imageView.backgroundColor = [UIColor clearColor];
    imageView.layer.cornerRadius = ((imageView.frame.size.width)/135.0f)*SHOES_IMAGE_CORNER_RADIUS;
    imageView.clipsToBounds = YES;
		[images addObject:imageView];
    imageView.contentMode = UIViewContentModeScaleToFill;
    
    //hide all imageview in the very beginning
    imageView.hidden = YES;
		
    [imageView release];
		//[btn release];
	}
	
  self.imageArray = [[images copy] autorelease];
  /*self.slideImageView = [[SlideImageView alloc] initWithFrameColorAndImages:CGRectMake(0.0f, 0.0f, 320.0f,  280.0f) 
                                                            backgroundColor:[UIColor grayColor]  
                                                                     images:self.imageArray];*/
  [self.slideImageView setupImages:self.imageArray];
  //[self.contentView addSubview:self.slideImageView];
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
  slideImageView.hidden = YES;
  progressIndicator.hidden = NO;
  [progressIndicator startAnimating];
}

- (void) stopAnimation {
  [progressIndicator stopAnimating];
  progressIndicator.hidden = YES;
  [UIView beginAnimations:nil context:nil];
  slideImageView.hidden = NO;
  [UIView commitAnimations];
}

- (void) showShoes:(NSArray *) shoesArray {

  //Start animation
  [self startAnimation];
  int i=0;
  
  for (Shoes *shoes in shoesArray){
    
    NSString *imageName = shoes.shoesImageName;
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@",MYSHOES_URL,imageName];
    
    NSURL *url = [NSURL URLWithString:imageUrl];
    //NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
  
    UIImage *image = [[UIImage imageWithData: [NSData dataWithContentsOfURL: url]] retain];
    //UIImage *roundImage = [image roundedCornerImage:SHOES_IMAGE_CORNER_RADIUS borderSize:SHOES_IMAGE_BORDER_SIZE];
    
    if (i< [self.imageArray count]){
      UIImageView *imageView;
      imageView = [self.imageArray objectAtIndex:i++];
      //[imageView loadRequest:requestObj];
      imageView.image = image;
      
      imageView.hidden = NO;

    }
    [image release];
  }
  [self stopAnimation];
}

- (void)dealloc {
    [super dealloc];
}

@end
