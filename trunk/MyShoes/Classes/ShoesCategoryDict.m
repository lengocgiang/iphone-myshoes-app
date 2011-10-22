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

+ (NSMutableDictionary*)dictionary
{
  if (dictionary == nil)
  {
    dictionary = [[[NSMutableDictionary alloc] init] autorelease];
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

    //Setup category for Backpacks
    category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_BACKPACKE_NAME] autorelease];
    [dictionary setObject: category forKey:SHOES_CATEGORY_BACKPACKE_NAME];
    
    //Setup category for Handbags
    category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_HANDBAGS_NAME] autorelease];
    [dictionary setObject: category forKey:SHOES_CATEGORY_HANDBAGS_NAME];
    
    //Setup category for Sports and Duffels
    category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_SPORTS_AND_DUFFELS_NAME] autorelease];
    [dictionary setObject: category forKey:SHOES_CATEGORY_SPORTS_AND_DUFFELS_NAME];
    
    //Setup category for Messenger Bags
    category = [[[ShoesCategory alloc] initWithName:SHOES_CATEGORY_MESSENGER_BAGS_NAME] autorelease];
    [dictionary setObject: category forKey:SHOES_CATEGORY_MESSENGER_BAGS_NAME];
  }
  
  return dictionary;
}

/*+ (id)allocWithZone:(NSZone *)zone
{
  return [[self dictionary] retain];
}*/

/*- (id)copyWithZone:(NSZone *)zone
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

- (oneway void)release
{
  //do nothing
}

- (id)autorelease
{
  return self;
}*/
@end
