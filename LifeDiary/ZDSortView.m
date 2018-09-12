//
//  ZDSortView.m
//  LifeDiary
//
//  Created by Jack on 2018/8/25.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDSortView.h"

@interface ZDSortView()
@property(nonatomic,strong) NSMutableArray *classMuArray;
@property(nonatomic,strong) NSMutableArray *sortMuArray;
@property(nonatomic,strong) UIImage *buttonOfClassImage;
@property(nonatomic,strong) UIImage *buttonOfSortImage;
@end

@implementation ZDSortView
- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
        _buttonOfClassImage = [UIImage imageNamed:@"buttonOfClassSelected"];
        _buttonOfClassImage = [_buttonOfClassImage  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        _buttonOfSortImage = [UIImage imageNamed:@"buttonOfSortSelected"];
        _buttonOfSortImage = [_buttonOfSortImage  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        self.backgroundColor = [UIColor whiteColor];
        _classMuArray = [NSMutableArray array];
        _sortMuArray = [NSMutableArray array];
        //classLabel
        [self addSubview:self.classLabel];
        [self.classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.left.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(60, 30));
        }];
        
        //classScrollView
        [self addSubview:self.classScrollView];
        [self.classScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.classLabel.mas_bottom).with.offset(5);
            make.left.mas_equalTo(8);
            make.size.mas_equalTo(CGSizeMake(WIDTH-16, 40));
        }];
        
        
        //allButton
        [self.classScrollView addSubview:self.allButton];
        [self.allButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.classLabel.mas_bottom).with.offset(5);
            make.left.mas_equalTo(8);
            make.size.mas_equalTo(CGSizeMake(80, 30));
        }];
        
        //foodButton
        [self.classScrollView addSubview:self.foodButton];
        [self.foodButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.classLabel.mas_bottom).with.offset(5);
            make.left.mas_equalTo(_allButton.mas_right).with.offset(5);
            make.size.mas_equalTo(CGSizeMake(80, 30));
        }];
        
        //medicineButton
        [self.classScrollView addSubview:self.medicineButton];
        [self.medicineButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.classLabel.mas_bottom).with.offset(5);
            make.left.mas_equalTo(_foodButton.mas_right).with.offset(5);
            make.size.mas_equalTo(CGSizeMake(80, 30));
        }];
        
        //cosmeticButton
        [self.classScrollView addSubview:self.cosmeticButton];
        [self.cosmeticButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.classLabel.mas_bottom).with.offset(5);
            make.left.mas_equalTo(_medicineButton.mas_right).with.offset(5);
            make.size.mas_equalTo(CGSizeMake(80, 30));
        }];
        
        //commodityButton
        [self.classScrollView addSubview:self.commodityButton];
        [self.commodityButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.classLabel.mas_bottom).with.offset(5);
            make.left.mas_equalTo(_cosmeticButton.mas_right).with.offset(5);
            make.size.mas_equalTo(CGSizeMake(80, 30));
        }];
        
        //sortLabel
        [self addSubview:self.sortLabel];
        [self.sortLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_classScrollView.mas_bottom).with.offset(5);
            make.left.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(60, 30));
        }];
        
        //sortScrollView
        [self addSubview:self.sortScrollView];
        [self.sortScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.sortLabel.mas_bottom).with.offset(5);
            make.left.mas_equalTo(8);
            make.width.mas_equalTo(WIDTH-16);
            make.height.mas_equalTo(40);
