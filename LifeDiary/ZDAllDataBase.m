//
//  ZDAllDataBase.m
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDAllDataBase.h"
#import "FMDB.h"

static ZDAllDataBase *_allDataBase = nil;
@implementation ZDAllDataBase{
    FMDatabase *_db;
}
+ (instancetype) sharedDataBase{
    if (_allDataBase == nil) {
        @synchronized(self) {
        _allDataBase = [[ZDAllDataBase alloc]init];
        [_allDataBase initDataBase];
        }
    }
    return _allDataBase;
}


- (void)initDataBase{
    
    NSString *filepath = [[NSString alloc]init];
    if(TARGET_IPHONE_SIMULATOR){

        filepath = @"/Users/jack/Public/iOS/allGoodsFmdb.db";
    }else{
        // 获得Documents目录路径
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        filepath = [documentsPath stringByAppendingPathComponent:@"messageModel.sqlite"];
    }
    
    _db = [FMDatabase databaseWithPath:filepath];

    
    // 实例化FMDataBase对象


    [_db open];
    // 初始化数据表
    NSString *goodsSql = @"CREATE TABLE IF NOT EXISTS allGoods (       id INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,identifier VARCHAR(255),name VARCHAR(255),remark VARCHAR(255),imageData blob,dateOfStart VARCHAR(255),dateOfEnd VARCHAR(255),saveTime VARCHAR(255),sum VARCHAR(255),ratio double,Family VARCHAR(255)          )";
    [_db executeUpdate:goodsSql];
    
    [_db close];
    
}
#pragma mark - 接口

- (void)addGoods:(ZDGoods *)goods{
    [_db open];
    
    NSNumber *maxID = @(0);
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM allGoods "];
    //获取数据库中最大的ID
    while ([res next]) {
        if ([maxID integerValue] < [[res stringForColumn:@"identifier"] integerValue]) {
            maxID = @([[res stringForColumn:@"identifier"] integerValue] ) ;
        }
        
    }

    maxID = @([maxID integerValue] + 1);
    
    NSNumber *ratioNumber = @(goods.ratio);
    [_db executeUpdate:@"INSERT INTO allGoods(identifier,name,remark,imageData,dateOfStart,dateOfEnd,saveTime,sum,ratio,family)VALUES(?,?,?,?,?,?,?,?,?,?)",maxID,goods.name,goods.remark,goods.imageData,goods.dateOfStart,goods.dateOfEnd,goods.saveTime,goods.sum, ratioNumber,goods.family];
    
 
    [_db close];
    
}

- (void)deleteGoods:(ZDGoods *)goods{
    [_db open];
    
    [_db executeUpdate:@"DELETE FROM allGoods WHERE identifier = ?",goods.identifier];
    
    [_db close];
}
//修改数据
-(void)updateGoods:(ZDGoods*)goods
{
    [_db open];
    [_db executeUpdate:@"UPDATE allGoods SET name = ? WHERE identifier = ?",goods.name,goods.identifier];
    [_db executeUpdate:@"UPDATE allGoods SET remark = ? WHERE identifier = ?",goods.remark,goods.identifier];
    [_db executeUpdate:@"UPDATE allGoods SET imageData = ? WHERE identifier = ?",goods.imageData,goods.identifier];
    [_db executeUpdate:@"UPDATE allGoods SET dateOfStart = ? WHERE identifier = ?",goods.dateOfStart,goods.identifier];
    [_db executeUpdate:@"UPDATE allGoods SET dateOfEnd = ? WHERE identifier = ?",goods.dateOfEnd,goods.identifier];
    [_db executeUpdate:@"UPDATE allGoods SET saveTime = ? WHERE identifier = ?",goods.saveTime,goods.identifier];
    [_db executeUpdate:@"UPDATE allGoods SET sum = ? WHERE identifier = ?",goods.sum,goods.identifier];
    
    [_db close];
}
- (NSMutableArray *)getAllGoods{
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM allGoods"];
    
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
