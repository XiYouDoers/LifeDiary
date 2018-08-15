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
        

        //_tabImageView
        _tabImageView = [[UIImageView alloc]init];
        _tabImageView.image = [UIImage imageNamed:@"arrow"];
        [self addSubview:_tabImageView];
        [_tabImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-5);
            make.size.mas_equalTo(CGSizeMake(8, 15));
            make.right.mas_equalTo(-40);
        }];
        
        
        //_tabLabel
        _tabLabel = [[UILabel alloc]init];
        [self addSubview:_tabLabel];
        [_tabLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-5 );
            make.size.mas_equalTo(CGSizeMake(60, 20));
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
