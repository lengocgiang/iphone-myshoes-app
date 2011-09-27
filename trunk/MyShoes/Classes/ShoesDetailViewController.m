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

}

-(CGImageRef)createMask:(UIImage*)temp
{
  CGImageRef ref=temp.CGImage;
  int mWidth=CGImageGetWidth(ref);
  int mHeight=CGImageGetHeight(ref);
  int count=mWidth*mHeight*4;
  void *bufferdata=malloc(count);
  
  CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
  CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
  CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
  
  CGContextRef cgctx = CGBitmapContextCreate (bufferdata,mWidth,mHeight, 8,mWidth*4, colorSpaceRef, kCGImageAlphaPremultipliedFirst); 
  
  CGRect rect = {0,0,mWidth,mHeight};
  CGContextDrawImage(cgctx, rect, ref); 
  bufferdata = CGBitmapContextGetData (cgctx);
  
  CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, bufferdata, mWidth*mHeight*4, NULL);
  CGImageRef savedimageref = CGImageCreate(mWidth,mHeight, 8, 32, mWidth*4, colorSpaceRef, bitmapInfo,provider , NULL, NO, renderingIntent);
  CFRelease(colorSpaceRef);
  return savedimageref;
}

-(UIImage *)changeWhiteColorTransparent: (UIImage *)image{
  CGImageRef rawImageRef=image.CGImage;
  
  const float colorMasking[6] = { 255,255,255, 255,255,255 };//{222, 255, 222, 255, 222, 255};
  
  UIGraphicsBeginImageContext(image.size);
  CGImageRef maskedImageRef=CGImageCreateWithMaskingColors(rawImageRef, colorMasking);
  {
    //if in iphone
    CGContextTranslateCTM(UIGraphicsGetCurrentContext(), 0.0, image.size.height);
    CGContextScaleCTM(UIGraphicsGetCurrentContext(), 1.0, -1.0); 
  }
  
  CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, image.size.width, image.size.height), maskedImageRef);
  UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
  CGImageRelease(maskedImageRef);
  UIGraphicsEndImageContext();    
  return result;
}

@end
