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
#import <QuartzCore/QuartzCore.h>


@implementation ShoesDetailViewController

@synthesize contentView;
@synthesize shoesBriefView;
//@synthesize indicatorView;
@synthesize shoesBrandName;
@synthesize shoesStyle;
//@synthesize shoesColor;
@synthesize shoesPrice;
@synthesize shoesBrandLogo;
@synthesize backgroundScrollView;
@synthesize shoesImageScrollView;
//@synthesize progressIndicator;
@synthesize shoes;
@synthesize networkTool;

const CGFloat kScrollImgViewOffsetX	= 6.0f;
const CGFloat kScrollImgViewOffsetY	= 6.0f;
const CGFloat kScrollObjHeight	= 260.0f;
const CGFloat kScrollViewWidth	= 320.0f;
const CGFloat kScrollObjWidth	= 260.0f;
const CGFloat kMarginX = 30.0f;
//const NSUInteger kNumImages		= 8;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

+ (UIImage *)maskWhiteToTransparent:(UIImage *)image {
  CGImageRef maskRef = [image CGImage];
  
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
  
  return [UIImage imageWithCGImage:masked];
}
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
  
  //Create network toolkit
  self.networkTool = [[NetworkTool alloc] init];
  
  //Create shoes brief info view programmically
  self.shoesBriefView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 86)] autorelease];
  self.shoesBrandName = [[[UILabel alloc] init] autorelease];
  self.shoesPrice = [[[UILabel alloc] init] autorelease];
  self.shoesStyle = [[[UILabel alloc] init] autorelease];
  
  //Set position of shoes labels
  self.shoesBrandName.frame = CGRectMake(20, 3, 144, 21);
  self.shoesPrice.frame = CGRectMake(20, 56, 128, 21);
  self.shoesStyle.frame = CGRectMake(20, 32, 128, 21);
  
  //Set font of shoes labels
  self.shoesBrandName.font = [UIFont fontWithName:@"Helvetica" size:14.0f];
  self.shoesStyle.font = [UIFont fontWithName:@"Helvetica" size:14.0f];
  self.shoesPrice.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.0f];
  [self.shoesBriefView addSubview:self.shoesBrandName];
  [self.shoesBriefView addSubview:self.shoesStyle];
  [self.shoesBriefView addSubview:self.shoesPrice];
  
  shoesBrandLogo = [[UIImageView alloc] initWithFrame:CGRectMake(170, 40, 122, 54)];
  [self.shoesBriefView addSubview:shoesBrandLogo];
  
  [self.contentView addSubview:self.shoesBriefView];
  
  shoesAllAngels = [[NSMutableArray arrayWithCapacity:SHOES_INFO_SHOESIMGS_COUNT] retain];
  
  //Create shoes image slide view programmically
  /*self.shoesImageScrollView = [[[BSPreviewScrollView alloc] initWithFrame:CGRectMake(0, 86, 320, 270)] autorelease];
  
  self.shoesImageScrollView.pageSize = CGSizeMake(290, 270);
	// Important to listen to the delegate methods.
	self.shoesImageScrollView.delegate = self;

  self.shoesImageScrollView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5f];
  
  [self.contentView addSubview:self.shoesImageScrollView];*/
  //Set extra properties of scroll view
  //backgroundScrollView.clipsToBounds = YES;	// default is NO, we want to restrict drawing within our scrollview
	//backgroundScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	//[backgroundScrollView setContentSize:CGSizeMake(imageView.frame.size.width, imageView.frame.size.height)];
	//[backgroundScrollView setScrollEnabled:YES];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark -
#pragma mark Memory management
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
	
	// Call the scrollview and let it know memory is running low
	[self.shoesImageScrollView didReceiveMemoryWarning];
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  //Load shoes existing info
  shoesBrandName.text = shoes.productBrandName;
  shoesStyle.text = shoes.productStyle;
  shoesPrice.text = shoes.productPrice;

  [self loadShoesDetail];
  
  HUD = [[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES] retain];

}

- (void)viewDidDisappear:(BOOL)animated {
  //Reset shoes detail view
  self.shoesBrandLogo.image = nil;
  [self.shoesImageScrollView setHidden:YES];
  //remove all the subview os shoesImageScrollView
  for (UIView *view in [self.shoesImageScrollView subviews]) {
    [view removeFromSuperview];
  }
  //[self.shoesImageScrollView setContentOffset:CGPointMake(0.0f, 0.0f) animated:NO];
  
  [self.shoesBriefView setHidden:YES];
  //[self.progressIndicator startAnimating];
  [shoesAllAngels removeAllObjects];
}


