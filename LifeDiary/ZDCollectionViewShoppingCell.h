//
//  ZDCollectionViewShoppingCell.h
//  LifeDiary
//
//  Created by Jack on 2018/7/24.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZDContentlistModel,ZDProductInfo;
@interface ZDCollectionViewShoppingCell : UICollectionViewCell
@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UIImageView *zanImageView;
@property(nonatomic,strong) UIImageView *messageImageView;
@property(nonatomic,strong) UIImageView *priceImageView;
@property(nonatomic,strong) UILabel *zanLabel;
@property(nonatomic,strong) UILabel *messageLabel;
@property(nonatomic,strong) UILabel *priceLabel;
@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UILabel *sourceLabel;

@property (nonatomic,strong) UIView *shadowView;
@property (nonatomic,strong) UIView *exhibitView;


/**
 更新cell
 */
- (void)updateCell:(ZDProductInfo *)productInfo;

@end
