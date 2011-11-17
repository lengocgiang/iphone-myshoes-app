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
  //Check if the shoes exist, if yes, just quantity plus 1
  int i = 0, index = -1;
  for(Shoes* s in shoesArray){
    if([s equals:shoes])
    {
      index = i;
      break;
    }
    i++;
  }
  
  //Not the same type of shoes in shopping cart
  if(index == -1) {
    [self addToCart:shoes andQuantitiy:1];
  }
  else //Add quantity by 1
  {
    NSUInteger q = [self getQuantity:index];
    q++;
    [shoesQuantity replaceObjectAtIndex:index withObject:[NSNumber numberWithInt:q]];
    
    
  }
}

- (void)addToCart:(Shoes *)shoes andQuantitiy:(NSUInteger)quantity {
  [shoesArray addObject:shoes];
  [shoesQuantity addObject:[NSNumber numberWithInt:quantity]];
}

- (NSUInteger)getCount {
  return [shoesArray count];
}

- (id)getShoesAtIndex:(NSUInteger)index {
  return [shoesArray objectAtIndex:index];
}

- (NSUInteger)getQuantity:(NSUInteger)index {
  NSNumber *number;
  number = [shoesQuantity objectAtIndex:index];
  
  return [number unsignedIntValue];
}

//Remove shoes and shoes quantity info from shopping cart
- (void)removeShoesAtIndex:(NSUInteger)index {
  //Out of boundary, do nothing
  if (index >= [self getCount]){
    return;
  }
  [shoesArray removeObjectAtIndex:index];
  [shoesQuantity removeObjectAtIndex:index];
}

//Update the quantity for a selected shoes
- (void)updateShoes:(id)shoes withQuantity:(NSUInteger)quantity {
  //Locate the shoes in the shopping cart shoes list
  NSUInteger index = [shoesArray indexOfObject:shoes];
  [shoesQuantity replaceObjectAtIndex:index withObject:[NSNumber numberWithInt:quantity]];
}


- (void)dealloc {
  [shoesQuantity release];
  [shoesArray release];
}

@end
