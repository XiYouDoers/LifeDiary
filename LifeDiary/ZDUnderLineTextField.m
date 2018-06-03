//
//  ZDUnderLineTextField.m
//  LifeDiary
//
//  Created by JACK on 2018/5/17.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDUnderLineTextField.h"

@implementation ZDUnderLineTextField
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    self.returnKeyType = UIReturnKeyNext;//变为换行按钮
    [[UIColor lightGrayColor] set];//设置下划线颜色     
    CGFloat y = CGRectGetHeight(self.frame);
    CGContextMoveToPoint(context, 0, y);
    CGContextAddLineToPoint(context, CGRectGetWidth(self.frame), y);
    //设置线的宽度
    CGContextSetLineWidth(context, 0.5);
    //渲染 显示到self上
    CGContextStrokePath(context);
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
