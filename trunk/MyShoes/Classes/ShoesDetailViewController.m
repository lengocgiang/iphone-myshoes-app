//
//  MyShoesDetailViewController.m
//  MyShoes
//
//  Created by Denny Ma on 25/02/11.
//  Copyright 2011 Mbi. All rights reserved.
//

#import "ShoesDetailViewController.h"
#import "TFHpple.h"
#import "TFHppleElement+AccessChildren.h"
#import "MyShoesAppDelegate.h"


@implementation ShoesDetailViewController

@synthesize shoesBriefView;
@synthesize shoesBrandName;
@synthesize shoesStyle;
//@synthesize shoesColor;
@synthesize shoesPrice;
@synthesize shoesBrandLogo;
@synthesize shoesImageScrollView;
@synthesize progressIndicator;
@synthesize shoes;
@synthesize networkTool;

const CGFloat kScrollObjHeight	= 260.0;
const CGFloat kScrollViewWidth	= 320.0;
const CGFloat kScrollObjWidth	= 260.0;
//const NSUInteger kNumImages		= 8;

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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.networkTool = [[NetworkTool alloc] init];

}

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

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self loadShoesDetail];
}

- (void)viewDidDisappear:(BOOL)animated {
  //Reset shoes detail view
  self.shoesBrandLogo.image = nil;
  [self.shoesImageScrollView setHidden:YES];
  //remove all the subview os shoesImageScrollView
  for (UIView *view in [self.shoesImageScrollView subviews]) {
    [view removeFromSuperview];
  }
  [self.shoesImageScrollView setContentOffset:CGPointMake(0.0f, 0.0f) animated:NO];
  
  [self.shoesBriefView setHidden:YES];
  [self.progressIndicator startAnimating];
}


- (void)dealloc {
  [networkTool release];
  [super dealloc];
}

#pragma mark Activity Indicator methods

- (void)startAnimation {

  shoesBriefView.hidden = YES;
  shoesImageScrollView.hidden = YES;
  progressIndicator.hidden = NO;
  [progressIndicator startAnimating];
}

- (void)stopAnimation {
  [progressIndicator stopAnimating];
  progressIndicator.hidden = YES;
  [UIView beginAnimations:nil context:nil];
  shoesBriefView.hidden = NO;
  shoesImageScrollView.hidden = NO;
  [UIView commitAnimations];
}

#pragma mark Network related methods
- (void)loadShoesDetail {
  //Check if the shoes detail link is available
  if((shoes == nil) || (shoes.productDetailLink == nil)){
    return;
  }
  //[self startAnimation];
  
  NSString *newUrl = [NSString stringWithFormat:@"%@%@",MYSHOES_URL,shoes.productDetailLink];
  
  //NSLog(@"Url of shoes detail is:%@",newUrl);
	//Issue the request of the selected shoes
	[networkTool getContent:newUrl withDelegate:self requestSelector:@selector(shoesDetailUpdateCallbackWithData:)];
    

}

- (void)shoesDetailUpdateCallbackWithData: (NSData *) content {
	  
	//Create parser
	TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:content];
	
  //Process shoes SKU info
	NSArray *elements  = [xpathParser search:SHOES_DETAIL_SKU_XPATH];
  
  if((elements != nil) && ([elements count] > 0)){
    [shoes processProductSKU:[elements objectAtIndex:0]];
  }
	
  //Process shoes brand logo img info
  
  elements = [xpathParser search:SHOES_DETAIL_BRANDLOGO_IMG_XPATH];
  if((elements != nil) && ([elements count] > 0)){
    [shoes processProductBrandLogo:[elements objectAtIndex:0]];
  }
  
	// Get the link information within the cell tag
	//NSString *value = [element objectForKey:HREF_TAG];
	//NSString *str;
  
  //Stop Animation
  //MyShoesAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
  
	[xpathParser release];
  
  //Start to render shoes detail
  [self renderShoesDetail];
}

