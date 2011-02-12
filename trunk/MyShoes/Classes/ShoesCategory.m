//
//  ShoesCategory.m
//  MyShoes
//
//  Created by Denny Ma on 8/02/11.
//  Copyright 2011 Mbi. All rights reserved.
//

#import "ShoesCategory.h"


@implementation ShoesCategory

@synthesize categoryName = _categoryName;
@synthesize categoryXPath = _categoryXPath;
@synthesize categoryURI = _categoryURI;

- (id)initWithName:(NSString *) name andXPath:(NSString *) xpath {
	
	self = [super init];
    if (self) {
        // Custom initialization.
		_categoryName = name;
		_categoryXPath = xpath;
    }
    return self;
}

@end
