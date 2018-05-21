//
//  ZDAddViewController.h
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDAddTableHeaderView.h"
#import "ZDAddDefaultCell.h"
#import "ZDPickerViewCell.h"

@interface ZDAddViewController : UIViewController
@property(nonatomic,strong) ZDAddTableHeaderView *addTableHeaderView;
@property(nonatomic,strong) UITableView *addTableView;
@property(nonatomic,strong) ZDAddDefaultCell *addDefaultCell;
@property(nonatomic,strong) ZDPickerViewCell *pickerViewCell;
@end
