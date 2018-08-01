//
//  ZDFindDataManager.h
//  LifeDiary
//
//  Created by Jack on 2018/7/18.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZDOrderModel.h"
typedef void (^requestSuccess) (ZDOrderModel *model);
typedef void (^requestFailure) (void);
@interface ZDFindDataManager : NSObject
@property(nonatomic,strong) ZDOrderModel *orderModel;
//请求方法
- (void)getData_sucessBlock:(requestSuccess )sucessBlock faliure:(requestFailure )failureBlock maxResult:(NSString *)maxResult;
@end
