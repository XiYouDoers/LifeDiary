//
//  ZDTranslateDataManager.h
//  LifeDiary
//
//  Created by Jack on 2018/9/6.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^requestSuccess) (NSString *result);
typedef void (^requestFailure) (void);

@interface ZDTranslateDataManager : NSObject
//请求方法
- (void)getData_sucessBlock:(requestSuccess )sucessBlock faliure:(requestFailure )failureBlock sourceString:(NSString *)string;
@end
