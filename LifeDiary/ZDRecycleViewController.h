//
//  ZDRecycleViewController.h
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  ZDRepertoryCell;
@interface ZDRecycleViewController : UIViewController
@property(nonatomic,strong) NSMutableArray *dataMutableArray;
@property(nonatomic,strong) UITableView *recycleTableView;
@property(nonatomic,strong) ZDRepertoryCell *recycleCell;

@end
