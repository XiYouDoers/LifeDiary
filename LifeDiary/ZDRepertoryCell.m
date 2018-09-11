//
//  ZDRepertoryCell.m
//  LifeDiary
//
//  Created by Jack on 2018/9/2.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDRepertoryCell.h"

@implementation ZDRepertoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithDisplayP3Red:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
        self.contentView.backgroundColor = [UIColor clearColor];
        
//        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        
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
        
    }
    return self;
}
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
@end
