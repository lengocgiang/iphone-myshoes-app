//
//  MyShoesApplicationTests.m
//  MyShoesApplicationTests
//
//  Created by Kevin Liu on 29/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ShoesListViewControllerApplicationTests.h"
#import "ShoesCategoryDict.h"

@implementation ShoesListViewControllerApplicationTests

- (void)setUp
{
  [super setUp];
  
  // Set-up code here.
  NSLog(@"%@ setUp", self.name);
  shoesListViewController = [[ShoesListViewController alloc] init];
  STAssertNotNil(shoesListViewController, @"Cannot create Calculator instance");
  
  categoryDict = [ShoesCategoryDict dictionary];
}

- (void)tearDown
{
  // Tear-down code here.
  //  [shoesListViewController release];
  NSLog(@"%@ tearDown", self.name);
  
  [super tearDown];
}

/* Given
 *  the user selected category is Men -> Athletic
 * Then
 *  the url should be "http://www.shoes.com/en-US/Mens/_/_/Athletic+Shoes/View+12/Products.aspx"
 */
- (void)testGenerateUrlCoverage
{
  NSLog(@"%@ start", self.name);
  //Initialize the user selected category to Men -> Athletic
  NSMutableArray *userSelectedCategoriesArray = [NSMutableArray arrayWithObjects:
                                                 [categoryDict objectForKey:SHOES_CATEGORY_MEN_NAME], 
                                                 [categoryDict objectForKey:SHOES_CATEGORY_ATHLETIC_NAME], 
                                                 nil];
  [shoesListViewController setUserSelectedCategoriesArray:userSelectedCategoriesArray];
  [shoesListViewController viewDidLoad];
  
  NSString *url = [shoesListViewController generateUrl];
  
  STAssertTrue([url isEqualToString:@"http://www.shoes.com/en-US/Mens/_/_/Athletic+Shoes/View+12/Products.aspx"], @"");
  NSLog(@"%@ end", self.name);
}


@end
