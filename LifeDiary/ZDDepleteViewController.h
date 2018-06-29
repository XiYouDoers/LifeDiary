//
//  ZDDepleteViewController.h
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDAllCell.h"

@interface ZDDepleteViewController : UIViewController
@property(nonatomic,strong) NSMutableArray *dataMutableArray;
@property(nonatomic,strong) UITableView *depleteTableView;
@property(nonatomic,strong) ZDAllCell *depleteCell;
@end
