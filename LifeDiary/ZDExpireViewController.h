//
//  ZDExpireViewController.h
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZDRepertoryCell;

@interface ZDExpireViewController : UIViewController

@property(nonatomic,strong) NSMutableArray *dataMutableArray;
@property(nonatomic,strong) UITableView *expireTableView;
@property(nonatomic,strong) ZDRepertoryCell *expireCell;

@end
