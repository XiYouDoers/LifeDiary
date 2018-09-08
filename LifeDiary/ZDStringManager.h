//
//  ZDStringManager.h
//  LifeDiary
//
//  Created by Jack on 2018/9/8.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDStringManager : NSObject

+ (NSString *)switchToNumberString:(NSString *)sourceString;
+ (NSString *)separateInfo:(NSString *)sourceString;
+ (NSString *)deleteSpace:(NSString *)sourceString;
+ (NSString *)addGangToDateString:(NSString *)sourceString;
+ (NSString *)caculateDate:(NSString *)str;
+ (NSString *)addDate:(NSString *)date str:(NSString *)str;

@end