- (void)dealloc {  
  //[shoesImageScrollView release];
  //[shoesBriefView release];
  [shoesAllAngels release];
  [networkTool release];
  [super dealloc];
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
    
    //Load shoes images with all angels
    for (NSString *str in shoes.shoesImgsAllAngle){
      //NSString *imgName = [shoes.shoesImgsAllAngle objectAtIndex:index]; 
      NSString *imageUrl = [NSString stringWithFormat:@"%@%@",MYSHOES_URL,str];
    
      NSURL *url = [NSURL URLWithString:imageUrl];
      //NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
      UIImage *image = [[UIImage imageWithData: [NSData dataWithContentsOfURL: url]] retain];
      [shoesAllAngels addObject:image];
      
      [image release];
    }
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
  [HUD hide:YES];
  //[progressIndicator stopAnimating];
  [shoesBriefView setHidden:NO];
  [shoesImageScrollView setHidden:NO];
  
  //shoesBrandName.text = shoes.productBrandName;
  //shoesStyle.text = shoes.productStyle;
  //shoesPrice.text = shoes.productPrice;
  
  //Render shoes brand logo img
  //imageView.image = shoes.shoesImage;
  NSString *logoName = shoes.productBrandLogo;
  NSString *imageUrl = [NSString stringWithFormat:@"%@%@",MYSHOES_URL,logoName];
  
  NSURL *url = [NSURL URLWithString:imageUrl];
  //NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
  
  UIImage *logoImage = [[UIImage imageWithData: [NSData dataWithContentsOfURL: url]] retain];
  
  CGSize sz = SHOES_DETAIL_LOGO_ING_SIZE;
  
  UIImage *resized = [HomeViewController scale:logoImage toSize:sz];
  
  self.shoesBrandLogo.image = [ShoesDetailViewController maskWhiteToTransparent:resized];
  
  if(shoesImageScrollView){
    [shoesImageScrollView removeFromSuperview];
  }
  
  self.shoesImageScrollView = [[[BSPreviewScrollView alloc] initWithFrame:CGRectMake(0, 86, 320, 270)] autorelease];
  
  self.shoesImageScrollView.pageSize = CGSizeMake(kScrollObjWidth + kMarginX, kScrollObjHeight);
	// Important to listen to the delegate methods.
	self.shoesImageScrollView.delegate = self;
  
  //self.shoesImageScrollView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5f];
  
  [self.contentView addSubview:self.shoesImageScrollView];

}

/*- (void)layoutScrollImages
{
	UIImageView *view = nil;
	NSArray *subviews = [self.shoesImageScrollView subviews];
  
	// reposition all image subviews in a horizontal serial fashion
  //int i = 1;
  int marginX = 30.0f;
  
	CGFloat curXLoc = 0;
	for (view in subviews)
	{
		if ([view isKindOfClass:[UIImageView class]] && view.tag > 0)
		{
			CGRect frame = view.frame;
			frame.origin = CGPointMake(curXLoc + marginX, 0 + 5.0f);
			view.frame = frame;
			
			curXLoc += (kScrollViewWidth);
      

		}
	}
	
	// set the content size so it can be scrollable
	[self.shoesImageScrollView setContentSize:CGSizeMake(([shoes.shoesImgsAllAngle count] * (kScrollObjWidth + marginX*2)), [self.shoesImageScrollView bounds].size.height)];
}*/

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
  // Remove HUD from screen when the HUD was hidded
  [HUD removeFromSuperview];
  [HUD release];
	HUD = nil;
}

#pragma mark -
#pragma mark BSPreviewScrollViewDelegate methods
-(UIView*)viewForItemAtIndex:(BSPreviewScrollView*)scrollView index:(int)index
{
	// Note that the images are actually smaller than the image view frame, each image
	// is 210x280. Images are centered and because they are smaller than the actual 
	// view it creates a padding between each image. 
	CGRect imageViewFrame = CGRectMake(0.0f, 0.0f, kScrollObjWidth + kMarginX , kScrollObjHeight);
	
	// TapImage is a subclassed UIImageView that catch touch/tap events 
	TapImage *imageView = [[[TapImage alloc] initWithFrame:imageViewFrame] autorelease];
	imageView.userInteractionEnabled = YES;

  /*NSString *imgName = [shoes.shoesImgsAllAngle objectAtIndex:index]; 
  NSString *imageUrl = [NSString stringWithFormat:@"%@%@",MYSHOES_URL,imgName];
  
  NSURL *url = [NSURL URLWithString:imageUrl];
  //NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
  
  UIImage *image = [[UIImage imageWithData: [NSData dataWithContentsOfURL: url]] retain];*/
  //NSString *imageName = [NSString stringWithFormat:@"image%d.jpg", i];
  //UIImage *image = [UIImage imageNamed:imageName];
  UIImage *image = [shoesAllAngels objectAtIndex:index];
  CGSize sz = CGSizeMake(kScrollObjWidth, kScrollObjHeight);
  
  UIImage *resized = [HomeViewController scale:image toSize:sz];
  //UIImageView *imageView = [[UIImageView alloc] initWithImage:resized];
	
  imageView.image = resized;//[ShoesDetailViewController maskWhiteToTransparent:resized];
	imageView.contentMode = UIViewContentModeCenter;

  CALayer *layer = [imageView layer];
  //[layer setMasksToBounds:YES];
  [layer setBorderColor:[UIColor lightGrayColor].CGColor];
  [layer setBorderWidth:1.0f];
  
  //[image release];
	
	return imageView;
}

-(int)itemCount:(BSPreviewScrollView*)scrollView
{
	// Return the number of pages we intend to display
	return [self.shoes.shoesImgsAllAngle count];//[self.scrollPages count];
}

@end
