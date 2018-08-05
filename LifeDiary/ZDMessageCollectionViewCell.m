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
   
        //_nameLabel
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont boldSystemFontOfSize:15];
        _nameLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_nameLabel];
       
        
        //_pictureImageView
        _pictureImageView = [[UIImageView alloc]init];
        _pictureImageView.layer.cornerRadius = 5;
        _pictureImageView.layer.masksToBounds = true;
        //        _pictureImageView.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:_pictureImageView];
        
        //_GrayColorView
        _GrayColorView = [[UIView alloc]init];
        _GrayColorView.alpha = 0.5;
        _GrayColorView.layer.cornerRadius = 5;
        _GrayColorView.layer.masksToBounds = true;
        _GrayColorView.hidden = YES;
        _GrayColorView.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:_GrayColorView];
        
        //_detailView
        _detailView = [[UIView alloc]init];
//         _detailView.translatesAutoresizingMaskIntoConstraints = NO;
        _detailView.backgroundColor = [UIColor whiteColor];
        _detailView.hidden = YES;
        [self.contentView addSubview:_detailView];
        
        
        
//        //_remarkLabel
//        _remarkLabel = [[UILabel alloc]init];
//        _remarkLabel.textAlignment = NSTextAlignmentRight;
//        _remarkLabel.numberOfLines = 0;
//        _remarkLabel.font = [UIFont systemFontOfSize:15];
//        _remarkLabel.textColor = [UIColor blackColor];
//        [_detailView addSubview:_remarkLabel];
//        [_remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(5);
//            make.right.mas_offset(-10);
//            make.size.mas_equalTo(CGSizeMake(150, 40));
//        }];
        
       
        
        
        // _remainderTimeLabel
        _remainderTimeLabel = [[UILabel alloc]init];
        _remainderTimeLabel.textColor = GOLDCOLOR;
//        _remainderTimeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_detailView addSubview:_remainderTimeLabel];
        
        
        //stpper
        //可以设置x,y的位置，但是高和宽是固定的（80，40），即使设置为其他数值，也不会改变它的实际大小
        _stepper = [[UIStepper alloc] init];
        _stepper.tintColor = [UIColor whiteColor];
        _stepper.backgroundColor = NAVIGATIONCOLOR;
        _stepper.layer.cornerRadius = 16.f;
        _stepper.layer.masksToBounds = YES;
        //设置步进器的最小值
        _stepper.minimumValue = 0;
        //设置最大值
        _stepper.maximumValue = 99;
        //设置当前值
        //        _stpper.value = 10;
        //设置步进器每次的该变量
        _stepper.stepValue = 1;
        
        /*
         是否可以重复相应操作事件
         当为YES的时候，按住步进器，步进器会连续相应它的点击事件
         当为NO时，按住步进器，再松开，只会相应一次
         */
        _stepper.autorepeat = YES;
        
        /*
         是否将步进结果通过事件函数相应出来
         当值为YES的时候，按住步进器，-(void)setpChange；这个方法会连续调用；
         当值为NO的时候，按住步进器，-(void)setpChange；这个方法只会在松开步进器才会有结果输出
         */
        _stepper.continuous = YES;
//        _stepper.translatesAutoresizingMaskIntoConstraints = NO;
        [_detailView addSubview:_stepper];
        
        
        //_sumLabel
        _sumLabel = [[UILabel alloc]init];
        _sumLabel.textColor = [UIColor blackColor];
//        _sumLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_detailView addSubview:_sumLabel];
       
        
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];

    _nameLabel.frame = CGRectMake(5, 5, self.frame.size.width-10, 30);
     _pictureImageView.frame = CGRectMake(5, 40, self.frame.size.width-5*2, self.frame.size.height-40-5*2);
    
     _GrayColorView.frame = _pictureImageView.frame;
    
    
    if (self.frame.size.width > 300) {
        _detailView.frame = CGRectMake(_pictureImageView.frame.origin.x, _pictureImageView.frame.origin.y+_pictureImageView.frame.size.height/4*1.5, _pictureImageView.frame.size.width, _pictureImageView.frame.size.height/4);
    }else{
        _detailView.frame = CGRectMake(_pictureImageView.frame.origin.x, _pictureImageView.frame.origin.y+_pictureImageView.frame.size.height/5, _pictureImageView.frame.size.width, _pictureImageView.frame.size.height/5*3);
    }
    
    if (self.frame.size.width > 300 ) {
    _remainderTimeLabel.frame = CGRectMake(20, 10, 150, 30);
        
         _stepper.frame = CGRectMake(_detailView.frame.size.width-100-10, 10, 100, 30);
        
        _sumLabel.frame = CGRectMake(_stepper.frame.origin.x -_stepper.frame.size.width-20, _stepper.frame.origin.y, 100, 30);
        _sumLabel.textAlignment = NSTextAlignmentRight;
    }else{
    _remainderTimeLabel.frame = CGRectMake(5, 10, 100, 30);
        
        _stepper.frame = CGRectMake(_detailView.frame.size.width-100-2, _detailView.frame.size.height-30-10, 100, 30);
        _sumLabel.textAlignment = NSTextAlignmentLeft;
        _sumLabel.frame = CGRectMake(5, _detailView.frame.size.height-30-10, 100, 30);
    }
   
    
   
    
}
@end
