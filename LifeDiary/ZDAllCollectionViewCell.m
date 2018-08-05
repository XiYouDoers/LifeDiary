//
//  ZDAllCollectionViewCell.m
//  LifeDiary
//
//  Created by Jack on 2018/7/30.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDAllCollectionViewCell.h"

@implementation ZDAllCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        //_pictureImageView
        _pictureImageView = [[UIImageView alloc]init];
        _pictureImageView.layer.cornerRadius = 5;
        _pictureImageView.layer.masksToBounds = true;
        [self addSubview:_pictureImageView];
        [_pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(5);
            make.left.mas_offset(5);
            make.bottom.mas_offset(-5);
            make.right.mas_offset(-5);
            
        }];
        //_nameLabel
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont boldSystemFontOfSize:23];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = [UIColor whiteColor];
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(80, 60));
        }];
    }
    return self;
}
@end
