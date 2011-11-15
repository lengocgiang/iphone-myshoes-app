//
//  ShoppingCartViewCell.h
//  MyShoes
//
//  Created by Congpeng Ma on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shoes.h"

@interface ShoppingCartViewCell : UITableViewCell<UITextFieldDelegate> {
  
  //UILabel *shoesBrandName;
  UILabel *shoesInfo;
  //UILabel *shoesColor;
  UILabel *shoesDetail;
  
  UITextField *shoesQuantity;
  
  Shoes *shoes;
}

@property (nonatomic, retain) Shoes *shoes;

- (void)setShoesInfo:(NSString *)txt;
- (void)setShoesDetail:(NSString *)txt;
- (void)setShoesQuantity:(NSUInteger)quantity;
- (void)setEditing:(BOOL)editing;

@end
