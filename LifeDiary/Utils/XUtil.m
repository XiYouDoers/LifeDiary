//
//  UIImageTool.m
//  HiBuy
//
//  Created by youagoua on 15/3/21.
//  Copyright (c) 2015年 xiaoyou. All rights reserved.
//

#import "XUtil.h"
#import "AFSoundManager.h"
#import "MBProgressHUD+MJ.h"
#import <objc/runtime.h>
#import "AppDelegate.h"


@implementation XUtil

+(bool)isNull:(NSObject *) data{
    if((NSNull *)data != [NSNull null] && data != nil){
        return NO;
    }
    return  YES;
}

+ (NSString *)dateToSimpleString:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat:@"MM.dd"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

+ (NSString *)dateToString:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

+ (int)isSameDay:(NSDate *)date otherDay:(NSDate *)otherDate{
    NSString * dateStr =[XUtil dateToSimpleString:date];
    NSString * aDateStr =[XUtil dateToSimpleString:otherDate];
    if([dateStr isEqualToString:aDateStr] ){
        return YES;
    }else{
        return NO;
    }
}

+ (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName : font};
    // 如果将来计算的文字的范围超出了指定的范围,返回的就是指定的范围
    // 如果将来计算的文字的范围小于指定的范围, 返回的就是真实的范围
    CGSize size =  [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size;
}

+ (UIColor *) hexToRGB:(NSString *)hexColor
{
    unsigned int red, green, blue;
    NSRange range;
    range.length = 2 ;
    range.location = 0 ;
    [[NSScanner scannerWithString:[hexColor substringWithRange :range]] scanHexInt :&red];
    range.location = 2 ;
    [[NSScanner scannerWithString:[hexColor substringWithRange :range]] scanHexInt :&green];
    range.location = 4 ;
    [[NSScanner scannerWithString:[hexColor substringWithRange :range]] scanHexInt :&blue];
    return [UIColor colorWithRed:(float)(red/ 255.0f) green:(float)(green/ 255.0f) blue:(float)(blue/ 255.0f) alpha:1.0f ];
}

+ (UIColor *) hexToRGB:(NSString *)hexColor setAlpha:(CGFloat)alpha
{
    unsigned int red, green, blue;
    NSRange range;
    range.length = 2 ;
    range.location = 0 ;
    [[NSScanner scannerWithString:[hexColor substringWithRange :range]] scanHexInt :&red];
    range.location = 2 ;
    [[NSScanner scannerWithString:[hexColor substringWithRange :range]] scanHexInt :&green];
    range.location = 4 ;
    [[NSScanner scannerWithString:[hexColor substringWithRange :range]] scanHexInt :&blue];
    return [UIColor colorWithRed:(float)(red/ 255.0f) green:(float)(green/ 255.0f) blue:(float)(blue/ 255.0f) alpha:alpha ];
}

+ (NSDictionary *) entityToDictionary:(id)entity
{
    
    Class clazz = [entity class];
    u_int count;
    
    objc_property_t* properties = class_copyPropertyList(clazz, &count);
    NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];
    NSMutableArray* valueArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count ; i++)
    {
        objc_property_t prop=properties[i];
        const char* propertyName = property_getName(prop);
        NSString *property = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        if([property isEqualToString:@"content"] || [property isEqualToString:@"isFavor"] || [property isEqualToString:@"isDownload"]){
            continue;
        }

        id value;
        @try {
            value =  [entity performSelector:NSSelectorFromString(property)];
        }
        @catch (NSException *exception) {
        }
        @finally {
        }
        if(value !=nil){
            [propertyArray addObject:property];
            [valueArray addObject:value];
        }
    }
    
    free(properties);
    
    NSDictionary* returnDic = [NSDictionary dictionaryWithObjects:valueArray forKeys:propertyArray];
    NSLog(@"%@", returnDic);
    
    return returnDic;
}

+ (void) dictionaryToEntity:(NSDictionary *)dict entity:(NSObject*)entity
{
    if(dict == nil || [dict isEqual:[NSNull null]]){
        return;
    }
    if (dict && entity) {
        
        for (NSString *keyName in [dict allKeys]) {
            //构建出属性的set方法
            NSString *destMethodName = [NSString stringWithFormat:@"set%@:",[keyName capitalizedString]]; //capitalizedString返回每个单词首字母大写的字符串（每个单词的其余字母转换为小写）
            SEL destMethodSelector = NSSelectorFromString(destMethodName);
            
            if ([entity respondsToSelector:destMethodSelector]) {
                NSString *data = [dict objectForKey:keyName];
                [entity performSelector:destMethodSelector withObject:data];
            }
            
        }//end for
        
    }//end if
}

-(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (!jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

+(NSString*)getDownloadPath{
    NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    if (![[NSFileManager defaultManager] fileExistsAtPath:documentDir]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:documentDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return documentDir;
}


+(NSString*)getFileName:(NSString *)mp3{
    //名称太长，不能识别
//    NSString *name_md5 = [Md5Util getMd5_32Bit_String:mp3];
    NSRange range = [mp3 rangeOfString:@"/" options:NSBackwardsSearch];
    NSString *name_md5 = [mp3 substringFromIndex:range.location + 1];

    return name_md5;
}

+ (void)playRemoteFile:(NSString *)url {
    if (url == nil || url.length == 0) {
        return;
    }
    AFSoundItem *playitem = [[AFSoundItem alloc] initWithStreamingURL:[[NSURL alloc] initWithString :url]];
    
    AFSoundPlayback *player = [[AFSoundPlayback alloc] initWithItem:playitem];
    [player play];
    
    [player listenFeedbackUpdatesWithBlock:^(AFSoundItem *item) {
    } andFinishedBlock:^(void) {
    }];
    [MBProgressHUD showCustomMessage:@"正在发音" toView:nil];
}

@end
