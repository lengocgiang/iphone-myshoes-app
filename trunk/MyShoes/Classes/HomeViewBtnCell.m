//
//  HomeViewBtnCell.m
//  MyShoes
//
//  Created by Congpeng Ma on 21/09/11.
//  Copyright 2011 18m. All rights reserved.
//

#import "HomeViewBtnCell.h"


@implementation HomeViewBtnCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setBtnLableTxt:(NSString *)txt
{
  btnLable.text = txt;
}

- (void)dealloc
{
    [super dealloc];
}

@end
