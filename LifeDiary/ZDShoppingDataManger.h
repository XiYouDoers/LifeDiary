//
//  ZDShoppingDataManger.h
//  LifeDiary
//
//  Created by Jack on 2018/8/16.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  ZDShoppingModel;
typedef void (^requestForShoppingSuccess) (ZDShoppingModel *shoppingModel);
typedef void (^requestForShoppingFailure) (void);
@interface ZDShoppingDataManger : NSObject
//请求方法
- (void)getData_sucessBlock:(requestForShoppingSuccess )sucessBlock faliure:(requestForShoppingFailure )failureBlock keyString:(NSString *)keyString;
@end
