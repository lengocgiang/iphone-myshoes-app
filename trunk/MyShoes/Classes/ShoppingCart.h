//
//  ShoppingCart.h
//  MyShoes
//
//  Created by Congpeng Ma on 19/10/11.
//  Copyright 2011 18m. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shoes.h"


@interface ShoppingCart : NSObject {
    
  //Shoes object which are in the order
  NSMutableArray *shoesArray;
  //Shoes quantity which are in the order
  NSMutableArray *shoesQuantity;
}

@property (nonatomic, retain) NSMutableArray *shoesArray;
@property (nonatomic, retain) NSMutableArray *shoesQuantity;

@end
