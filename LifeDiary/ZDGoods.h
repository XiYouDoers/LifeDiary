//
//  ZDGoods.h
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDGoods : NSObject
@property(nonatomic,copy) NSNumber *identifier;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *remark;
@property(nonatomic,copy) NSData *imageData;
@property(nonatomic,copy) NSString *dateOfStart;
@property(nonatomic,copy) NSString *dateOfEnd;
@property(nonatomic,copy) NSString *saveTime;
@property(nonatomic,copy) NSString *sum;
@property(nonatomic,assign) float ratio;
@property(nonatomic,copy) NSString *family;
@end
