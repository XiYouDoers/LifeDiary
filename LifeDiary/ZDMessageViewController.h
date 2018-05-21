//
//  ZDMessageViewController.h
//  LifeDiary
//
//  Created by JACK on 2018/5/16.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDViewController.h"
#import "ZDMessageCell.h"
#import "ZDAllCell.h"

@interface ZDMessageViewController : ZDViewController
@property(nonatomic,strong) NSMutableArray *messageDataMutableArray;
@property(nonatomic,strong) NSMutableArray *AllDataMutableArray;
@property(nonatomic,strong) UITableView *messageTableView;
@property(nonatomic,strong) UITableView *allTableView;
@property(nonatomic,strong) ZDMessageCell *messageCell;
@property(nonatomic,strong) ZDAllCell *allCell;
@end
