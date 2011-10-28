//
//  BSPreviewScrollView+Reload.m
//  MyShoes
//
//  Created by Congpeng Ma on 15/10/11.
//  Copyright 2011 18m. All rights reserved.
//

#import "BSPreviewScrollView+ReloadPages.h"


@implementation BSPreviewScrollView (ReloadPages)

- (void)reloadPages {
  
  int pageCount = [delegate itemCount:self];
  
  //Clean all previous views
  for (UIView *subview in scrollView.subviews) {
    [subview removeFromSuperview];
  }
  
  [scrollViewPages removeAllObjects];
  [scrollViewPages release];
  
  scrollViewPages = [[NSMutableArray alloc] initWithCapacity:pageCount];
  
  // Fill our pages collection with empty placeholders
  for(int i = 0; i < pageCount; i++)
  {
    [scrollViewPages addObject:[NSNull null]];
  }
  
  // Calculate the size of all combined views that we are scrolling through 
  self.scrollView.contentSize = CGSizeMake([delegate itemCount:self] * self.scrollView.frame.size.width, scrollView.frame.size.height);
  
  // Reset scroll view selection position to page 0
  [self.scrollView setContentOffset:CGPointMake(0,0) animated:NO];

  // Load the first two pages
  [self loadPage:0];
  [self loadPage:1];
}

@end
