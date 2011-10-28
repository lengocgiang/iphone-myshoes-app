//
//  ShoesCategoryViewController.h
//  MyShoes
//
//  Created by Congpeng Ma on 23/09/11.
//  Copyright 2011 18m. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderedDictionary.h"
#import "NetworkTool.h"


@interface ShoesCategoryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
  
  UITableView *categoryTableView;

  // The array for the categories displayed on the current page
  NSArray *currentPageCategoriesArray;

}

@property (nonatomic, retain) UITableView *categoryTableView;
@property (nonatomic, retain) NSArray *currentPageCategoriesArray;

@end
