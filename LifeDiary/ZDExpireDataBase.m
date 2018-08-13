//
//  ZDExpireDataBase.m
//  LifeDiary
//
//  Created by wuxinyi on 18/5/14.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDExpireDataBase.h"
#import "FMDB.h"
#import "ZDGoods.h"

static ZDExpireDataBase *_messageDataBase = nil;
@implementation ZDExpireDataBase{
    FMDatabase *_db;
}
+ (instancetype) sharedDataBase{
    if (_messageDataBase ==nil) {
        _messageDataBase = [[ZDExpireDataBase alloc]init];
        
        [_messageDataBase initDataBase];
    }
    return _messageDataBase;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    
    if (_messageDataBase == nil) {
        
        _messageDataBase = [super allocWithZone:zone];
        
    }
    return _messageDataBase;
    
}
- (void)initDataBase{
    
    NSString *filepath = [[NSString alloc]init];
    //判断是否为模拟器
    if(TARGET_IPHONE_SIMULATOR){
        filepath = @"/Users/jack/Public/iOS/expireGoodsFmdb.db";
        
    }else{
        // 获得Documents目录路径
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        filepath = [documentsPath stringByAppendingPathComponent:@"expireModel.sqlite"];
    }
    
    _db = [FMDatabase databaseWithPath:filepath];
    
    [_db open];
    // 初始化数据表
    NSString *expireGoodsSql = @"CREATE TABLE IF NOT EXISTS expireGoods (       id INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,identifier VARCHAR(255),name VARCHAR(255),remark VARCHAR(255),imageData blob,dateOfStart VARCHAR(255),dateOfEnd VARCHAR(255),saveTime VARCHAR(255),sum VARCHAR(255),ratio double,Family VARCHAR(255)          )";
    [_db executeUpdate:expireGoodsSql];
    
    [_db close];
    
}
#pragma mark - 接口

- (void)addGoods:(ZDGoods *)goods{
    [_db open];
    
    NSNumber *maxID = @(0);
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM expireGoods "];
    //获取数据库中最大的ID
    while ([res next]) {
        if ([maxID integerValue] < [[res stringForColumn:@"identifier"] integerValue]) {
            maxID = @([[res stringForColumn:@"identifier"] integerValue] ) ;
        }
        
    }
    maxID = @([maxID integerValue] + 1);
    NSNumber *ratioNumber = @(goods.ratio);
    [_db executeUpdate:@"INSERT INTO expireGoods(identifier,name,remark,imageData,dateOfStart,dateOfEnd,saveTime,sum,ratio,family)VALUES(?,?,?,?,?,?,?,?,?,?)",maxID,goods.name,goods.remark,goods.imageData,goods.dateOfStart,goods.dateOfEnd,goods.saveTime,goods.sum, ratioNumber,goods.family];
    
    
    [_db close];

    
}

- (void)deleteGoods:(ZDGoods *)goods{
    [_db open];
    
    [_db executeUpdate:@"DELETE FROM expireGoods WHERE identifier = ?",goods.identifier];
    
    [_db close];
}
- (NSMutableArray *)getAllGoods{
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM expireGoods"];
    
    while ([res next]) {
        ZDGoods *goods = [[ZDGoods alloc] init];
        goods.identifier = @([[res stringForColumn:@"identifier"] integerValue]);
        goods.name = [res stringForColumn:@"name"];
        goods.remark = [res stringForColumn:@"remark"];
        goods.imageData = [res dataForColumn:@"imageData"];
        goods.dateOfStart = [res stringForColumn:@"dateOfStart"];
        goods.dateOfEnd = [res stringForColumn:@"dateOfEnd"];
        goods.saveTime = [res stringForColumn:@"saveTime"];
        goods.sum = [res stringForColumn:@"sum"];
        goods.ratio = [res doubleForColumn:@"ratio"];
        goods.family = [res stringForColumn:@"family"];
        
        [dataArray addObject:goods];
    }
    
    [_db close];
    
    
    
    return dataArray;
    
    
}


@end
