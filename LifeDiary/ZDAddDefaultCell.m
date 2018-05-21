//
//  ZDAddDefaultCell.m
//  LifeDiary
//
//  Created by JACK on 2018/5/14.
//  Copyright © 2018年 JACK. All rights reserved.
//
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#import "ZDAddDefaultCell.h"

@implementation ZDAddDefaultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        //_tabImageView
        _tabImageView = [[UIImageView alloc]init];
        _tabImageView.frame = CGRectMake(10, 13, 19, 19);
        _tabImageView.image = [UIImage imageNamed:@"add"];
        [self addSubview:_tabImageView];
        
        
        //_tabLabel
        _tabLabel = [[UILabel alloc]init];
        _tabLabel.frame = CGRectMake(45, 10, 100, 25);
        [self addSubview:_tabLabel];
        
        //_textField
        _textField = [[UITextField alloc]init];
        _textField.frame = CGRectMake(150, 10, 150, 25);
        [self addSubview:_textField];
        
              //_datePicker
        _datePicker = [[UIDatePicker alloc]init];
        _datePicker.frame = CGRectMake(0, HEIGHT/4*3, WIDTH, HEIGHT/4);
         _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        _datePicker.layer.backgroundColor = [UIColor whiteColor].CGColor;
        _datePicker.layer.masksToBounds = YES;
        _textField.inputView = _datePicker;

    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
