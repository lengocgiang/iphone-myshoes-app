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
@synthesize shoesImgsCount = _shoesImgsCount;
@synthesize productBrandName = _productBrandName;
@synthesize productBrandLogo = _productBrandLogo;
@synthesize shoesColors = _shoesColors;
@synthesize shoesSizes = _shoesSizes;
@synthesize shoesSizesValue = _shoesSizesValue;
@synthesize selectedColor = _selectedColor;
@synthesize selectedSize = _selectedSize;
@synthesize urlsWithColors = _urlsWithColors;

/*  Child node structure
 
 */
- (id)initWithShoesNode:(TFHppleElement *)node {
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

- (id)copyWithZone:(NSZone*)zone {
  
	Shoes *copy = [[[self class] allocWithZone: zone] init];
  
  //Copy all shoes properties
	copy.pID = [[self.pID copy] autorelease];
	copy.pgID = [[self.pgID copy] autorelease];
	copy.shoesImageName = [[self.shoesImageName copy] autorelease];
	copy.productSalesmessaging = [[self.productSalesmessaging copy] autorelease];
	
	copy.brandName = [[self.brandName copy] autorelease];
	copy.styleNameList = [[self.styleNameList copy] autorelease];
	
	copy.productPrice = [[self.productPrice copy] autorelease];
  copy.productCategory = [[self.productCategory copy] autorelease];
  //NSString *_product;
	copy.productPriceCurrency = [[self.productPriceCurrency copy] autorelease];
  copy.productDetailLink = [[self.productDetailLink copy] autorelease];
  copy.productRating = [[self.productRating copy] autorelease];
  copy.productStyle = [[self.productStyle copy] autorelease];
  copy.productColor = [[self.productColor copy] autorelease];
  copy.productBrandName = [[self.productBrandName copy] autorelease];
  
  copy.productSKU = [[self.productSKU copy] autorelease];
  
  copy.shoesImgsAllAngle = [[self.shoesImgsAllAngle copy] autorelease];
  copy.shoesImgsCount = self.shoesImgsCount;
  copy.productBrandLogo = [[self.productBrandLogo copy] autorelease];
  copy.shoesColors = [[self.shoesColors copy] autorelease];
  copy.urlsWithColors = [[self.urlsWithColors copy] autorelease];
  copy.shoesSizes = [[self.shoesSizes copy] autorelease];
  copy.shoesSizesValue = [[self.shoesSizesValue copy] autorelease];
  
  copy.selectedColor = self.selectedColor;
  copy.selectedSize = self.selectedSize;
  
	return copy;//[copy autorelease];
}

- (void)processProductImage:(TFHppleElement *)node{
  
  NSArray *elements  = [node childNodes];  
  // Access the first cell
  if([elements count] <= 0){
    return;
  }
  TFHppleElement *element = [elements objectAtIndex:0];
  
  //set product detail link
  //self.productDetailLink = [[element objectForKey:HREF_TAG] retain];
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
  
  //[self.shoesImageName release];
  //self.shoesImageName = [str retain];//[childElement objectForKey:SRC_TAG];
  self.shoesImageName = str;
  //[self.productCategory release];
  //self.productCategory = [[childElement objectForKey:ALT_TAG] retain];
  self.productCategory = [childElement objectForKey:ALT_TAG];
  
}

//Grab the value of a tag
//Which is a value of the shoes
- (NSString *)processShoesInfo:(TFHppleElement *)node withProductTag:(NSString*)tag{
  
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

- (void)processBrandTitleColor:(TFHppleElement *)node{
  
  NSArray *elements  = [node childNodes];  
  // Access the first cell
  if([elements count] <= 0){
    return;
  }
  
  //Get the product detail node
  TFHppleElement *element = [elements objectAtIndex:0];
  
  //set product detail link
  //self.productDetailLink = [[element objectForKey:HREF_TAG] retain];
  self.productDetailLink = [element objectForKey:HREF_TAG];
  
  NSArray *childElements  = [element childNodes];
  if([childElements count] <= 0){
    return;
  }
  TFHppleElement *childElement = [childElements objectAtIndex:0];
  //set product brand name
  id str = [childElement content];
  //[self.productBrandName release];
  self.productBrandName = str;
  //self.productBrandName = [str retain];
    
  childElement = [childElements objectAtIndex:2];
  //set product style name
  str = [childElement content];
  //[self.productStyle release];
  //self.productStyle = [str retain];
  self.productStyle = str;
  
  //To test if the shoes has more info like color and rating
  if ([elements count] <= 2){
    return;
  }

  //[element autorelease];
  element = [elements objectAtIndex:2];
  
  //[self.productColor release];
  //self.productColor = [[element content] retain];
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
  
    //[self.productRating release];
    //self.productRating = [[childElement content] retain];
    self.productRating = [childElement content];
  }
}

#pragma mark -
#pragma mark update shoes properties methods called from ShoesDetailViewController

//Process SKU
//Process shoes image of all angel
//It's shoes_iaEC1148271.jpg to shoes_ihEC1148271.jpg for large image
//And shoes_i1EC1148271.jpg to shoes_i8EC1148271.jpg for small image
- (void)processProductSKU:(TFHppleElement *)node {
  NSString *tmpStr = [node content];
  NSString *sku = [tmpStr substringFromIndex:[SHOES_INFO_SKU_PREFIX length]];
  
  //Trim whitespaces
  sku = [sku stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  //self.productSKU = [sku retain];
  self.productSKU = sku;
  
  /*NSString *tmpUrl;
  NSMutableArray *imgArray = [NSMutableArray arrayWithCapacity:SHOES_INFO_SHOESIMGS_COUNT];
  for (char i=97; i <= 104; i++){
    tmpUrl = [NSString stringWithFormat:@"%@%c%@%@", SHOES_INFO_SHOESIMGS_ALLANGLE_URIPREFIX,
              i, sku, SHOES_INFO_SHOESIMGS_FILE_SURFIX];
    [imgArray addObject:tmpUrl];
  }
  
  [self.shoesImgsAllAngle release];
  self.shoesImgsAllAngle = [[NSArray arrayWithArray:imgArray] retain];*/
}
- (void)processShoesImagesCount:(NSArray *)elements {
  NSUInteger tmpCount =  [elements count];
  
  self.shoesImgsCount = tmpCount;
}

- (void)processShoesImagesAllAngels:(TFHppleElement *)node {
  NSString *tmpStr = [node objectForKey:SRC_TAG];
  
  @try{
    NSRange range1 = [tmpStr rangeOfString:SHOES_INFO_SHOESIMGS_ALLANGLE_URIPREFIX options:NSCaseInsensitiveSearch];
    //NSRange range2 = [tmpStr rangeOfString:@"."];
    //Processing "/ProductImages/shoes_if07165.jpg"
    //Target is 07165
    tmpStr = [tmpStr substringFromIndex:range1.location + range1.length + 1];
    
    range1 = [tmpStr rangeOfString:SHOES_INFO_SHOESIMGS_FILE_SURFIX options:NSCaseInsensitiveSearch];
    tmpStr = [tmpStr substringToIndex:range1.location];
  }
  @catch ( NSException *e ){
    tmpStr = self.productSKU;
  }
  
  NSString *tmpUrl;
  NSMutableArray *imgArray = [NSMutableArray arrayWithCapacity:SHOES_INFO_SHOESIMGS_COUNT];
  for (char i=97; i < 97 + self.shoesImgsCount; i++){
    tmpUrl = [NSString stringWithFormat:@"%@%c%@%@", SHOES_INFO_SHOESIMGS_ALLANGLE_URIPREFIX,
              i, tmpStr, SHOES_INFO_SHOESIMGS_FILE_SURFIX];
    [imgArray addObject:tmpUrl];
  }
  
  //Update shoesImageName since in the shoes detail view page, there is no shoesImageName tag
  //This is to update shoesImageName in case that user select a different color of shoes
  //The shoesImageName is in format of shoes_isec1305414.jpg
  self.shoesImageName = [NSString stringWithFormat:@"%@%c%@%@", SHOES_INFO_SHOESIMGS_ALLANGLE_URIPREFIX,
                         83, tmpStr, SHOES_INFO_SHOESIMGS_FILE_SURFIX];
  
  //[self.shoesImgsAllAngle release];
  //self.shoesImgsAllAngle = [[NSArray arrayWithArray:imgArray] retain];
  self.shoesImgsAllAngle = [NSArray arrayWithArray:imgArray];
}


- (void)processProductBrandLogo:(TFHppleElement *)node {
  //NSLog(@"This is a function of shoes");
  /*NSArray *childElements  = [node childNodes];
  if([childElements count] <= 0){
    return;
  }
  TFHppleElement *element = [childElements objectAtIndex:0];*/
  //set product brand name
  //set product detail link
  NSString *tmpStr = [node objectForKey:SRC_TAG];
  //[self.productBrandLogo release];
  //self.productBrandLogo = [tmpStr retain];
  self.productBrandLogo = tmpStr;
  
}

- (void)processShoesColors:(TFHppleElement *)node {
  
  NSString *baseColorURL = [node objectForKey:SHOES_COLORS_BASEURL_TAG];
  NSArray *childElements = [node childNodes];
  
  if([childElements count] <= 0){
    return;
  }
  
  NSMutableArray *colorsArray = [NSMutableArray arrayWithCapacity:SHOES_INFO_COLOR_COUNT];
  NSMutableArray *urlsWithColors = [NSMutableArray arrayWithCapacity:SHOES_INFO_COLOR_COUNT];
  NSString *colorName;
  NSString *urlWithColor;
  NSString *tmpStr;
  int i = 0;
  
  for(TFHppleElement *child in childElements){
    colorName = [child content];
    urlWithColor = [child objectForKey:VALUE_TAG];
    
    [colorsArray addObject:colorName];
    if([[child objectForKey:SELECTD_TAG] isEqualToString:SELECTD_TAG]){
      _selectedColor = i;
      
      //update the current shoes color
      //[self.productColor release];
      //self.productColor = [colorName retain];
      self.productColor = colorName;
    }
    
    //Process url with color
    //Input is something shown as below
    //"javascript: location.href='/Shopping/ProductDetails.aspx?p=' + this.options[this.selectedIndex].value + '&pg=5080624'"
    //Output is something like
    ///Shopping/ProductDetails.aspx?p12435&pg=5080624
    NSRange range = [baseColorURL rangeOfString:@"' + this.options[this.selectedIndex].value + '"];
    tmpStr = [baseColorURL substringFromIndex: (range.location  + range.length)];
    
    range = [tmpStr rangeOfString:@"'"];
    tmpStr = [tmpStr substringToIndex:range.location];
    
    urlWithColor = [NSString stringWithFormat:@"%@%@%@",@"/Shopping/ProductDetails.aspx?p=", urlWithColor, tmpStr];
    
    [urlsWithColors addObject:urlWithColor];
    i++;
  }
  
  //[self.shoesColors release];
  //self.shoesColors = [[NSArray arrayWithArray:colorsArray] retain];
  self.shoesColors = [NSArray arrayWithArray:colorsArray];
  //[self.urlsWithColors release];
  //self.urlsWithColors = [[NSArray arrayWithArray:urlsWithColors] retain];
  self.urlsWithColors = [NSArray arrayWithArray:urlsWithColors];
}

- (void)processShoesSizes:(TFHppleElement *)node {

  NSArray *childElements = [node childNodes];
  
  if([childElements count] <= 0){
    return;
  }
  
  NSMutableArray *sizesArray = [NSMutableArray arrayWithCapacity:SHOES_INFO_SIZE_COUNT];
  NSMutableArray *sizesValueArray = [NSMutableArray arrayWithCapacity:SHOES_INFO_SIZE_COUNT];
  
  int i = 0;
  NSString *size;
  NSString *sizeValue;
  
  for(TFHppleElement *child in childElements){
    size = [child content];
    sizeValue = [child objectForKey:VALUE_TAG];
    
    [sizesArray addObject:size];
    if([[child objectForKey:SELECTD_TAG] isEqualToString:SELECTD_TAG]){
      _selectedSize = i;
    }
    
    [sizesValueArray addObject:sizeValue];
    
    i++;
  }
  
  //[self.shoesSizes release];
  //self.shoesSizes = [[NSArray arrayWithArray:sizesArray] retain];
  self.shoesSizes = [NSArray arrayWithArray:sizesArray];
  //[self.shoesSizesValue release];
  //self.shoesSizesValue= [[NSArray arrayWithArray:sizesValueArray] retain];
  self.shoesSizesValue= [NSArray arrayWithArray:sizesValueArray];
}

//Update shoes price and price currency
- (void)processShoesPrice:(TFHppleElement *)node {

  NSDictionary *attributes = [node attributes];
  NSString *pricePrefix = [node objectForKey:@"class"];
  NSString *priceAttribute;
  
  NSArray *keys = [attributes allKeys];
  NSRange textRange;
  
  for(NSString* key in keys){
    textRange =[[key lowercaseString] rangeOfString:[pricePrefix lowercaseString]];
    
    if(textRange.location != NSNotFound)
    {
      priceAttribute = key;
      break;
    }
  }
  
  //If price attribute is nil, won't update the price
  if (priceAttribute == nil){
    return;
  }
  
  //[self.productPrice release];
  
  NSString *str;
  str = [node objectForKey:priceAttribute];
  //self.productPrice = [str retain];
  self.productPrice = str;
  //[self.productPrice retain];
  
  @try{
    //Update price currency
    str = [priceAttribute substringFromIndex:(textRange.location+textRange.length + 1)];
    //[self.productPriceCurrency release];
    //self.productPriceCurrency = [str retain];
    self.productPriceCurrency = str;
  }
  @catch (NSException *e) {
    //In case of any exception, won't update price currentcy
    return;
  }
}

#pragma mark -
#pragma mark dealloc methods

- (void)dealloc {
	//release all objects here
	//[_pID release];
	//[_pgID release];
  [_shoesSizes release];
  [_shoesSizesValue release];
  [_shoesColors release];
  [_urlsWithColors release];  
  [_productBrandLogo release];
  [_shoesImgsAllAngle release];
  [_productSKU release];
  [_productSalesmessaging release];
  [_productPriceCurrency release];
  [_productPrice release];
  [_productDetailLink release];
  [_shoesImageName release];
  [_productCategory release];
  [_productBrandName release];
  [_productColor release];
  [_productStyle release];
  [_productRating release];
	
	[super dealloc];
}	

@end
