//
//  ZDAllCell.m
//  LifeDiary
//
//  Created by JACK on 2018/6/24.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDAllCell.h"

@implementation ZDAllCell{
    CAShapeLayer *_outsideArc;
    CAShapeLayer *_insideArc;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        self.contentView.backgroundColor = [UIColor clearColor];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.shadowView];
        
        [self.shadowView addSubview:self.exhibitView];
        
        [self.exhibitView addSubview: self.nameLabel];
        
        [self.exhibitView addSubview: self.remarkLabel];
        
        [self.exhibitView addSubview: self.pictureImageView];
        
        [self.exhibitView addSubview: self.dateOfstartLabel];
        
        [self.exhibitView addSubview: self.dateOfEndLabel];
        
        [self.exhibitView addSubview: self.saveTimeLabel];
        
        [self.exhibitView addSubview: self.sumLabel];
        
        
//        _outsideArc =  [CAShapeLayer layer];
//        _outsideArc.fillColor = [UIColor clearColor].CGColor;
//        //圆弧的宽度
//        _outsideArc.lineWidth = 3.5f;
//        [self.layer addSublayer:_outsideArc];
//
//        _insideArc = [CAShapeLayer layer];
//        //圆弧边框的宽度
//        _insideArc.lineWidth = 0.f;
//        [self.layer addSublayer:_insideArc];
        
    }
    return self;
}
//- (void)setArc:(double )ratio saveTimeTimeInterval:(NSTimeInterval)timeInterval{
//
//    UIBezierPath *pathOfOutsideArc = [UIBezierPath bezierPathWithArcCenter:CGPointMake(WIDTH-40, 40) radius:16 startAngle:(1.5*M_PI) endAngle:1.49999*M_PI clockwise:true];
//
//    _outsideArc.path = [pathOfOutsideArc CGPath];
//    //外面圆弧的strokeColor
//    if (ratio<0.25) {
//        _outsideArc.strokeColor = [UIColor redColor].CGColor;
//    }else if(ratio<0.5){
//        _outsideArc.strokeColor = [UIColor yellowColor].CGColor;
//    }else if(ratio<0.75){
//        _outsideArc.strokeColor = [UIColor orangeColor].CGColor;
//    }else{
//        _outsideArc.strokeColor = [UIColor greenColor].CGColor;
//    }
//
//    UIBezierPath *pathOfInsideArc = [UIBezierPath bezierPathWithArcCenter:CGPointMake(WIDTH-40, 40) radius:13 startAngle:(1.5*M_PI) endAngle:ratio*M_PI clockwise:true];
//    _insideArc.path = [pathOfInsideArc CGPath];
//    int months = timeInterval/3600/24/30;
//    //里面圆弧的fillColor
//    if (months<6) {
//        _insideArc.fillColor = [UIColor redColor].CGColor;
//    }else if(months<12){
//        _insideArc.fillColor = [UIColor yellowColor].CGColor;
//    }else if(months<24){
//        _insideArc.fillColor = [UIColor orangeColor].CGColor;
//    }else{
//        _insideArc.fillColor = [UIColor greenColor].CGColor;
//    }
//    
//
//}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.contentView.frame = CGRectMake(10, 10, self.frame.size.width-10*2, self.frame.size.height-10*2);
    _exhibitView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.left.mas_equalTo(_pictureImageView.mas_right).with.offset(10);
        make.right.mas_offset(-10);
        make.height.mas_equalTo(20);
        
    }];
    [self.remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLabel.mas_bottom).mas_offset(@10);
        make.left.mas_equalTo(_pictureImageView.mas_right).with.offset(10);
        make.right.mas_offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    [self.pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(@10);
        make.left.mas_offset(@10);
        make.bottom.mas_offset(@-10);
        make.right.mas_offset(-WIDTH/5*3);
        
    }];
    
    [self.dateOfstartLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_remarkLabel.mas_bottom).mas_offset(5);
        make.left.equalTo(_pictureImageView.mas_right).mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    
    [self.dateOfEndLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_dateOfstartLabel.mas_bottom).mas_offset(5);
        make.left.equalTo(_pictureImageView.mas_right).mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    [self.saveTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_dateOfEndLabel.mas_bottom).mas_offset(10);
        make.bottom.mas_offset(-10);
        make.left.equalTo(_pictureImageView.mas_right).mas_offset(10);
        make.width.mas_equalTo(WIDTH/3);
    }];
    
}
- (UIView *)shadowView{
    if (_shadowView == nil) {
        //_shadowView
        _shadowView = [[UIView alloc]init];
        _shadowView.layer.shadowColor = [UIColor colorWithDisplayP3Red:210.0/255 green:210.0/255 blue:210.0/255 alpha:1].CGColor;;
        _shadowView.layer.shadowOffset = CGSizeMake(0, 10);
        _shadowView.layer.shadowRadius = 10;
        _shadowView.layer.shadowOpacity = 1;
        _shadowView.layer.shouldRasterize = YES;
    }
    return _shadowView;
}
- (UIView *)exhibitView{
    if (_exhibitView==nil) {
        //_exhibitView
        _exhibitView = [[UIView alloc]init];
        _exhibitView.backgroundColor = [UIColor whiteColor];
        _exhibitView.layer.cornerRadius = 13;
        _exhibitView.layer.masksToBounds = YES;
    }
    return _exhibitView;
}
- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        
    }
    return _nameLabel;
}
- (UILabel *)remarkLabel{
    if (!_remarkLabel) {
        _remarkLabel = [[UILabel alloc]init];
        _remarkLabel.font = [UIFont systemFontOfSize:11];
        _remarkLabel.textColor = [UIColor lightGrayColor];
        

    }
    return _remarkLabel;
}
- (UIImageView *)pictureImageView{
    if (!_pictureImageView) {
        //_pictureImageView
        _pictureImageView = [[UIImageView alloc]init];
        _pictureImageView.layer.cornerRadius = 5;
        _pictureImageView.layer.masksToBounds = true;
        
    }
    return _pictureImageView;
}
- (UILabel *)dateOfstartLabel{
    
    if (!_dateOfstartLabel) {
        _dateOfstartLabel = [[UILabel alloc]init];
        _dateOfstartLabel.textColor = [UIColor lightGrayColor];
        
    }
    return _dateOfstartLabel;
}
- (UILabel *)dateOfEndLabel{
    
    if (!_dateOfEndLabel) {
        _dateOfEndLabel = [[UILabel alloc]init];
        _dateOfEndLabel.textColor = GOLDCOLOR;
        
    }
    return _dateOfEndLabel;
}
- (UILabel *)saveTimeLabel{
    
    if (!_saveTimeLabel) {
        _saveTimeLabel = [[UILabel alloc]init];
        _saveTimeLabel.textColor = LIGHTBLUE;
        
    }
    return _saveTimeLabel;
}
- (UILabel *)sumLabel{
    if (!_sumLabel) {
        _sumLabel = [[UILabel alloc]init];
        _sumLabel.textColor = LIGHTBLUE;
        
    }
    return _sumLabel;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
