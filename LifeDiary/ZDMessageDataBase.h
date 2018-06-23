//
//  ZDMessageDataBase.h
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZDGoods.h"

@interface ZDMessageDataBase : NSObject
@property(nonatomic,strong) ZDGoods *goods;

+ (instancetype)sharedDataBase;


#pragma mark - goods
/**
 *  添加Goods
 *
 */
- (void)addGoods:(ZDGoods *)goods;
/**
 *  删除Goods
 *
 */
- (void)deleteGoods:(ZDGoods *)goods;
- (NSMutableArray *)getAllGoods;

@end
