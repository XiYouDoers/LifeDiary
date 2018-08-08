//
//  ZDDetailView.m
//  LifeDiary
//
//  Created by Jack on 2018/8/8.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDDetailView.h"

@implementation ZDDetailView

- (id)init{
    if (self = [super init]) {
        
        // _remainderTimeLabel
        _remainderTimeLabel = [[UILabel alloc]init];
        _remainderTimeLabel.textColor = GOLDCOLOR;
        //        _remainderTimeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_remainderTimeLabel];
        
        
        //stpper
        //可以设置x,y的位置，但是高和宽是固定的（80，40），即使设置为其他数值，也不会改变它的实际大小
        _stepper = [[UIStepper alloc] init];
        _stepper.tintColor = [UIColor whiteColor];
        _stepper.backgroundColor = NAVIGATIONCOLOR;
        _stepper.layer.cornerRadius = 16.f;
        _stepper.layer.masksToBounds = YES;
        //设置步进器的最小值
        _stepper.minimumValue = 0;
        //设置最大值
        _stepper.maximumValue = 99;
        //设置当前值
        //        _stpper.value = 10;
        //设置步进器每次的该变量
        _stepper.stepValue = 1;
        
        /*
         是否可以重复相应操作事件
         当为YES的时候，按住步进器，步进器会连续相应它的点击事件
         当为NO时，按住步进器，再松开，只会相应一次
         */
        _stepper.autorepeat = YES;
        
        /*
         是否将步进结果通过事件函数相应出来
         当值为YES的时候，按住步进器，-(void)setpChange；这个方法会连续调用；
         当值为NO的时候，按住步进器，-(void)setpChange；这个方法只会在松开步进器才会有结果输出
         */
        _stepper.continuous = YES;
        //        _stepper.translatesAutoresizingMaskIntoConstraints = NO;
        //        [_detailView addSubview:_stepper];
        [self addSubview:_stepper];
        
        //_sumLabel
        _sumLabel = [[UILabel alloc]init];
        _sumLabel.textColor = [UIColor blackColor];
        [self addSubview:_sumLabel];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
