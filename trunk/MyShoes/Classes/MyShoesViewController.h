//
//  MyShoesViewController.h
//  MyShoes
//
//  Created by Denny Ma on 27/01/11.
//  Copyright 2011 Mbi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyShoesViewController : UIViewController {
  UIView *contentView;
  UIActivityIndicatorView *progressIndicator;
  
  UIWebView *shoesImage;
}

@property (nonatomic, retain) IBOutlet UIView *contentView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *progressIndicator;
@property (nonatomic, retain) IBOutlet UIWebView *shoesImage;

- (void) startAnimation;
- (void) stopAnimation;
- (void) showShoesImage:(NSString *) imageUrl;

@end

