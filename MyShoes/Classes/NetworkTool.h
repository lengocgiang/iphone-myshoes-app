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

-(void)getContent:(NSString *) urlStr 
     withDelegate:(id)requestDelegate 
  requestSelector:(SEL)requestSelector;
-(void)request:(NSURL *) url;
- (void)sendFormWithDelegate:(id)requestDelegate 
             requestSelector:(SEL)requestSelector 
                    formDict:(NSDictionary *)loginFormDict
               formActionUrl:(NSURL *)url;
-(void)loginWithDelegate:(id)requestDelegate 
         requestSelector:(SEL)requestSelector 
           loginFormDict:(NSDictionary *)loginFormDict;
-(void)addToCart:(NSString *)cartURL
    WithDelegate:(id)requestDelegate
 requestSelector:(SEL)requestSelector
    cartFormDict:(NSDictionary *)cartFormDict;
+ (BOOL)hasUserLoggedIn;
+ (void)showAllSavedCookies;


@end