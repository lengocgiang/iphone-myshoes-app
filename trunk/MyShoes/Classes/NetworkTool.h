//
//  ContentUpdater.h
//  MyShoes
//
//  Created by Denny Ma on 27/01/11.
//  Copyright 2011 Mbi. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NetworkTool : NSObject {
	
	NSMutableData		*receivedData;
	NSMutableURLRequest	*theRequest;
	NSURLConnection		*theConnection;
	id					delegate;
	SEL					callback;
	SEL					errorCallback;
	
	BOOL				isPost;
	NSString			*requestBody;
}

@property(nonatomic, retain) NSString	   *username;
@property(nonatomic, retain) NSString	   *password;
@property(nonatomic, retain) NSMutableData *receivedData;
@property(nonatomic, assign) id			    delegate;
@property(nonatomic) SEL					callback;
@property(nonatomic) SEL					errorCallback;

-(void)getContent:(NSString *) urlStr withDelegate:(id)requestDelegate requestSelector:(SEL)requestSelector;
-(void)request:(NSURL *) url;
-(void)LoginWithDelegate:(id)requestDelegate requestSelector:(SEL)requestSelector userID:(NSString*)userID password:(NSString*)password;

@end