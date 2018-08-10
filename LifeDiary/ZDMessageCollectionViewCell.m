//
//  ZDMessageCollectionViewCell.m
//  LifeDiary
//
//  Created by Jack on 2018/8/1.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDMessageCollectionViewCell.h"

@implementation ZDMessageCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
//        self.contentView.layer.cornerRadius = 13.f;
//        self.contentView.layer.masksToBounds = YES;
        self.contentView.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
//        self.contentView.backgroundColor = [UIColor blueColor];
       
        
       
        
        [self.contentView addSubview:self.shadowView];
        
        [self.shadowView addSubview:self.exhibitView];
        
        [self.exhibitView addSubview:self.nameLabel];
        
        [self.exhibitView addSubview:self.pictureImageView];
        
        [self.exhibitView addSubview:self.remarkLabel];
        
        
//        // _remainderTimeLabel
//        _remainderTimeLabel = [[UILabel alloc]init];
//        _remainderTimeLabel.textColor = GOLDCOLOR;
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
//        //_sumLabel
//        _sumLabel = [[UILabel alloc]init];
//        _sumLabel.textColor = [UIColor blackColor];

        
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

//- (void)setSelected:(BOOL)selected{
//    [super setSelected:selected];
//    if (selected) {
//        //选中时
////        self.contentView.backgroundColor = [UIColor grayColor];
//        self.contentView.alpha = 0.7f;
//    }else{
//        //非选中
////        self.contentView.backgroundColor = [UIColor whiteColor];
//        self.contentView.alpha = 1.0f;
//    }
//
//    // Configure the view for the selected state
//}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.contentView.frame = CGRectMake(10, 10, self.frame.size.width-10*2, self.frame.size.height-10*2);
    _exhibitView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
  
    _nameLabel.frame = CGRectMake(10, 10, self.frame.size.width-20, 30);
    _remarkLabel.frame = CGRectMake(10,  _nameLabel.frame.origin.y+ _nameLabel.frame.size.height+10, self.frame.size.width-20-10, 20);
    _pictureImageView.frame = CGRectMake(10, _remarkLabel.frame.origin.y+ _remarkLabel.frame.size.height+10, self.contentView.frame.size.width-10*2, self.contentView.frame.size.height-30-20-10*4-10);
}
- (UIView *)shadowView{
    if (_shadowView == nil) {

        //_shadowView
        _shadowView = [[UIView alloc]init];
        _shadowView.backgroundColor = [UIColor purpleColor];
        _shadowView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        _shadowView.layer.shadowOffset = CGSizeMake(0, 0);
        _shadowView.layer.shadowRadius = 4 ;
        _shadowView.layer.shadowOpacity = 0.8;
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
@end
