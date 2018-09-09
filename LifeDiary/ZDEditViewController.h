//
//  ZDEditViewController.h
//  LifeDiary
//
//  Created by Jack on 2018/7/28.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZDEditVCDelegate<NSObject>
- (void)exhibitSucceed;
@end
@class ZDAddTableHeaderView,ZDEditDefaultCell,ZDEditPickerViewCell,ZDGoods,ZDEditClassPickerViewCell;

@interface ZDEditViewController : UIViewController

/**
    与ZDAddTableHeaderView 相同
 */
@property(nonatomic,strong) ZDAddTableHeaderView *editTableHeaderView;
@property(nonatomic,strong) ZDGoods *goods;
@property(nonatomic,strong) UITableView *editTableView;
@property(nonatomic,strong) ZDEditDefaultCell *editDefaultCell;
@property(nonatomic,strong) ZDEditPickerViewCell *editPickerViewCell;
@property(nonatomic,strong) ZDEditClassPickerViewCell *editClassPickerViewCell;
@property(nonatomic,weak) id <ZDEditVCDelegate> delegate;
@end
