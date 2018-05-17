//
//  ZDMessageCell.h
//  LifeDiary
//
//  Created by JACK on 2018/5/14.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDMessageCell : UITableViewCell

@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UILabel *remarkLabel;
@property(nonatomic,strong) UIImageView *pictureImageView;
@property(nonatomic,strong) UILabel *dateOfstartLabel;
@property(nonatomic,strong) UILabel *dateOfEndLabel;
@property(nonatomic,strong) UILabel *saveTimeLabel;
@end