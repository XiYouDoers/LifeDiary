//
//  ZDAddViewController.h
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZDAddVCDelegate<NSObject>
- (void)exhibitSucceed;
@end
@class ZDAddTableHeaderView,ZDAddDefaultCell,ZDPickerViewCell,ZDClassPickerTableViewCell,ZDGoods;

@interface ZDAddViewController : UIViewController

@property(nonatomic,strong) ZDAddTableHeaderView *addTableHeaderView;
@property(nonatomic,strong) UITableView *addTableView;
@property(nonatomic,strong) ZDAddDefaultCell *addDefaultCell;
@property(nonatomic,strong) ZDPickerViewCell *pickerViewCell;
@property(nonatomic,strong) ZDClassPickerTableViewCell *classPickerViewCell;
@property(nonatomic,strong) UIButton *continueToRecognizeButton;
@property(nonatomic,weak) id <ZDAddVCDelegate> delegate;



- (void)setGoodsInfo:(ZDGoods *)goods;

@end
