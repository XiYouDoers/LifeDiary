//
//  ZDExpireDataBase.h
//  LifeDiary
//
//  Created by wuxinyi on 18/5/14.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZDGoods.h"

@interface ZDExpireDataBase : NSObject
@property(nonatomic,strong) ZDGoods *expireGoods;

+ (instancetype)sharedDataBase;


#pragma mark - goods
/**
 *  添加Goods
 *
 */
- (void)addGoods:(ZDGoods *)expireGoods;
/**
 *  删除Goods
 *
 */
- (void)deleteGoods:(ZDGoods *)expireGoods;
- (NSMutableArray *)getAllGoods;

@end
