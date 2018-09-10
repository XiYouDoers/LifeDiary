//
//  ZDShoppingDataManger.m
//  LifeDiary
//
//  Created by Jack on 2018/8/16.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDShoppingDataManger.h"
#import <AFNetworking/AFNetworking.h>
#import "ZDShoppingModel.h"

@implementation ZDShoppingDataManger
- (void)getData_sucessBlock:(requestForShoppingSuccess )sucessBlock faliure:(requestForShoppingFailure )failureBlock {
    
    NSString *urlString = @"http://120.79.189.62:8888/search";
    NSDictionary *paraDictionary =  [NSDictionary dictionaryWithObjectsAndKeys:@"洗发水",@"key",@"1",@"page",nil];
    AFHTTPSessionManager *sessionManger = [AFHTTPSessionManager manager];
    sessionManger.requestSerializer = [AFHTTPRequestSerializer serializer];
    [sessionManger POST:urlString parameters:paraDictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZDShoppingModel *model = [[ZDShoppingModel alloc]initWithDictionary:responseObject error:nil];
         sucessBlock(model);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fffffff  %@",error);
    }];
   
    

}
@end
