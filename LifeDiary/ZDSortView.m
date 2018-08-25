//
//  ZDSortView.m
//  LifeDiary
//
//  Created by Jack on 2018/8/25.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDSortView.h"

@implementation ZDSortView
- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
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
        
        //foodButton
        [self.classScrollView addSubview:self.foodButton];
        [self.foodButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.classLabel.mas_bottom).with.offset(5);
            make.left.mas_equalTo(8);
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
        _classScrollView.contentSize = CGSizeMake(WIDTH*1.5, 40);
        _classScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _classScrollView;
}
- (UIButton *)foodButton{
    
    if (_foodButton == nil) {
        _foodButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _foodButton.layer.masksToBounds = YES;
        _foodButton.layer.cornerRadius = 15.f;
        [_foodButton setTitle:@"食品" forState:UIControlStateNormal];
        [_foodButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_foodButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_foodButton setBackgroundColor:[UIColor colorWithRed:90/255.0 green:180/255.0 blue:249/255.0 alpha:1]];
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
//        [_medicineButton setBackgroundColor:[UIColor colorWithRed:90/255.0 green:180/255.0 blue:249/255.0 alpha:1]];
    }
    return _medicineButton;
}

- (UIButton *)cosmeticButton{
    
    if (_cosmeticButton == nil) {
        _cosmeticButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cosmeticButton.layer.masksToBounds = YES;
        _cosmeticButton.layer.cornerRadius = 15.f;
        [_cosmeticButton setTitle:@"化妆品" forState:UIControlStateNormal];
        [_cosmeticButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cosmeticButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//        [_cosmeticButton setBackgroundColor:[UIColor colorWithRed:90/255.0 green:180/255.0 blue:249/255.0 alpha:1]];
    }
    return _cosmeticButton;
}

- (UIButton *)commodityButton{
    
    if (_commodityButton == nil) {
        _commodityButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commodityButton.layer.masksToBounds = YES;
        _commodityButton.layer.cornerRadius = 15.f;
        [_commodityButton setTitle:@"日用品" forState:UIControlStateNormal];
        [_commodityButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_commodityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//        [_commodityButton setBackgroundColor:[UIColor colorWithRed:90/255.0 green:180/255.0 blue:249/255.0 alpha:1]];
    }
    return _commodityButton;
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
        _sortScrollView.contentSize = CGSizeMake(WIDTH*2,40);
        _sortScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _sortScrollView;
}
- (UIButton *)defaultSortButton{
    
    if (_defaultSortButton == nil) {
        _defaultSortButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _defaultSortButton.layer.masksToBounds = YES;
        _defaultSortButton.layer.cornerRadius = 15.f;
        [_defaultSortButton setTitle:@"默认排序" forState:UIControlStateNormal];
        [_defaultSortButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_defaultSortButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_defaultSortButton setBackgroundColor:[UIColor colorWithRed:64/255.0 green:219/255.0 blue:228/255.0 alpha:1]];
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
        //        [_medicineButton setBackgroundColor:[UIColor colorWithRed:90/255.0 green:180/255.0 blue:249/255.0 alpha:1]];
    }
    return _timeUpSortButton;
}

- (UIButton *)timeDownSortButton{
    
    if (_timeDownSortButton == nil) {
        _timeDownSortButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _timeDownSortButton.layer.masksToBounds = YES;
        _timeDownSortButton.layer.cornerRadius = 15.f;
        [_timeDownSortButton setTitle:@"时间升序" forState:UIControlStateNormal];
        [_timeDownSortButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_timeDownSortButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        //        [_cosmeticButton setBackgroundColor:[UIColor colorWithRed:90/255.0 green:180/255.0 blue:249/255.0 alpha:1]];
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
        //        [_commodityButton setBackgroundColor:[UIColor colorWithRed:90/255.0 green:180/255.0 blue:249/255.0 alpha:1]];
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
        //        [_commodityButton setBackgroundColor:[UIColor colorWithRed:90/255.0 green:180/255.0 blue:249/255.0 alpha:1]];
    }
    return _sumDownSortButton;
}
@end
