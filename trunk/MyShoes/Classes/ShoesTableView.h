//
//  ShoesTableView.h
//  MyShoes
//
//  Created by Congpeng Ma on 29/05/11.
//  Copyright 2011 18m. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoesDataSource.h"

@class Shoes;


@interface ShoesTableView : UIView <UITableViewDelegate> {
	UITableView *theTableView;
	id<ShoesDataSourcePro,UITableViewDataSource> dataSource;
	
}

@property (nonatomic,retain) UITableView *theTableView;
@property (nonatomic,retain) id<ShoesDataSourcePro,UITableViewDataSource> dataSource;

- (id)initWithFrame:(CGRect)frame withDataSource:(id<ShoesDataSourcePro,UITableViewDataSource>) dataSource;
@end
