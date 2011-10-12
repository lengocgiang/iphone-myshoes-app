//
//  Shoes.h
//  MyShoes
//
//  Created by Denny Ma on 1/02/11.
//  Copyright 2011 Mbi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFHppleElement+AccessChildren.h"


@interface Shoes : NSObject {
	
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
  NSString *_productBrandLogo;
  
  NSArray *_shoesColors;
  NSArray *_urlsWithColors;
  NSArray *_shoesSizes;
  NSArray *_shoesSizesValue;
  
  int _selectedColor;
  int _selectedSize;
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
@property (nonatomic, retain) NSString *productBrandLogo;
@property (nonatomic, retain) NSArray *shoesColors;
@property (nonatomic, retain) NSArray *shoesSizes;
@property (nonatomic, retain) NSArray *shoesSizesValue;
@property (nonatomic, assign) int selectedColor;
@property (nonatomic, assign) int selectedSize;
@property (nonatomic, retain) NSArray *urlsWithColors;

- (id)initWithShoesNode:(TFHppleElement *)node;
- (void)processProductImage:(TFHppleElement *)node;
- (void)processBrandTitleColor:(TFHppleElement *)node;
- (void)processProductSKU:(TFHppleElement *)node;
- (void)processProductBrandLogo:(TFHppleElement *)node;
- (void)processShoesColors:(TFHppleElement *)node;
- (void)processShoesSizes:(TFHppleElement *)node;
- (NSString *)processShoesInfo:(TFHppleElement *)node withProductTag:(NSString*)tag;

@end
