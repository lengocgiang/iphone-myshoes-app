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
  NSString *_productBrandTitleColor;
	NSString *_productPriceCurrency;
  NSString *_productDetailLink;

}

@property(nonatomic, retain) NSString	*pID;
@property(nonatomic, retain) NSString	*pgID;
@property(nonatomic, retain) NSString	*shoesImageName;
@property(nonatomic, retain) NSString	*productSalesmessaging;
@property(nonatomic, retain) NSString	*brandName;
@property(nonatomic, retain) NSArray	*styleNameList;
@property(nonatomic, retain) NSString	*productPrice;
@property(nonatomic, retain) NSString *productCategory;
@property(nonatomic, retain) NSString *productBrandTitleColor;
@property(nonatomic, retain) NSString	*productPriceCurrency;
@property(nonatomic, retain) NSString *productDetailLink;

- (id)initWithShoesNode:(TFHppleElement *) node;
- (void)processProductImage:(TFHppleElement *) node;
- (NSString *)processShoesInfo:(TFHppleElement *) node withProductTag:(NSString*) tag;

@end
