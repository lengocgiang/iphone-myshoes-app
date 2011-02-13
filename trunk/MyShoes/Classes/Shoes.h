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

}

@property(nonatomic, retain) NSString	*pID;
@property(nonatomic, retain) NSString	*pgID;
@property(nonatomic, retain) NSString	*shoesImageName;
@property(nonatomic, retain) NSString	*productSalesmessaging;
@property(nonatomic, retain) NSString	*brandName;
@property(nonatomic, retain) NSArray	*styleNameList;
@property(nonatomic, retain) NSString	*productPrice;
@property(nonatomic, retain) NSString *productCategory;
//@property(nonatomic, retain) NSString *productBrandTitleColor;
@property(nonatomic, retain) NSString	*productPriceCurrency;
@property(nonatomic, retain) NSString *productDetailLink;
@property(nonatomic, retain) NSString *productRating;
@property(nonatomic, retain) NSString *productStyle;
@property(nonatomic, retain) NSString *productColor;
@property(nonatomic, retain) NSString *productBrandName;

- (id)initWithShoesNode:(TFHppleElement *) node;
- (void)processProductImage:(TFHppleElement *) node;
- (void)processBrandTitleColor:(TFHppleElement *) node;
- (NSString *)processShoesInfo:(TFHppleElement *) node withProductTag:(NSString*) tag;

@end
