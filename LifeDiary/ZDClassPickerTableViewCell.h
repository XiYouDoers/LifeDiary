//
//  ZDClassPickerTableViewCell.h
//  LifeDiary
//
//  Created by Jack on 2018/9/6.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDClassPickerTableViewCell : UITableViewCell
@property(nonatomic,strong) UIImageView *tabImageView;
@property(nonatomic,strong) UILabel *tabLabel;
@property(nonatomic,strong) UITextField *textField;
@property(nonatomic,strong) UIPickerView *pickerView;
@property(nonatomic,strong) NSArray *pickerViewDataArray;
@end