#pragma mark Shoes Rendering related methods
- (void)renderShoesDetail {
  [progressIndicator stopAnimating];
  [shoesBriefView setHidden:NO];
  [shoesImageScrollView setHidden:NO];
  
  shoesBrandName.text = shoes.productBrandName;
  shoesStyle.text = shoes.productStyle;
  shoesPrice.text = shoes.productPrice;
  
  //Render shoes brand logo img
  //imageView.image = shoes.shoesImage;
  NSString *logoName = shoes.productBrandLogo;
  NSString *imageUrl = [NSString stringWithFormat:@"%@%@",MYSHOES_URL,logoName];
  
  NSURL *url = [NSURL URLWithString:imageUrl];
  //NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
  
  UIImage *logoImage = [[UIImage imageWithData: [NSData dataWithContentsOfURL: url]] retain];
  
  CGSize sz = SHOES_DETAIL_LOGO_ING_SIZE;
  
  UIImage *resized = [HomeViewController scale:logoImage toSize:sz];
  
  //Mask the image to get rid of the white background
  
  /*
  CGImageRef ref1=[self createMask:resized];
  const float colorMasking[6] = { 255,255,255, 255,255,255 };//{1.0, 2.0, 1.0, 1.0, 1.0, 1.0};
  //const float whiteMask[6] = {222, 255, 222, 255, 222, 255};//{ 255,255,255, 255,255,255 };
  //CGImageRef New=CGImageCreateWithMaskingColors(ref1, whiteMask);
  CGImageRef New=CGImageCreateWithMaskingColors(ref1, colorMasking);
  UIImage *resultedimage=[UIImage imageWithCGImage:New];
  //const float colorMasking[6] = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0};
  //UIImage *resultedimage = [UIImage imageWithCGImage: CGImageCreateWithMaskingColors(resized.CGImage, colorMasking)];
  self.shoesBrandLogo.image = resultedimage;*/
  
  //The follwing code is to process image to get rid of white background and make it transparent
  //Process and render shoes brand logo
  CGImageRef maskRef = [resized CGImage];
  
  CGColorSpaceRef cs = CGColorSpaceCreateDeviceRGB();
  
  CGFloat width = CGImageGetWidth(maskRef);
  CGFloat height = CGImageGetWidth(maskRef);
  
  CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                      CGImageGetHeight(maskRef),
                                      CGImageGetBitsPerComponent(maskRef),
                                      CGImageGetBitsPerPixel(maskRef),
                                      CGImageGetBytesPerRow(maskRef),
                                      CGImageGetDataProvider(maskRef), nil, YES);
  
  CGContextRef ctxWithAlpha = CGBitmapContextCreate(nil, width, height, 8, 4*width, cs, kCGImageAlphaPremultipliedFirst);

  CGContextDrawImage(ctxWithAlpha, CGRectMake(0, 0, width, height), maskRef);
  
  CGImageRef imageWithAlpha = CGBitmapContextCreateImage(ctxWithAlpha);

  /*UIImage *image = [UIImage imageWithContentsOfFile:path];
  
  CGImageRef masked = CGImageCreateWithMask([image CGImage], mask);*/
  CGImageRef masked = CGImageCreateWithMask(imageWithAlpha, mask);

  self.shoesBrandLogo.image = [UIImage imageWithCGImage:masked];

  //Render shoes images of all angels
  //Set the first two images only
  NSUInteger i=1;
	for (i = 1; i <= [shoes.shoesImgsAllAngle count]; i++)
	{
    NSString *imgName = [shoes.shoesImgsAllAngle objectAtIndex:i-1]; 
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@",MYSHOES_URL,imgName];
    
    NSURL *url = [NSURL URLWithString:imageUrl];
    //NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    UIImage *image = [[UIImage imageWithData: [NSData dataWithContentsOfURL: url]] retain];
		//NSString *imageName = [NSString stringWithFormat:@"image%d.jpg", i];
		//UIImage *image = [UIImage imageNamed:imageName];
    CGSize sz = CGSizeMake(kScrollObjHeight, kScrollObjHeight);
    
    UIImage *resized = [HomeViewController scale:image toSize:sz];
		UIImageView *imageView = [[UIImageView alloc] initWithImage:resized];
		
		// setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
		CGRect rect = imageView.frame;
		//rect.size.height = 280;
		//rect.size.width = 320;
    //rect.origin.x += 25;
    //rect.origin.y += 5;
		imageView.frame = rect;
		imageView.tag = i;	// tag our images for later use when we place them in serial fashion
		[self.shoesImageScrollView addSubview:imageView];
		[imageView release];
    
    /*if (i >= 2){//Only preload the first images
      break;
    }*/
	}
	
	[self layoutScrollImages];
}

