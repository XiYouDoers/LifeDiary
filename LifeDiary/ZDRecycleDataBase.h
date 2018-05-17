//
//  ZDRecycleDataBase.h
//  LifeDiary
//
//  Created by wuxinyi on 18/5/14.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZDGoods.h"

@interface ZDRecycleDataBase : NSObject
//@property(nonatomic,strong) ZDGoods *recycleGoods;

+ (instancetype)sharedDataBase;


#pragma mark - goods
/**
 *  添加Goods
 *
 */
- (void)addGoods:(ZDGoods *)recycleGoods;
/**
 *  删除Goods
 *
 */
- (void)deleteGoods:(ZDGoods *)recycleGoods;
- (NSMutableArray *)getAllGoods;

@end