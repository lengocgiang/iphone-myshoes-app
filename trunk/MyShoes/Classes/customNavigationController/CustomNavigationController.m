//
//  CustomNavigationController.m
//  MyShoes
//
//  Created by Congpeng Ma on 1/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "customNavigationController.h"

@implementation CustomNavigationController
@synthesize delegate;

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
	//if([[self.viewControllers lastObject] class] == [SettingsTableController class]){
  /*
  if([[self.viewControllers lastObject] isMemberOfClass:[UIViewController class]]){
    
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration: 1.00];
		[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown
                           forView:self.view cache:NO];
    
		UIViewController *viewController = [super popViewControllerAnimated:NO];
    
		[UIView commitAnimations];
    
		return viewController;
	} else {
		return [super popViewControllerAnimated:animated];
	}
   */
  id popedView;
  popedView = [super popViewControllerAnimated:animated];
  
  [self.delegate navigationController:self didPopViewController:popedView animated:animated];
  
  return popedView;
}

@end