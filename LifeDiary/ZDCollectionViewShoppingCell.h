//
//  ZDCollectionViewShoppingCell.h
//  LifeDiary
//
//  Created by Jack on 2018/7/24.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDOrderModel.h"

@interface ZDCollectionViewShoppingCell : UICollectionViewCell
@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UILabel *sourceLabel;
@property(nonatomic,strong) UIImageView *zanImageView;
@property(nonatomic,strong) UILabel *zanLabel;
@property(nonatomic,strong) UIImageView *priceImageView;
@property(nonatomic,strong) UILabel *priceLabel;

/**
 更新cell
 */
- (void)updateCell:(ZDContentlistModel *)contentlistModel;

@end
