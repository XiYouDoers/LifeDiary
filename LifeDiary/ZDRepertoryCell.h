//
//  ZDRepertoryCell.h
//  LifeDiary
//
//  Created by Jack on 2018/9/2.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDRepertoryCell : UITableViewCell

@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UILabel *remarkLabel;
@property(nonatomic,strong) UIImageView *pictureImageView;
@property(nonatomic,strong) UILabel *dateOfstartLabel;
@property(nonatomic,strong) UILabel *dateOfEndLabel;
@property(nonatomic,strong) UILabel *saveTimeLabel;
@property(nonatomic,strong) UILabel *sumLabel;
@property (nonatomic,strong) UIView *shadowView;
@property (nonatomic,strong) UIView *exhibitView;
@property (nonatomic,strong) UILabel *classificationLabel;
@property (nonatomic,strong) UIView *manageView;
@property (nonatomic,strong) UIButton *deleteButton;
@property (nonatomic,strong) UIButton *editButton;

@end
