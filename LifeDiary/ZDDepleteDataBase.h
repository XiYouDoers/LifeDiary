//
//  ZDDepleteDataBase.h
//  LifeDiary
//
//  Created by wuxinyi on 18/5/14.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZDGoods;

@interface ZDDepleteDataBase : NSObject
@property(nonatomic,strong) ZDGoods *depleteGoods;

+ (instancetype)sharedDataBase;


#pragma mark - goods
/**
 *  添加Goods
 *
 */
- (void)addGoods:(ZDGoods *)depleteGoods;
/**
 *  删除Goods
 *
 */
- (void)deleteGoods:(ZDGoods *)depleteGoods;
- (NSMutableArray *)getAllGoods;

@end
