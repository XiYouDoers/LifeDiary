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
        

        
        //_nameLabel
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont boldSystemFontOfSize:22];

        [self addSubview:_nameLabel];
       
        //_remarkLabel
        _remarkLabel = [[UILabel alloc]init];
        _remarkLabel.textAlignment = NSTextAlignmentRight;
        _remarkLabel.numberOfLines = 0;
        _remarkLabel.font = [UIFont systemFontOfSize:15];
        _remarkLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:_remarkLabel];
      
        
        //_pictureImageView
        _pictureImageView = [[UIImageView alloc]init];
        _pictureImageView.layer.cornerRadius = 5;
        _pictureImageView.layer.masksToBounds = true;
        //        _pictureImageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_pictureImageView];
       
        
        
        // _remainderTimeLabel
        _remainderTimeLabel = [[UILabel alloc]init];
        _remainderTimeLabel.textColor = GOLDCOLOR;
        [self addSubview:_remainderTimeLabel];
       
        
        //_sumLabel
        _sumLabel = [[UILabel alloc]init];
        _sumLabel.textColor = NAVIGATIONCOLOR;
        _sumLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_sumLabel];
       
        
        //stpper
        //可以设置x,y的位置，但是高和宽是固定的（80，40），即使设置为其他数值，也不会改变它的实际大小
        _stepper = [[UIStepper alloc] init];
        _stepper.tintColor = [UIColor colorWithRed:91.0/255 green:0.0/255 blue:220.0/255 alpha:1];
        
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
        [self addSubview:_stepper];
      
        
        
        //_outsideArc
        _outsideArc =  [CAShapeLayer layer];
        _outsideArc.fillColor = [UIColor clearColor].CGColor;
          //圆弧的宽度
        _outsideArc.lineWidth = 3.5f;
        [self.layer addSublayer:_outsideArc];
        //_insideArc
        _insideArc = [CAShapeLayer layer];
          //圆弧边框的宽度
        _insideArc.lineWidth = 0.f;
        [self.layer addSublayer:_insideArc];

    }
    return self;
}

- (void) layoutSubviews{
    [super layoutSubviews];

    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
        
    }];
    
    [_remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.right.mas_offset(-10);
        make.size.mas_equalTo(CGSizeMake(150, 40));
    }];
    
    [_pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(50);
        make.left.mas_offset(10);
        make.bottom.mas_offset(-50);
        make.right.mas_offset(-10);
        
    }];
    
    [_remainderTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_offset(-10);
        make.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(WIDTH/4, 30));
    }];
    
    
    [_sumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-10);
        make.left.mas_equalTo(_remainderTimeLabel.mas_right).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(WIDTH/5, 30));
    }];
    
    [_stepper mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-10);
        make.left.mas_equalTo(_sumLabel.mas_right).with.offset(5);
        
    }];
}
- (void)setArc:(double )ratio saveTimeTimeInterval:(NSTimeInterval)timeInterval{
    
    UIBezierPath *pathOfOutsideArc = [UIBezierPath bezierPathWithArcCenter:CGPointMake(WIDTH-40, 400-25) radius:16 startAngle:(1.5*M_PI) endAngle:1.49999*M_PI clockwise:true];

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

    UIBezierPath *pathOfInsideArc = [UIBezierPath bezierPathWithArcCenter:CGPointMake(WIDTH-40, 400-25) radius:13 startAngle:(1.5*M_PI) endAngle:ratio*M_PI clockwise:true];
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