- (void)layoutScrollImages
{
	UIImageView *view = nil;
	NSArray *subviews = [self.shoesImageScrollView subviews];
  
	// reposition all image subviews in a horizontal serial fashion
  //int i = 1;
	CGFloat curXLoc = 0;
	for (view in subviews)
	{
		if ([view isKindOfClass:[UIImageView class]] && view.tag > 0)
		{
			CGRect frame = view.frame;
			frame.origin = CGPointMake(curXLoc + 30.0f, 0 + 5.0f);
			view.frame = frame;
			
			curXLoc += (kScrollViewWidth);
      
      //Process the first two image2 only
      /*if(i >= 2){
        break;
      }
      i++;*/
		}
	}
	
	// set the content size so it can be scrollable
	[self.shoesImageScrollView setContentSize:CGSizeMake(([shoes.shoesImgsAllAngle count] * kScrollViewWidth), [self.shoesImageScrollView bounds].size.height)];
}

#pragma mark scroll view delegate methods

/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
  // 
   //  calculate the current page that is shown 
   //  you can also use scrollview.frame.size.height if your image is the exact size of your scrollview 
   //  
  int currentPage = (scrollView.contentOffset.x / kScrollViewWidth);
  
  if (currentPage >= [shoes.shoesImgsAllAngle count] -1){//The end of the shoes images
    return;
  }
  
  // display the image and maybe +/-1 for a smoother scrolling  
  // but be sure to check if the image already exists, you can do this very easily using tags  
  if ( [scrollView viewWithTag:(currentPage +2)] ) {  
    return;  
  }  
  else {  
    // view is missing, create it and set its tag to currentPage+1  
    
    NSString *imgName = [shoes.shoesImgsAllAngle objectAtIndex:currentPage +1]; 
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@",MYSHOES_URL,imgName];
    
    NSURL *url = [NSURL URLWithString:imageUrl];
    //NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    UIImage *image = [[UIImage imageWithData: [NSData dataWithContentsOfURL: url]] retain];
		//NSString *imageName = [NSString stringWithFormat:@"image%d.jpg", i];
		//UIImage *image = [UIImage imageNamed:imageName];
    CGSize sz = CGSizeMake(kScrollObjHeight, kScrollObjHeight);
    
    UIImage *resized = [HomeViewController scale:image toSize:sz];
		UIImageView *imageView = [[UIImageView alloc] initWithImage:resized];
		
		// setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
		CGRect rect = imageView.frame;
		//rect.size.height = 280;
		//rect.size.width = 320;
    //rect.origin.x += 25;
    //rect.origin.y += 5;
		imageView.frame = rect;
		imageView.tag = currentPage +2;	// tag our images for later use when we place them in serial fashion
    
    CGRect frame = imageView.frame;
    frame.origin = CGPointMake(scrollView.contentOffset.x + kScrollViewWidth + 30.0f, 0 + 5.0f);
    imageView.frame = frame;

		[scrollView addSubview:imageView];
		[imageView release];
  }  
  
}*/

@end
