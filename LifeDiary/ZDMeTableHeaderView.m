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
        [_headPictureButton setImage:[UIImage imageNamed:@"headPictureImage"] forState:UIControlStateNormal];
        [self addSubview:_headPictureButton];
        [_headPictureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(frame.size.height/4);
            make.size.mas_equalTo(CGSizeMake(70, 70));
            make.left.mas_equalTo(frame.size.width/2-35);
        }];
        
        //_nameTextField
        _nameTextField = [[UITextField alloc]init];
        _nameTextField.textAlignment = NSTextAlignmentCenter;
        _nameTextField.returnKeyType = UIReturnKeyDone;//变为确认按钮
        [self addSubview:_nameTextField];
        [_nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_headPictureButton.mas_bottom).with.offset(10);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(20);
        }];
        
        //_personalitySignatureTextField
        _personalitySignatureTextField = [[UITextField alloc]init];
//        _personalitySignatureTextField.text = @"没有个性，何来签名";
        _personalitySignatureTextField.frame = CGRectMake(0,  frame.size.height/3-30+90+10, frame.size.width, 20);
        _personalitySignatureTextField.textAlignment = NSTextAlignmentCenter;
        _personalitySignatureTextField.font = [UIFont systemFontOfSize:12];
        _personalitySignatureTextField.textColor = [UIColor whiteColor];
        _personalitySignatureTextField.returnKeyType = UIReturnKeyDone;//变为确认按钮
        [self addSubview:_personalitySignatureTextField];
        [_personalitySignatureTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_nameTextField.mas_bottom).with.offset(10);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(20);
        }];
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
