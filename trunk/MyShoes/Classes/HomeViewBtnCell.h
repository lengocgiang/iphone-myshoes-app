//
//  HomeViewBtnCell.h
//  MyShoes
//
//  Created by Congpeng Ma on 21/09/11.
//  Copyright 2011 18m. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomeViewBtnCell : UITableViewCell {
  IBOutlet UILabel *btnLable;
}

- (void)setBtnLableTxt:(NSString *)txt;

@end
