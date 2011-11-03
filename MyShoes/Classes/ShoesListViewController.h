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

@interface ShoesListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, ShoesViewProtocol/*, SlideImageViewDelegate*/>{
  UIView *contentView;
  UIActivityIndicatorView *progressIndicator;
  //UIWebView *shoesImage;
  
  //SlideImageView *slideImageView;
  
  UITableView *shoesListView;
  UIView *shoesScrollingView;
  
  NSArray *_imageArray;
  
  NSMutableArray *_shoesArray;
  
  Boolean _isTableView;
  
  NSMutableDictionary *_shoesCategoryDict;
  
  ShoesListViewCell *shoesListCell;
  LoadMoreSearchResultsTableViewCell *loadMoreSearchResultsCell;
  //SlideMenuViewController *slideMenuViewController;
  
  /* The NetworkTool instance to do network communications. */
  NetworkTool *networkTool;
  
  /* Representing how many pages have been loaded from network. */
  NSUInteger currentPages;
  
  // The array storing all categories user selected
  NSMutableArray *userSelectedCategoriesArray;  
  
  //HJCache library for asynchronous image loading and caching
  HJObjManager *objMan;

  //The flag to show if the view has been reset, the initial value is TRUE
  BOOL viewRest;
}

@property (nonatomic, retain) IBOutlet UIView *contentView;
@property (nonatomic, retain) IBOutlet UIView *shoesScrollingView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *progressIndicator;
@property (nonatomic, retain) IBOutlet UITableView *shoesListView;
@property (nonatomic, retain) IBOutlet ShoesListViewCell *shoesListCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *loadMoreSearchResultsCell;
@property (nonatomic, retain) NSMutableDictionary *shoesDict;
@property (nonatomic, retain) NSArray *imageArray;
@property (nonatomic, retain) NSMutableArray *userSelectedCategoriesArray;

- (void)startAnimation;
- (void)stopAnimation;
- (void)showShoesList;
- (void)hideShoesListInfoLabels;
- (void)loadShoesList;
- (NSString *)generateUrl;

@end

