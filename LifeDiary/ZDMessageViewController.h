//
//  ZDMessageViewController.h
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDMessageCell.h"

@interface ZDMessageViewController : UIViewController
@property(nonatomic,strong) NSMutableArray *dataMutableArray;
@property(nonatomic,strong) UITableView *messageTableView;
@property(nonatomic,strong) ZDMessageCell *messageCell;
@end
