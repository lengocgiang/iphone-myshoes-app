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
//@synthesize productBrandTitleColor = _productBrandTitleColor;
@synthesize	productPriceCurrency = _productPriceCurrency;
@synthesize productDetailLink = _productDetailLink;
@synthesize productRating = _productRating;
@synthesize productStyle = _productStyle;
@synthesize productColor = _productColor;
@synthesize productBrandName = _productBrandName;

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
        //_productBrandTitleColor = [self processShoesInfo:child withProductTag:HREF_TAG];
        [self processBrandTitleColor:child];
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

- (void)processBrandTitleColor:(TFHppleElement *) node{
  
  NSArray *elements  = [node childNodes];  
  // Access the first cell
  if([elements count] <= 0){
    return;
  }
  
  //Get the product detail node
  TFHppleElement *element = [elements objectAtIndex:0];
  
  //set product detail link
  self.productDetailLink = [element objectForKey:HREF_TAG];
  
  NSArray *childElements  = [element childNodes];
  if([childElements count] <= 0){
    return;
  }
  TFHppleElement *childElement = [childElements objectAtIndex:0];
  //set product brand name
  id str = [childElement content];
  self.productBrandName = str;
    
  childElement = [childElements objectAtIndex:2];
  //set product style name
  str = [childElement content];
  self.productStyle = str;
  
  //To test if the shoes has more info like color and rating
  if ([elements count] <= 2){
    return;
  }

  //[element autorelease];
  element = [elements objectAtIndex:2];
  
  self.productColor = [element content];
  
  //[element autorelease];
  //Check if the shoes has the rating info section
  if ([elements count] >= 4){
    element = [elements objectAtIndex:3];
    childElements  = [element childNodes];
    if([childElements count] <= 0){
      return;
    }
    childElement = [childElements objectAtIndex:0];
    //Get the shoes rating value
  
    self.productRating = [childElement content];
  }
}


- (void)dealloc {
	//release all objects here
	[_pID release];
	[_pgID release];
	
	[super dealloc];
}	

@end
