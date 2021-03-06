//
//  ZDHtmlScrollView.h
//  LifeDiary
//
//  Created by Jack on 2018/8/1.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZDContentlistModel;
@interface ZDHtmlScrollView : UIScrollView

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *sourceLabel;
@property(nonatomic,strong) UIImageView *headImageView;
@property(nonatomic,strong) UIImageView *footImageView;
@property(nonatomic,strong) UILabel *htmlLabel;

-(void)updateHtmlView:(ZDContentlistModel *)contentlistModel;

@end
