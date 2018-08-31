//
//  NSUserDefaultsUtil.h
//  sdata
//
//  Created by 白静 on 5/20/16.
//  Copyright © 2016 Netease Youdao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaultsUtil : NSObject
+(NSObject *)getObject:(NSString *)key;
+(NSString *)getStringObject:(NSString *)key;
+(void)putObject:(NSObject *)value key:(NSString *)key;
@end
