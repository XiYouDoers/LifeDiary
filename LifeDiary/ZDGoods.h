//
//  ZDGoods.h
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDGoods : NSObject
@property(nonatomic,strong) NSNumber *identifier;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *remark;
@property(nonatomic,strong) NSData *imageData;
@property(nonatomic,strong) NSString *dateOfStart;
@property(nonatomic,strong) NSString *dateOfEnd;
@property(nonatomic,strong) NSString *saveTime;
@property(nonatomic,strong) NSString *sum;
@property(nonatomic,assign) float ratio;
@end
