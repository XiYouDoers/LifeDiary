//
//  ZDMeSwitchCell.m
//  LifeDiary
//
//  Created by Jack on 2018/9/2.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDMeSwitchCell.h"

@implementation ZDMeSwitchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        
        
        //_nightModeSwitch
        _nightModeSwitch = [[UISwitch alloc]init];
        [self.contentView addSubview:_nightModeSwitch];
        [_nightModeSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.right.mas_equalTo(-20);
        }];
        
        
        //_tabLabel
        _tabLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_tabLabel];
        [_tabLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-10 );
            make.size.mas_equalTo(CGSizeMake(100, 30));
            make.left.mas_equalTo(40);
        }];
        
        
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