//            make.bottom.mas_equalTo(-5);
        }];
        
        //defaultSortButton
        [self.sortScrollView addSubview:self.defaultSortButton];
        [self.defaultSortButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.left.mas_equalTo(8);
            make.size.mas_equalTo(CGSizeMake(100, 30));
        }];
        
        //timeUpSortButton
        [self.sortScrollView addSubview:self.timeUpSortButton];
        [self.timeUpSortButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.left.mas_equalTo(_defaultSortButton.mas_right).with.offset(5);
            make.size.mas_equalTo(CGSizeMake(100, 30));
        }];
        
        //timeDownSortButton
        [self.sortScrollView addSubview:self.timeDownSortButton];
        [self.timeDownSortButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.left.mas_equalTo(_timeUpSortButton.mas_right).with.offset(5);
            make.size.mas_equalTo(CGSizeMake(100, 30));
        }];
        
        //sumUpSortButton
        [self.sortScrollView addSubview:self.sumUpSortButton];
        [self.sumUpSortButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo( 5);
            make.left.mas_equalTo(_timeDownSortButton.mas_right).with.offset(5);
            make.size.mas_equalTo(CGSizeMake(100, 30));
        }];
        
        //sumDownSortButton
        [self.sortScrollView addSubview:self.sumDownSortButton];
        [self.sumDownSortButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo( 5);
            make.left.mas_equalTo(_sumUpSortButton.mas_right).with.offset(5);
            make.size.mas_equalTo(CGSizeMake(100, 30));
        }];
        
        
        //cancelButton
        [self addSubview:self.cancelButton];
        [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.sumDownSortButton.mas_bottom).with.offset(20);
            make.right.mas_equalTo(-20);
            make.size.mas_equalTo(CGSizeMake(80, 40));
        }];
        
        //confirmButton
        [self addSubview:self.confirmButton];
        [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.sumDownSortButton.mas_bottom).with.offset(20);
            make.right.mas_equalTo(self.cancelButton.mas_left).with.offset(-10);
            make.size.mas_equalTo(CGSizeMake(80, 40));
        }];
        
        
        [self NightWithType:UIViewColorTypeBlue];
        
    }
    return self;
}
- (UILabel *)classLabel{
    
    if (_classLabel == nil) {
        _classLabel = [[UILabel alloc]init];
        _classLabel.textAlignment = NSTextAlignmentCenter;
        _classLabel.text = @"分类";
        _classLabel.font = [UIFont systemFontOfSize:19];
        
    }
    return _classLabel;
}
- (UIScrollView *)classScrollView{
    if (_classScrollView == nil) {
        _classScrollView = [[UIScrollView alloc]init];
        _classScrollView.contentSize = CGSizeMake(WIDTH*1.2, 40);
        _classScrollView.showsHorizontalScrollIndicator = NO;
        [_classScrollView NightWithType:UIViewColorTypeBlue];
    }
    return _classScrollView;
}
- (UIButton *)allButton{
    
    if (_allButton == nil) {
        _allButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _allButton.layer.masksToBounds = YES;
        _allButton.layer.cornerRadius = 15.f;
        _allButton.selected = YES;
        [_allButton setTitle:@"全部" forState:UIControlStateNormal];
        [_allButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_allButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_allButton addTarget:self action:@selector(clickButtonOfClass:) forControlEvents:UIControlEventTouchUpInside];
        [_allButton setBackgroundImage:_buttonOfClassImage forState:UIControlStateSelected];
        [_classMuArray addObject:_allButton];
    }
    return _allButton;
}
- (UIButton *)foodButton{
    
    if (_foodButton == nil) {
        _foodButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _foodButton.layer.masksToBounds = YES;
        _foodButton.layer.cornerRadius = 15.f;
        [_foodButton setTitle:@"食品" forState:UIControlStateNormal];
        [_foodButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_foodButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_foodButton addTarget:self action:@selector(clickButtonOfClass:) forControlEvents:UIControlEventTouchUpInside];
        [_foodButton setBackgroundImage:_buttonOfClassImage forState:UIControlStateSelected];
        [_classMuArray addObject:_foodButton];
    }
    return _foodButton;
}

