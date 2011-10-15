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
#import "ShoesTableView.h"
#import "ShoesListViewCell.h"
#import "LoadMoreSearchResultsTableViewCell.h"
#import "NetworkTool.h"

@interface ShoesListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource/*, SlideImageViewDelegate*/>{
  UIView *contentView;
  UIActivityIndicatorView *progressIndicator;
  //UIWebView *shoesImage;
  
  SlideImageView *slideImageView;
  //ShoesTableView *shoesTableView;
  
  UITableView *shoesListView;
  UIView *shoesScrollingView;
  //NSMutableArray *_shoesList;
  NSMutableDictionary *_shoesDict;
  
  UILabel *shoesBrandName;
  UILabel *shoesStyle;
  UILabel *shoesColor;
  UILabel *shoesPrice;
  
  //UIToolbar
  UIToolbar *toolBar;
  
  NSArray *_imageArray;
  
  NSArray *_shoesArray;
  
  Boolean _isTableView;
  
  NSMutableDictionary *_shoesCategoryDict;
  
  ShoesListViewCell *shoesListCell;
  LoadMoreSearchResultsTableViewCell *loadMoreSearchResultsCell;
  //SlideMenuViewController *slideMenuViewController;
  
  /* The url for next request. */
  NSString *url;
  
  /* The NetworkTool instance to do network communications. */
  NetworkTool *networkTool;
  
  /* Representing how many pages have been loaded from network. */
  NSInteger *currentPages;
  
  // The array storing all categories user selected
  NSMutableArray *userSelectedCategoriesArray;  
}

@property (nonatomic, retain) IBOutlet UIView *contentView;
@property (nonatomic, retain) IBOutlet UIView *shoesScrollingView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *progressIndicator;
//@property (nonatomic, retain) IBOutlet UIWebView *shoesImage;
@property (nonatomic, retain) IBOutlet SlideImageView *slideImageView;
@property (nonatomic, retain) IBOutlet UITableView *shoesListView;
@property (nonatomic, retain) IBOutlet ShoesListViewCell *shoesListCell;
@property (nonatomic, retain) IBOutlet UITableViewCell *loadMoreSearchResultsCell;
//@property (nonatomic, retain) ShoesTableView *shoesTableView;
//@property (nonatomic, retain) NSMutableArray *shoesList;
@property (nonatomic, retain) NSMutableDictionary *shoesDict;
@property (nonatomic, retain) IBOutlet UILabel *shoesBrandName;
@property (nonatomic, retain) IBOutlet UILabel *shoesStyle;
@property (nonatomic, retain) IBOutlet UILabel *shoesColor;
@property (nonatomic, retain) IBOutlet UILabel *shoesPrice;
@property (nonatomic, retain) UIToolbar *toolBar;
@property (nonatomic, retain) NSArray *imageArray;
//@property (nonatomic, retain) SlideMenuViewController *slideMenuViewController;
@property (nonatomic, retain) NSMutableDictionary *shoesCategoryDict;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NetworkTool *networkTool;
@property (nonatomic) NSInteger *currentPages;
@property (nonatomic, retain) NSMutableArray *userSelectedCategoriesArray;

- (void)startAnimation;
- (void)stopAnimation;
- (void)showShoesList/*:(NSArray *) shoesList*/;
- (void)showShoesListInfo:(Shoes *)shoes;
- (void)hideShoesListInfoLabels;
- (void)loadShoesList;
- (NSString *)generateInitialUrl;

@end

