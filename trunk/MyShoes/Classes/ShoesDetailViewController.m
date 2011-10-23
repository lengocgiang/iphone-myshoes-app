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
#import "ShoppingCart.h"
#import <QuartzCore/QuartzCore.h>


@implementation ShoesDetailViewController

//@synthesize contentView;
@synthesize shoesBriefView;
//@synthesize indicatorView;
@synthesize shoesBrandName;
@synthesize shoesStyle;
//@synthesize shoesColor;
@synthesize shoesPrice;
@synthesize chooseColorLabel;
@synthesize chooseSizeLabel;
@synthesize shoppingCartBtn;
@synthesize shoesBrandLogo;
//@synthesize backgroundScrollView;
@synthesize shoesImageScrollView;
@synthesize chooseColor;
//@synthesize progressIndicator;
@synthesize shoes;
@synthesize networkTool;

const CGFloat kScrollImgViewOffsetX	= 6.0f;
const CGFloat kScrollImgViewOffsetY	= 6.0f;
const CGFloat kScrollObjHeight	= 260.0f;
const CGFloat kScrollViewWidth	= 320.0f;
const CGFloat kScrollObjWidth	= 260.0f;
const CGFloat kMarginX = 30.0f;
const NSUInteger kColorColumn = 0;
const NSUInteger kSizeColumn = 1;
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
  self.shoesBriefView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)] autorelease];
  self.shoesBrandName = [[[UILabel alloc] init] autorelease];
  self.shoesPrice = [[[UILabel alloc] init] autorelease];
  self.shoesStyle = [[[UILabel alloc] init] autorelease];
  
  //Set position of shoes labels
  self.shoesBrandName.frame = CGRectMake(5, 3, 144, 21);
  self.shoesPrice.frame = CGRectMake(5, 32, 65, 21);
  self.shoesStyle.frame = CGRectMake(70, 32, 200, 21);
  
  //Set font of shoes labels
  self.shoesBrandName.font = [UIFont fontWithName:@"Helvetica" size:14.0f];
  self.shoesStyle.font = [UIFont fontWithName:@"Helvetica" size:14.0f];
  self.shoesPrice.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.0f];
  [self.shoesBriefView addSubview:self.shoesBrandName];
  [self.shoesBriefView addSubview:self.shoesStyle];
  [self.shoesBriefView addSubview:self.shoesPrice];
  
  shoesBrandLogo = [[[UIImageView alloc] initWithFrame:CGRectMake(170, 0, 122, 54)] autorelease];
  [self.shoesBriefView addSubview:shoesBrandLogo];
      
  [self.view addSubview:self.shoesBriefView];
  [self.shoesBriefView setHidden:YES];
  
  //self.shoesImageScrollView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5f];
  
  self.shoesImageScrollView = [[[BSPreviewScrollView alloc] initWithFrame:CGRectMake(0, 60, 320, 270)] autorelease];
  
  self.shoesImageScrollView.pageSize = CGSizeMake(kScrollObjWidth + kMarginX, kScrollObjHeight);
	// Important to listen to the delegate methods.
	self.shoesImageScrollView.delegate = self;

  [self.shoesImageScrollView setHidden:YES];
  [self.view addSubview:self.shoesImageScrollView];
  self.chooseColor = [[[UIPickerView alloc] initWithFrame:CGRectZero] autorelease];
  CGRect frame;
  
  frame.origin.x = 0;
  frame.origin.y = 365;
  frame.size.width = self.chooseColor.frame.size.width;
  frame.size.height = self.chooseColor.frame.size.height;
  
  //Set the location of the color picker
  self.chooseColor.frame = frame;
  
  self.chooseColor.delegate = self;
  self.chooseColor.dataSource = self;
  self.chooseColor.showsSelectionIndicator = YES;
  self.chooseColor.backgroundColor = [UIColor clearColor];
  
  self.chooseColorLabel = [[[UILabel alloc] init] autorelease];
  self.chooseColorLabel.frame = CGRectMake(10, 340, 50, 21);
  self.chooseColorLabel.text = @"Step 1";
  //Add the choose shoes, step 1, 2, 3
  [self.view addSubview:self.chooseColorLabel];
  [self.view addSubview:self.chooseColor];
  [self.chooseColor setHidden:YES];
  [self.chooseColorLabel setHidden:YES];

  self.shoppingCartBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];//[[[UIButton alloc] initWithFrame:CGRectMake(30, self.chooseColor.frame.origin.y + self.chooseColor.frame.size.height + 30, 260, 80)] autorelease];
  self.shoppingCartBtn.frame = CGRectMake(30, self.chooseColor.frame.origin.y + self.chooseColor.frame.size.height + 20, 260, 40);
  [self.shoppingCartBtn setTitle:@"add to cart" forState:UIControlStateNormal];
  UIImage *btnImage = [UIImage imageNamed:@"shopping_cart-32.png"];
  [self.shoppingCartBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, btnImage.size.width , 0.0 , 0.0)]; // Left inset is the negative of image width.
  //[self.shoppingCartBtn setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -btnImage.size.width, -25.0, 0.0)]; // Left inset is the negative of image width.
  
  [self.shoppingCartBtn setImage:btnImage forState:UIControlStateNormal];
  [self.shoppingCartBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 20)]; 
  [self.shoppingCartBtn setBackgroundImage:[[UIImage imageNamed:@"red_button.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0] 
                                  forState:UIControlStateNormal];
  [self.shoppingCartBtn addTarget:self action:@selector(addToCart) forControlEvents:UIControlEventTouchUpInside];
  // Right inset is the negative of text bounds width.  
  //self.shoppingCartBtn.backgroundColor = [UIColor orangeColor];
  //[self.shoppingCartBtn setImageEdgeInsets:UIEdgeInsetsMake(-15.0, 0.0, 0.0, -self.shoppingCartBtn.titleLabel.bounds.size.width)]; 
  // Right inset is the negative of text 
  self.shoppingCartBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
  [self.view addSubview:self.shoppingCartBtn];
  [self.shoppingCartBtn setHidden:YES];

  //[self.chooseColor selectRow:shoes.selectedColor inComponent:0 animated:NO];
  
  /*CGAffineTransform t0 = CGAffineTransformMakeTranslation(self.chooseColor.bounds.size.width/2, self.chooseColor.bounds.size.height/2);
	CGAffineTransform s0 = CGAffineTransformMakeScale(1, 0.8);
	CGAffineTransform t1 = CGAffineTransformMakeTranslation(-self.chooseColor.bounds.size.width/2, -self.chooseColor.bounds.size.height/2);
	self.chooseColor.transform = CGAffineTransformConcat(t0, CGAffineTransformConcat(s0, t1));*/

  
  shoesAllAngels = [[NSMutableArray arrayWithCapacity:SHOES_INFO_SHOESIMGS_COUNT] retain];
  
  
  //self.contentView.frame = CGRectMake(0, 0, 320, 400);
  
  [(UIScrollView *)self.view setContentSize:CGSizeMake(320,660)];
  ((UIScrollView *)self.view).clipsToBounds = YES;
  ((UIScrollView *)self.view).scrollEnabled = YES;
  
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

  [self loadShoesDetail];
  
  //HUD = [[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES] retain];

}

- (void)viewDidDisappear:(BOOL)animated {
  //Reset shoes detail view
  self.shoesBrandLogo.image = nil;
  [shoesAllAngels removeAllObjects];
  [self hideShoesInfo];
}


- (void)dealloc {  
  [shoesAllAngels release];
  [networkTool release];
  [super dealloc];
}

#pragma mark Network related methods
- (void)loadShoesDetail {
  
  //Load shoes info using the default product info url
  [self loadShoesDetailWithProductUrl:nil];

}

- (void)loadShoesDetailWithProductUrl:(NSString *)url {
  
  NSString *newUrl;
  
  if(!url){
    //Load shoes info using the default product info url
    //Check if the shoes detail link is available
    if((shoes == nil) || (shoes.productDetailLink == nil)){
      return;
    }
    //[self startAnimation];
    
    newUrl = [NSString stringWithFormat:@"%@%@",MYSHOES_URL,shoes.productDetailLink];    
  }
  else{
    //Update product detail link
    shoes.productDetailLink = url;
    newUrl = [NSString stringWithFormat:@"%@%@",MYSHOES_URL,url];  
  }


  //NSLog(@"Url of shoes detail is:%@",newUrl);
  //Issue the request of the selected shoes
  [networkTool getContent:newUrl withDelegate:self requestSelector:@selector(shoesDetailUpdateCallbackWithData:)];
  
  HUD = [[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES] retain];
  
  //HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	//[self.navigationController.view addSubview:HUD];
	
  //HUD.delegate = self;
  HUD.labelText = @"Fetching Details";
	
  //[HUD showWhileExecuting:nil onTarget:self withObject:nil animated:YES];

}

- (void)shoesDetailUpdateCallbackWithData:(NSData *)content {
	  
	//Create parser
	TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:content];
	
  //Process shoes SKU info
	NSArray *elements  = [xpathParser search:SHOES_DETAIL_SKU_XPATH];
  
  if((elements != nil) && ([elements count] > 0)){
    [shoes processProductSKU:[elements objectAtIndex:0]];
    
  }
  
  //Process count of shoes images of all angels info
	elements  = [xpathParser search:SHOES_DETAIL_SHOES_IMAGES_ALLANGEL];
  
  if((elements != nil) && ([elements count] > 0)){
    [shoes processShoesImagesCount:elements];
    
  }

  
  //Process shoes images of all angels
	elements  = [xpathParser search:SHOES_DETAIL_SHOES_IMAGES_LARGE];
  
  if((elements != nil) && ([elements count] > 0)){
    [shoes processShoesImagesAllAngels:[elements objectAtIndex:0]];
    
    //Load shoes images with all angels
    for (NSString *str in shoes.shoesImgsAllAngle){
      //NSString *imgName = [shoes.shoesImgsAllAngle objectAtIndex:index]; 
      NSString *imageUrl = [NSString stringWithFormat:@"%@%@",MYSHOES_URL,str];
      
      NSURL *url = [NSURL URLWithString:imageUrl];
      //NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
      
      UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL: url]];
      [shoesAllAngels addObject:image];
    }
  }
  
  //Process shoes brand logo img info
  
  elements = [xpathParser search:SHOES_DETAIL_BRANDLOGO_IMG_XPATH];
  if((elements != nil) && ([elements count] > 0)){
    [shoes processProductBrandLogo:[elements objectAtIndex:0]];
  }
  
  //Process available shoes colors info and update the current color
  
  elements = [xpathParser search:SHOES_DETAIL_AVAILABLE_COLORS_XPATH];
  if((elements != nil) && ([elements count] > 0)){
    [shoes processShoesColors:[elements objectAtIndex:0]];
  }
  
  //Process and update shoes price in case the same model with difference color have the different price
  
  elements = [xpathParser search:SHOES_DETAIL_SHOES_PRICE];
  if((elements != nil) && ([elements count] > 0)){
    [shoes processShoesPrice:[elements objectAtIndex:0]];
  }
    
  //Process available shoes size info
  
  elements = [xpathParser search:SHOES_DETAIL_AVAILABLE_SIZES_XPATH];
  if((elements != nil) && ([elements count] > 0)){
    [shoes processShoesSizes:[elements objectAtIndex:0]];
  }
  
	[xpathParser release];
  
  //Start to render shoes detail
  [self renderShoesDetail];
}

