//
//  ThemeManage.m
//  NightMode
//
//  Created by ZL on 2017/4/21.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "ThemeManage.h"

static ThemeManage *themeManage; // 单例


@implementation ThemeManage

#pragma mark - 单例的初始化

+ (ThemeManage *)shareThemeManage {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        themeManage = [[ThemeManage alloc] init];
    });
    return themeManage;
}

#pragma mark 重写isNight的set方法

- (void)setIsNight:(BOOL)isNight {
    
    _isNight = isNight;
    
    if (self.isNight) { // 夜间模式改变相关颜色
 
        self.bgColor = [UIColor colorWithRed:18/255.0 green:27/255.0 blue:66/255.0 alpha:1];
        self.textColor = [UIColor whiteColor];
        self.color1 = [UIColor colorWithRed:18/255.0 green:27/255.0 blue:66/255.0 alpha:1];
        self.navBarColor = [UIColor colorWithRed:13/255.0 green:7/255.0 blue:75.0/255 alpha:1];
        self.color2 = [UIColor colorWithRed:18/255.0 green:27/255.0 blue:66/255.0 alpha:1];
        self.textColorGray = [UIColor whiteColor];
        self.tabBarColor = [UIColor colorWithRed:18/255.0 green:27/255.0 blue:66/255.0 alpha:1];
        self.cellColor = [UIColor colorWithRed:42/255.0 green:0/255.0 blue:85/255.0 alpha:1];
    } else{
    
        self.bgColor = [UIColor colorWithDisplayP3Red:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
        self.textColor = [UIColor blackColor];
        self.color1 = [UIColor colorWithDisplayP3Red:250.0/255 green:250.0/255 blue:250.0/255 alpha:1];
        
        self.navBarColor = [UIColor whiteColor];
        self.color2 = [UIColor whiteColor];
        self.textColorGray = [UIColor grayColor];
        self.tabBarColor = [UIColor whiteColor];
        self.cellColor = [UIColor whiteColor];
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.colorClear = [UIColor clearColor];
    });
}


@end
