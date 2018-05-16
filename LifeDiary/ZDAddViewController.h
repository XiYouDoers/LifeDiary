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
#import "ZDCellAddedDatePickerView.h"
#import "ZDCellAddedTextFieldView.h"


@interface ZDAddViewController : UIViewController
@property(nonatomic,strong) ZDAddTableHeaderView *addTableHeaderView;
@property(nonatomic,strong) UITableView *addTableView;
@property(nonatomic,strong) ZDAddDefaultCell *addDefaultCell;
@property(nonatomic,strong) ZDCellAddedDatePickerView *CellForIndexZeroAddedDatePickerView;
@property(nonatomic,strong) ZDCellAddedDatePickerView *CellForIndexTwoAddedDatePickerView;
@property(nonatomic,strong) ZDCellAddedTextFieldView *cellForIndexTwoAddedTextFieldView;
@property(nonatomic,strong) ZDCellAddedTextFieldView *cellForIndexThreeAddedTextFieldView;
@end
