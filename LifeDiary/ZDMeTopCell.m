//
//  ZDMeTopCell.m
//  LifeDiary
//
//  Created by JACK on 2018/5/14.
//  Copyright © 2018年 JACK. All rights reserved.
//

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#import "ZDMeTopCell.h"

@implementation ZDMeTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //_headPictureImageView
    _headPictureImageView = [[UIImageView alloc]init];
    _headPictureImageView.frame = CGRectMake(WIDTH-80, 5, 70, 70);
    [self addSubview:_headPictureImageView];
    
    //_nameLabel
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.frame = CGRectMake(10, 5, 100, 20);
    [self addSubview:_nameLabel];
    
    //_personalitySignatureLabel
    _personalitySignatureLabel = [[UILabel alloc]init];
    _personalitySignatureLabel.frame = CGRectMake(10, 30, 100, 20);
    _personalitySignatureLabel.font = [UIFont systemFontOfSize:12];
    _personalitySignatureLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:_personalitySignatureLabel];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
