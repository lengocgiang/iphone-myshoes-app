//
//  Config.h
//  MyShoes
//
//  Created by Denny Ma on 1/02/11.
//  Copyright 2011 Mbi. All rights reserved.
//

//This is the entrance of the whole app
#define MYSHOES_URL @"http://www.shoes.com/"
#define MYSHOES_HOSTNAME @"www.shoes.com"
#define HREF_TAG @"href"
#define SRC_TAG @"src"
#define ALT_TAG @"alt"
#define SPAN_TAG @"span"
#define ORIGINAL_TAG @"original"
#define SHOES_COLORS_BASEURL_TAG @"onchange"
#define SELECTD_TAG @"selected"
#define VALUE_TAG @"value"

#define SHOES_INFO_SKU_PREFIX @"Style # "
#define SHOES_INFO_SHOESIMGS_ALLANGLE_URIPREFIX @"ProductImages/shoes_i"
#define SHOES_INFO_SHOESIMGS_FILE_SURFIX @".jpg"
#define SHOES_INFO_SHOESIMGS_COUNT 8
#define SHOES_INFO_COLOR_COUNT 12
#define SHOES_INFO_SIZE_COUNT 20


//#define SHOES_CATEGORY_WOMEN_XPATH @"//*[@id='navlist-main']/li/a[text()='Women']"
//#define SHOES_CATEGORY_MEN_XPATH @"//*[@id='navlist-main']/li/a[text()='Men']"
//#define SHOES_CATEGORY_GIRLS_XPATH @"//*[@id='navlist-main']/li/a[text()='Girls']"
//#define SHOES_CATEGORY_BOYS_XPATH @"//*[@id='navlist-main']/li/a[text()='Boys']"
//#define SHOES_CATEGORY_JUNIORS_XPATH @"//*[@id='navlist-main']/li/a[text()='Juniors']"
//#define SHOES_CATEGORY_BAGS_XPATH @"//*[@id='navlist-main']/li/a[text()='Maps']"
#define HOME_CATEGORY_BTN_IMG_SIZE CGSizeMake(24.0f, 24.0f)
#define SHOES_LIST_IMG_SIZE CGSizeMake(60.0f, 60.0f)
#define SHOES_DETAIL_LOGO_ING_SIZE CGSizeMake(122.0f, 54.0f)

#define SHOES_LIST_CELL_IMG_WIDTH 60.0f
#define SHOES_LIST_CELL_HEIGHT 60.0f

#define HOME_NAVE_TITLE_NAME @"MyShoes"
#define TAB_HOME_NAV_NAME @"Home"
#define TAB_HOME_NAV_PNG  @"home.png"
#define TAB_SETTING_NAV_NAME @"Settings"
#define TAB_SETTING_NAV_PNG @"setting.png"
#define TAB_MYACCOUNT_NAV_NAME @"MyAccount"
#define TAB_MYACCOUNT_NAV_PNG @"account.png"
#define TAB_SEARCH_NAV_NAME @"Search"
#define TAB_SEARCH_NAV_PNG @"search.png"

#define CATEGORY_NAV_TITLE_NAME @"Category"
#define SECONDARY_CATEGORY_NAV_TITLE_NAME @"SecondaryCategory"
#define SHOESLIST_NAV_TITLE_NAME @"Shoes List"

#define CART_NAV_TITLE_NAME @"Shopping Cart"

#define SHOES_CATEGORY_WOMEN_NAME @"Womens"
#define SHOES_CATEGORY_MEN_NAME @"Mens"
#define SHOES_CATEGORY_GIRLS_NAME @"Kids-Girls"
#define SHOES_CATEGORY_BOYS_NAME @"Kids-Boys"
#define SHOES_CATEGORY_JUNIORS_NAME @"Juniors"
#define SHOES_CATEGORY_BAGS_NAME @"Bags"

#define SHOES_CATEGORY_DRESS_NAME @"Dress"
#define SHOES_CATEGORY_CASUAL_NAME @"Casual"
#define SHOES_CATEGORY_ATHLETIC_NAME @"Athletic"
#define SHOES_CATEGORY_BOOTS_NAME @"Boots"
#define SHOES_CATEGORY_SANDALS_NAME @"Sandals"
#define SHOES_CATEGORY_BACKPACKE_NAME @"Backpacks"
#define SHOES_CATEGORY_HANDBAGS_NAME @"Handbags"
#define SHOES_CATEGORY_SPORTS_AND_DUFFELS_NAME @"Sports+and+Duffels"
#define SHOES_CATEGORY_MESSENGER_BAGS_NAME @"Messenger+Bags"

#define SHOES_CATEGORY_WOMEN_URI_12ITEM @"/en-US/Womens/_/_/_/View+12/Products.aspx"
#define SHOES_CATEGORY_MEN_URI_12ITEM @"/en-US/Mens/_/_/_/View+12/Products.aspx"
#define SHOES_CATEGORY_GIRLS_URI_12ITEM @"/en-US/Kids-Girls/_/_/_/View+12/Products.aspx"
#define SHOES_CATEGORY_BOYS_URI_12ITEM @"/en-US/Kids-Boys/_/_/_/View+12/Products.aspx"
#define SHOES_CATEGORY_JUNIORS_URI_12ITEM @"/en-US/Womens/_/_/Juniors+Shoes/View+12/Products.aspx"
#define SHOES_CATEGORY_BAGS_URI_12ITEM @"/en-US/Bags/_/_/_/View+12/Products.aspx"

