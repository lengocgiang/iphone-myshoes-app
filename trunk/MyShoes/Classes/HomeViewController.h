//
//  HomeViewController.h
//  MyShoes
//
//  Created by Congpeng Ma on 19/09/11.
//  Copyright 2011 18m. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewBtnCell.h"
//#import "ShoesTableView.h"
//#import "ShoesDataSourceProtocol.h"


@interface HomeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    
  UIButton *browserCategoryBtn;
  UIButton *onSaleBtn;
  
  NSArray  *btnNameArray;
  UITableView *aTableViewBtn;
  IBOutlet HomeViewBtnCell *btnCell;
  //ShoesTableView *aTableViewBtn;
}

@property (nonatomic, retain) IBOutlet UIButton *browserCategoryBtn;
@property (nonatomic, retain) IBOutlet UIButton *onSaleBtn;
@property (nonatomic, retain) UITableView *aTableViewBtn;

+ (UIImage *)scale:(UIImage *)image toSize:(CGSize)size;
- (IBAction) browserCategory;
- (IBAction) browserOnSale;

@end
