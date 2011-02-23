//
//  SlideImageView.m
//  MyShoes
//
//  Created by Denny Ma on 15/02/11.
//  Copyright 2011 Mbi. All rights reserved.
//

#import "SlideImageView.h"
#import "Config.h"
#import <QuartzCore/QuartzCore.h>

@implementation SlideImageView
@synthesize imageViews = _imageViews;
@synthesize delegate;
//@synthesize imageQueueHead = _imageQueueHead;
//@synthesize imageQueueEnd = _imageQueueEnd;

/*-(id) initWithFrame:(CGRect)frame{
	
	if (self = [super initWithFrame:frame]) {
				
    //Do nothing right now
    //
    
	}
	return self;
}*/

- (void) setupImages:(NSArray*)imageArray{

  // Add the buttons to the scrollview
  //menuButtons = buttonArray;

  self.imageViews = [[NSMutableArray arrayWithCapacity:CAPACITY_SHOES_LIST] retain];
  
  //Initialize queue of the image
  for (UIView *image in imageArray){
    //image.layer.cornerRadius = ((frame.size.width)/135.0f)*30.0f;
    image.layer.borderWidth = SHOES_IMAGE_BORDER_SIZE;
    //self.layer.borderWidth = SHOES_IMAGE_BORDER_SIZE;
    [self addSubview:image];
    [self.imageViews enqueue:image];
  }
  
  [self updateImagesRectAnimation];
  [self updateImagesRectAnimationRight];
  [self updateImagesRectAnimationLeft];
}
/*-(id) initWithFrameColorAndImages:(CGRect)frame backgroundColor:(UIColor*)bgColor  images:(NSArray*)imageArray{
	
	if (self = [super initWithFrame:frame]) {
    
		// Add the buttons to the scrollview
		//menuButtons = buttonArray;
		_imageViews = [[NSMutableArray arrayWithCapacity:CAPACITY_SCROLL_BAR] retain];
    
    //Initialize queue of the image
    for (UIView *image in imageArray){
      //image.layer.cornerRadius = ((frame.size.width)/135.0f)*30.0f;
      image.layer.borderWidth = SHOES_IMAGE_BORDER_SIZE;
      //self.layer.borderWidth = SHOES_IMAGE_BORDER_SIZE;
      [self addSubview:image];
      [_imageViews enqueue:image];
    }
    
    [self updateImagesRectAnimation];
    [self updateImagesRectAnimationRight];
    [self updateImagesRectAnimationLeft];
    
	}
	return self;
}*/

/*
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
  //Called back to delegate when starting to scroll
  [self.delegate performSelector:@selector(scrollViewBeganScroll)];
  //[self.delegate performSelector:@selector(scrollViewBeganScroll:) withObject:[self.imageViews objectAtIndex:0]];
  
  UITouch *touch = [[event allTouches] anyObject];
  //Handle single tap only
  //UITouch *touch = [touches anyObject];
  
  NSUInteger numTaps = [touch tapCount];
  
  NSLog(@"The number of taps was: %i", numTaps);
  
  if(numTaps == 1){
    
    NSLog(@"Single tap detected."); }
  else{
      
    // Pass the event to the next responder in the chain.
      
    [self.nextResponder touchesBegan:touches withEvent:event];
    return;
  }
  _firstMove = TRUE;
  _touchBegin = [touch locationInView:touch.view];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{ 
  if(!_firstMove){
    return;
  }
  NSLog(@"TOUCHES MOVED!!");
  // get touch event
  UITouch *touch = [[event allTouches] anyObject];

  // get the touch location
  CGPoint touchLoc = [touch locationInView:touch.view];
  NSLog(@"Mouse location: %f %f", touchLoc.x, touchLoc.y);
  int dx = _touchBegin.x - touchLoc.x;
  //int dy = _touchBegin.y - touchLoc.y;
  /*if(dy>0){
    NSLog(@"N");
  }else{
    NSLog(@"S");
  }*/
  if(dx>0)
  {
    NSLog(@"W");
    
    if ([self.imageViews count] >= 1) {

      id queueHead = [self.imageViews dequeue];
      [self.imageViews enqueue:queueHead];
    
      [UIView beginAnimations:nil context:nil];
      [self updateImagesRectAnimation];
      [self updateImagesRectAnimationLeft];
      [UIView commitAnimations];
      [self updateImagesRectAnimationRight];
    }

  }else{
    //Going backward to the previous views
    NSLog(@"E");
    
    if ([self.imageViews count] >= 1)
    {
      //Get and remove the last image in the queue
      id endObject = [self.imageViews objectAtIndex:[self.imageViews count] -1];
      if (endObject != nil) {
        [[endObject retain] autorelease]; // so it isn't dealloc'ed on remove
        [self.imageViews removeObjectAtIndex:[self.imageViews count] -1];
      }
      [self.imageViews insertObject:endObject atIndex:0];
      //[self.imageViews enqueue:endObject];
      /*for (int i=[self.imageViews.count]-1; i>=1 ;i--)
      {
        [self.imageViews[i] =
      }*/
      
      [UIView beginAnimations:nil context:nil];
      [self updateImagesRectAnimation];
      [self updateImagesRectAnimationRight];
      [UIView commitAnimations];
      [self updateImagesRectAnimationLeft];
    }
  }
  _firstMove = FALSE;
  
  //Called back to delegate when done scrolling
  [self.delegate performSelector:@selector(scrollViewDidScroll:) withObject:[self.imageViews objectAtIndex:0]];
}

