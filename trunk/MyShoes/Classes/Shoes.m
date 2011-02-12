//
//  Shoes.m
//  MyShoes
//
//  Created by Denny Ma on 1/02/11.
//  Copyright 2011 Mbi. All rights reserved.
//

#import "Shoes.h"
#import "Debug.h"
#import "Config.h"

@implementation Shoes

@synthesize	pID = _pID;
@synthesize	pgID = _pgID;
@synthesize	shoesImageName = shoesImageName;
@synthesize	productSalesmessaging = _productSalesmessaging;
@synthesize	brandName = _brandName;
@synthesize	styleNameList = _styleNameList;
@synthesize	productPrice = _productPrice;
@synthesize productCategory = _productCategory;
@synthesize productBrandTitleColor = _productBrandTitleColor;
@synthesize	productPriceCurrency = _productPriceCurrency;
@synthesize productDetailLink = _productDetailLink;

/*  Child node structure
 
 */
- (id)initWithShoesNode:(TFHppleElement *) node {
	//hold the data. The node structure is shown above
	//
	if((self = [super init] )) {
		
		TFHppleElement *shoesNode = [node retain];
    
		for (TFHppleElement *child in [shoesNode childNodes]) {

      NSString *tagValue = [child objectForKey:SHOES_NODE_PRODUCTTAG];
      if ([tagValue isEqualToString:SHOES_NODE_PRODUCTIMAGE]) {
        [self processProductImage:child];
      }
      else if ([tagValue isEqualToString:SHOES_NODE_PRODUCTSALESMESSAGING]) {
        _productSalesmessaging = [self processShoesInfo:child withProductTag:SHOES_NODE_PRODUCTTAG];
      }
      else if ([tagValue isEqualToString:SHOES_NODE_PRODUCTBRANDTITLECOLOR]) {
        _productBrandTitleColor = [self processShoesInfo:child withProductTag:HREF_TAG];
      }
      else if ([tagValue isEqualToString:SHOES_NODE_PRODUCTPRICE]) {
        _productPrice = [self processShoesInfo:child withProductTag:SHOES_NODE_PRODUCTPRICETAG_USD];
      }
		}
		
		
		[shoesNode release];
		//[[self allConveySpriteSheets] addObject:spriteSheet];
	}
	return self;
}

- (void)processProductImage:(TFHppleElement *) node{
  
  NSArray *elements  = [node childNodes];  
  // Access the first cell
  if([elements count] <= 0){
    return;
  }
  TFHppleElement *element = [elements objectAtIndex:0];
  
  //set product detail link
  self.productDetailLink = [element objectForKey:HREF_TAG];
  
  NSArray *childElements  = [element childNodes];
  if([childElements count] <= 0){
    return;
  }
  TFHppleElement *childElement = [childElements objectAtIndex:0];
  //set product image name
  id str = [childElement objectForKey:SRC_TAG];
  if (str == nil) {
    str = [childElement objectForKey:ORIGINAL_TAG];
  }
  self.shoesImageName = str;//[childElement objectForKey:SRC_TAG];
  self.productCategory = [childElement objectForKey:ALT_TAG];
  
}

- (NSString *)processShoesInfo:(TFHppleElement *) node withProductTag:(NSString*) tag{
  
  NSArray *elements  = [node childNodes];  
  // Access the first cell
  if([elements count] <= 0){
    return nil;
  }
  TFHppleElement *element = [elements objectAtIndex:0];
    
  /*NSArray *childElements  = [element childNodes];
  if([childElements count] <= 0){
    return nil;
  }
  TFHppleElement *childElement = [childElements objectAtIndex:0];*/
  //set product image name
  return [element objectForKey:tag];
  
}

- (void)dealloc {
	//release all objects here
	[_pID release];
	[_pgID release];
	
	[super dealloc];
}	

@end
