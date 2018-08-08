//
//  ZDTimerView.h
//  LifeDiary
//
//  Created by Jack on 2018/7/20.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDTimerView : UIView

@property(nonatomic,assign) NSInteger count;
@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,strong) UIButton *timeButton;

@end
