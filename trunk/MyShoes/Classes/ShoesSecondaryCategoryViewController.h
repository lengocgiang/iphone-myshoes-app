//
//  ShoesSecondaryCategoryViewController.h
//  MyShoes
//
//  Created by Kevin Liu on 4/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ShoesSecondaryCategoryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    
  UITableView *categoryTableView;
    
  // The array for the categories displayed on the current page
  NSArray *currentPageCategoriesArray;
  
  // The array storing all categories user selected
  NSMutableArray *userSelectedCategoriesArray;  
}

@property (nonatomic, retain) NSArray *currentPageCategoriesArray;
@property (nonatomic, retain) NSMutableArray *userSelectedCategoriesArray;

@end
