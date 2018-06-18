//
//  ZDAllDataBase.m
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//



#import "ZDAllDataBase.h"
#import "FMDB.h"


@implementation ZDAllDataBase{
    FMDatabase *_db;
}
+ (instancetype) sharedDataBase{
    
    static ZDAllDataBase *allDataBase = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        allDataBase = [[ZDAllDataBase alloc]init];
        
        [allDataBase initDataBase];
        
    });
    return allDataBase;
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
    NSString *goodsSql = @"CREATE TABLE IF NOT EXISTS allGoods (id INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,allGoods_identifier VARCHAR(255),allGoods_name VARCHAR(255),allGoods_remark VARCHAR(255),allGoods_imageData blob,allGoods_dateOfStart VARCHAR(255),allGoods_dateOfEnd VARCHAR(255),allGoods_saveTime VARCHAR(255),allGoods_sum VARCHAR(255),allGoods_ratio double)";
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
        if ([maxID integerValue] < [[res stringForColumn:@"allGoods_identifier"] integerValue]) {
            maxID = @([[res stringForColumn:@"allGoods_identifier"] integerValue] ) ;
        }
        
    }

    maxID = @([maxID integerValue] + 1);
    
    NSNumber *ratioNumber = @(goods.ratio);
    [_db executeUpdate:@"INSERT INTO allGoods(allGoods_identifier,allGoods_name,allGoods_remark,allGoods_imageData,allGoods_dateOfStart,allGoods_dateOfEnd,allGoods_saveTime,allGoods_sum,allGoods_ratio)VALUES(?,?,?,?,?,?,?,?,?)",maxID,goods.name,goods.remark,goods.imageData,goods.dateOfStart,goods.dateOfEnd,goods.saveTime,goods.sum, ratioNumber];
    
 
    [_db close];
    
}

- (void)deleteGoods:(ZDGoods *)goods{
    [_db open];
    
    [_db executeUpdate:@"DELETE FROM allGoods WHERE allGoods_identifier = ?",goods.identifier];
    
    [_db close];
}
- (NSMutableArray *)getAllGoods{
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM allGoods"];
    
    while ([res next]) {
        ZDGoods *goods = [[ZDGoods alloc] init];
        goods.identifier = @([[res stringForColumn:@"allGoods_identifier"] integerValue]);
        goods.name = [res stringForColumn:@"allGoods_name"];
        goods.remark = [res stringForColumn:@"allGoods_remark"];
        goods.imageData = [res dataForColumn:@"allGoods_imageData"];
        goods.dateOfStart = [res stringForColumn:@"allGoods_dateOfStart"];
        goods.dateOfEnd = [res stringForColumn:@"allGoods_dateOfEnd"];
        goods.saveTime = [res stringForColumn:@"allGoods_saveTime"];
        goods.sum = [res stringForColumn:@"allGoods_sum"];
        goods.ratio = [res doubleForColumn:@"allGoods_ratio"];
  
        [dataArray addObject:goods];
    }
    
    [_db close];
    
    
    
    return dataArray;
    
    
}
@end
