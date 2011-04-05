//
//  Created by Björn Sållarp on 2008-10-04.
//  Copyright MightyLittle Industries 2008. All rights reserved.
//
//  Read my blog @ http://jsus.is-a-geek.org/blog
//

#import "SlideMenuView.h"
#import "Config.h"


@implementation SlideMenuView

@synthesize menuScrollView = _menuScrollView;
//@synthesize rightMenuImage = _rightMenuImage;
//@synthesize leftMenuImage = _leftMenuImage;
@synthesize menuButtons = _menuButtons;

- (id) initWithFrameColorAndButtons:(CGRect)frame backgroundColor:(UIColor*)bgColor  buttons:(NSArray*)buttonArray  {
	
	if ((self = [super initWithFrame:frame])) {
		
		// Initialize the scroll view with the same size as this view.
		_menuScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];

		// Set behaviour for the scrollview
		_menuScrollView.backgroundColor = bgColor;
		_menuScrollView.showsHorizontalScrollIndicator = FALSE;
		_menuScrollView.showsVerticalScrollIndicator = FALSE;
		_menuScrollView.scrollEnabled = YES;
		_menuScrollView.bounces = FALSE;
		
		// Add ourselves as delegate receiver so we can detect when the user is scrolling.
		_menuScrollView.delegate = self;
		
		// Add the buttons to the scrollview
		//menuButtons = buttonArray;
		_menuButtons = [[NSMutableArray arrayWithCapacity:CAPACITY_SCROLL_BAR] retain];
		
		float totalButtonWidth = 0.0f;
		
		for(UIButton *btn in buttonArray)
		{
			[_menuButtons addObject:btn];			
			// Move the buttons position in the x-demension (horizontal).
			// Make button frame wider and higher than button by 10 points
			//CGRect btnRect = btn.frame;
			CGRect btnRect = CGRectMake(totalButtonWidth , btn.frame.origin.y - 10, btn.frame.size.width + 10, btn.frame.size.height + 10);
			UIView *btnView = [[[UIView alloc] initWithFrame:btnRect] autorelease];
			//btnRect.origin.x = totalButtonWidth;
			btn.frame = CGRectMake(5.0f , 5.0f, btn.frame.size.width , btn.frame.size.height);
			//[btn setFrame:btnRect];
			[btnView addSubview:btn];
			
			// Add the button to the scrollview
			[_menuScrollView addSubview:btnView];
			
			// Add the width of the button to the total width.
			totalButtonWidth += btnView.frame.size.width;
		}
		
		// Update the scrollview content rect, which is the combined width of the buttons
		[_menuScrollView setContentSize:CGSizeMake(totalButtonWidth, self.frame.size.height)];
		
		[self addSubview:_menuScrollView];
		
		//register Touch UpInside event for scrollview
		//[self addTarget:self action:@selector(scrollViewPressed:) forControlEvents:UIControlEventTouchUpInside];
		
	}
	return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
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


}

/*- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan!!! ");

	[super touchesEnded:touches withEvent:event];		
	
	// only forward the event UP the responder chain if this touch
	// is for a scroll view (self or a subview that inherits from
	// UIScrollView); the default UIScrollView implementation deals 
	// with subview event handling above in the [super] invocation.
	if ([myTouch.view isKindOfClass:[UIScrollView class]]) {
		if(self.nextResponder != nil &&
		   [self.nextResponder respondsToSelector:@selector(touchesEnded:withEvent:)]) {
			[self.nextResponder touchesEnded:touches withEvent:event];
		}
	}
}*/


- (void)dealloc {
	//[_menuButtons release];
	//[_rightMenuImage release];
	//[_leftMenuImage release];
	[_menuScrollView release];
    [super dealloc];
}


@end