- (UIButton *)medicineButton{
    
    if (_medicineButton == nil) {
        _medicineButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _medicineButton.layer.masksToBounds = YES;
        _medicineButton.layer.cornerRadius = 15.f;
        [_medicineButton setTitle:@"药品" forState:UIControlStateNormal];
        [_medicineButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_medicineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_medicineButton setBackgroundImage:_buttonOfClassImage forState:UIControlStateSelected];
        [_medicineButton addTarget:self action:@selector(clickButtonOfClass:) forControlEvents:UIControlEventTouchUpInside];
        [_classMuArray addObject:_medicineButton];
    }
    return _medicineButton;
}

- (UIButton *)cosmeticButton{
    
    if (_cosmeticButton == nil) {
        _cosmeticButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cosmeticButton.layer.masksToBounds = YES;
        _cosmeticButton.layer.cornerRadius = 15.f;
        [_cosmeticButton setTitle:@"日用品" forState:UIControlStateNormal];
        [_cosmeticButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cosmeticButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_cosmeticButton setBackgroundImage:_buttonOfClassImage forState:UIControlStateSelected];
        [_cosmeticButton addTarget:self action:@selector(clickButtonOfClass:) forControlEvents:UIControlEventTouchUpInside];
        [_classMuArray addObject:_cosmeticButton];
    }
    return _cosmeticButton;
}

- (UIButton *)commodityButton{
    
    if (_commodityButton == nil) {
        _commodityButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commodityButton.layer.masksToBounds = YES;
        _commodityButton.layer.cornerRadius = 15.f;
        [_commodityButton setTitle:@"其他" forState:UIControlStateNormal];
        [_commodityButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_commodityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_commodityButton setBackgroundImage:_buttonOfClassImage forState:UIControlStateSelected];
        [_commodityButton addTarget:self action:@selector(clickButtonOfClass:) forControlEvents:UIControlEventTouchUpInside];
        [_classMuArray addObject:_commodityButton];
    }
    return _commodityButton;
}
- (void)clickButtonOfClass:(UIButton *)button{
    
    for (UIButton *button in _classMuArray) {
        button.selected = NO;
    }
    button.selected = !button.selected;
    _classString = button.titleLabel.text;
}
- (UILabel *)sortLabel{
    
    if (_sortLabel == nil) {
        _sortLabel = [[UILabel alloc]init];
        _sortLabel.textAlignment = NSTextAlignmentCenter;
        _sortLabel.text = @"排序";
        _sortLabel.font = [UIFont systemFontOfSize:19];
        
    }
    return _sortLabel;
}
- (UIScrollView *)sortScrollView{
    if (_sortScrollView == nil) {
        _sortScrollView = [[UIScrollView alloc]init];
        _sortScrollView.contentSize = CGSizeMake(WIDTH*1.5,40);
        _sortScrollView.showsHorizontalScrollIndicator = NO;
        [_sortScrollView NightWithType:UIViewColorTypeBlue];
    }
    return _sortScrollView;
}
- (UIButton *)defaultSortButton{
    
    if (_defaultSortButton == nil) {
        _defaultSortButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _defaultSortButton.layer.masksToBounds = YES;
        _defaultSortButton.layer.cornerRadius = 15.f;
        _defaultSortButton.selected = YES;
        [_defaultSortButton setTitle:@"默认排序" forState:UIControlStateNormal];
        [_defaultSortButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_defaultSortButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_defaultSortButton setBackgroundImage:_buttonOfSortImage forState:UIControlStateSelected];
        [_defaultSortButton addTarget:self action:@selector(clickButtonOfSort:) forControlEvents:UIControlEventTouchUpInside];
        [_sortMuArray addObject:_defaultSortButton];
    }
    return _defaultSortButton;
}

- (UIButton *)timeUpSortButton{
    
    if (_timeUpSortButton == nil) {
        _timeUpSortButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _timeUpSortButton.layer.masksToBounds = YES;
        _timeUpSortButton.layer.cornerRadius = 15.f;
        [_timeUpSortButton setTitle:@"时间升序" forState:UIControlStateNormal];
        [_timeUpSortButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_timeUpSortButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_timeUpSortButton setBackgroundImage:_buttonOfSortImage forState:UIControlStateSelected];
        [_timeUpSortButton addTarget:self action:@selector(clickButtonOfSort:) forControlEvents:UIControlEventTouchUpInside];
        [_sortMuArray addObject:_timeUpSortButton];
    }
    return _timeUpSortButton;
}

