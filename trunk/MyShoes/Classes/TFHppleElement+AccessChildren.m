//
//  TFHppleElement+AccessChildren.m
//  MyShoes
//
//  Created by Denny Ma on 9/02/11.
//  Copyright 2011 Mbi. All rights reserved.
//

#import "TFHppleElement+AccessChildren.h"


@implementation TFHppleElement (AccessChildren)

- (NSArray *) childNodes {
	NSString *TFHppleChildNodeArrayKey = @"nodeChildArray";
	NSArray * childNodes = [node objectForKey:TFHppleChildNodeArrayKey];
	NSMutableArray * hppleElements = [NSMutableArray array];
	for (id child in childNodes) {
		TFHppleElement * e = [[TFHppleElement alloc] initWithNode:child];
		[hppleElements addObject:e];
		[e release];
	}
	return hppleElements;
}

@end
