//
//  ZDHighTabBar.h
//  LifeDiary
//
//  Created by Jack on 2018/8/24.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>
//tab页面个数
typedef NS_ENUM(NSInteger, SamItemUIType) {
    SamItemUIType_Three = 3,//底部3个选项
    SamItemUIType_Five = 5,//底部5个选项
};
@class ZDHighTabBar;
@protocol ZDHighTabBarDelegate <NSObject>

-(void)tabBar:(ZDHighTabBar *)tabBar clickCenterButton:(UIButton *)sender;

@end

@interface ZDHighTabBar : UITabBar
@property (nonatomic, weak) id<ZDHighTabBarDelegate> tabDelegate;
@property (nonatomic, strong) NSString *centerBtnTitle;
@property (nonatomic, strong) NSString *centerBtnIcon;

+(instancetype)instanceCustomTabBarWithType:(SamItemUIType)type;

@end
