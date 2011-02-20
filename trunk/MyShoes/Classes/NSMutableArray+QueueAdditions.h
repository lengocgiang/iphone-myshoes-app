//
//  NSMutableArray+QueueAdditions.h
//  MyShoes
//
//  Created by Denny Ma on 18/02/11.
//  Copyright 2011 Mbi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (QueueAdditions)
- (id) dequeue;
- (void) enqueue:(id)obj;
@end
