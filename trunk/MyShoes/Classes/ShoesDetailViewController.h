//
//  MyShoesDetailViewController.h
//  MyShoes
//
//  Created by Denny Ma on 25/02/11.
//  Copyright 2011 Mbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
#import "NetworkTool.h"
#import "Shoes.h"


@interface ShoesDetailViewController : UIViewController {

  UIView *shoesBriefView;
  UILabel *shoesBrandName;
  UILabel *shoesStyle;
  //UILabel *shoesColor;
  UILabel *shoesPrice;
  
  UIImageView *shoesBrandLogo;
  
  UIActivityIndicatorView *progressIndicator;
  
  UIScrollView *shoesImageScrollView;
  
  Shoes *shoes;

  NetworkTool *networkTool;
}

@property (nonatomic, retain) IBOutlet UIView *shoesBriefView;
@property (nonatomic, retain) IBOutlet UILabel *shoesBrandName;
@property (nonatomic, retain) IBOutlet UILabel *shoesStyle;
//@property (nonatomic, retain) IBOutlet UILabel *shoesColor;
@property (nonatomic, retain) IBOutlet UILabel *shoesPrice;
@property (nonatomic, retain) IBOutlet UIImageView *shoesBrandLogo;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *progressIndicator;
@property (nonatomic, retain) IBOutlet UIScrollView *shoesImageScrollView;
@property (nonatomic, retain) Shoes *shoes;
@property (nonatomic, retain) NetworkTool *networkTool;

- (void)startAnimation;
- (void)stopAnimation;
- (void)loadShoesDetail;
- (void)renderShoesDetail;
-(CGImageRef)createMask:(UIImage*)temp;
-(UIImage *)changeWhiteColorTransparent: (UIImage *)image;

@end