#pragma mark Shoes Rendering related methods

- (void)renderShoesDetail {
  [HUD hide:YES];
  
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
  
  //Load shoes existing info
  shoesBrandName.text = shoes.productBrandName;
  shoesStyle.text = shoes.productStyle;
  shoesPrice.text = shoes.productPrice;

  [self.shoesBriefView setHidden:NO];
  //Reload shoes images with all Angels
  [self.view addSubview:self.shoesBriefView];
  [self.shoesImageScrollView reloadPages];
  [self.shoesImageScrollView setHidden:NO];

  
  //self.chooseColor.delegate = self;
  [self.chooseColor reloadAllComponents];
  //Set the default selection of the shoes color
  [self.chooseColor selectRow:shoes.selectedColor inComponent:0 animated:NO];
  //Set the default selection of shoes size
  //It should be a reminder "Select avaiable sizes"
  [self.chooseColor selectRow:0 inComponent:1 animated:NO];

  //[self.view addSubview:self.chooseColor];
  [self.chooseColor setHidden:NO];
  [self.chooseColorLabel setHidden:NO];
  [self.shoppingCartBtn setHidden:NO];
  
  //Disable add to cart btn. It can be clicked only after users choose shoes color and size
  [self.shoppingCartBtn setEnabled:NO];
  [self.shoppingCartBtn setHidden:NO];
  
  //Disable touch until load finishes
  [self.view setUserInteractionEnabled:YES];

}

