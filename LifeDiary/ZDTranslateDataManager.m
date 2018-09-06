//
//  ZDTranslateDataManager.m
//  LifeDiary
//
//  Created by Jack on 2018/9/6.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDTranslateDataManager.h"
#import <AFNetworking/AFNetworking.h>

@implementation ZDTranslateDataManager
- (void)getData_sucessBlock:(requestSuccess )sucessBlock faliure:(requestFailure )failureBlock sourceString:(NSString *)string{

    
    NSString *urlString= [NSString stringWithFormat:@"http://www.baidu.com"];
     NSString *utf8String = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *salt = [NSString stringWithFormat:@"%d",arc4random_uniform(500)];
    
    NSDictionary *paraDictionary =  [NSDictionary dictionaryWithObjectsAndKeys:utf8String,@"q",@"EN",@"from",@"zh-CHS",@"to",@"2b1c202a7b52cbd6", @"appKey",salt, @"salt",@"",nil];
    AFHTTPSessionManager *sessionManger = [AFHTTPSessionManager manager];
    sessionManger.requestSerializer = [AFHTTPRequestSerializer serializer];
    [sessionManger GET:urlString parameters:paraDictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    

    
}
@end
