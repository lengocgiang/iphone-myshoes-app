//
//  ShoesCategoryTableViewCell.m
//  MyShoes
//
//  Created by Congpeng Ma on 24/09/11.
//  Copyright 2011 18m. All rights reserved.
//

#import "ShoesListViewCell.h"
#import "Config.h"


@implementation ShoesListViewCell

//@synthesize shoesBrandName;
//@synthesize shoesStyle;
//@synthesize shoesColor;
//@synthesize shoesPrice;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    // Initialization code
    //Create Lable for BrandName
    shoesBrandName = [[[UILabel alloc] init] autorelease];
    shoesBrandName.font = [UIFont fontWithName:@"Helvetica" size:(14.0)];
    [self.contentView addSubview:shoesBrandName];
    
    //Create Lable for Color
    shoesColor = [[[UILabel alloc] init] autorelease];
    shoesColor.textAlignment = UITextAlignmentRight;
    shoesColor.font = [UIFont fontWithName:@"Helvetica" size:(12.0)];
    [self.contentView addSubview:shoesColor];
    
    //Create Lable for Style
    shoesStyle = [[[UILabel alloc] init] autorelease];
    shoesStyle.font = [UIFont fontWithName:@"Helvetica" size:(12.0)];
    [self.contentView addSubview:shoesStyle];
    
    //Create Lable for Style
    shoesPrice = [[[UILabel alloc] init] autorelease];
    shoesPrice.textAlignment = UITextAlignmentRight;
    shoesPrice.font = [UIFont fontWithName:@"Helvetica" size:(20.0)];
    [self.contentView addSubview:shoesPrice];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  CGRect frame;
  float indicatorSize = 25;//cell.accessoryView.frame.size.width;

  
  frame.origin.x = 10 + SHOES_LIST_CELL_IMG_WIDTH;
  frame.origin.y = 0;
  frame.size.height = 30;
  frame.size.width = 150;

  shoesBrandName.frame = frame;
  
  //The position of the Color label
  frame.origin.x = self.contentView.frame.size.width - 80 - indicatorSize;
  frame.origin.y = 0;
  frame.size.height = 20;
  frame.size.width = 80;   
  
  shoesColor.frame = frame;
  

  frame.origin.x = 10 + SHOES_LIST_CELL_IMG_WIDTH;
  frame.origin.y = 30;
  frame.size.height = 30;
  frame.size.width = 150;
  
  shoesStyle.frame = frame;
  
  //The position of the price label
  frame.origin.x = self.contentView.frame.size.width - 80 - indicatorSize;
  frame.origin.y = 20;
  frame.size.height = 40;
  frame.size.width = 80;
  
  shoesPrice.frame = frame;
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

- (void)dealloc
{
  [super dealloc];
}

- (void)setShoesBrandName:(NSString *)txt{
  shoesBrandName.text = txt;
}
- (void)setShoesStyle:(NSString *)txt{
  shoesStyle.text = txt;
}
- (void)setShoesColor:(NSString *)txt{
  shoesColor.text = txt;
}
- (void)setShoesPrice:(NSString *)txt{
  shoesPrice.text = txt;
}

@end
