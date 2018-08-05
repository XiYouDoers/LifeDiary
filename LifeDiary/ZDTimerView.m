//
//  ZDTimerView.m
//  LifeDiary
//
//  Created by Jack on 2018/7/20.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDTimerView.h"

@implementation ZDTimerView
- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(action) userInfo:nil repeats:YES];
        [self addSubview:self.timeButton];
        
    }
    return self;
}
- (UIButton *)timeButton{
    if (!_timeButton) {
        _timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_timeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _timeButton.frame = CGRectMake(0, 0, 50, 50);
    }
    return _timeButton;
}




- (void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();//获取上下文对象  只要是用了 CoreGraPhics  就必须创建他
    CGContextSetLineWidth(context, 5);//显然是设置线宽
    CGContextSetRGBStrokeColor(context, 234.0/255, 130.0/255,178.0/255, 1);// 设置颜色
    CGContextAddArc(context, 25, 25, 15, 0 , self.count/300.0 * 2* M_PI, 0);//这就是画曲线了
    CGContextStrokePath(context);
}
- (void)action{
    
    self.count++;//时间累加
    if (self.count == 300) {
        //到达时间以后取消定时器
        [self.timer invalidate];
        self.timer = nil;
    }
    if ((self.count-1) % 100 == 0) {
        [self.timeButton setTitle:[NSString stringWithFormat:@"%ld",3 - self.count/100] forState:UIControlStateNormal];
        
    }
    
    [self setNeedsDisplay];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
