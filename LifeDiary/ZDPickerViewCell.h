//
//  ZDPickerViewCell.h
//  LifeDiary
//
//  Created by JACK on 2018/5/20.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDPickerViewCell : UITableViewCell

@property(nonatomic,strong) UIImageView *tabImageView;
@property(nonatomic,strong) UILabel *tabLabel;
@property(nonatomic,strong) UITextField *textField;
@property(nonatomic,strong) UIPickerView *pickerView;
@property(nonatomic,strong) NSArray *pickerViewDataArray;
@end
