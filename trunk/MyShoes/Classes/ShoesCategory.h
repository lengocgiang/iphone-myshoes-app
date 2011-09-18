//
//  ShoesCategory.h
//  MyShoes
//
//  Created by Denny Ma on 8/02/11.
//  Copyright 2011 Mbi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Config.h"
#import "Debug.h"


@interface ShoesCategory : NSObject {
	
	NSString *_categoryName;
	NSString *_categoryXPath;
	NSString *_categoryURI;

}

@property(nonatomic, retain) NSString	*categoryName;
@property(nonatomic, retain) NSString	*categoryXPath;
@property(nonatomic, retain) NSString	*categoryURI;

- (id)initWithName:(NSString *) name;// andXPath:(NSString *) xpath;

@end
