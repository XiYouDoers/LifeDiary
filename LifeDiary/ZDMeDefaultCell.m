//
//  ZDMeDefaultCell.m
//  LifeDiary
//
//  Created by JACK on 2018/5/20.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDMeDefaultCell.h"

@implementation ZDMeDefaultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:244.0/255 alpha:1];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.cornerRadius = 15.f;
        self.contentView.layer.masksToBounds = YES;
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.bottom.mas_equalTo(-5);
            make.left.mas_equalTo(5);
            make.right.mas_equalTo(-5);
        }];
        //_tabImageView
        _tabImageView = [[UIImageView alloc]init];
        _tabImageView.image = [UIImage imageNamed:@"arrow"];
        [self.contentView addSubview:_tabImageView];
        [_tabImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-18);
            make.top.mas_equalTo(18);
            make.right.mas_equalTo(-40);
            make.width.mas_equalTo(8);
        }];
        
        
        //_tabLabel
        _tabLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_tabLabel];
        [_tabLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-10 );
            make.width.mas_equalTo(100);
            make.top.mas_equalTo(10);
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
