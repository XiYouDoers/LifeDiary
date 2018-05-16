//
//  ZDRecycleDataBase.m
//  LifeDiary
//
//  Created by wuxinyi on 18/5/14.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDRecycleDataBase.h"
#import "FMDB.h"

static ZDRecycleDataBase *_messageDataBase = nil;
@implementation ZDRecycleDataBase{
    FMDatabase *_db;
}
+ (instancetype) sharedDataBase{
    if (_messageDataBase ==nil) {
        _messageDataBase = [[ZDRecycleDataBase alloc]init];
        
        [_messageDataBase initDataBase];
    }
    return _messageDataBase;
}
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    if (_messageDataBase == nil) {
        
        _messageDataBase = [super allocWithZone:zone];
        
    }
    
    return _messageDataBase;
    
}
- (void)initDataBase{
    // 获得Documents目录路径
    
//    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    
//    // 文件路径
//    
//    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"recyleModel.sqlite"];
    
    // 实例化FMDataBase对象
    
    _db = [FMDatabase databaseWithPath:@"/Users/jack/Public/iOS/recycleGoodsFmdb.db"];
    
    [_db open];
    // 初始化数据表
    NSString *recyleGoodsSql = @"CREATE TABLE IF NOT EXISTS recyleGoods (id INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,recyleGoods_identifier VARCHAR(255),recyleGoods_name VARCHAR(255),recyleGoods_remark VARCHAR(255),recyleGoods_imageData blob,recyleGoods_dateOfStart VARCHAR(255),recyleGoods_dateOfEnd VARCHAR(255),recyleGoods_saveTime VARCHAR(255))";
    [_db executeUpdate:recyleGoodsSql];
    
    [_db close];
    
}
#pragma mark - 接口

- (void)addGoods:(ZDGoods *)recyleGoods{
    [_db open];
    
    NSNumber *maxID = @(0);
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM recyleGoods "];
    //获取数据库中最大的ID
    while ([res next]) {
        if ([maxID integerValue] < [[res stringForColumn:@"recyleGoods_identifier"] integerValue]) {
            maxID = @([[res stringForColumn:@"recyleGoods_identifier"] integerValue] ) ;
        }
        
    }
    maxID = @([maxID integerValue] + 1);
    [_db executeUpdate:@"INSERT INTO recyleGoods(recyleGoods_identifier,recyleGoods_name,recyleGoods_remark,recyleGoods_imageData,recyleGoods_dateOfStart,recyleGoods_dateOfEnd,recyleGoods_saveTime)VALUES(?,?,?,?,?,?,?)",maxID,recyleGoods.name,recyleGoods.remark,recyleGoods.imageData,recyleGoods.dateOfStart,recyleGoods.dateOfEnd,recyleGoods.saveTime];
    
    
    [_db close];
    
}

- (void)deleteGoods:(ZDGoods *)recycleGoods{
    [_db open];
    
    [_db executeUpdate:@"DELETE FROM recyleGoods WHERE recyleGoods_identifier = ?",recycleGoods.identifier];
    
    [_db close];
}
- (NSMutableArray *)getAllGoods{
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM recyleGoods"];
    
    while ([res next]) {
        ZDGoods *recycleGoods = [[ZDGoods alloc] init];
        recycleGoods.identifier = @([[res stringForColumn:@"recyleGoods_identifier"] integerValue]);
        recycleGoods.name = [res stringForColumn:@"recyleGoods_name"];
        recycleGoods.remark = [res stringForColumn:@"recyleGoods_remark"];
        recycleGoods.imageData = [res dataForColumn:@"recyleGoods_imageData"];
        recycleGoods.dateOfStart = [res stringForColumn:@"recyleGoods_dateOfStart"];
        recycleGoods.dateOfEnd = [res stringForColumn:@"recyleGoods_dateOfEnd"];
        recycleGoods.saveTime = [res stringForColumn:@"recyleGoods_saveTime"];
        [dataArray addObject:recycleGoods];
    }
    
    [_db close];
    
    
    
    return dataArray;
    
    
}


@end
