//
//  ZDStringSaveByNumber.m
//  LifeDiary
//
//  Created by Jack on 2018/9/3.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDStringSaveByNumber.h"

@implementation ZDStringSaveByNumber
/**
 字符串截图数字
 */
+ (NSString *)charactersString:(NSString *)sourceString{
    
    
    
    NSMutableArray *characters = [NSMutableArray array];
    NSMutableString *mutStr = [NSMutableString string];
    
    
    // 分离出字符串中的所有字符，并存储到数组characters中
    for (int i = 0; i < sourceString.length; i ++) {
        NSString *subString = [sourceString substringToIndex:i + 1];
        
        subString = [subString substringFromIndex:i];
        
        [characters addObject:subString];
    }
    
    // 利用正则表达式，匹配数组中的每个元素，判断是否是数字，将数字拼接在可变字符串mutStr中
    for (NSString *b in characters) {
        NSString *regex = @"^[0-9]*$";
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];// 谓词
        BOOL isShu = [pre evaluateWithObject:b];// 对b进行谓词运算
        if (isShu) {
            [mutStr appendString:b];
        }
    }
    return mutStr;
}
@end
