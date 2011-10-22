//
//  ShoppingCart.m
//  MyShoes
//
//  Created by Congpeng Ma on 19/10/11.
//  Copyright 2011 18m. All rights reserved.
//

#import "ShoppingCart.h"
#import "Config.h"

@implementation ShoppingCart

@synthesize shoesArray;
@synthesize shoesQuantity;

- (id)init {
	//Initialize the two arrays to accept user's order
	//
	if((self = [super init] )) {
		shoesArray = [[NSMutableArray arrayWithCapacity:CAPACITY_SHOPPING_CART] retain];
    shoesQuantity = [[NSMutableArray arrayWithCapacity:CAPACITY_SHOPPING_CART] retain];
	}
	return self;
}

- (void)dealloc {
  [shoesQuantity release];
  [shoesArray release];
}

@end
