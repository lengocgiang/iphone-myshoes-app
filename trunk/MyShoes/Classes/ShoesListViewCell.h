//
//  ShoesCategoryTableViewCell.h
//  MyShoes
//
//  Created by Congpeng Ma on 24/09/11.
//  Copyright 2011 18m. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ShoesListViewCell : UITableViewCell {
  
  UILabel *shoesBrandName;
  UILabel *shoesStyle;
  UILabel *shoesColor;
  UILabel *shoesPrice;
  
  
}

- (void)setShoesBrandName:(NSString *)txt;
- (void)setShoesStyle:(NSString *)txt;
- (void)setShoesColor:(NSString *)txt;
- (void)setShoesPrice:(NSString *)txt;

@end
