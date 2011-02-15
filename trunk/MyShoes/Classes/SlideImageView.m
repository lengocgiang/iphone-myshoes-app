//
//  SlideImageView.m
//  MyShoes
//
//  Created by Denny Ma on 15/02/11.
//  Copyright 2011 Mbi. All rights reserved.
//

#import "SlideImageView.h"
#import "Config.h"

@implementation SlideImageView

//@synthesize imageScrollView = _imageScrollView;
@synthesize imageViews = _imageViews;
@synthesize imageQueueHead = _imageQueueHead;
@synthesize imageQueueEnd = _imageQueueEnd;

-(id) initWithFrameColorAndImages:(CGRect)frame backgroundColor:(UIColor*)bgColor  images:(NSArray*)imageArray{
	
	if (self = [super initWithFrame:frame]) {
		
		// Initialize the scroll view with the same size as this view.
		//_imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
    
		// Set behaviour for the scrollview
		/*_imageScrollView.backgroundColor = bgColor;
		_imageScrollView.showsHorizontalScrollIndicator = FALSE;
		_imageScrollView.showsVerticalScrollIndicator = FALSE;
		_imageScrollView.scrollEnabled = YES;
		_imageScrollView.bounces = FALSE;*/
		
		// Add ourselves as delegate receiver so we can detect when the user is scrolling.
		//_imageScrollView.delegate = self;
		
		// Add the buttons to the scrollview
		//menuButtons = buttonArray;
		_imageViews = [[NSMutableArray arrayWithCapacity:CAPACITY_SCROLL_BAR] retain];
    
    //Init the first 5 visible image views
		//-(id) initWithFrameColorAndImage:(CGRect)frame backgroundColor:(UIColor*)bgColor image:(UIView*)image
    ZoomImageView *zoomImage1, *zoomImage2, *zoomImage3, *zoomImage4, *zoomImage5;
    
    if ([imageArray count] >= 5) {
      zoomImage1 = [[ZoomImageView alloc] initWithFrameColorAndImage:CGRectMake(25.0f, 108.0f, 135.0f,  135.0f) 
                                                    backgroundColor:[UIColor grayColor]  
                                                              image:[imageArray objectAtIndex:0]];
      zoomImage2 = [[ZoomImageView alloc] initWithFrameColorAndImage:CGRectMake(145.0f, 115.0f, 100.0f,  100.0f) 
                                                    backgroundColor:[UIColor grayColor]  
                                                              image:[imageArray objectAtIndex:1]];
      zoomImage3 = [[ZoomImageView alloc] initWithFrameColorAndImage:CGRectMake(193.0f, 75.0f, 75.0f,  75.0f) 
                                                    backgroundColor:[UIColor grayColor]  
                                                              image:[imageArray objectAtIndex:2]];
      zoomImage4 = [[ZoomImageView alloc] initWithFrameColorAndImage:CGRectMake(215.0f, 42.0, 60.0f,  60.0f) 
                                                    backgroundColor:[UIColor grayColor]  
                                                              image:[imageArray objectAtIndex:3]];
      zoomImage5 = [[ZoomImageView alloc] initWithFrameColorAndImage:CGRectMake(189.0f, 6.0f, 45.0f,  45.0f) 
                                                    backgroundColor:[UIColor grayColor]  
                                                              image:[imageArray objectAtIndex:4]];
      zoomImage1.nextView = zoomImage2;
      zoomImage2.nextView = zoomImage3;
      zoomImage3.nextView = zoomImage4;
      zoomImage4.nextView = zoomImage5;

      [self addSubview:zoomImage5];
      [self addSubview:zoomImage4];
      [self addSubview:zoomImage3];
      [self addSubview:zoomImage2];
      [self addSubview:zoomImage1];
             
    }

    //All the rest image should be invisiable, hidden somewhere
    //The last image in the queue has NIL as the next view
    int i;
    i = 5;
    ZoomImageView *zoomImage, *zoomImagePrevious;
    zoomImagePrevious = zoomImage5;
    
    for (; i<[imageArray count]; i++) {
      zoomImage = [[ZoomImageView alloc] initWithFrameColorAndImage:CGRectMake(148.0f, 9.0f, 0.0f,  0.0f) 
                                                    backgroundColor:[UIColor grayColor]  
                                                              image:[imageArray objectAtIndex:i]];
      zoomImagePrevious.nextView = zoomImage;
      zoomImage.nextView = nil;
      
      [self addSubview:zoomImage];
      zoomImagePrevious = zoomImage;
      
      [zoomImage release];
    }
    
    _imageQueueHead = zoomImage1;
    _imageQueueEnd = zoomImagePrevious;

    [zoomImage1 release];
    [zoomImage2 release];
    [zoomImage3 release];
    [zoomImage4 release];
    [zoomImage5 release];
		
	}
	return self;
}

/*- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	// if the offset is less than 3, the content is scrolled to the far left. This would be the time to show/hide
	// an arrow that indicates that you can scroll to the right. The 3 is to give it some "padding".
	if(scrollView.contentOffset.x <= 3)
	{
		NSLog(@"Scroll is as far left as possible");
	}
	// The offset is always calculated from the bottom left corner, which means when the scroll is as far
	// right as possible it will not give an offset that is equal to the entire width of the content. Example:
	// The content has a width of 500, the scroll view has the width of 200. Then the content offset for far right
	// would be 300 (500-200). Then I remove 3 to give it some "padding"
	else if(scrollView.contentOffset.x >= (scrollView.contentSize.width - scrollView.frame.size.width)-3)
	{
		NSLog(@"Scroll is as far right as possible");
	}
	else
	{
		// The scoll is somewhere in between left and right. This is the place to indicate that the 
		// use can scroll both left and right
	}
  
}

- (void)drawRect:(CGRect)rect {
  // Drawing code
}

- (void)scrollViewPressed:(id)sender {
	//screenLabel.text = ((UIButton*)sender).currentTitle;
	//(SlideMenuView*) slidemenu = (SlideMenuView*) sender;
	NSLog(@"Scroll Menu bar is pressed");
  
  
}*/

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  NSLog(@"TOUCHES BEGAN!!");
  UITouch *touch = [[event allTouches] anyObject];
  _touchBegin = [touch locationInView:touch.view];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{ 
  NSLog(@"TOUCHES MOVED!!");
  // get touch event
  UITouch *touch = [[event allTouches] anyObject];
  // get the touch location
  CGPoint touchLoc = [touch locationInView:touch.view];
  NSLog(@"Mouse location: %f %f", touchLoc.x, touchLoc.y);
  int dx = _touchBegin.x - touchLoc.x;
  int dy = _touchBegin.y - touchLoc.y;
  if(dy>0){NSLog(@"N");}else{NSLog(@"S");}
  if(dx>0){NSLog(@"W");}else{NSLog(@"E");}
}

- (void)dealloc {
	//[_imageScrollView release];
  [super dealloc];
}

@end
