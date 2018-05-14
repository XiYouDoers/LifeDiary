//
//  ZDAddDefaultCell.m
//  LifeDiary
//
//  Created by JACK on 2018/5/14.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDAddDefaultCell.h"

@implementation ZDAddDefaultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        //_addImageView
        _addImageView = [[UIImageView alloc]init];
        _addImageView.frame = CGRectMake(10, 10, 25, 25);
        _addImageView.image = [UIImage imageNamed:@"add"];
        [self addSubview:_addImageView];
        
        
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
