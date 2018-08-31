//
//  UIImageTool.h
//  HiBuy
//
//  Created by youagoua on 15/3/21.
//  Copyright (c) 2015年 xiaoyou. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface XUtil : NSObject
+(BOOL) isDay;
+ (int)isSameDay:(NSDate *)date otherDay:(NSDate *)otherDate;
+ (NSString *)dateToSimpleString:(NSDate *)date;
+ (NSString *)dateToString:(NSDate *)date;
+(bool)isNull:(NSObject *) data;

+ (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize;

+ (UIColor *) hexToRGB:(NSString *)hexColor;

+ (UIColor *) hexToRGB:(NSString *)hexColor setAlpha:(CGFloat)alpha;

+ (void) dictionaryToEntity:(NSDictionary *)dict entity:(NSObject*)entity;

+ (NSDictionary *) entityToDictionary:(id)entity;

+ (NSString*)DataTOjsonString:(id)object;

+ (NSString*)getDownloadPath;

+ (NSString*)getFileName:(NSString *)mp3;

+ (void)playRemoteFile:(NSString *)url;

+(BOOL) containsChi:(NSString *)text;
@end