#define SHOES_CATEGORY_WOMEN_URI @"/en-US/Womens"
#define SHOES_CATEGORY_MEN_URI @"/en-US/Mens"
#define SHOES_CATEGORY_GIRLS_URI @"/en-US/Kids-Girls"
#define SHOES_CATEGORY_BOYS_URI @"/en-US/Kids-Boys"
#define SHOES_CATEGORY_JUNIORS_URI @"/en-US/Womens/_/_/Juniors+Shoes/_/Products.aspx"
#define SHOES_CATEGORY_BAGS_URI @"/en-US/Bags"

#define SHOES_NODE_PRODUCTTAG @"class"
#define SHOES_NODE_PRODUCTPRICETAG_USD @"e4xprice_usd"
#define SHOES_NODE_PRODUCTIMAGE @"productImage"
#define SHOES_NODE_PRODUCTSALESMESSAGING @"productSalesMessaging"
#define SHOES_NODE_PRODUCTBRANDTITLECOLOR @"productBrandTitleColor"
#define SHOES_NODE_PRODUCTPRICE @"productPrice"

#define SHOES_CATEGORY_BUTTON_UNSELECTED_SIZE 12
#define SHOES_CATEGORY_BUTTON_SELECTED_SIZE 16

#define SHOES_CATEGORY_PRODUCT_LIST_XPATH @"//*[@id='ResultZone2_wrapper']//div[@class='productCell']"

#define SHOES_DETAIL_SKU_XPATH @"//*[@id='prodDetailWrap']//span[@class='SKUtxt']"
#define SHOES_DETAIL_BRANDLOGO_IMG_XPATH @"//img[@id='ctl00_cphPageMain_BrandAndPrice1_imgLogo']"
#define SHOES_DETAIL_AVAILABLE_COLORS_XPATH @"//select[@id='ctl00_cphPageMain_ProductSelection2_ddlColor']"
#define SHOES_DETAIL_AVAILABLE_SIZES_XPATH @"//select[@id='ctl00_cphPageMain_ProductSelection2_ddlSizeAndWidth']"
#define SHOES_DETAIL_SHOES_IMAGES_LARGE @"//img[@id='ctl00_cphPageMain_ImageMultiView1_imgLargeDisplay']"
#define SHOES_DETAIL_SHOES_IMAGES_ALLANGEL @"//div[@class='multThumbs']"
#define SHOES_DETAIL_SHOES_PRICE @"//span[@id='ctl00_cphPageMain_BrandAndPrice1_ProductPrice']//span[@class='e4xprice']"
//#define SHOES_DETAIL_SHOES_IMAGES_ALLANGEL_DEFAULT 8
//#define SHOES_CATEGORY_PRODUCT_LIST_XPATH @"//*[@id='ResultZone2_wrapper']//div[@style='height: auto;']"
#define CATEGORY_SHOES_COUNT 12

#define CAPACITY_DICTIONARY 20
#define CAPACITY_SCROLL_BAR 20
#define CAPACITY_SHOES_LIST 20
#define CAPACITY_SHOPPING_CART 100

#define SHOES_IMAGE_BORDER_SIZE 0.3f
#define SHOES_IMAGE_CORNER_RADIUS 20.0f

#define SHOES_LOGIN_URL @"https://secure.shoes.com/Profiles/Login.aspx?returnurl=%2fProfiles%2fWelcome.aspx"
#define SHOES_LOGIN_INPUT_USERNAME_ID @"ctl00$cphpagemain$createaccountorlogin$logincontrol$username"
#define SHOES_LOGIN_INPUT_PASSWORD_ID @"ctl00$cphpagemain$createaccountorlogin$logincontrol$password"
#define SHOES_LOGIN_INPUT_BTN_X_ID @"ctl00$cphPageMain$CreateAccountOrLogin$LoginControl$loginButton.x"
#define SHOES_LOGIN_INPUT_BTN_Y_ID @"ctl00$cphPageMain$CreateAccountOrLogin$LoginControl$loginButton.y"
#define SHOES_LOGIN_VALUE_EMPTY @""
#define SHOES_LOGIN_INPUT_EVENTTARGET_ID @"__EVENTTARGET"
#define SHOES_LOGIN_INPUT_EVENTARGUMENT_ID @"__EVENTARGUMENT"
#define SHOES_LOGIN_INPUT_VIEWSTATEENCRYPTED_ID @"__VIEWSTATEENCRYPTED"
#define SHOES_LOGIN_INPUT_VIEWSTATE_ID @"__VIEWSTATE"
#define SHOES_LOGIN_INPUT_VIEWSTATE_VALUE @"z/xspKkfU6pPdaxXTTp/k4P27EE2+onbAVd0AI674gNiPyW9Zua1q3aEROHwfmY7SwD8fRgoZFZyuQhpI5Me2gpgkHGbZiWVwrBJIyRSq3gHYtw9j9Ss9/qWUfgk4oNIwPGSg4N5hFyoho8Zbrpm5UgywZzM/sGQcYGyucL6QATJ7IX95E7pqK52zNq3wslvlVEnz6CT78Jf2MYfJIzPmECMWpybVI15GF2S/CdLwq1DW+HyC5QyrMr9zYxZwlTv6T+gKaCtS/3Xc/Q7kQr1Rw2poayQUlyZoAMmZjk08Dvl7LrJ+tpf988OyxVv0PH4ZQE0xLDO56jPjA0dt4YR3vVaOj1hWpZHy+RZ7IZdxOX+IXryRMIzSxUQg4hO2gp4WsNJMkMkhxuu7vztWBySXaIU1664TzLv/JbxDMcvZp3i0Est"

