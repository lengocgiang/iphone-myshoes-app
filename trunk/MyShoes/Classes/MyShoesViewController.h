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

@interface MyShoesViewController : UIViewController {
  UIView *contentView;
  UIActivityIndicatorView *progressIndicator;
  //UIWebView *shoesImage;
  
  SlideImageView *_slideImageView;
  NSArray *_imageArray;
}

@property (nonatomic, retain) IBOutlet UIView *contentView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *progressIndicator;
//@property (nonatomic, retain) IBOutlet UIWebView *shoesImage;
@property (nonatomic, retain) SlideImageView *slideImageView;
@property (nonatomic, retain) NSArray *imageArray;

- (void) startAnimation;
- (void) stopAnimation;
- (void) showShoes:(NSArray *) shoesList;

@end

