//
//  ZDMessageCell.m
//  LifeDiary
//
//  Created by JACK on 2018/5/14.
//  Copyright © 2018年 JACK. All rights reserved.
//
#import "ZDMessageCell.h"


@implementation ZDMessageCell{
    CAShapeLayer *_outsideArc;
    CAShapeLayer *_insideArc;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //_pictureImageView
        _pictureImageView = [[UIImageView alloc]init];
        _pictureImageView.layer.cornerRadius = 5;
        _pictureImageView.layer.masksToBounds = true;
        _pictureImageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_pictureImageView];
        [_pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(50);
            make.left.mas_offset(0);
            make.bottom.mas_offset(-50);
            make.right.mas_offset(0);
            
        }];
        //_nameLabel
        _nameLabel = [[UILabel alloc]init];
        _remarkLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(10);
            make.left.mas_equalTo(20);
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(30);
            
        }];
        //_remarkLabel
        _remarkLabel = [[UILabel alloc]init];
        _remarkLabel.textAlignment = NSTextAlignmentRight;
        _remarkLabel.numberOfLines = 0;
        _remarkLabel.font = [UIFont systemFontOfSize:11];
        _remarkLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:_remarkLabel];
        [_remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.right.mas_offset(-10);
            make.size.mas_equalTo(CGSizeMake(150, 40));
        }];
        

        // _remainderTimeLabel
        _remainderTimeLabel = [[UILabel alloc]init];
        _remainderTimeLabel.textColor = RED;
        [self addSubview:_remainderTimeLabel];
        [_remainderTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.mas_offset(-10);
            make.left.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(WIDTH/3, 30));
        }];
        
        //_sumLabel
        _sumLabel = [[UILabel alloc]init];
        _sumLabel.textColor = LIGHTBLUE ;
        [self addSubview:_sumLabel];
        [_sumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(-10);
            make.left.mas_equalTo(_remainderTimeLabel.mas_right).with.offset(20);
            make.size.mas_equalTo(CGSizeMake(WIDTH/4, 30));
        }];

        _outsideArc =  [CAShapeLayer layer];
        _outsideArc.fillColor = [UIColor clearColor].CGColor;
        //圆弧的宽度
        _outsideArc.lineWidth = 3.5f;
        [self.layer addSublayer:_outsideArc];
        
        _insideArc = [CAShapeLayer layer];
        //圆弧边框的宽度
        _insideArc.lineWidth = 0.f;
        [self.layer addSublayer:_insideArc];

    }
    return self;
}
- (void)setArc:(double )ratio saveTimeTimeInterval:(NSTimeInterval)timeInterval{
    
    UIBezierPath *pathOfOutsideArc = [UIBezierPath bezierPathWithArcCenter:CGPointMake(WIDTH-40, 300-25) radius:16 startAngle:(1.5*M_PI) endAngle:1.49999*M_PI clockwise:true];

    _outsideArc.path = [pathOfOutsideArc CGPath];
    //外面圆弧的strokeColor
    if (ratio<0.25) {
        _outsideArc.strokeColor = [UIColor redColor].CGColor;
    }else if(ratio<0.5){
        _outsideArc.strokeColor = [UIColor yellowColor].CGColor;
    }else if(ratio<0.75){
        _outsideArc.strokeColor = [UIColor orangeColor].CGColor;
    }else{
        _outsideArc.strokeColor = [UIColor greenColor].CGColor;
    }

    UIBezierPath *pathOfInsideArc = [UIBezierPath bezierPathWithArcCenter:CGPointMake(WIDTH-40, 300-25) radius:13 startAngle:(1.5*M_PI) endAngle:ratio*M_PI clockwise:true];
    _insideArc.path = [pathOfInsideArc CGPath];
    int months = timeInterval/3600/24/30;
    //里面圆弧的fillColor
    if (months<6) {
        _insideArc.fillColor = [UIColor redColor].CGColor;
    }else if(months<12){
        _insideArc.fillColor = [UIColor yellowColor].CGColor;
    }else if(months<24){
        _insideArc.fillColor = [UIColor orangeColor].CGColor;
    }else{
        _insideArc.fillColor = [UIColor greenColor].CGColor;
    }
    

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
