//
//  SlideImageView.h
//  MyShoes
//
//  Created by Denny Ma on 15/02/11.
//  Copyright 2011 Mbi. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "ZoomImageView.h"
#import "NSMutableArray+QueueAdditions.h"

@interface SlideImageView : UIView{
  
  //It's actually a queue
	NSMutableArray *_imageViews;
  
  //ZoomImageView *_imageQueueHead;
  //ZoomImageView *_imageQueueEnd;
  
  CGPoint _touchBegin;
  BOOL _firstMove;
}

//@property (nonatomic, retain) UIImageView* rightMenuImage;
//@property (nonatomic, retain) UIImageView* leftMenuImage;
@property (nonatomic, retain) NSMutableArray* imageViews;
//@property (nonatomic, retain) ZoomImageView* imageQueueHead;
//@property (nonatomic, retain) ZoomImageView* imageQueueEnd;

//- (id) initWithFrame:(CGRect)frame;
//- (id) initWithFrameColorAndImages:(CGRect)frame backgroundColor:(UIColor*)bgColor images:(NSArray*)imageArray;
- (void) setupImages:(NSArray*)imageArray;
- (void)updateImagesRectAnimation;
//- (void)updateImagesRectNoAnimation;
- (void)updateImagesRectAnimationLeft;
- (void)updateImagesRectAnimationRight;

@end
