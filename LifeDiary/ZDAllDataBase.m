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
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    if (_allDataBase == nil) {
        @synchronized(self) {
        _allDataBase = [super allocWithZone:zone];
        }
        
    }
    
    return _allDataBase;
    
}
- (void)initDataBase{
    // 获得Documents目录路径
    
//    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    
//    // 文件路径
//    
//    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"messageModel.sqlite"];
//    
    // 实例化FMDataBase对象
    
    _db = [FMDatabase databaseWithPath:@"/Users/jack/Public/iOS/allGoodsFmdb.db"];
    
    [_db open];
    // 初始化数据表
    NSString *goodsSql = @"CREATE TABLE IF NOT EXISTS allGoods (id INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,allGoods_identifier VARCHAR(255),allGoods_name VARCHAR(255),allGoods_remark VARCHAR(255),allGoods_imageData blob,allGoods_dateOfStart VARCHAR(255),allGoods_dateOfEnd VARCHAR(255),allGoods_saveTime VARCHAR(255))";
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
    [_db executeUpdate:@"INSERT INTO allGoods(allGoods_identifier,allGoods_name,allGoods_remark,allGoods_imageData,allGoods_dateOfStart,allGoods_dateOfEnd,allGoods_saveTime)VALUES(?,?,?,?,?,?,?)",maxID,goods.name,goods.remark,goods.imageData,goods.dateOfStart,goods.dateOfEnd,goods.saveTime];
    
    
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
        [dataArray addObject:goods];
    }
    
    [_db close];
    
    
    
    return dataArray;
    
    
}
@end
