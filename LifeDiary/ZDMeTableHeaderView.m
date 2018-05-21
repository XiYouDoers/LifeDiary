//
//  ZDMeTableHeaderView.m
//  LifeDiary
//
//  Created by JACK on 2018/5/18.
//  Copyright © 2018年 JACK. All rights reserved.
//
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#import "ZDMeTableHeaderView.h"

@implementation ZDMeTableHeaderView
- (id)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        
        //_backgroundImageView
        _backgroundImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backgroundImage"]];
        _backgroundImageView.frame = frame;
        [self addSubview:_backgroundImageView];
        
        //_headPictureButton
        _headPictureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _headPictureButton.frame = CGRectMake(frame.size.width/2-30, frame.size.height/3-30, 60, 60);
        [_headPictureButton setImage: [UIImage imageNamed:@"headPictureImage"] forState:UIControlStateNormal];
        [self addSubview:_headPictureButton];
        
        //_nameTextField
        _nameTextField = [[UITextField alloc]init];
        _nameTextField.frame = CGRectMake(0,  frame.size.height/3-30+60+10, frame.size.width, 20);
        _nameTextField.textAlignment = NSTextAlignmentCenter;
        _nameTextField.text = @"LifeDiary";
        [self addSubview:_nameTextField];
        
        //_personalitySignatureTextField
        _personalitySignatureTextField = [[UITextField alloc]init];
        _personalitySignatureTextField.frame = CGRectMake(0,  frame.size.height/3-30+90+10, frame.size.width, 20);
        _personalitySignatureTextField.textAlignment = NSTextAlignmentCenter;
        _personalitySignatureTextField.text = @"没有个性，何来签名";
        _personalitySignatureTextField.font = [UIFont systemFontOfSize:12];
        _personalitySignatureTextField.textColor = [UIColor whiteColor];
        [self addSubview:_personalitySignatureTextField];
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
