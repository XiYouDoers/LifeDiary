//
//  ZDMessageCollectionViewCell.m
//  LifeDiary
//
//  Created by Jack on 2018/8/1.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDMessageCollectionViewCell.h"
#import "ZDGoods.h"
extern NSDateFormatter const *_formatter;
@interface ZDMessageCollectionViewCell(){
    CAShapeLayer *_outsideArc;
}
@end

@implementation ZDMessageCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
//         self.contentView.backgroundColor = [UIColor colorWithDisplayP3Red:250.0/255 green:250.0/255 blue:250.0/255 alpha:1];
        self.contentView.backgroundColor = [UIColor clearColor];

        
        [self.contentView addSubview:self.shadowView];
        
        [self.shadowView addSubview:self.exhibitView];
        
        
        [self.exhibitView addSubview:self.nameLabel];
        
        [self.exhibitView addSubview:self.pictureImageView];
        
        [self.exhibitView addSubview:self.remarkLabel];
        
        //_outsideArc
        _outsideArc =  [CAShapeLayer layer];
        _outsideArc.fillColor = [UIColor clearColor].CGColor;
            //圆弧的宽度
        [self.layer addSublayer:_outsideArc];
        
        [self.exhibitView addSubview:self.remainderTimeLabel];
    }
    return self;
}
- (void)setArc:(double )ratio saveTimeTimeInterval:(NSTimeInterval)timeInterval{
    UIBezierPath *pathOfOutsideArc ;
    if (self.frame.size.width > 200) {
        pathOfOutsideArc = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width-40,40) radius:16 startAngle:(1.5*M_PI) endAngle:1.49999*M_PI clockwise:true];
        _outsideArc.lineWidth = 3.5f;
        _remainderTimeLabel.frame = CGRectMake(self.frame.size.width-65, 15, 30, 30);
    }else{
        pathOfOutsideArc = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width-30,35) radius:12 startAngle:(1.5*M_PI) endAngle:1.49999*M_PI clockwise:true];
        _outsideArc.lineWidth = 2.5f;
        _remainderTimeLabel.frame = CGRectMake(self.frame.size.width-55, 10, 30, 30);
        _remainderTimeLabel.font = [UIFont systemFontOfSize:12];
    }
   
    _outsideArc.path = [pathOfOutsideArc CGPath];
    //外面圆弧的strokeColor
    if (ratio<0.25) {
        _outsideArc.strokeColor = [UIColor colorWithRed:255/255.0 green:117/255.0 blue:163/255.0 alpha:1].CGColor;
         _remainderTimeLabel.textColor = [UIColor colorWithRed:255/255.0 green:117/255.0 blue:163/255.0 alpha:1];
    }else if(ratio<0.5){
        _outsideArc.strokeColor = [UIColor yellowColor].CGColor;
        _remainderTimeLabel.textColor = [UIColor yellowColor];
    }else if(ratio<0.75){
        _outsideArc.strokeColor = [UIColor orangeColor].CGColor;
        _remainderTimeLabel.textColor = [UIColor orangeColor];
    }else{
        _outsideArc.strokeColor = [UIColor greenColor].CGColor;
        _remainderTimeLabel.textColor = [UIColor greenColor];
    }
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.contentView.frame = CGRectMake(10, 10, self.frame.size.width-10*2, self.frame.size.height-10*2);
    _exhibitView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    _imageView.frame =  _exhibitView.frame;
    _nameLabel.frame = CGRectMake( 15, 10, self.frame.size.width-90, 30);
    _remarkLabel.frame = CGRectMake(15,  _nameLabel.frame.origin.y+ _nameLabel.frame.size.height+5, self.frame.size.width-20-10, 15);
    _pictureImageView.frame = CGRectMake(10, _remarkLabel.frame.origin.y+ _remarkLabel.frame.size.height+10, self.contentView.frame.size.width-10*2, self.contentView.frame.size.height-30-10-10*4);
    
}
- (UIView *)shadowView{
    if (_shadowView == nil) {

        //_shadowView
        _shadowView = [[UIView alloc]init];
        _shadowView.layer.shadowColor = [UIColor colorWithDisplayP3Red:210.0/255 green:210.0/255 blue:210.0/255 alpha:1].CGColor;
        _shadowView.layer.shadowOffset = CGSizeMake(0, 10);
        _shadowView.layer.shadowRadius = 10;
        _shadowView.layer.shadowOpacity = 1;
        _shadowView.layer.shouldRasterize = NO;
    }
    return _shadowView;
}
- (UIView *)exhibitView{
    if (_exhibitView==nil) {
        //_exhibitView
        _exhibitView = [[UIView alloc]init];
        _exhibitView.backgroundColor = [UIColor whiteColor];
        _exhibitView.layer.cornerRadius = 15;
        _exhibitView.layer.masksToBounds = YES;
        
    }
    return _exhibitView;
}
- (UIImageView *)imageView{
    
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]initWithFrame:self.frame];
        UIBlurEffect* effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleProminent];
        UIVisualEffectView* effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = _imageView.bounds;
        [_imageView addSubview:effectView];
    }
    return _imageView;
}
- (UILabel *)nameLabel{
    
    if (_nameLabel==nil) {
        
        //_nameLabel
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont boldSystemFontOfSize:18];
        _nameLabel.textColor = [UIColor blackColor];
    }
    return _nameLabel;
}
- (UIImageView *)pictureImageView{
    
    if (_pictureImageView == nil) {
        //_pictureImageView
        _pictureImageView = [[UIImageView alloc]init];
        _pictureImageView.layer.cornerRadius = 5;
        _pictureImageView.layer.masksToBounds = true;
        //        _pictureImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _pictureImageView;
}
- (UILabel *)remarkLabel{
    if (_remarkLabel == nil) {
        //_remarkLabel
        _remarkLabel = [[UILabel alloc]init];
        _remarkLabel.textAlignment = NSTextAlignmentLeft;
        _remarkLabel.numberOfLines = 0;
        _remarkLabel.font = [UIFont systemFontOfSize:17];
        _remarkLabel.textColor = [UIColor lightGrayColor];
    }
    return _remarkLabel;
}
- (UILabel *)sumLabel{
    if (_sumLabel == nil) {
        //_sumLabel
        _sumLabel = [[UILabel alloc]init];
    }
    return _sumLabel;
}
- (UILabel *)remainderTimeLabel{
    
    if (_remainderTimeLabel == nil) {
        
        _remainderTimeLabel = [[UILabel alloc]init];
        _remainderTimeLabel.font = [UIFont systemFontOfSize:15];
        _remainderTimeLabel.textColor = [UIColor colorWithRed:255/255.0 green:117/255.0 blue:163/255.0 alpha:1];
        _remainderTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _remainderTimeLabel;
}
- (void)setData:(ZDGoods *)goods{
    
    self.imageView.image = [UIImage imageWithData:goods.imageData];
    self.nameLabel.text = goods.name;
    self.pictureImageView.image = [UIImage imageWithData:goods.imageData];
    self.remarkLabel.text = goods.remark;
    self.pictureImageView.image = [UIImage imageWithData:goods.imageData];
    
    NSDate *dateNow = [[NSDate alloc]init];
    NSDate *resDate = [_formatter dateFromString:goods.dateOfEnd];
    NSInteger seconds = [resDate timeIntervalSinceDate:dateNow]/(60*60*24);
    self.remainderTimeLabel.text = [NSString stringWithFormat:@"%ld",seconds];
    self.sumLabel.text = [NSString stringWithFormat:@"数量：%@",goods.sum];
    //计算出保质期的时间戳
            NSDate *dateOfStart = [_formatter dateFromString:goods.dateOfStart];
            NSDate *dateOfEnd = [_formatter dateFromString:goods.dateOfEnd];
            NSTimeInterval timeIntervalOfStart = [dateOfStart timeIntervalSince1970];
            NSTimeInterval timeIntervalOfEnd = [dateOfEnd timeIntervalSince1970];
            [self setArc:goods.ratio saveTimeTimeInterval:timeIntervalOfEnd - timeIntervalOfStart];
    //    _messageCollectionViewCell.stepper.tag = 200 + indexPath.row;
    //    _messageCollectionViewCell.stepper.value = [goods.sum doubleValue];
    //    [_messageCollectionViewCell.stepper addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    
    
}
@end
