//
//  ZDMeTableHeaderView.m
//  LifeDiary
//
//  Created by JACK on 2018/5/18.
//  Copyright © 2018年 JACK. All rights reserved.
//
#import "ZDMeTableHeaderView.h"
#import "ZDDepleteViewController.h"
#import "ZDRecycleViewController.h"
#import "ZDExpireViewController.h"

@implementation ZDMeTableHeaderView
- (id)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        
        self.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:244.0/255 alpha:1];
        //_backgroundImageView
        _backgroundImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backgroundImage"]];
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        _backgroundImageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height*0.5);
        [self addSubview:_backgroundImageView];
        
        
        //_titleLabel
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"我的";
        _titleLabel.font = [UIFont systemFontOfSize: 34];
        [_backgroundImageView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(14);
            make.top.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(100, 40));
        }];
        
        
       
        
        //_repertoryView
        _repertoryView = [[UIView alloc]init];
        _repertoryView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_repertoryView];
        [_repertoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(frame.size.height*0.48);
            make.top.mas_equalTo(_backgroundImageView.mas_bottom);
        }];
        
       
        
     
        
        //_depleteButton
        _depleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_depleteButton setImage:[UIImage imageNamed:@"depleteButton"] forState:UIControlStateNormal];
        [_repertoryView addSubview:_depleteButton];
        [_depleteButton addTarget:self.degegate action:@selector(clickDepleteButton) forControlEvents:UIControlEventTouchUpInside];
        [_depleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WIDTH/9);
            make.size.mas_equalTo(CGSizeMake(WIDTH/9, WIDTH/9));
            make.bottom.mas_equalTo(-60);
        }];
        
        //_depleteLabel
        _depleteLabel = [[[UILabel alloc]init]init];
        _depleteLabel.textAlignment = NSTextAlignmentCenter;
        _depleteLabel.text = @"耗尽物品";
        [_repertoryView addSubview:_depleteLabel];
        [_depleteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_depleteButton.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(100, 15));
            make.bottom.mas_equalTo(-30);
        }];
        
        
        
        
        //_recycleButton
        _recycleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_recycleButton setImage:[UIImage imageNamed:@"recycleButton"] forState:UIControlStateNormal];
        [_recycleButton setTitle:@"耗尽物品" forState:UIControlStateNormal];
        [_recycleButton addTarget:self.degegate action:@selector(clickRecycleButton) forControlEvents:UIControlEventTouchUpInside];
        [_repertoryView addSubview:_recycleButton];
        [_recycleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_depleteButton.mas_right).with.offset(WIDTH/9*2);
            make.size.mas_equalTo(CGSizeMake(WIDTH/9, WIDTH/9));
            make.bottom.mas_equalTo(-60);
        }];
        //_recycleLabel
        _recycleLabel = [[[UILabel alloc]init]init];
        _recycleLabel.textAlignment = NSTextAlignmentCenter;
        _recycleLabel.text = @"回收站";
        [_repertoryView addSubview:_recycleLabel];
        [_recycleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_recycleButton.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(100, 15));
            make.bottom.mas_equalTo(-30);
        }];
        
       
        
        
        //_expireButton
        _expireButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_expireButton setImage:[UIImage imageNamed:@"expireButton"] forState:UIControlStateNormal];
        [_expireButton setTitle:@"耗尽物品" forState:UIControlStateNormal];
        [_expireButton addTarget:self.degegate action:@selector(clickExpireButton) forControlEvents:UIControlEventTouchUpInside];
        [_repertoryView addSubview:_expireButton];
        [_expireButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_recycleButton.mas_right).with.offset(WIDTH/9*2);
            make.size.mas_equalTo(CGSizeMake(WIDTH/9, WIDTH/9));
            make.bottom.mas_equalTo(-60);
        }];
        
        //_expireLabel
        _expireLabel = [[[UILabel alloc]init]init];
        _expireLabel.textAlignment = NSTextAlignmentCenter;
        _expireLabel.text = @"过期物品";
        [_repertoryView addSubview:_expireLabel];
        [_expireLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_expireButton.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(100, 15));
            make.bottom.mas_equalTo(-30);
        }];
        
        
        //_shadowViewForRepertoryView
        [self addSubview:self.shadowViewForRepertoryView];
        
        
        //_userInfoView
        _userInfoView = [[UIView alloc]init];
        _userInfoView.layer.cornerRadius = 13.f;
        _userInfoView.layer.masksToBounds = YES;
        _userInfoView.backgroundColor = [UIColor whiteColor];
        [self.shadowViewForRepertoryView addSubview:_userInfoView];
        [_userInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(25);
            make.width.mas_equalTo(WIDTH-25*2);
            make.height.mas_equalTo(140);
            make.top.mas_equalTo(_backgroundImageView.mas_bottom).with.offset(-50);
        }];
        
        
        //_nameTextField
        _nameTextField = [[UITextField alloc]init];
        _nameTextField.textAlignment = NSTextAlignmentCenter;
        _nameTextField.font = [UIFont systemFontOfSize:20];
        _nameTextField.returnKeyType = UIReturnKeyDone;//变为确认按钮
        [_userInfoView addSubview:_nameTextField];
        [_nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(65);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(20);
        }];
        
        //_personalitySignatureTextField
        _personalitySignatureTextField = [[UITextField alloc]init];
        //        _personalitySignatureTextField.text = @"没有个性，何来签名";
        _personalitySignatureTextField.frame = CGRectMake(0,  frame.size.height/3-30+90+10, frame.size.width, 20);
        _personalitySignatureTextField.textAlignment = NSTextAlignmentCenter;
        _personalitySignatureTextField.font = [UIFont systemFontOfSize:18];
        _personalitySignatureTextField.textColor = [UIColor lightGrayColor];
        _personalitySignatureTextField.returnKeyType = UIReturnKeyDone;//变为确认按钮
        [_userInfoView addSubview:_personalitySignatureTextField];
        [_personalitySignatureTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-20);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(20);
        }];
        
        
        
        //shadowViewForHeadPicture
        [self addSubview:self.shadowViewForHeadPicture];
        
        //_headPictureButton
        _headPictureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _headPictureButton.backgroundColor = [UIColor whiteColor];
        _headPictureButton.layer.cornerRadius = 100/2;
        _headPictureButton.layer.masksToBounds = YES;
        _headPictureButton.layer.borderWidth = 1.0f;
        _headPictureButton.userInteractionEnabled = YES;
        _headPictureButton.layer.borderColor = LIGHTBLUE.CGColor;
        [self.shadowViewForHeadPicture addSubview:_headPictureButton];
        [_headPictureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_userInfoView.mas_top).with.offset(-100/2);
            make.size.mas_equalTo(CGSizeMake(100, 100));
            make.left.mas_equalTo(frame.size.width/2-100/2);
        }];
        
    }
    return self;
}

