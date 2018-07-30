//
//  ZDEditDefaultCell.m
//  LifeDiary
//
//  Created by Jack on 2018/7/28.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDEditDefaultCell.h"

@implementation ZDEditDefaultCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.tabImageView.image = [UIImage imageNamed:@"edit"];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
