//
//  ZoomImageView.h
//  MyShoes
//
//  Created by Denny Ma on 15/02/11.
//  Copyright 2011 Mbi. All rights reserved.
//
//  Implemented by a UIScrollView which has only one image View
#import <Foundation/Foundation.h>

@interface ZoomImageView : NSObject /*UIView <UIScrollViewDelegate> */{
  
	//UIScrollView *_imageScrollView;
	//NSMutableArray *_imageViews;
  UIView *_imageView;
  
  //ZoomImageView *_nextView;
}

//@property (nonatomic, retain) UIScrollView* imageScrollView;
//@property (nonatomic, retain) UIImageView* rightMenuImage;
//@property (nonatomic, retain) UIImageView* leftMenuImage;
@property (nonatomic, retain) UIView* imageView;
@property (nonatomic, retain) ZoomImageView* nextView;

-(id) initWithFrameColorAndImage:(CGRect)frame backgroundColor:(UIColor*)bgColor image:(UIImageView*)image;
-(void) resizeView:(CGRect)frame;

@end
