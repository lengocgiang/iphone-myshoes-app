//
//  CustomNavigationController.h
//  MyShoes
//
//  Created by Congpeng Ma on 1/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNavigationController : UINavigationController{

  id  delegate;
}

@property(nonatomic, assign) id delegate;


@end

@protocol CustomNavigationControllerDelegate<NSObject>

@required

- (void)navigationController:(UINavigationController *)navigationController didPopViewController:(UIViewController *)viewController animated:(BOOL)animated;


@end