//
//  ShoppingCartViewCell.m
//  MyShoes
//
//  Created by Congpeng Ma on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ShoppingCartViewCell.h"
#import "ShoppingCart.h"
#import "ShoppingCartViewController.h"
#import "MyShoesAppDelegate.h"
#import "Config.h"

@implementation ShoppingCartViewCell
@synthesize shoes;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    // Initialization code
    // Initialization code
    //Create Shoes Info Label
    shoesInfo = [[[UILabel alloc] init] autorelease];
    shoesInfo.font = [UIFont fontWithName:@"Helvetica" size:(14.0)];
    [self.contentView addSubview:shoesInfo];
    
    //Create Shoes size Info Label which is below the Shoes Info Label
    shoesSizeInfo = [[[UILabel alloc] init] autorelease];
    shoesSizeInfo.font = [UIFont fontWithName:@"Helvetica" size:(10.0)];
    [self.contentView addSubview:shoesSizeInfo];
    
    //Create Shoes Detail Label
    shoesDetail = [[[UILabel alloc] init] autorelease];
    shoesDetail.textAlignment = UITextAlignmentRight;
    shoesDetail.font = [UIFont fontWithName:@"Helvetica" size:(10.0)];
    [self.contentView addSubview:shoesDetail];
    
    //Create input for quantity
    //Should accept number only
    shoesQuantity = [[[UITextField alloc] init] autorelease];
    shoesQuantity.textAlignment = UITextAlignmentRight;
    shoesQuantity.font = [UIFont fontWithName:@"Helvetica" size:(12.0)];
    
    //Quantity text input field should accept number only
    shoesQuantity.keyboardType = UIKeyboardTypeNumberPad;
    //Set the boder and corner of the text field
    shoesQuantity.layer.cornerRadius = 2.0f;
    shoesQuantity.clipsToBounds = YES;
    shoesQuantity.layer.borderWidth = 1.0f;
    
    //By default, Shoes Quantity Input should be invisible
    [shoesQuantity setHidden:YES];
    
    //Locate shopping cart object
    id delegate = [[UIApplication sharedApplication] delegate];
    
    ShoppingCartViewController *shoppingCartView = nil;
    if ([delegate respondsToSelector:@selector(shoppingCart)]){
      shoppingCartView = [delegate shoppingCartController];
    }
    
    shoesQuantity.delegate = shoppingCartView;
    [self.contentView addSubview:shoesQuantity];
    
  }

  //Remove default views
  [self.imageView removeFromSuperview];
  [self.textLabel removeFromSuperview];
  [self.contentView setOpaque:YES];

  return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
  [super layoutSubviews];
  CGRect frame;
  float indicatorSize = 5;//cell.accessoryView.frame.size.width;
  
  //The frame of the shoes info label
  frame.origin.x = 5 + SHOES_LIST_CELL_IMG_WIDTH;
  frame.origin.y = 5;
  frame.size.height = 30;
  frame.size.width = 150;
  
  shoesInfo.frame = frame;
  
  //The frame of the shoessize info label
  frame.origin.x = 5 + SHOES_LIST_CELL_IMG_WIDTH;
  frame.origin.y = 5 + shoesInfo.frame.size.height;
  frame.size.height = 20;
  frame.size.width = 150;
  
  shoesSizeInfo.frame = frame;
 
  
  //The frame of the shoes detail label
  frame.origin.x = self.contentView.frame.size.width - 70 - indicatorSize;
  frame.origin.y = 20;
  frame.size.height = 20;
  frame.size.width = 70;   
  
  shoesDetail.frame = frame;
  
  //The frame of the shoes quantity text input field
  frame.origin.x = self.contentView.frame.size.width - 60 - indicatorSize;
  frame.origin.y = 10;
  frame.size.height = 30;
  frame.size.width = 60;
  
  shoesQuantity.frame = frame;
}

- (void)setShoesInfo:(NSString *)txt {
  shoesInfo.text = txt;
}

- (void)setShoesSizeInfo:(NSString *)txt {
  shoesSizeInfo.text = txt;
}

- (void)setShoesDetail:(NSString *)txt {
  shoesDetail.text = txt;
}

- (void)setShoesQuantity:(NSUInteger)quantity {
  shoesQuantity.text = [NSString stringWithFormat:@"%d",quantity];
}

- (void)setEditing:(BOOL)editing {
  //In editing mode
  //Hide shoes detail label and show shoes quantity input
  if(editing) {
    [shoesQuantity setHidden:NO];
    [shoesDetail setHidden:YES];
  }
  else{
    [shoesQuantity setHidden:YES];
    [shoesDetail setHidden:NO];   
  }
}

- (void)dealloc
{
  [super dealloc];
  [shoes release];
}

/*
#pragma mark UITextFieldDelegate methods


- (void)textFieldDidEndEditing:(UITextField *)textField {
  //Grab the number that user set for quantity
  //For the moment, don't do any valid check
  id delegate = [[UIApplication sharedApplication] delegate];
  
  ShoppingCart *shoppingCart = nil;
  if ([delegate respondsToSelector:@selector(shoppingCart)]){
    shoppingCart = [delegate shoppingCart];
  }
  
  NSString *str = textField.text;
  
  //Convert the String to number
  NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
  [f setNumberStyle:NSNumberFormatterNoStyle];
  NSNumber * myNumber = [f numberFromString:str];
  [f release];
  
  //Set the updated number of shoppingCart
  [shoppingCart updateShoes:self.shoes withQuantity:myNumber.integerValue];
  
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return NO;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField {
  UITableViewCell *cell = (UITableViewCell*) [[textField superview] superview];
  [tView scrollToRowAtIndexPath:[tView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}*/

@end
