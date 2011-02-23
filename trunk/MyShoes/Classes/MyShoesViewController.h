//
//  MyShoesViewController.h
//  MyShoes
//
//  Created by Denny Ma on 27/01/11.
//  Copyright 2011 Mbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
#import "SlideImageView.h"
#import "Shoes.h"

@interface MyShoesViewController : UIViewController <SlideImageViewDelegate>{
  UIView *contentView;
  UIActivityIndicatorView *progressIndicator;
  //UIWebView *shoesImage;
  
  SlideImageView *slideImageView;
  //NSMutableArray *_shoesList;
  NSMutableDictionary *_shoesDict;
  
  UILabel *shoesBrandName;
  UILabel *shoesStyle;
  UILabel *shoesColor;
  UILabel *shoesPrice;
  
  NSArray *_imageArray;
}

@property (nonatomic, retain) IBOutlet UIView *contentView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *progressIndicator;
//@property (nonatomic, retain) IBOutlet UIWebView *shoesImage;
@property (nonatomic, retain) IBOutlet SlideImageView *slideImageView;
//@property (nonatomic, retain) NSMutableArray *shoesList;
@property (nonatomic, retain) NSMutableDictionary *shoesDict;
@property (nonatomic, retain) IBOutlet UILabel *shoesBrandName;
@property (nonatomic, retain) IBOutlet UILabel *shoesStyle;
@property (nonatomic, retain) IBOutlet UILabel *shoesColor;
@property (nonatomic, retain) IBOutlet UILabel *shoesPrice;
@property (nonatomic, retain) NSArray *imageArray;

- (void) startAnimation;
- (void) stopAnimation;
- (void) showShoes:(NSArray *) shoesList;
- (void) showShoesInfo:(Shoes *)shoes;
- (void) hideShoesInfoLabels;

@end

