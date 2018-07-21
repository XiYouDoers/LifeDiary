//
//  ZDCollectionViewCell.m
//  LifeDiary
//
//  Created by JACK on 2018/5/31.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDCollectionViewCell.h"

@implementation ZDCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.contentView.layer.cornerRadius = 13.f;
        self.contentView.layer.masksToBounds = YES;
        //backView
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        backView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:backView];
        
        
        
        //_imageView
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/5*3)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        
        [backView addSubview:_imageView];
        
        
        //_nameLabel
        
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_imageView.mas_bottom).with.offset(20);
            make.size.mas_equalTo(CGSizeMake(self.frame.size.width, 20));
            make.left.mas_equalTo(0);
        }];
        
        //_zanImageView
        
        _zanImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zan"]];
        [backView addSubview:_zanImageView];
        [_zanImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_nameLabel.mas_bottom).with.offset(20);
            make.left.mas_equalTo(self.frame.size.width/9*2);
            make.size.mas_equalTo(CGSizeMake(frame.size.width/9, frame.size.width/9));
            
        }];
        
        
        //_zanLabel
        
        _zanLabel = [[UILabel alloc]init];
        _zanLabel.text = @"24";
        _zanLabel.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:_zanLabel];
        [_zanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_zanImageView.mas_bottom).with.offset(10);
            make.left.mas_equalTo(self.frame.size.width/9*2);
            make.size.mas_equalTo(CGSizeMake(frame.size.width/9, 20));
            
        }];
        
        //_saveImageView
        
        _saveImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"save"]];
        [backView addSubview:_saveImageView];
        [_saveImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(_nameLabel.mas_bottom).with.offset(20);
            make.left.mas_equalTo(_zanImageView.mas_right).with.offset(frame.size.width/9);
            make.size.mas_equalTo(CGSizeMake(frame.size.width/9, frame.size.width/9));
            
        }];
        
        //_saveLabel
        
        _saveLabel = [[UILabel alloc]init];
        _saveLabel.text = @"16";
        _saveLabel.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:_saveLabel];
        [_saveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_saveImageView.mas_bottom).with.offset(10);
            make.left.mas_equalTo(_saveImageView.mas_left);
            make.size.mas_equalTo(CGSizeMake(frame.size.width/9, 20));
            
        }];

        //_messageImageView
        
        _messageImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"message"]];
        [backView addSubview:_messageImageView];
        [_messageImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_nameLabel.mas_bottom).with.offset(20);
            make.left.mas_equalTo(_saveImageView.mas_right).with.offset(frame.size.width/9);
            make.size.mas_equalTo(CGSizeMake(frame.size.width/9, frame.size.width/9));
            
        }];
        
        //_messageLabel
        
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.text = @"35";
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:_messageLabel];
        [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_messageImageView.mas_bottom).with.offset(10);
            make.left.mas_equalTo(_saveImageView.mas_right).with.offset(frame.size.width/9);
            make.size.mas_equalTo(CGSizeMake(frame.size.width/9, 20));
            
        }];
        
        
        
        //_sourceLabel
        
        _sourceLabel = [[UILabel alloc]init];
        _sourceLabel.textAlignment = NSTextAlignmentCenter;
        _sourceLabel.layer.cornerRadius = 5.f;
        _sourceLabel.layer.masksToBounds = YES;
        _sourceLabel.backgroundColor = [UIColor lightGrayColor];
        [backView addSubview:_sourceLabel];
        [_sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-30);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(frame.size.width/9*3, frame.size.width/9*3/4*1));
            
        }];

    }
    return self;
}

@end
