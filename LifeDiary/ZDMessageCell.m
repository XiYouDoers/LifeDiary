//
//  ZDMessageCell.m
//  LifeDiary
//
//  Created by JACK on 2018/5/14.
//  Copyright © 2018年 JACK. All rights reserved.
//
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#import "ZDMessageCell.h"
#import "Masonry.h"

@implementation ZDMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //_pictureImageView
        _pictureImageView = [[UIImageView alloc]init];
        _pictureImageView.layer.cornerRadius = 5;
        _pictureImageView.layer.masksToBounds = true;
        [self addSubview:_pictureImageView];
        [_pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(@10);
            make.left.mas_offset(@10);
            make.bottom.mas_offset(@-10);
            make.right.mas_offset(-WIDTH/5*3);
            
        }];
        //_nameLabel
        _nameLabel = [[UILabel alloc]init];
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(10);
            make.left.mas_equalTo(_pictureImageView.mas_right).with.offset(10);
            make.right.mas_offset(-10);
            make.height.mas_equalTo(20);
            
        }];
        //_remarkLabel
        _remarkLabel = [[UILabel alloc]init];
        _remarkLabel.font = [UIFont systemFontOfSize:11];
        _remarkLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:_remarkLabel];
        [_remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_nameLabel.mas_bottom).mas_offset(@10);
            make.left.mas_equalTo(_pictureImageView.mas_right).with.offset(10);
            make.right.mas_offset(-10);
            make.height.mas_equalTo(20);
        }];
        
        //_dateOfstartLabel
        _dateOfstartLabel = [[UILabel alloc]init];
        _dateOfstartLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:_dateOfstartLabel];
        [_dateOfstartLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_remarkLabel.mas_bottom).mas_offset(5);
            make.left.equalTo(_pictureImageView.mas_right).mas_offset(10);
            make.right.mas_offset(-10);
            make.height.mas_equalTo(20);
        }];
        
        //_dateOfEndLabel
        _dateOfEndLabel = [[UILabel alloc]init];
        _dateOfEndLabel.textColor = [UIColor redColor];
        [self addSubview:_dateOfEndLabel];
        [_dateOfEndLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_dateOfstartLabel.mas_bottom).mas_offset(5);
            make.left.equalTo(_pictureImageView.mas_right).mas_offset(10);
            make.right.mas_offset(-10);
            make.height.mas_equalTo(20);
        }];
        //_saveTimeLabel
        _saveTimeLabel = [[UILabel alloc]init];
        _saveTimeLabel.textColor = [UIColor blueColor];
        [self addSubview:_saveTimeLabel];
        [_saveTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_dateOfEndLabel.mas_bottom).mas_offset(10);
            make.bottom.mas_offset(-10);
            make.left.equalTo(_pictureImageView.mas_right).mas_offset(10);
            make.right.mas_offset(-10);
        }];

        CAShapeLayer *solidLine;
        solidLine =  [CAShapeLayer layer];
        //圆弧的宽度
        solidLine.lineWidth = 3.5f;
        //圆弧的颜色
        solidLine.strokeColor = [UIColor orangeColor].CGColor;
        //背景填充色
        solidLine.fillColor = [UIColor clearColor].CGColor;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(WIDTH-50, 50) radius:16 startAngle:(1.5*M_PI) endAngle:0*M_PI clockwise:true];
        solidLine.path = [path CGPath];
        [self.layer addSublayer:solidLine];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
