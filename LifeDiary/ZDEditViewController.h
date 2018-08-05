//
//  ZDEditViewController.h
//  LifeDiary
//
//  Created by Jack on 2018/7/28.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDAddTableHeaderView.h"
#import "ZDEditDefaultCell.h"
#import "ZDEditPickerViewCell.h"
#import "ZDGoods.h"
@interface ZDEditViewController : UIViewController

/**
    与ZDAddTableHeaderView 相同
 */
@property(nonatomic,strong) ZDAddTableHeaderView *editTableHeaderView;
@property(nonatomic,strong) ZDGoods *goods;
@property(nonatomic,strong) UITableView *editTableView;
@property(nonatomic,strong) ZDEditDefaultCell *editDefaultCell;
@property(nonatomic,strong)  ZDEditPickerViewCell *editPickerViewCell;
@end