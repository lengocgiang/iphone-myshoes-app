//
//  MyShoesViewController.h
//  MyShoes
//
//  Created by Denny Ma on 27/01/11.
//  Copyright 2011 Mbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
#import "Shoes.h"
#import "ShoesCategory.h"
#import "OrderedDictionary.h"
#import "ShoesListViewCell.h"
#import "LoadMoreSearchResultsTableViewCell.h"
#import "CustomNavigationController.h"
#import "NetworkTool.h"
#import "HJObjManager.h"
#import "MBProgressHUD.h"

@interface ShoesListViewController : UIViewController<
  UITableViewDelegate, 
  UITableViewDataSource, 
  ShoesViewProtocol
> {
  UIView *contentView;
  
  UITableView *shoesListView;
  
  NSMutableArray *shoesArray;
  
  // The cell for loading more results
  LoadMoreSearchResultsTableViewCell *loadMoreSearchResultsCell;
  
  // The NetworkTool instance to do network communications. 
  NetworkTool *networkTool;
  
  // Representing how many pages have been loaded from network. 
  NSUInteger currentPages;
  
  // The array storing all categories user selected
  NSMutableArray *userSelectedCategoriesArray;  
  
  // HJCache library for asynchronous image loading and caching
  HJObjManager *objMan;

  // The flag to show if the view has been reset, the initial value is TRUE
  BOOL viewRest;
  
  // The progress indicator
  MBProgressHUD *HUD;
}

@property (nonatomic, retain) NSMutableArray *userSelectedCategoriesArray;

- (void)startAnimation;
- (void)stopAnimation;
- (void)showShoesList;
- (void)hideShoesListInfoLabels;
- (void)loadShoesList;
- (NSString *)generateUrl;
- (NSString *)generateUrlWithKey:(NSString *)key;

@property (nonatomic, copy) NSString *listType;
@property (nonatomic, copy) NSString *listKey;

@end

