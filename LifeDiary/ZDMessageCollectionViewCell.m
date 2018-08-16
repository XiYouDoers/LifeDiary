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
        
        
        // _remainderTimeLabel
        _remainderTimeLabel = [[UILabel alloc]init];
        _remainderTimeLabel.textColor = GOLDCOLOR;
//        //        _remainderTimeLabel.translatesAutoresizingMaskIntoConstraints = NO;
////        [_detailView addSubview:_remainderTimeLabel];
//        
//        
//        //stpper
//        //可以设置x,y的位置，但是高和宽是固定的（80，40），即使设置为其他数值，也不会改变它的实际大小
//        _stepper = [[UIStepper alloc] init];
//        _stepper.tintColor = [UIColor whiteColor];
//        _stepper.backgroundColor = NAVIGATIONCOLOR;
//        _stepper.layer.cornerRadius = 16.f;
//        _stepper.layer.masksToBounds = YES;
//        //设置步进器的最小值
//        _stepper.minimumValue = 0;
//        //设置最大值
//        _stepper.maximumValue = 99;
//        //设置当前值
//        //        _stpper.value = 10;
//        //设置步进器每次的该变量
//        _stepper.stepValue = 1;
//        
//        /*
//         是否可以重复相应操作事件
//         当为YES的时候，按住步进器，步进器会连续相应它的点击事件
//         当为NO时，按住步进器，再松开，只会相应一次
//         */
//        _stepper.autorepeat = YES;
//        
//        /*
//         是否将步进结果通过事件函数相应出来
//         当值为YES的时候，按住步进器，-(void)setpChange；这个方法会连续调用；
//         当值为NO的时候，按住步进器，-(void)setpChange；这个方法只会在松开步进器才会有结果输出
//         */
//        _stepper.continuous = YES;
//        //        _stepper.translatesAutoresizingMaskIntoConstraints = NO;
////        [_detailView addSubview:_stepper];
//        
//        
        //_sumLabel
        _sumLabel = [[UILabel alloc]init];
        _sumLabel.textColor = [UIColor blackColor];

        
//        //_grayView
//        _grayView = [[UIView alloc]init];
//        _grayView.alpha = 0.5;
//        _grayView.layer.cornerRadius = 5;
//        _grayView.layer.masksToBounds = true;
//        _grayView.hidden = YES;
//        _grayView.backgroundColor = [UIColor lightGrayColor];
//        [self.contentView addSubview:_grayView];
        
    }
    
    return self;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.contentView.frame = CGRectMake(10, 10, self.frame.size.width-10*2, self.frame.size.height-10*2);
    _exhibitView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
  
    _nameLabel.frame = CGRectMake(10, 10, self.frame.size.width-20, 30);
    _remarkLabel.frame = CGRectMake(10,  _nameLabel.frame.origin.y+ _nameLabel.frame.size.height+10, self.frame.size.width-20-10, 20);
    _pictureImageView.frame = CGRectMake(10, _remarkLabel.frame.origin.y+ _remarkLabel.frame.size.height+10, self.contentView.frame.size.width-10*2, self.contentView.frame.size.height-30-20-10*4);
}
- (UIView *)shadowView{
    if (_shadowView == nil) {

        //_shadowView
        _shadowView = [[UIView alloc]init];
        _shadowView.layer.shadowColor = [UIColor colorWithDisplayP3Red:210.0/255 green:210.0/255 blue:210.0/255 alpha:1].CGColor;
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
        _exhibitView.layer.cornerRadius = 15;
        _exhibitView.layer.masksToBounds = YES;
    }
    return _exhibitView;
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
- (void)setData:(ZDGoods *)goods{
    
    self.nameLabel.text = goods.name;
    self.pictureImageView.image = [UIImage imageWithData:goods.imageData];
    self.remarkLabel.text = goods.remark;
    self.pictureImageView.image = [UIImage imageWithData:goods.imageData];
    
    NSDate *dateNow = [[NSDate alloc]init];
    NSDate *resDate = [_formatter dateFromString:goods.dateOfEnd];
    NSInteger seconds = [resDate timeIntervalSinceDate:dateNow]/(60*60*24);
    self.remainderTimeLabel.text = [NSString stringWithFormat:@"剩余：%ld天",seconds];
    self.sumLabel.text = [NSString stringWithFormat:@"数量：%@",goods.sum];
    //
    //计算出保质期的时间戳
    //        NSDate *dateOfStart = [_formatter dateFromString:goods.dateOfStart];
    //        NSDate *dateOfEnd = [_formatter dateFromString:goods.dateOfEnd];
    //        NSTimeInterval timeIntervalOfStart = [dateOfStart timeIntervalSince1970];
    //        NSTimeInterval timeIntervalOfEnd = [dateOfEnd timeIntervalSince1970];
    //        [_messageCollectionViewCell setArc:goods.ratio saveTimeTimeInterval:timeIntervalOfEnd-timeIntervalOfStart];
    //    _messageCollectionViewCell.stepper.tag = 200 + indexPath.row;
    //    _messageCollectionViewCell.stepper.value = [goods.sum doubleValue];
    //    [_messageCollectionViewCell.stepper addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    
    
}
@end
