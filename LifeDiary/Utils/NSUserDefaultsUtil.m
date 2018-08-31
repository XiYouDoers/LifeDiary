//
//  NSUserDefaultsUtil.m
//  sdata
//
//  Created by 白静 on 5/20/16.
//  Copyright © 2016 Netease Youdao. All rights reserved.
//

#import "NSUserDefaultsUtil.h"

@implementation NSUserDefaultsUtil

+(NSObject *)getObject:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSObject* value = [userDefaults objectForKey:key];
    return value;
}

+(NSString *)getStringObject:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString* value = [userDefaults objectForKey:key];
    return value;
}

+(void )putObject:(NSObject *)value key:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:key];
}

@end
