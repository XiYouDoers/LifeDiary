//
//  ZDFindDataManager.m
//  LifeDiary
//
//  Created by Jack on 2018/7/18.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDFindDataManager.h"
#import <AFNetworking/AFNetworking.h>
#import "ZDOrderModel.h"

@implementation ZDFindDataManager
- (void)getData_sucessBlock:(requestSuccess )sucessBlock faliure:(requestFailure )failureBlock maxResult:(NSString *)maxResult{
    
    NSString *urlString = @"https://route.showapi.com/109-35";
    NSDictionary *paraDictionary =  [NSDictionary dictionaryWithObjectsAndKeys:@"74299",@"showapi_appid",@"e5302823acb34081a1324151a4dc2914",@"showapi_sign",@"1",@"needHtml",@"1", @"page",@"健康养生", @"channelName",maxResult,@"maxResult",nil];
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
