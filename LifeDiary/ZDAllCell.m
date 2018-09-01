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
        self.backgroundColor = [UIColor colorWithDisplayP3Red:250.0/255 green:250.0/255 blue:250.0/255 alpha:1];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self.contentView addSubview:self.manageView];
        
        [self.manageView addSubview:self.deleteButton];
        
        [self.manageView addSubview:self.editButton];
        
        [self.contentView addSubview:self.exhibitView];
        
//        [self.shadowView addSubview:self.exhibitView];
        
        [self.exhibitView addSubview: self.nameLabel];
        
        [self.exhibitView addSubview: self.remarkLabel];
        
        [self.exhibitView addSubview: self.pictureImageView];
        
        [self.exhibitView addSubview: self.dateOfstartLabel];
        
        [self.exhibitView addSubview: self.dateOfEndLabel];
        
        [self.exhibitView addSubview: self.saveTimeLabel];
        
        [self.exhibitView addSubview: self.sumLabel];
        
        [self.exhibitView addSubview: self.classificationLabel];
        
        
        
        
        
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
    _exhibitView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, 140);

    self.manageView.frame = CGRectMake(87.5, 100, 200, 40);
    self.deleteButton.frame = CGRectMake(0, 0, 100, 40);
    self.editButton.frame = CGRectMake(100, 0, 100, 40);
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.left.mas_equalTo(_pictureImageView.mas_right).with.offset(10);
        
        make.right.mas_offset(-50);
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
    [self.classificationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.right.mas_offset(-10);
        make.size.mas_equalTo(CGSizeMake(36, 36));
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
- (UILabel *)classificationLabel{
    if (_classificationLabel == nil) {
        _classificationLabel = [[UILabel alloc]init];
        _classificationLabel.textAlignment = NSTextAlignmentCenter;
        _classificationLabel.textColor = [UIColor whiteColor];
        _classificationLabel.text = @"食";
        _classificationLabel.backgroundColor = [UIColor colorWithRed:114/255.0 green:190/255.0 blue:246/255.0 alpha:1];
        _classificationLabel.layer.masksToBounds = YES;
        _classificationLabel.layer.cornerRadius = 18.f;
    }
    return _classificationLabel;
}
- (UIView *)manageView{
    if (_manageView == nil) {
        _manageView = [[UIView alloc]init];
        _manageView.backgroundColor = [UIColor whiteColor];
        _manageView.layer.masksToBounds = YES;
        _manageView.layer.cornerRadius = 5.f;
    }
    return _manageView;
}
- (UIButton *)deleteButton{
    if (_deleteButton == nil) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_deleteButton setBackgroundColor:[UIColor redColor]];
        [_deleteButton addTarget:self.delegate action:@selector(deleteButtonWasClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}
- (UIButton *)editButton{
    if (_editButton == nil) {
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
        [_editButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_editButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_editButton setBackgroundColor:[UIColor colorWithRed:114/255.0 green:190/255.0 blue:246/255.0 alpha:1]];
        [_editButton addTarget:self.delegate action:@selector(editButtonWasClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editButton;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
     self.manageView.frame = CGRectMake(87.5, 160, 200, 40);
}

@end