- (void)updateImagesRectAnimation{
  //update the first 5 items in the queue

  for (int i=0; i<4; i++){
    [((UIView*)[self.imageViews objectAtIndex:i]) removeFromSuperview];
  }
  
  [(UIView*)[self.imageViews objectAtIndex:0] setFrame:CGRectMake(25.0f, 108.0f, 135.0f,  135.0f)];
  ((UIView*)[self.imageViews objectAtIndex:0]).layer.cornerRadius = (135.0/135.0f)*SHOES_IMAGE_CORNER_RADIUS;
  [(UIView*)[self.imageViews objectAtIndex:1] setFrame:CGRectMake(145.0f, 120.0f, 100.0f,  100.0f)];
  ((UIView*)[self.imageViews objectAtIndex:1]).layer.cornerRadius = (100.0/135.0f)*SHOES_IMAGE_CORNER_RADIUS;
  [(UIView*)[self.imageViews objectAtIndex:2] setFrame:CGRectMake(193.0f, 75.0f, 75.0f,  75.0f)];
  ((UIView*)[self.imageViews objectAtIndex:2]).layer.cornerRadius = (75.0/135.0f)*SHOES_IMAGE_CORNER_RADIUS;
  [(UIView*)[self.imageViews objectAtIndex:3] setFrame:CGRectMake(215.0f, 42.0, 60.0f,  60.0f)];
  ((UIView*)[self.imageViews objectAtIndex:3]).layer.cornerRadius = (60.0/135.0f)*SHOES_IMAGE_CORNER_RADIUS;
  [(UIView*)[self.imageViews objectAtIndex:4] setFrame:CGRectMake(189.0f, 6.0f, 45.0f,  45.0f)];
  ((UIView*)[self.imageViews objectAtIndex:4]).layer.cornerRadius = (45.0/135.0f)*SHOES_IMAGE_CORNER_RADIUS;
  
  //[(UIView*)[self.imageViews objectAtIndex:5] setFrame:CGRectMake(148.0f, 9.0f, 0.0f,  0.0f)];
  //((UIView*)[self.imageViews objectAtIndex:5]).layer.cornerRadius = (0/135.0f)*SHOES_IMAGE_CORNER_RADIUS;

  //Set the position of the last image in the image queue
  //[(UIView*)[self.imageViews objectAtIndex:[_imageViews count]-1] setFrame:CGRectMake(-295.0f, 108.0f, 135.0f,  135.0f)];
  //((UIView*)[self.imageViews objectAtIndex:[_imageViews count]-1]).layer.cornerRadius = (135.0f/135.0f)*SHOES_IMAGE_CORNER_RADIUS;

  for (int i=3; i>=0; i--){
    [self addSubview:((UIView*)[self.imageViews objectAtIndex:i])];
  }
  /*
  int i = 5;
  for (; i<[_imageViews count]; i++) {
    [(UIView*)[self.imageViews objectAtIndex:i] setFrame:CGRectMake(148.0f, 9.0f, 0.0f,  0.0f)];
    ((UIView*)[self.imageViews objectAtIndex:0]).layer.cornerRadius = (0/135.0f)*30.0f;
  }*/
  
}

- (void)updateImagesRectAnimationLeft{
  [(UIView*)[self.imageViews objectAtIndex:[_imageViews count]-1] setFrame:CGRectMake(-295.0f, 108.0f, 135.0f,  135.0f)];
  ((UIView*)[self.imageViews objectAtIndex:[_imageViews count]-1]).layer.cornerRadius = (135.0f/135.0f)*SHOES_IMAGE_CORNER_RADIUS;
}

- (void)updateImagesRectAnimationRight{
  [(UIView*)[self.imageViews objectAtIndex:5] setFrame:CGRectMake(148.0f, 9.0f, 0.0f,  0.0f)];
  ((UIView*)[self.imageViews objectAtIndex:5]).layer.cornerRadius = (0/135.0f)*SHOES_IMAGE_CORNER_RADIUS;
}

/*- (void)updateImagesRectNoAnimation{
  [(UIView*)[self.imageViews objectAtIndex:5] setFrame:CGRectMake(148.0f, 9.0f, 0.0f,  0.0f)];
  ((UIView*)[self.imageViews objectAtIndex:5]).layer.cornerRadius = (0/135.0f)*SHOES_IMAGE_CORNER_RADIUS;
  [(UIView*)[self.imageViews objectAtIndex:[_imageViews count]-1] setFrame:CGRectMake(-295.0f, 108.0f, 135.0f,  135.0f)];
  ((UIView*)[self.imageViews objectAtIndex:[_imageViews count]-1]).layer.cornerRadius = (135.0f/135.0f)*SHOES_IMAGE_CORNER_RADIUS;
}*/

- (void)dealloc {
	//[_imageScrollView release];
  [super dealloc];
}

@end
