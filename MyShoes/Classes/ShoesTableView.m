//
//  ShoesTableView.m
//  MyShoes
//
//  Created by Congpeng Ma on 29/05/11.
//  Copyright 2011 18m. All rights reserved.
//

#import "ShoesTableView.h"
//#import "ShoesTableViewCell.h"
#import "ShoesDataSource.h"


@implementation ShoesTableView

@synthesize theTableView;
@synthesize dataSource;


- (id)initWithFrame:(CGRect)frame withDataSource:(id)dataS {

    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
      UITableView *tableView = [[UITableView alloc] initWithFrame:frame 
                                                            style:[dataS tableViewStyle]];
      
      // set the autoresizing mask so that the table will always fill the view
      tableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
      
      // set the cell separator to a single straight line.
      tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
      
      // set the tableview delegate to this object and the datasource to the datasource which has already been set
      tableView.delegate = self;
      tableView.dataSource = (id<ShoesDataSourcePro,UITableViewDataSource>)dataS;
      
      tableView.sectionIndexMinimumDisplayRowCount=10;
      
      // set the tableview as the controller view
      self.theTableView = tableView;
      //self.view  = tableView;
      [self addSubview:theTableView];
      [tableView release];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)dealloc{
  
  [super dealloc];
}
@end