- (UIView *)shadowViewForRepertoryView{
    if (_shadowViewForRepertoryView == nil) {
        
        //_shadowViewForRepertoryView
        _shadowViewForRepertoryView = [[UIView alloc]init];
        _shadowViewForHeadPicture.frame = CGRectMake(0, 100, WIDTH, HEIGHT/2);
//        _shadowViewForRepertoryView = [UIColor purpleColor];
        _shadowViewForRepertoryView.layer.shadowColor =  [UIColor colorWithRed:203.0/255 green:231.0/255 blue:247.0/255 alpha:1].CGColor;
        _shadowViewForRepertoryView.layer.shadowOffset = CGSizeMake(0, 8);
        _shadowViewForRepertoryView.layer.shadowRadius = 20 ;
        _shadowViewForRepertoryView.layer.shadowOpacity = 1;
        _shadowViewForRepertoryView.layer.shouldRasterize = YES;
    }
    return _shadowViewForRepertoryView;
}
- (UIView *)shadowViewForHeadPicture{
    
    if (_shadowViewForHeadPicture == nil) {
        
        //shadowViewForHeadPicture
        _shadowViewForHeadPicture = [[UIView alloc]init];
        _shadowViewForHeadPicture.frame = CGRectMake(0, 0, WIDTH, HEIGHT/2);
        _shadowViewForHeadPicture.layer.shadowColor =  [UIColor colorWithRed:203.0/255 green:231.0/255 blue:247.0/255 alpha:1].CGColor;
        _shadowViewForHeadPicture.layer.shadowOffset = CGSizeMake(0, 5);
        _shadowViewForHeadPicture.layer.shadowRadius = 20 ;
        _shadowViewForHeadPicture.layer.shadowOpacity = 1;
        _shadowViewForHeadPicture.layer.shouldRasterize = YES;
    }
    return _shadowViewForHeadPicture;
}
- (void)clickDepleteButton{
    ZDDepleteViewController *deVC = [[ZDDepleteViewController alloc]init];
    [self.degegate.navigationController pushViewController:deVC animated:YES];
}
- (void)clickRecycleButton{
    ZDRecycleViewController *reVC = [[ZDRecycleViewController alloc]init];
    [self.degegate.navigationController pushViewController:reVC animated:YES];
}
- (void)clickExpireButton{
    ZDExpireViewController *exVC = [[ZDExpireViewController alloc]init];
    [self.degegate.navigationController pushViewController:exVC animated:YES];
}
    
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
