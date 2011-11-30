//
//  ContentUpdater.m
//  MyShoes
//
//  Created by Denny Ma on 27/01/11.
//  Copyright 2011 Mbi. All rights reserved.
//

#import "NetworkTool.h"
#import "Config.h"


@implementation NetworkTool

@synthesize username;
@synthesize password;
@synthesize receivedData;
@synthesize delegate;
@synthesize callback;
@synthesize errorCallback;

-(void)getContent:(NSString *) urlStr withDelegate:(id)requestDelegate requestSelector:(SEL)requestSelector{
	isPost = NO;
	// Set the delegate and selector
	self.delegate = requestDelegate;
	self.callback = requestSelector;
	// The URL of the Request we intend to send
	NSURL *url = [NSURL URLWithString:urlStr];
	[self request:url];
}

//request the img and store to the local
-(void)request:(NSURL *) url {
	theRequest   = [[NSMutableURLRequest alloc] initWithURL:url];
	
	if(isPost) {
		NSLog(@"ispost");
		[theRequest setHTTPMethod:@"POST"];
		[theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
		[theRequest setHTTPBody:[requestBody dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
		[theRequest setValue:[NSString stringWithFormat:@"%d",[requestBody length] ] forHTTPHeaderField:@"Content-Length"];
	}
	
	theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if (theConnection) {
		// Create the NSMutableData that will hold
		// the received data
		// receivedData is declared as a method instance elsewhere
		receivedData=[[NSMutableData data] retain];
    //self.receivedData = [NSMutableData data];
	} else {
		// inform the user that the download could not be made
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	NSLog(@"challenged %@",[challenge proposedCredential] );
	
	if ([challenge previousFailureCount] == 0) {
        NSURLCredential *newCredential;
        newCredential=[NSURLCredential credentialWithUser:[self username]
                                                 password:[self password]
                                              persistence:NSURLCredentialPersistenceNone];
        [[challenge sender] useCredential:newCredential
               forAuthenticationChallenge:challenge];
		//[newCredential release];
    } else {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
        // inform the user that the user name and password
        // in the preferences are incorrect
		NSLog(@"Invalid Username or Password");
    }
	
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // this method is called when the server has determined that it
    // has enough information to create the NSURLResponse
	
    // it can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    // receivedData is declared as a method instance elsewhere
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	//NSLog([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
	// append the new data to the receivedData
    // receivedData is declared as a method instance elsewhere
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
  // release the connection, and the data object
  [connection release];
  // receivedData is declared as a method instance elsewhere
  [receivedData release];
	
	[theRequest release];
	
  // inform the user
  /*NSLog(@"Connection failed! Error - %@ %@",
	[error localizedDescription],
	[[error userInfo] objectForKey:NSErrorFailingURLStringKey]);*/
	
	NSLog(@"Connection failed! Error - %@",[error localizedDescription]);
	
	if(errorCallback) {
		[delegate performSelector:errorCallback withObject:error];
	}
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
  // do something with the data
	
	if(delegate && callback) {
		if([delegate respondsToSelector:self.callback]) {
			[delegate performSelector:self.callback withObject:receivedData];
		} else {
			NSLog(@"No response from delegate");
		}
	} 
	
	// release the connection, and the data object
	[theConnection release];
  [receivedData release];
	[theRequest release];
}

#pragma mark - login
- (void)sendFormWithDelegate:(id)requestDelegate 
             requestSelector:(SEL)requestSelector 
                    formDict:(NSDictionary *)loginFormDict
               formActionUrl:(NSURL *)url{
  
	self.delegate = requestDelegate;
	self.callback = requestSelector;
	
  //What the hell of myBounds for and where is the value from? 
  //-Just random string to distinguish bodyData
  NSString *myBounds = @"98765abcde";
  NSMutableData *bodyData = [[NSMutableData alloc] initWithCapacity:10];
  
  NSArray *formKeys = [loginFormDict allKeys];
  for (int i = 0; i < [formKeys count]; i++) {
    [bodyData appendData:[[NSString stringWithFormat:@"--%@\n",myBounds] 
       dataUsingEncoding:NSASCIIStringEncoding]];
    
    [bodyData appendData: [[NSString stringWithFormat:
                            @"Content-Disposition: form-data; name=\"%@\"\n\n%@\n",
                            [formKeys objectAtIndex:i],
                            [loginFormDict valueForKey:[formKeys objectAtIndex: i]]]
                           dataUsingEncoding:NSASCIIStringEncoding]];
  }
  [bodyData appendData:[[NSString stringWithFormat:@"--%@--\n", myBounds]
     dataUsingEncoding:NSASCIIStringEncoding]];
  
  //We usually don't add autorelease in a debug
  //The below two lines are just to print the value of bodyData
  /*
  NSString *bodyDataString = [[[NSString alloc] initWithData:bodyData 
                                                    encoding:NSASCIIStringEncoding] autorelease];
  NSLog(@"bodyData=%@", bodyDataString);
  */
  
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  [request setHTTPMethod:@"POST"];
  [request setHTTPBody: bodyData];
  NSString *myContent = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",myBounds];
  [request setValue:myContent forHTTPHeaderField:@"Content-Type"];
  
  theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
	if (theConnection) {
		// Create the NSMutableData that will hold
		// the received data
		// receivedData is declared as a method instance elsewhere
		receivedData=[[NSMutableData data] retain];
    //self.receivedData = [NSMutableData data];
	} else {
		// inform the user that the download could not be made
	}
  
  [bodyData release];
}

+ (BOOL)hasUserLoggedIn {
  BOOL hasFoundUserNameInCookie = NO;
  BOOL hasFoundRememberMe = NO;
  BOOL loginIsTrue = NO;
  
  NSArray * cookies  = [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies;
  NSString *cookieName, *cookieValue;
  
  for (int i = 0; i < cookies.count; i++){
    cookieName = [[cookies objectAtIndex:i] name];
    cookieValue = [(NSHTTPCookie *)[cookies objectAtIndex:i] value];
    if ([cookieName isEqualToString:@"UserName"]) {
      hasFoundUserNameInCookie = YES;
      NSLog(@"Found cookie \"%@=%@\" in sharedHTTPCookieStorage!", cookieName, cookieValue);
    }else if([cookieName isEqualToString:@"rememberMe"]){
      hasFoundRememberMe = YES;
      NSLog(@"Found cookie \"%@=%@\" in sharedHTTPCookieStorage!", cookieName, cookieValue);
    }else if([cookieName isEqualToString:@"Login"]){
      if ([cookieValue isEqualToString:@"true"]){
        loginIsTrue = YES;
      }
    }
  }
  
  if (hasFoundUserNameInCookie && hasFoundRememberMe && loginIsTrue) {
    NSLog(@"User already logged in!");
    return YES;
  }else{
    NSLog(@"User needs to log in!");
    return NO;
  }
}

+ (void)showAllSavedCookies {
  NSArray * cookies  = [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies;
  NSString *cookieName, *cookieValue;
  
  NSLog(@"Dump save cookies start: ===========");
  for (int i = 0; i < cookies.count; i++){
    cookieName = [[cookies objectAtIndex:i] name];
    cookieValue = [(NSHTTPCookie *)[cookies objectAtIndex:i] value];
    NSLog(@"Found cookie \"%@=%@\" in sharedHTTPCookieStorage!", cookieName, cookieValue);
  }
  NSLog(@"Dump save cookies end: ===========");
}


@end
