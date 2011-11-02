//
//  MyShoesViewController.h
//  MyShoes
//
//  Created by Denny Ma on 27/01/11.
//  Copyright 2011 Mbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
#import "SlideImageView.h"
//#import "SlideMenuViewController.h"
#import "Shoes.h"
#import "ShoesCategory.h"
#import "OrderedDictionary.h"
#import "ShoesListViewCell.h"
#import "LoadMoreSearchResultsTableViewCell.h"
#import "NetworkTool.h"
#import "HJObjManager.h"

@interface ShoesListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource/*, SlideImageViewDelegate*/>{
  UIView *contentView;
  UIActivityIndicatorView *progressIndicator;
  //UIWebView *shoesImage;
  
  SlideImageView *slideImageView;
  
  UITableView *shoesListView;
  UIView *shoesScrollingView;
  //NSMutableArray *_shoesList;
  
  UILabel *shoesBrandName;
  UILabel *shoesStyle;
  UILabel *shoesColor;
  UILabel *shoesPrice;
  
  //UIToolbar
  UIToolbar *toolBar;
  
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
}

@property (nonatomic, retain) IBOutlet UIView *contentView;
@property (nonatomic, retain) IBOutlet UIView *shoesScrollingView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *progressIndicator;
//@property (nonatomic, retain) IBOutlet UIWebView *shoesImage;
@property (nonatomic, retain) IBOutlet SlideImageView *slideImageView;
@property (nonatomic, retain) IBOutlet UITableView *shoesListView;
@property (nonatomic, retain) IBOutlet ShoesListViewCell *shoesListCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *loadMoreSearchResultsCell;
@property (nonatomic, retain) NSMutableDictionary *shoesDict;
@property (nonatomic, retain) IBOutlet UILabel *shoesBrandName;
@property (nonatomic, retain) IBOutlet UILabel *shoesStyle;
@property (nonatomic, retain) IBOutlet UILabel *shoesColor;
@property (nonatomic, retain) IBOutlet UILabel *shoesPrice;
@property (nonatomic, retain) UIToolbar *toolBar;
@property (nonatomic, retain) NSArray *imageArray;
//@property (nonatomic, retain) SlideMenuViewController *slideMenuViewController;
@property (nonatomic, retain) NSMutableArray *userSelectedCategoriesArray;

- (void)startAnimation;
- (void)stopAnimation;
- (void)showShoesList/*:(NSArray *) shoesList*/;
- (void)showShoesListInfo:(Shoes *)shoes;
- (void)hideShoesListInfoLabels;
- (void)loadShoesList;
- (NSString *)generateUrl;

@end

