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
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    // 文件路径
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"recyleModel.sqlite"];
    
    // 实例化FMDataBase对象
    
    _db = [FMDatabase databaseWithPath:filePath];
    
    [_db open];
    // 初始化数据表
    NSString *recyleGoodsSql = @"CREATE TABLE recyleGoods ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,recyleGoods_name VARCHAR(255),recyleGoods_remark VARCHAR(255),recyleGoods_imageData blob,recyleGoods_dateOfStart VARCHAR(255),recyleGoods_dateOfEnd VARCHAR(255),recyleGoods_saveTime VARCHAR(255))";
    [_db executeUpdate:recyleGoodsSql];
    
    [_db close];
    
}
#pragma mark - 接口

- (void)addRecycleGoods:(ZDGoods *)recyleGoods{
    [_db open];
    
    [_db executeUpdate:@"INSERT INTO recyleGoods(recyleGoods_name,recyleGoods_remark,recyleGoods_imageData,recyleGoods_dateOfStart,recyleGoods_dateOfEnd,recyleGoods_saveTime)VALUES(?,?,?,?,?,?)",recyleGoods.name,recyleGoods.remark,recyleGoods.imageData,recyleGoods.dateOfStart,recyleGoods.dateOfEnd,recyleGoods.saveTime];
    
    
    [_db close];
    
}

- (void)deleteRecycleGoods:(ZDGoods *)recycleGoods{
    [_db open];
    
    [_db executeUpdate:@"DELETE FROM person WHERE goods_name = ?",recycleGoods.name];
    
    [_db close];
}
- (NSMutableArray *)getAllRecycleGoods{
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM goods"];
    
    while ([res next]) {
        ZDGoods *recycleGoods = [[ZDGoods alloc] init];
        recycleGoods.name = [res stringForColumn:@"person_name"];
        recycleGoods.remark = [res stringForColumn:@"person_remark"];
        recycleGoods.imageData = [res dataForColumn:@"person_imageData"];
        recycleGoods.dateOfStart = [res stringForColumn:@"person_dateOfStart"];
        recycleGoods.dateOfEnd = [res stringForColumn:@"person_dateOfEnd"];
        recycleGoods.saveTime = [res stringForColumn:@"person_saveTime"];
        
    }
    
    [_db close];
    
    
    
    return dataArray;
    
    
}


@end
