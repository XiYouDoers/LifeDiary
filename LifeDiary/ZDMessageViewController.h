//
//  ZDMessageViewController.h
//  LifeDiary
//
//  Created by JACK on 2018/5/16.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDViewController.h"
#import "ZDMessageCell.h"

@interface ZDMessageViewController : ZDViewController
@property(nonatomic,strong) NSMutableArray *dataMutableArray;
@property(nonatomic,strong) UITableView *messageTableView;
@property(nonatomic,strong) ZDMessageCell *messageCell;
@end
