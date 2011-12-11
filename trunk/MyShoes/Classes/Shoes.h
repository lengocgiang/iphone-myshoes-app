//
//  Shoes.h
//  MyShoes
//
//  Created by Denny Ma on 1/02/11.
//  Copyright 2011 Mbi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFHppleElement+AccessChildren.h"


@interface Shoes : NSObject<NSCopying> {
	
	//it's something like
	///Shopping/ProductDetails.aspx?p=EC1240753&pg=5137941
	
	NSString *_pID;
	NSString *_pgID;
	
	NSString *_shoesImageName;
	NSString *_productSalesmessaging;
	
	NSString *_brandName;
	NSArray  *_styleNameList;
	
	NSString *_productPrice;
  NSString *_productCategory;
  //NSString *_product;
	NSString *_productPriceCurrency;
  NSString *_productDetailLink;
  NSString *_productRating;
  NSString *_productStyle;
  NSString *_productColor;
  NSString *_productBrandName;

  //SKU is the serial number. With the number, shoes images with all angel can be found by
  //For example, SKU is EC1274935, All the images is 
  //http://www.shoes.com/ProductImages/shoes_iaec1274335.jpg to http://www.shoes.com/ProductImages/shoes_ihec1274335.jpg
  //or
  //http://www.shoes.com/ProductImages/shoes_i1ec1274335.jpg to http://www.shoes.com/ProductImages/shoes_i8ec1274335.jpg
  NSString *_productSKU;
  
  NSArray *_shoesImgsAllAngle;
  NSUInteger _shoesImgsCount;
  NSString *_productBrandLogo;
  
  NSArray *_shoesColors;
  NSArray *_shoesColorsValue;
  //NSArray *_urlsWithColors;
  //The value of 
  ///Shopping/ProductDetails.aspx?p12435&pg=5080624 pg=508064,whichi s the same for all color urls
  NSString *_colorURLPGValue;

  NSArray *_shoesSizes;
  NSArray *_shoesSizesValue;
  
  NSUInteger _selectedColor;
  NSUInteger _selectedSize;
}

@property (nonatomic, retain) NSString	*pID;
@property (nonatomic, retain) NSString	*pgID;
@property (nonatomic, retain) NSString	*shoesImageName;
@property (nonatomic, retain) NSString	*productSalesmessaging;
@property (nonatomic, retain) NSString	*brandName;
@property (nonatomic, retain) NSArray	*styleNameList;
@property (nonatomic, retain) NSString	*productPrice;
@property (nonatomic, retain) NSString *productCategory;
//@property(nonatomic, retain) NSString *productBrandTitleColor;
@property (nonatomic, retain) NSString	*productPriceCurrency;
@property (nonatomic, retain) NSString *productDetailLink;
@property (nonatomic, retain) NSString *productRating;
@property (nonatomic, retain) NSString *productStyle;
@property (nonatomic, retain) NSString *productColor;
@property (nonatomic, retain) NSString *productBrandName;
@property (nonatomic, retain) NSString *productSKU;
@property (nonatomic, retain) NSArray *shoesImgsAllAngle;
@property (nonatomic, assign) NSUInteger shoesImgsCount;
@property (nonatomic, retain) NSString *productBrandLogo;
@property (nonatomic, retain) NSArray *shoesColors;
@property (nonatomic, retain) NSArray *shoesColorsValue;
@property (nonatomic, retain) NSString *colorURLPGValue;
@property (nonatomic, retain) NSArray *shoesSizes;
@property (nonatomic, retain) NSArray *shoesSizesValue;
@property (nonatomic, assign) NSUInteger selectedColor;
@property (nonatomic, assign) NSUInteger selectedSize;
//@property (nonatomic, retain) NSArray *urlsWithColors;

- (id)initWithShoesNode:(TFHppleElement *)node;
- (id)copyWithZone:(NSZone*)zone;
- (void)processProductImage:(TFHppleElement *)node;
- (void)processBrandTitleColor:(TFHppleElement *)node;
- (void)processProductSKU:(TFHppleElement *)node;
- (void)processShoesImagesCount:(NSArray *)elements;
- (void)processShoesImagesAllAngels:(TFHppleElement *)node;
- (void)processProductBrandLogo:(TFHppleElement *)node;
- (void)processShoesColors:(TFHppleElement *)node;
- (void)processShoesSizes:(TFHppleElement *)node;
- (void)processShoesPrice:(TFHppleElement *)node;
- (NSString *)processShoesInfo:(TFHppleElement *)node withProductTag:(NSString*)tag;
- (BOOL)equals:(Shoes *)shoes;
//Return the shoes size description info not the actually shoes size value
- (NSString *)getShoesSizeInfo;
- (NSString *)getShoesSize;
- (NSString *)getShoesColor;
- (NSString *)getShoesColorValue;
- (NSString *)getShoesColorURL:(NSUInteger)index;

@end
