//
//  ZDTranslateDataManager.m
//  LifeDiary
//
//  Created by Jack on 2018/9/6.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDTranslateDataManager.h"
#import <AFNetworking/AFNetworking.h>
#import <CommonCrypto/CommonDigest.h>

@implementation ZDTranslateDataManager

- (void)getData_sucessBlock:(requestSuccess )sucessBlock faliure:(requestFailure )failureBlock sourceString:(NSString *)string{

    
    NSString *urlString= [NSString stringWithFormat:@"https://openapi.youdao.com/ocrapi"];
     NSString *q = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *salt = [NSString stringWithFormat:@"%d",arc4random_uniform(100)];
    NSString *appKey = @"6ad071e8b3555f9c";
    NSString *appSerect = @"ShMqlh8BlJy1LKeuMwqmCGmWgt40zdrP";
    NSString *signForString = [NSString stringWithFormat:@"%@+%@+%@+%@",appKey,q,salt,appSerect];
    NSMutableString *sign = [self MD5With:signForString];
    NSLog(@"=====     %@",sign);
    salt = [self URLEncodedString:salt];
    appKey = [self URLEncodedString:appKey];
    q = [self URLEncodedString:q];
    NSDictionary *paraDictionary =  [NSDictionary dictionaryWithObjectsAndKeys:q,@"q",@"EN",@"from",@"zh-CHS",@"to",appKey, @"appKey",salt, @"salt",sign,@"sign",nil];
    AFHTTPSessionManager *sessionManger = [AFHTTPSessionManager manager];
    sessionManger.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    [sessionManger POST:urlString parameters:paraDictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"111111  %@",responseObject);
        sucessBlock();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"22222222 %@",error);
    }];
    

    
}
- (NSString *)URLEncodedString:(NSString *)str
{
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    
    NSString *unencodedString = str;
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}

- (NSMutableString *)MD5With:(NSString *)str{
    
    const char *cStr = [str UTF8String];
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5( cStr, str.length, digest );
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        
        [result appendFormat:@"%02X", digest[i]];
    
    return result;
    
}


@end
