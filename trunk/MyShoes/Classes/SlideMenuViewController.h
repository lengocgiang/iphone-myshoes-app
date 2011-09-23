//
//  SlideMenuViewController.h
//  MyShoes
//
//  Created by Denny Ma on 7/02/11.
//  Copyright 2011 Mbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideMenuView.h"
#import "Config.h"
#import "NetworkTool.h"


@interface SlideMenuViewController : UIViewController {

	SlideMenuView *slideMenuView;	
	UIButton *_previousButton;
	NSDictionary *_shoesCategoryDict;
  NSArray *_shoesArray;
  NSArray *_categoryButtons;
  
	NetworkTool *_cu;
}

@property (nonatomic, retain) SlideMenuView *slideMenuView;
@property (nonatomic, retain) UIButton *previousButton;
@property (nonatomic, retain) NSDictionary *shoesCategoryDict;
@property (nonatomic, retain) NSArray *shoesArray;
@property (nonatomic, retain) NSArray *categoryButtons;
@property (nonatomic, retain) NetworkTool *cu;

- (id)init;
- (id)initWithCategories:(NSDictionary*) dict;

@end
