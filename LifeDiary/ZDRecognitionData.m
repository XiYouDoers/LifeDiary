//
//  ZDRecognitionData.m
//  LifeDiary
//
//  Created by Jack on 2018/9/2.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDRecognitionData.h"

@implementation ZDRecognitionData
- (id)init{
    if (self = [super init]) {
        _nameDic = @{@"name":@""};
        _savetimeDic = @{@"savetime":@""};
        _dateOfStartDic = @{@"_dateOfStartDic":@""};
        _dateOfEndDic = @{@"_dateOfStartDic":@""};
    }
    return self;
    
}
@end
