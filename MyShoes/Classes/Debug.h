//
//  Debug.h
//  MyShoes
//
//  Created by Denny Ma on 1/02/11.
//  Copyright 2011 Mbi. All rights reserved.

#ifdef DEBUG
#define debug_NSLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define debug_NSLog(format, ...)
#endif
