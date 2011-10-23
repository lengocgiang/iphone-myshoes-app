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

//@synthesize shoesArray;
//@synthesize shoesQuantity;

- (id)init {
	//Initialize the two arrays to accept user's order
	//
	if((self = [super init] )) {
		shoesArray = [[NSMutableArray arrayWithCapacity:CAPACITY_SHOPPING_CART] retain];
    shoesQuantity = [[NSMutableArray arrayWithCapacity:CAPACITY_SHOPPING_CART] retain];
	}
	return self;
}

- (void)addToCart:(Shoes *)shoes {
  [self addToCart:shoes andQuantitiy:1];
}

- (void)addToCart:(Shoes *)shoes andQuantitiy:(NSUInteger)quantity {
  [shoesArray addObject:shoes];
  [shoesQuantity addObject:[NSNumber numberWithInt:quantity]];
}


- (void)dealloc {
  [shoesQuantity release];
  [shoesArray release];
}

@end