- (void)hideShoesInfo {
  [self.shoesBriefView setHidden:YES];
  [self.shoesImageScrollView setHidden:YES];
  [self.chooseColor setHidden:YES];
  [self.shoesBriefView setHidden:YES];
  [self.chooseColorLabel setHidden:YES];
  [self.shoppingCartBtn setHidden:YES];
}

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
- (UIView*)viewForItemAtIndex:(BSPreviewScrollView*)scrollView index:(int)index {
	// Note that the images are actually smaller than the image view frame, each image
	// is 210x280. Images are centered and because they are smaller than the actual 
	// view it creates a padding between each image. 
	CGRect imageViewFrame = CGRectMake(0.0f, 0.0f, kScrollObjWidth + kMarginX , kScrollObjHeight);
	
	// TapImage is a subclassed UIImageView that catch touch/tap events 
	TapImage *imageView = [[[TapImage alloc] initWithFrame:imageViewFrame] autorelease];
	imageView.userInteractionEnabled = YES;

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

- (int)itemCount:(BSPreviewScrollView*)scrollView {
	// Return the number of pages we intend to display
	return [self.shoes.shoesImgsAllAngle count];//[self.scrollPages count];
}

#pragma mark -
#pragma mark ChooseColorPickerViewDelegate methods

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
  // Handle the selection
  //Column(Component) 1 is for shoes color. Column(Component) 2 is for shoes size
  //Shoes size depends on shoes color selection.
  if(component == kColorColumn){//Should reload shoes info to get the avaiable sizes
    //Put a safe check, it should not happen at all
    if (row > [shoes.urlsWithColors count] -1 ){
      return;
    }
      
    NSString *urlWithColor = [shoes.urlsWithColors objectAtIndex:row];
    
    //Remove previous shoes images of all angels
    [shoesAllAngels removeAllObjects];
    
    [self hideShoesInfo];
    //Disable touch until load finishes
    [self.view setUserInteractionEnabled:FALSE];
    [self loadShoesDetailWithProductUrl:urlWithColor];
    
  }
  else if(component == kSizeColumn){//Should enable add to shopping cart button if size is choosed
    if (row == 0){
      //The first row of size is just a reminder. It should be ignored
      return;
    }
    
    //Set shoes size
    shoes.selectedSize = row;
    [self.shoppingCartBtn setEnabled:YES];
  }

}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  NSUInteger numRows;// = [shoes.shoesColors count];
  
  if(component == kColorColumn){
    numRows = [shoes.shoesColors count];
  }
  else if(component == kSizeColumn){
    numRows = [shoes.shoesSizes count];
  }
  
  return numRows;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return 2;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
  NSString *title;
  
  //Column 1 shows avaiable colors
  //Column 2 shows avaiable sizes
  
  if(component == kColorColumn){
    title = [shoes.shoesColors objectAtIndex:row];//[@"" stringByAppendingFormat:@"%d",row];
  }
  else if(component == kSizeColumn){
    title = [shoes.shoesSizes objectAtIndex:row];
  }
  
  return title;
}

