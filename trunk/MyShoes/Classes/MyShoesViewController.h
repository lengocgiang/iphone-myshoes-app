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
//#import "SlideMenuViewController.h"
#import "Shoes.h"
#import "ShoesCategory.h"
#import "OrderedDictionary.h"
#import "ShoesTableView.h"

@interface MyShoesViewController : UIViewController <SlideImageViewDelegate>{
  UIView *contentView;
  UIActivityIndicatorView *progressIndicator;
  //UIWebView *shoesImage;
  
  SlideImageView *slideImageView;
  ShoesTableView *shoesTableView;
  UIView *shoesScrollingView;
  //NSMutableArray *_shoesList;
  NSMutableDictionary *_shoesDict;
  
  UILabel *shoesBrandName;
  UILabel *shoesStyle;
  UILabel *shoesColor;
  UILabel *shoesPrice;
  
  //UIToolbar
  UIToolbar *toolBar;
  
  NSArray *_imageArray;
  
  NSArray *_shoesArray;
  
  Boolean _isTableView;
  
  NSMutableDictionary *_shoesCategoryDict;
  //SlideMenuViewController *slideMenuViewController;
}

@property (nonatomic, retain) IBOutlet UIView *contentView;
@property (nonatomic, retain) IBOutlet UIView *shoesScrollingView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *progressIndicator;
//@property (nonatomic, retain) IBOutlet UIWebView *shoesImage;
@property (nonatomic, retain) IBOutlet SlideImageView *slideImageView;
//@property (nonatomic, retain) ShoesTableView *shoesTableView;
//@property (nonatomic, retain) NSMutableArray *shoesList;
@property (nonatomic, retain) NSMutableDictionary *shoesDict;
@property (nonatomic, retain) IBOutlet UILabel *shoesBrandName;
@property (nonatomic, retain) IBOutlet UILabel *shoesStyle;
@property (nonatomic, retain) IBOutlet UILabel *shoesColor;
@property (nonatomic, retain) IBOutlet UILabel *shoesPrice;
@property (nonatomic, retain) UIToolbar *toolBar;
@property (nonatomic, retain) NSArray *imageArray;
//@property (nonatomic, retain) SlideMenuViewController *slideMenuViewController;
@property (nonatomic, retain) NSMutableDictionary *shoesCategoryDict;

- (void) startAnimation;
- (void) stopAnimation;
- (void) showShoes:(NSArray *) shoesList;
- (void) showShoesInfo:(Shoes *)shoes;
- (void) hideShoesInfoLabels;

@end

