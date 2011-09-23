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
  
  //NSArray  *categoryNameArray;
  UITableView *categoryTableView;

  NSMutableDictionary *shoesCategoryDict;
  NSArray *shoesArray;

  NetworkTool *networkTool;

}

@property (nonatomic, retain) UITableView *categoryTableView;
//@property (nonatomic, retain) NSArray *categoryNameArray;
@property (nonatomic, retain) NSMutableDictionary *shoesCategoryDict;
@property (nonatomic, retain)   NSArray *shoesArray;
@property (nonatomic, retain) NetworkTool *networkTool;

@end
