//
//  Created by Björn Sållarp on 2008-10-04.
//  Copyright MightyLittle Industries 2008. All rights reserved.
//
//  Read my blog @ http://jsus.is-a-geek.org/blog
//

#import <UIKit/UIKit.h>


@interface SlideMenuView : UIView <UIScrollViewDelegate> {
	UIScrollView *_menuScrollView;
	//UIImageView *_rightMenuImage;
	//UIImageView *_leftMenuImage;
	NSMutableArray *_menuButtons;
}
-(id) initWithFrameColorAndButtons:(CGRect)frame backgroundColor:(UIColor*)bgColor  buttons:(NSArray*)buttonArray;

@property (nonatomic, retain) UIScrollView* menuScrollView;
//@property (nonatomic, retain) UIImageView* rightMenuImage;
//@property (nonatomic, retain) UIImageView* leftMenuImage;
@property (nonatomic, retain) NSMutableArray* menuButtons;

@end