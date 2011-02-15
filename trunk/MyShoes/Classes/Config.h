//
//  Config.h
//  MyShoes
//
//  Created by Denny Ma on 1/02/11.
//  Copyright 2011 Mbi. All rights reserved.
//

//This is the entrance of the whole app
#define MYSHOES_URL @"http://www.shoes.com/"
#define HREF_TAG @"href"
#define SRC_TAG @"src"
#define ALT_TAG @"alt"
#define ORIGINAL_TAG @"original"

#define SHOES_CATEGORY_WOMEN_XPATH @"//*[@id='navlist-main']/li/a[text()='Women']"
#define SHOES_CATEGORY_MEN_XPATH @"//*[@id='navlist-main']/li/a[text()='Men']"
#define SHOES_CATEGORY_GIRLS_XPATH @"//*[@id='navlist-main']/li/a[text()='Girls']"
#define SHOES_CATEGORY_BOYS_XPATH @"//*[@id='navlist-main']/li/a[text()='Boys']"

#define SHOES_CATEGORY_WOMEN_NAME @"Women"
#define SHOES_CATEGORY_MEN_NAME @"Men"
#define SHOES_CATEGORY_GIRLS_NAME @"Girls"
#define SHOES_CATEGORY_BOYS_NAME @"Boys"

#define SHOES_CATEGORY_WOMEN_URI_12ITEM @"/en-US/Womens/_/_/_/View+12/Products.aspx"
#define SHOES_CATEGORY_MEN_URI_12ITEM @"/en-US/Mens/_/_/_/View+12/Products.aspx"
#define SHOES_CATEGORY_GIRLS_URI_12ITEM @"/en-US/Kids-Girls/_/_/_/View+12/Products.aspx"
#define SHOES_CATEGORY_BOYS_URI_12ITEM @"/en-US/Kids-Boys/_/_/_/View+12/Products.aspx"

#define SHOES_NODE_PRODUCTTAG @"class"
#define SHOES_NODE_PRODUCTPRICETAG_USD @"e4xprice_usd"
#define SHOES_NODE_PRODUCTIMAGE @"productImage"
#define SHOES_NODE_PRODUCTSALESMESSAGING @"productSalesMessaging"
#define SHOES_NODE_PRODUCTBRANDTITLECOLOR @"productBrandTitleColor"
#define SHOES_NODE_PRODUCTPRICE @"productPrice"

#define SHOES_CATEGORY_PRODUCT_LIST_XPATH @"//*[@id='ResultZone2_wrapper']//div[@class='productCell']"
//#define SHOES_CATEGORY_PRODUCT_LIST_XPATH @"//*[@id='ResultZone2_wrapper']//div[@style='height: auto;']"
#define CATEGORY_SHOES_COUNT 12

#define CAPACITY_DICTIONARY 20
#define CAPACITY_SCROLL_BAR 20
#define CAPACITY_SHOES_LIST 20