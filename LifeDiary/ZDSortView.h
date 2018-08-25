//
//  ZDSortView.h
//  LifeDiary
//
//  Created by Jack on 2018/8/25.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDSortView : UIView
//class
@property(nonatomic,strong) UILabel *classLabel;
@property(nonatomic,strong) UIScrollView *classScrollView;
@property(nonatomic,strong) UIButton *foodButton;
@property(nonatomic,strong) UIButton *medicineButton;
@property(nonatomic,strong) UIButton *cosmeticButton;
@property(nonatomic,strong) UIButton *commodityButton;
//sort
@property(nonatomic,strong) UILabel *sortLabel;
@property(nonatomic,strong) UIScrollView *sortScrollView;
@property(nonatomic,strong) UIButton *defaultSortButton;
@property(nonatomic,strong) UIButton *timeUpSortButton;
@property(nonatomic,strong) UIButton *timeDownSortButton;
@property(nonatomic,strong) UIButton *sumUpSortButton;
@property(nonatomic,strong) UIButton *sumDownSortButton;


@end
