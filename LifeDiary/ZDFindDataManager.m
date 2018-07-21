//
//  ZDFindDataManager.m
//  LifeDiary
//
//  Created by Jack on 2018/7/18.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDFindDataManager.h"
#import <AFNetworking/AFNetworking.h>
@implementation ZDFindDataManager
- (void)getData_sucessBlock:(requestSuccess )sucessBlock faliure:(requestFailure )failureBlock{
    
    NSString *urlString = @"https://route.showapi.com/90-87";
    NSDictionary *paraDictionary =  [NSDictionary dictionaryWithObjectsAndKeys:@"70122",@"showapi_appid",@"0df9204adb56452a80f40b20652e1158",@"showapi_sign",@"569",@"tid",nil];
    AFHTTPSessionManager *sessionManger = [AFHTTPSessionManager manager];
    sessionManger.requestSerializer = [AFHTTPRequestSerializer serializer];
    [sessionManger GET:urlString parameters:paraDictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        _orderModel = [[ZDOrderModel alloc] initWithDictionary:responseObject error:nil];
        sucessBlock(_orderModel);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //通知
        
        
        failureBlock();
    }];
    
    
    
    
    
    
}
@end
