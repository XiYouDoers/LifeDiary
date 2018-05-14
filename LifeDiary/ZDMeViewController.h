//
//  ZDMeViewController.h
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDMeTopCell.h"


@interface ZDMeViewController : UIViewController
@property(nonatomic,strong) UITableView *meTableView;
@property(nonatomic,strong) UITableViewCell *meCell;
@property(nonatomic,strong) ZDMeTopCell *topCell;
@property(nonatomic,copy) NSArray *cellDataArray;
@end
