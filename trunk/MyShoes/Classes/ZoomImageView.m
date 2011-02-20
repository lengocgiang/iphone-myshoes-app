//
//  ZoomImageView.m
//  MyShoes
//
//  Created by Denny Ma on 15/02/11.
//  Copyright 2011 Mbi. All rights reserved.
//

#import "ZoomImageView.h"
#import <QuartzCore/QuartzCore.h>

@implementation ZoomImageView

//@synthesize imageScrollView = _imageScrollView;
@synthesize imageView = _imageView;
@synthesize nextView = _nextView;

-(id) initWithFrameColorAndImage:(CGRect)frame backgroundColor:(UIColor*)bgColor image:(UIImageView*)image{
	
  if (self = [super init]) {
	/*if (self = [super initWithFrame:frame]) {
		
		// Initialize the scroll view with the same size as this view.
		_imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
    
		// Set behaviour for the scrollview
		//_imageScrollView.backgroundColor = bgColor;
		_imageScrollView.showsHorizontalScrollIndicator = FALSE;
		_imageScrollView.showsVerticalScrollIndicator = FALSE;
		_imageScrollView.scrollEnabled = NO;
    [_imageScrollView setUserInteractionEnabled:NO];
    
    _imageScrollView.layer.cornerRadius = ((frame.size.width)/135.0f)*30.0f;
    _imageScrollView.layer.borderWidth = 2.0f;
    
    //[(UIScrollView *)[[_imageScrollView subviews] objectAtIndex:0] setBounces:NO];
    //_imageScrollView.bouncesZoom = YES;
		_imageScrollView.bounces = NO;
		
		// Add ourselves as delegate receiver so we can detect when the user is scrolling.
		_imageScrollView.delegate = self;
		    
    //Just contains one image in this zoom scroll view
		[_imageScrollView setContentSize:CGSizeMake(frame.size.width, frame.size.height)];*/
    _imageView = [image retain];
    [_imageView setUserInteractionEnabled:NO];
    _imageView.frame = frame;//CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height);
    
    _imageView.layer.cornerRadius = ((frame.size.width)/135.0f)*30.0f;
    _imageView.layer.borderWidth = 2.0f;
    
    //_imageView.frame = CGRectMake(0.0f , 0.0f, frame.size.width, frame.size.height);
		//[_imageScrollView addSubview:_imageView];
    
    //Resize of the image to the size of the scroll view
    //[_imageScrollView zoomToRect:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height) animated:NO];
    
		//[self addSubview:_imageScrollView];
		
		//register Touch UpInside event for scrollview
		//[self addTarget:self action:@selector(scrollViewPressed:) forControlEvents:UIControlEventTouchUpInside];
		
	}
	return self;
}

-(void) resizeView:(CGRect)frame{
  //Set the size of the whole frame of the view
  //self.frame = frame;
  //Update the size of the scroll view
  //_imageScrollView.frame = frame;
  //_imageScrollView.layer.cornerRadius = ((frame.size.width)/135.0f)*30.0f;
  
  //[_imageScrollView zoomToRect:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height) animated:YES];
  self.imageView.layer.cornerRadius = ((frame.size.width)/135.0f)*30.0f;
  [UIView beginAnimations:nil context:nil];
  [self.imageView setFrame:frame];
  [UIView commitAnimations];
  //[[self.imageView animator] setFrame:frame];
}


#pragma mark UIScrollViewDelegate methods
// Just need to zoom the image in the scroll bar
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{

  return _imageView;
}

- (void)dealloc {
	//release all objects here
	//[_pID release];
	[_imageView release];
	
	[super dealloc];
}	


@end
