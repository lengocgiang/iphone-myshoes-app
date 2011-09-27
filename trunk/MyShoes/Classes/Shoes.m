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
@synthesize productSKU = _productSKU;
@synthesize shoesImgsAllAngle = _shoesImgsAllAngle;
@synthesize productBrandName = _productBrandName;
@synthesize productBrandLogo = _productBrandLogo;

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
        _productSalesmessaging = [[self processShoesInfo:child withProductTag:SHOES_NODE_PRODUCTTAG] retain];
      }
      else if ([tagValue isEqualToString:SHOES_NODE_PRODUCTBRANDTITLECOLOR]) {
        //_productBrandTitleColor = [self processShoesInfo:child withProductTag:HREF_TAG];
        [self processBrandTitleColor:child];
      }
      else if ([tagValue isEqualToString:SHOES_NODE_PRODUCTPRICE]) {
        _productPrice = [[self processShoesInfo:child withProductTag:SHOES_NODE_PRODUCTPRICETAG_USD] retain];
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
  self.productDetailLink = [[element objectForKey:HREF_TAG] retain];
  
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
  self.shoesImageName = [str retain];//[childElement objectForKey:SRC_TAG];
  self.productCategory = [[childElement objectForKey:ALT_TAG] retain];
  
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
  self.productDetailLink = [[element objectForKey:HREF_TAG] retain];
  
  NSArray *childElements  = [element childNodes];
  if([childElements count] <= 0){
    return;
  }
  TFHppleElement *childElement = [childElements objectAtIndex:0];
  //set product brand name
  id str = [childElement content];
  self.productBrandName = [str retain];
    
  childElement = [childElements objectAtIndex:2];
  //set product style name
  str = [childElement content];
  self.productStyle = [str retain];
  
  //To test if the shoes has more info like color and rating
  if ([elements count] <= 2){
    return;
  }

  //[element autorelease];
  element = [elements objectAtIndex:2];
  
  self.productColor = [[element content] retain];
  
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
  
    self.productRating = [[childElement content] retain];
  }
}

- (void)processProductSKU:(TFHppleElement *) node{
  NSString *tmpStr = [node content];
  NSString *sku = [tmpStr substringFromIndex:[SHOES_INFO_SKU_PREFIX length]];
  
  self.productSKU = [sku retain];
  
  NSString *tmpUrl;
  NSMutableArray *imgArray = [NSMutableArray arrayWithCapacity:SHOES_INFO_SHOESIMGS_COUNT];
  for (int i=1; i <=8; i++){
    tmpUrl = [NSString stringWithFormat:@"%@%@%d%@%@", MYSHOES_URL, SHOES_INFO_SHOESIMGS_ALLANGLE_URIPREFIX,
              i, sku, SHOES_INFO_SHOESIMGS_FILE_SURFIX];
    [imgArray addObject:tmpUrl];
  }
  
  self.shoesImgsAllAngle = [[NSArray arrayWithArray:imgArray] retain];
}

- (void)processProductBrandLogo:(TFHppleElement *) node{
  //NSLog(@"This is a function of shoes");
  /*NSArray *childElements  = [node childNodes];
  if([childElements count] <= 0){
    return;
  }
  TFHppleElement *element = [childElements objectAtIndex:0];*/
  //set product brand name
  //set product detail link
  NSString *tmpStr = [node objectForKey:SRC_TAG];
  self.productBrandLogo = [tmpStr retain];
  
}

- (void)dealloc {
	//release all objects here
	//[_pID release];
	//[_pgID release];
  
  [_productBrandLogo release];
  [_shoesImgsAllAngle release];
  [_productSKU release];
  [_productSalesmessaging release];
  [_productPrice release];
  [_productDetailLink release];
  [_shoesImageName release];
  [_productCategory release];
  [_productDetailLink release];
  [_productBrandName release];
  [_productColor release];
  [_productStyle release];
  [_productRating release];
	
	[super dealloc];
}	

@end
