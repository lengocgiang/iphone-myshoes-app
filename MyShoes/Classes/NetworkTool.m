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
		//receivedData=[[NSMutableData data] retain];
    self.receivedData = [NSMutableData data];
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
- (void)LoginWithDelegate:(id)requestDelegate requestSelector:(SEL)requestSelector userID:(NSString*)userID password:(NSString*)pwd {
  
  self.username = userID;
  self.password = pwd;
  
	self.delegate = requestDelegate;
	self.callback = requestSelector;
	
  NSURL *url = [NSURL URLWithString:SHOES_LOGIN_URL];
	
  //(value, key) pairs
  //The login form inputs
  //Are they all needed?
  NSDictionary *loginFormDict = [NSDictionary dictionaryWithObjectsAndKeys:
                        username, SHOES_LOGIN_INPUT_USERNAME_ID, 
                        password, SHOES_LOGIN_INPUT_PASSWORD_ID, 
                        @"25", SHOES_LOGIN_INPUT_BTN_X_ID, 
                        @"16", SHOES_LOGIN_INPUT_BTN_Y_ID,                         
                        SHOES_LOGIN_VALUE_EMPTY, SHOES_LOGIN_INPUT_EVENTTARGET_ID, 
                        SHOES_LOGIN_VALUE_EMPTY, SHOES_LOGIN_INPUT_EVENTARGUMENT_ID, 
                        SHOES_LOGIN_VALUE_EMPTY, SHOES_LOGIN_INPUT_VIEWSTATEENCRYPTED_ID, 
                        SHOES_LOGIN_INPUT_VIEWSTATE_VALUE, SHOES_LOGIN_INPUT_VIEWSTATE_ID,                         
                        nil];
  
  //What the hell of myBounds for and where is the value from?
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
  NSString *bodyDataString = [[[NSString alloc] initWithData:bodyData encoding:NSASCIIStringEncoding] autorelease];
  NSLog(@"bodyData=%@", bodyDataString);
  
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
		//receivedData=[[NSMutableData data] retain];
    self.receivedData = [NSMutableData data];
	} else {
		// inform the user that the download could not be made
	}
  
  [bodyData release];
	NSLog(@"Sent the login form");
}

@end
