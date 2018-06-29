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
        _tabImageView.frame = CGRectMake(10, 13, 19, 19);
        _tabImageView.image = [UIImage imageNamed:@"add"];
        [self addSubview:_tabImageView];
        
        
        //_tabLabel
        _tabLabel = [[UILabel alloc]init];
        _tabLabel.frame = CGRectMake(45, 10, 100, 25);
        [self addSubview:_tabLabel];
        

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
