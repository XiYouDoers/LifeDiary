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

@implementation ZDMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //_nameLabel
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.frame = CGRectMake(WIDTH/2+20, 10, 100, 20);
        [self addSubview:_nameLabel];
        
        //_remarkLabel
        _remarkLabel = [[UILabel alloc]init];
        _remarkLabel.frame = CGRectMake(WIDTH/2+20, 35, 100, 20);
        _remarkLabel.font = [UIFont systemFontOfSize:11];
        _remarkLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:_remarkLabel];
        
        //_pictureImageView
        _pictureImageView = [[UIImageView alloc]init];
        _pictureImageView.frame = CGRectMake(5, 5, WIDTH/2-10, HEIGHT-10);
        [self addSubview:_pictureImageView];
        
        //_dateOfstartLabel
        _dateOfstartLabel = [[UILabel alloc]init];
        _dateOfstartLabel.frame = CGRectMake(WIDTH/2+20, 60, 100, 20);
        _dateOfstartLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:_dateOfstartLabel];
        
        //_dateOfEndLabel
        _dateOfEndLabel = [[UILabel alloc]init];
        _dateOfEndLabel.frame = CGRectMake(WIDTH/2+20, 95, 100, 20);
        _dateOfEndLabel.textColor = [UIColor redColor];
        [self addSubview:_dateOfEndLabel];
        
        CAShapeLayer *solidLine;
        solidLine =  [CAShapeLayer layer];
        //圆弧的宽度
        solidLine.lineWidth = 3.5f;
        //圆弧的颜色
        solidLine.strokeColor = [UIColor orangeColor].CGColor;
        //背景填充色
        solidLine.fillColor = [UIColor clearColor].CGColor;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(WIDTH/2+20, 90) radius:16 startAngle:(1.5*M_PI) endAngle:0*M_PI clockwise:true];
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
