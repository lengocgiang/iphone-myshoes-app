//
//  ShoesCategoryDict.m
//  MyShoes
//
//  Created by Kevin Liu on 4/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ShoesCategoryDict.h"
#import "ShoesCategory.h"

static NSMutableDictionary *dictionary = nil;

@implementation ShoesCategoryDict

+(NSMutableDictionary*) dictionary
{
  if (dictionary == nil)
  {
    dictionary = [[NSMutableDictionary alloc] init];
    //Setup category for women
    ShoesCategory *category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_WOMEN_NAME/* andXPath:SHOES_CATEGORY_WOMEN_XPATH*/] autorelease];
    category.categoryURI = SHOES_CATEGORY_WOMEN_URI;
    [dictionary setObject: category forKey:SHOES_CATEGORY_WOMEN_NAME];
    //Setup category for men
    //[category autorelease];
    category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_MEN_NAME/* andXPath:SHOES_CATEGORY_MEN_XPATH*/] autorelease];
    category.categoryURI = SHOES_CATEGORY_MEN_URI;
    [dictionary setObject:category forKey:SHOES_CATEGORY_MEN_NAME];
    //Setup category for girls
    //[category autorelease];
    category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_GIRLS_NAME/* andXPath:SHOES_CATEGORY_GIRLS_XPATH*/] autorelease];
    category.categoryURI = SHOES_CATEGORY_GIRLS_URI;
    [dictionary setObject: category forKey:SHOES_CATEGORY_GIRLS_NAME];
    //Setup category for boys
    //[category autorelease];
    category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_BOYS_NAME/* andXPath:SHOES_CATEGORY_BOYS_XPATH*/] autorelease];
    category.categoryURI = SHOES_CATEGORY_BOYS_URI;
    [dictionary setObject:category forKey:SHOES_CATEGORY_BOYS_NAME];
    
    //Setup category for Juniors
    //[category autorelease];
    category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_JUNIORS_NAME/* andXPath:SHOES_CATEGORY_JUNIORS_XPATH*/] autorelease];
    category.categoryURI = SHOES_CATEGORY_JUNIORS_URI;
    [dictionary setObject:category forKey:SHOES_CATEGORY_JUNIORS_NAME];
    
    //Setup category for bags
    //[category autorelease];
    category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_BAGS_NAME/* andXPath:SHOES_CATEGORY_BAGS_XPATH*/] autorelease];
    category.categoryURI = SHOES_CATEGORY_BAGS_URI;
    [dictionary setObject:category forKey:SHOES_CATEGORY_BAGS_NAME];

    //Setup category for dress
    category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_DRESS_NAME] autorelease];
    [dictionary setObject: category forKey:SHOES_CATEGORY_DRESS_NAME];
    
    //Setup category for casual
    category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_CASUAL_NAME] autorelease];
    [dictionary setObject: category forKey:SHOES_CATEGORY_CASUAL_NAME];
    
    //Setup category for athletic
    category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_ATHLETIC_NAME] autorelease];
    [dictionary setObject: category forKey:SHOES_CATEGORY_ATHLETIC_NAME];
    
    //Setup category for boots
    category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_BOOTS_NAME] autorelease];
    [dictionary setObject: category forKey:SHOES_CATEGORY_BOOTS_NAME];
    
    //Setup category for sandals
    category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_SANDALS_NAME] autorelease];
    [dictionary setObject: category forKey:SHOES_CATEGORY_SANDALS_NAME];
    
    //Setup category for sale
    category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_SALE_NAME] autorelease];
    [dictionary setObject: category forKey:SHOES_CATEGORY_SALE_NAME];
  }
  
  return dictionary;
}

+ (id)allocWithZone:(NSZone *)zone
{
  return [[self dictionary] retain];
}

- (id)copyWithZone:(NSZone *)zone
{
  return self;
}

- (id)retain
{
  return self;
}

- (NSUInteger)retainCount
{
  return NSUIntegerMax;  //denotes an object that cannot be released
}

- (void)release
{
  //do nothing
}

- (id)autorelease
{
  return self;
}
@end
