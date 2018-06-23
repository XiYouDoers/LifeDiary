//
//  ZDMeViewController.h
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDMeDefaultCell.h"

@interface ZDMeViewController : UIViewController
@property(nonatomic,strong) UITableView *meTableView;
@property(nonatomic,strong) ZDMeDefaultCell *meCell;

@end
