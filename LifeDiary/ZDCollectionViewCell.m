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
        [backView addSubview:_imageView];
        
        
        //_nameLabel
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width-100)/2, self.frame.size.height/5*3+30, 100, 20)];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:_nameLabel];
        
        //_zanImageView
        _zanImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zan"]];
        _zanImageView.frame = CGRectMake(60, self.frame.size.height/5*3+50+20, 40, 40);
        [backView addSubview:_zanImageView];
        //_zanLabel
        _zanLabel = [[UILabel alloc]init];
        _zanLabel.frame = CGRectMake(60, self.frame.size.height/5*3+50+65, 40, 20);
        _zanLabel.text = @"24";
        _zanLabel.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:_zanLabel];
        
        //_saveImageView
        _saveImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"save"]];
        _saveImageView.frame = CGRectMake(60+70, self.frame.size.height/5*3+50+20, 40, 40);
        [backView addSubview:_saveImageView];
        //_saveLabel
        _saveLabel = [[UILabel alloc]init];
        _saveLabel.frame = CGRectMake(60+70, self.frame.size.height/5*3+50+65, 40, 20);
        _saveLabel.text = @"16";
        _saveLabel.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:_saveLabel];

        //_messageImageView
        _messageImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"message"]];
        _messageImageView.frame = CGRectMake(60+70+70, self.frame.size.height/5*3+50+20,40, 40);
        [backView addSubview:_messageImageView];
        //_messageLabel
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.frame = CGRectMake(60+70+70, self.frame.size.height/5*3+50+65, 40, 20);
        _messageLabel.text = @"35";
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:_messageLabel];
        
        //_sourceLabel
        _sourceLabel = [[UILabel alloc]init];
        _sourceLabel.frame = CGRectMake((self.frame.size.width-100)/2, self.frame.size.height-50, 100, 30);
        _sourceLabel.text = @"JingDong";
        _sourceLabel.textAlignment = NSTextAlignmentCenter;
        _sourceLabel.layer.cornerRadius = 5.f;
        _sourceLabel.layer.masksToBounds = YES;
        _sourceLabel.backgroundColor = [UIColor lightGrayColor];
        [backView addSubview:_sourceLabel];

    }
    return self;
}
@end
