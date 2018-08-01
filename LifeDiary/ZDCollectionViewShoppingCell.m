//
//  ZDCollectionViewShoppingCell.m
//  LifeDiary
//
//  Created by Jack on 2018/7/24.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDCollectionViewShoppingCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ZDCollectionViewShoppingCell
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
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor blackColor];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_nameLabel.mas_bottom).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(self.frame.size.width-20, 0.5));
            make.left.mas_equalTo(10);
        }];
        
        //_zanImageView
        
        _zanImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zan"]];
        [backView addSubview:_zanImageView];
        [_zanImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_nameLabel.mas_bottom).with.offset(20);
            make.left.mas_equalTo(self.frame.size.width/9*3);
            make.size.mas_equalTo(CGSizeMake(frame.size.width/9, frame.size.width/9));
            
        }];
        
        
        //_zanLabel
        
        _zanLabel = [[UILabel alloc]init];
        _zanLabel.text = @"99" ;
        _zanLabel.textAlignment = NSTextAlignmentLeft;
        [backView addSubview:_zanLabel];
        [_zanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_nameLabel.mas_bottom).with.offset(20);
            make.left.mas_equalTo(self.frame.size.width/9*5);
            make.size.mas_equalTo(CGSizeMake(frame.size.width/9, frame.size.width/9));
            
        }];
        
        //priceImageView
        
        _priceImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"price"]];
        [backView addSubview:_priceImageView];
        [_priceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_zanImageView.mas_bottom).with.offset(10);
            make.left.mas_equalTo(self.frame.size.width/9*3);
            make.size.mas_equalTo(CGSizeMake(frame.size.width/9, frame.size.width/9));
            
        }];
        
        //_priceLabel
        
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        [backView addSubview:_priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_zanImageView.mas_bottom).with.offset(10);
            make.left.mas_equalTo(self.frame.size.width/9*5);
            make.size.mas_equalTo(CGSizeMake(frame.size.width/9*3, frame.size.width/9));
            
        }];
        
        //_sourceLabel
        
        _sourceLabel = [[UILabel alloc]init];
        _sourceLabel.textAlignment = NSTextAlignmentCenter;
        _sourceLabel.layer.cornerRadius = 5.f;
        _sourceLabel.layer.masksToBounds = YES;
        _sourceLabel.backgroundColor = [UIColor lightGrayColor];
        [backView addSubview:_sourceLabel];
        [_sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-20);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(frame.size.width/9*3, frame.size.width/9*3/4*1));
            
        }];
        
    }
    return self;
}

- (void)updateCell:(ZDContentlistModel *)contentlistModel{
    
   
}



@end
