//
//  ZDCollectionViewCell.h
//  LifeDiary
//
//  Created by JACK on 2018/5/31.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZDContentlistModel;
@interface ZDCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UIImageView *zanImageView;
@property(nonatomic,strong) UIImageView *messageImageView;
@property(nonatomic,strong) UIImageView *saveImageView;
@property(nonatomic,strong) UILabel *zanLabel;
@property(nonatomic,strong) UILabel *messageLabel;
@property(nonatomic,strong) UILabel *saveLabel;
@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UILabel *sourceLabel;


/**
 更新cell
 */
- (void)updateCell:(ZDContentlistModel *)contentlistModel;

@end
