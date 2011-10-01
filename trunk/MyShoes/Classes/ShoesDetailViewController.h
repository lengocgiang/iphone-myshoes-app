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
#import "MBProgressHUD.h"
#import "BSPreviewScrollView.h"
#import "TapImage.h"


@interface ShoesDetailViewController : UIViewController<MBProgressHUDDelegate, BSPreviewScrollViewDelegate> {

  UIView *contentView;
  UIView *shoesBriefView;
  UIView *indicatorView;
  UILabel *shoesBrandName;
  UILabel *shoesStyle;
  //UILabel *shoesColor;
  UILabel *shoesPrice;
  
  UIImageView *shoesBrandLogo;
  
  //UIActivityIndicatorView *progressIndicator;
  
  UIScrollView *backgroundScrollView;
  BSPreviewScrollView *shoesImageScrollView;
  
  Shoes *shoes;

  NetworkTool *networkTool;
  
  MBProgressHUD *HUD;
  
  NSMutableArray *shoesAllAngels;
}

@property (nonatomic, retain) IBOutlet UIView *contentView;
@property (nonatomic, retain) IBOutlet UIView *shoesBriefView;
//@property (nonatomic, retain) IBOutlet UIView *indicatorView;
@property (nonatomic, retain) UILabel *shoesBrandName;
@property (nonatomic, retain) UILabel *shoesStyle;
//@property (nonatomic, retain) IBOutlet UILabel *shoesColor;
@property (nonatomic, retain) UILabel *shoesPrice;
@property (nonatomic, retain) UIImageView *shoesBrandLogo;
//@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *progressIndicator;
@property (nonatomic, retain) IBOutlet UIScrollView *backgroundScrollView;
@property (nonatomic, retain) /*IBOutlet*/BSPreviewScrollView *shoesImageScrollView;
@property (nonatomic, retain) Shoes *shoes;
@property (nonatomic, retain) NetworkTool *networkTool;

+ (UIImage *)maskWhiteToTransparent:(UIImage *)image;
//- (void)startAnimation;
//- (void)stopAnimation;
- (void)loadShoesDetail;
- (void)renderShoesDetail;

//- (void)layoutScrollImages;

@end
