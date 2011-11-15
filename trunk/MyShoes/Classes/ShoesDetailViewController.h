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
#import "BSPreviewScrollView+ReloadPages.h"
#import "CustomNavigationController.h"
#import "TapImage.h"


@interface ShoesDetailViewController : UIViewController<MBProgressHUDDelegate, BSPreviewScrollViewDelegate, 
                    UIPickerViewDelegate, UIPickerViewDataSource, ShoesViewProtocol> {

  //UIView *contentView;
  UIView *shoesBriefView;
  UIView *indicatorView;
  UILabel *shoesBrandName;
  UILabel *shoesStyle;
  //UILabel *shoesColor;
  UILabel *shoesPrice;
  
  UILabel *chooseColorLabel;
  UILabel *chooseSizeLabel;
  UIButton *shoppingCartBtn;
  
  UIImageView *shoesBrandLogo;
  
  //UIActivityIndicatorView *progressIndicator;
  
  //UIScrollView *backgroundScrollView;
  BSPreviewScrollView *shoesImageScrollView;
  
  //Shoes color selecter
  UIPickerView *chooseColor;
  
  Shoes *shoes;

  NetworkTool *networkTool;
  
  MBProgressHUD *HUD;
  
  NSMutableArray *shoesAllAngels;
  
  //The flag to show if the view is reset. If it's still in the stack of navigator, the value
  //should be false. So it won't reset it view when users come back
  //The default value is TRUE
  BOOL viewRest;

  //The flag to show if the view is from shopping cart view
  //If yes, means it's from shopping cart view and it has a textfield for shoes Quantity
  //and the button change to "UPdate the cart"
  //Took the second solution, there is no more edting mode for shoes detail view
  /*                    
  BOOL editing;
  UILabel *shoesQuantityLabel;
  UITextField *shoesQuantity;*/
                      
}

//@property (nonatomic, retain) IBOutlet UIView *contentView;
@property (nonatomic, retain) IBOutlet UIView *shoesBriefView;
//@property (nonatomic, retain) IBOutlet UIView *indicatorView;
@property (nonatomic, retain) UILabel *shoesBrandName;
@property (nonatomic, retain) UILabel *shoesStyle;
//@property (nonatomic, retain) IBOutlet UILabel *shoesColor;
@property (nonatomic, retain) UILabel *shoesPrice;
@property (nonatomic, retain) UILabel *chooseColorLabel;
@property (nonatomic, retain) UILabel *chooseSizeLabel;
@property (nonatomic, retain) UIButton *shoppingCartBtn;
@property (nonatomic, retain) UIImageView *shoesBrandLogo;
//@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *progressIndicator;
//@property (nonatomic, retain) IBOutlet UIScrollView *backgroundScrollView;
@property (nonatomic, retain) /*IBOutlet*/BSPreviewScrollView *shoesImageScrollView;
@property (nonatomic, retain) UIPickerView *chooseColor;
@property (nonatomic, retain) Shoes *shoes;
//@property (nonatomic, assign) BOOL editing;
@property (nonatomic, retain) NetworkTool *networkTool;

+ (UIImage *)maskWhiteToTransparent:(UIImage *)image;
//- (void)startAnimation;
//- (void)stopAnimation;
- (void)loadShoesDetail;
- (void)loadShoesDetailWithProductUrl:(NSString *)url;
- (void)renderShoesDetail;
- (void)hideShoesInfo;
//- (void)layoutScrollImages;

@end