// tell the picker the width of each row for a given component
/*- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
  int sectionWidth = 200;
  
  return sectionWidth;
}*/

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
  //Both columns have the same font
  UILabel *retval = (id)view;
  if (!retval) {
    retval= [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)] autorelease];
  }
  
  //retval.text = @"Demo";
  //retval.text = [shoes.shoesColors objectAtIndex:row];
  if(component == kColorColumn){
    retval.text = [shoes.shoesColors objectAtIndex:row];//[@"" stringByAppendingFormat:@"%d",row];
    retval.font = [UIFont systemFontOfSize:14];
  }
  else if(component == kSizeColumn){
    retval.text = [shoes.shoesSizes objectAtIndex:row];
    retval.font = [UIFont systemFontOfSize:10];
  }

  return retval;
}

#pragma mark -
#pragma mark Add to cart button methods
// Add the current shoes to the cart and go to shopping cart view
- (void)addToCart {
  
  //Locate the shopping cart object in MyShoesApplicationDelegate
  id delegate = [[UIApplication sharedApplication] delegate];
  
  ShoppingCart *shoppingCart;
  if ([delegate respondsToSelector:@selector(shoppingCart)]){
    shoppingCart = [delegate shoppingCart];
  }
  
  //Add the selected shoes object to shopping cart
  [shoppingCart addToCart:shoes]; 
}

@end
