//
//  SecondViewController.m
//  LoginShoes
//
//  Created by Yi Shen on 10/19/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchViewController.h"

@implementation SearchViewController
@synthesize webview;
@synthesize networkTool;
@synthesize loadingIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      self.title = NSLocalizedString(@"Account Info", @"Account Info");
      self.tabBarItem.image = [UIImage imageNamed:@"search"];
    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
  [self setLoadingIndicator:nil];
  [self setNetworkTool:nil];
  [self setWebview:nil];
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
  if (networkTool){
    [networkTool release];
  }
  
  if (loadingIndicator) {    
    [loadingIndicator release];
  }
  [webview release];
  [super dealloc];
}



#pragma mark - network method

- (IBAction)refresh:(id)sender {
  // show activity indicator view
  if (!loadingIndicator){
    loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
  }
  [loadingIndicator startAnimating];    
  [loadingIndicator setFrame:CGRectMake(self.view.center.x - 11, self.view.center.y - 11, 22.0, 22.0)];
  [loadingIndicator setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];
  [self.view addSubview:loadingIndicator];
  
  // load web page
  if (!self.networkTool){
    self.networkTool = [[NetworkTool alloc] init];
  }
  NSString *newUrl = [NSString stringWithFormat:@"%@",@"https://secure.shoes.com/Profiles/EditAccount.aspx"];
	[self.networkTool getContent:newUrl withDelegate:self requestSelector:@selector(updateData:)];
}

- (void)updateData: (NSData *) content {
  NSString *result = [[[NSString alloc] initWithData:content encoding:NSUTF8StringEncoding] autorelease];
  [self.webview loadHTMLString:result baseURL:nil];
  
  [loadingIndicator stopAnimating];
  [loadingIndicator removeFromSuperview];
}
@end