- (UIButton *)timeDownSortButton{
    
    if (_timeDownSortButton == nil) {
        _timeDownSortButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _timeDownSortButton.layer.masksToBounds = YES;
        _timeDownSortButton.layer.cornerRadius = 15.f;
        [_timeDownSortButton setTitle:@"时间降序" forState:UIControlStateNormal];
        [_timeDownSortButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_timeDownSortButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_timeDownSortButton setBackgroundImage:_buttonOfSortImage forState:UIControlStateSelected];
        [_timeDownSortButton addTarget:self action:@selector(clickButtonOfSort:) forControlEvents:UIControlEventTouchUpInside];
        [_sortMuArray addObject:_timeDownSortButton];
    }
    return _timeDownSortButton;
}

- (UIButton *)sumUpSortButton{
    
    if (_sumUpSortButton == nil) {
        _sumUpSortButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sumUpSortButton.layer.masksToBounds = YES;
        _sumUpSortButton.layer.cornerRadius = 15.f;
        [_sumUpSortButton setTitle:@"数量升序" forState:UIControlStateNormal];
        [_sumUpSortButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_sumUpSortButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_sumUpSortButton setBackgroundImage:_buttonOfSortImage forState:UIControlStateSelected];
        [_sumUpSortButton addTarget:self action:@selector(clickButtonOfSort:) forControlEvents:UIControlEventTouchUpInside];
        [_sortMuArray addObject:_sumUpSortButton];
    }
    return _sumUpSortButton;
}
- (UIButton *)sumDownSortButton{
    
    if (_sumDownSortButton == nil) {
        _sumDownSortButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sumDownSortButton.layer.masksToBounds = YES;
        _sumDownSortButton.layer.cornerRadius = 15.f;
        [_sumDownSortButton setTitle:@"数量降序" forState:UIControlStateNormal];
        [_sumDownSortButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_sumDownSortButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
      
        [_sumDownSortButton setBackgroundImage:_buttonOfSortImage forState:UIControlStateSelected];
        [_sumDownSortButton addTarget:self action:@selector(clickButtonOfSort:) forControlEvents:UIControlEventTouchUpInside];
        [_sortMuArray addObject:_sumDownSortButton];
    }
    return _sumDownSortButton;
}
- (void)clickButtonOfSort:(UIButton *)button{
    for (UIButton *button in _sortMuArray) {
        button.selected = NO;
    }
    button.selected = !button.selected;
    _sortString = button.titleLabel.text;
}
- (UIButton *)confirmButton{
    
    if (_confirmButton == nil) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmButton.layer.masksToBounds = YES;
        _confirmButton.layer.cornerRadius = 15.f;
        [_confirmButton setTitle:@"确认" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_confirmButton setBackgroundColor:LIGHTBLUE];
        [_confirmButton setBackgroundImage:_buttonOfSortImage forState:UIControlStateSelected];
        [_confirmButton addTarget:self action:@selector(confirmButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}
- (void)confirmButtonClicked{

    [self.delegate confirmToSort:_classString sort:_sortString];
}
- (UIButton *)cancelButton{
    
    if (_cancelButton == nil) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.layer.masksToBounds = YES;
        _cancelButton.layer.cornerRadius = 15.f;
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor whiteColor ] forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_cancelButton setBackgroundColor:[UIColor colorWithRed:255/255.0 green:117/255.0 blue:163/255.0 alpha:1]];
        [_cancelButton addTarget:self action:@selector(cancelButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}
- (void)cancelButtonClicked{
    [self.delegate hiddenSortView];
}

@end
