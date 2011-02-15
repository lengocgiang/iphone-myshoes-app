//
//  SlideImageView.h
//  MyShoes
//
//  Created by Denny Ma on 15/02/11.
//  Copyright 2011 Mbi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZoomImageView.h"

@interface SlideImageView : UIView <UIScrollViewDelegate> {
  
	//UIScrollView *_imageScrollView;
	NSMutableArray *_imageViews;
  
  ZoomImageView *_imageQueueHead;
  ZoomImageView *_imageQueueEnd;
  
  CGPoint _touchBegin;
}
-(id) initWithFrameColorAndImages:(CGRect)frame backgroundColor:(UIColor*)bgColor images:(NSArray*)imageArray;

//@property (nonatomic, retain) UIScrollView* imageScrollView;
//@property (nonatomic, retain) UIImageView* rightMenuImage;
//@property (nonatomic, retain) UIImageView* leftMenuImage;
@property (nonatomic, retain) NSMutableArray* imageViews;
@property (nonatomic, retain) ZoomImageView* imageQueueHead;
@property (nonatomic, retain) ZoomImageView* imageQueueEnd;

@end
