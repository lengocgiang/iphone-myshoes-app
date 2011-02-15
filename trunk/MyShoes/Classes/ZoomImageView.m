//
//  ZoomImageView.m
//  MyShoes
//
//  Created by Denny Ma on 15/02/11.
//  Copyright 2011 Mbi. All rights reserved.
//

#import "ZoomImageView.h"

@implementation ZoomImageView

@synthesize imageScrollView = _imageScrollView;
@synthesize imageView = _imageView;
@synthesize nextView = _nextView;

-(id) initWithFrameColorAndImage:(CGRect)frame backgroundColor:(UIColor*)bgColor image:(UIView*)image{
	
	if (self = [super initWithFrame:frame]) {
		
		// Initialize the scroll view with the same size as this view.
		_imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
    
		// Set behaviour for the scrollview
		//_imageScrollView.backgroundColor = bgColor;
		_imageScrollView.showsHorizontalScrollIndicator = FALSE;
		_imageScrollView.showsVerticalScrollIndicator = FALSE;
		_imageScrollView.scrollEnabled = NO;
    _imageScrollView.bouncesZoom = YES;
		_imageScrollView.bounces = YES;
		
		// Add ourselves as delegate receiver so we can detect when the user is scrolling.
		_imageScrollView.delegate = self;
		    
    //Just contains one image in this zoom scroll view
		[_imageScrollView setContentSize:CGSizeMake(frame.size.width, frame.size.height)];
    _imageView = image;
    _imageView.frame = CGRectMake(0.0f , 0.0f, frame.size.width, frame.size.height);
		[_imageScrollView addSubview:_imageView];
    
		[self addSubview:_imageScrollView];
		
		//register Touch UpInside event for scrollview
		//[self addTarget:self action:@selector(scrollViewPressed:) forControlEvents:UIControlEventTouchUpInside];
		
	}
	return self;
}

#pragma mark UIScrollViewDelegate methods
// Just need to zoom the image in the scroll bar
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
  /*UIView *view = nil;
  if (scrollView == imageScrollView) {
    view = [imageScrollView viewWithTag:ZOOM_VIEW_TAG];
  }
  return view;*/
  return _imageView;
}

@end
