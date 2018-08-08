//
//  ZDDepleteDataBase.m
//  LifeDiary
//
//  Created by wuxinyi on 18/5/14.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDDepleteDataBase.h"
#import "FMDB.h"
#import "ZDGoods.h"

static ZDDepleteDataBase *_messageDataBase = nil;
@implementation ZDDepleteDataBase{
    FMDatabase *_db;
}
+ (instancetype) sharedDataBase{
    if (_messageDataBase ==nil) {
        _messageDataBase = [[ZDDepleteDataBase alloc]init];
        
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
    
    NSString *filepath = [[NSString alloc]init];
    //判断是否为模拟器
    if(TARGET_IPHONE_SIMULATOR){
        filepath = @"/Users/jack/Public/iOS/depleteGoodsFmdb.db";
        
    }else{
        // 获得Documents目录路径
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        filepath = [documentsPath stringByAppendingPathComponent:@"depleteModel.sqlite"];
    }
    
    _db = [FMDatabase databaseWithPath:filepath];
    
    [_db open];
    // 初始化数据表
    NSString *depleteGoodsSql = @"CREATE TABLE  if not exists depleteGoods('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,depleteGoods_identifier VARCHAR(255),depleteGoods_name VARCHAR(255),depleteGoods_remark VARCHAR(255),depleteGoods_imageData blob,depleteGoods_dateOfStart VARCHAR(255),depleteGoods_dateOfEnd VARCHAR(255),depleteGoods_saveTime VARCHAR(255),depleteGoods_sum VARCHAR(255),depleteGoods_ratio double)";
    [_db executeUpdate:depleteGoodsSql];
    
    [_db close];
    
}
#pragma mark - 接口

- (void)addGoods:(ZDGoods *)depleteGoods{
    [_db open];
    
    NSNumber *maxID = @(0);
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM depleteGoods "];
    //获取数据库中最大的ID
    while ([res next]) {
        if ([maxID integerValue] < [[res stringForColumn:@"depleteGoods_identifier"] integerValue]) {
            maxID = @([[res stringForColumn:@"depleteGoods_identifier"] integerValue] ) ;
        }
        
    }
    maxID = @([maxID integerValue] + 1);
    NSNumber *ratioNumber = @(depleteGoods.ratio);
    [_db executeUpdate:@"INSERT INTO depleteGoods(depleteGoods_identifier,depleteGoods_name,depleteGoods_remark,depleteGoods_imageData,depleteGoods_dateOfStart,depleteGoods_dateOfEnd,depleteGoods_saveTime,depleteGoods_sum,depleteGoods_ratio)VALUES(?,?,?,?,?,?,?,?,?)",maxID,depleteGoods.name,depleteGoods.remark,depleteGoods.imageData,depleteGoods.dateOfStart,depleteGoods.dateOfEnd,depleteGoods.saveTime,depleteGoods.sum,ratioNumber];
    
    
    [_db close];
    
}

- (void)deleteGoods:(ZDGoods *)depleteGoods{
    [_db open];
    
    [_db executeUpdate:@"DELETE FROM depleteGoods WHERE depleteGoods_identifier = ?",depleteGoods.identifier];
    
    [_db close];
}
- (NSMutableArray *)getAllGoods{
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM depleteGoods"];
    
    while ([res next]) {
        ZDGoods *depleteGoods = [[ZDGoods alloc] init];
        depleteGoods.identifier = @([[res stringForColumn:@"depleteGoods_identifier"] integerValue]);
        depleteGoods.name = [res stringForColumn:@"depleteGoods_name"];
        depleteGoods.remark = [res stringForColumn:@"depleteGoods_remark"];
        depleteGoods.imageData = [res dataForColumn:@"depleteGoods_imageData"];
        depleteGoods.dateOfStart = [res stringForColumn:@"depleteGoods_dateOfStart"];
        depleteGoods.dateOfEnd = [res stringForColumn:@"depleteGoods_dateOfEnd"];
        depleteGoods.saveTime = [res stringForColumn:@"depleteGoods_saveTime"];
        depleteGoods.sum = [res stringForColumn:@"depleteGoods_sum"];
        depleteGoods.ratio = [res doubleForColumn:@"depleteGoods_saveTime"];
        [dataArray addObject:depleteGoods];
    }
    
    [_db close];
    
    
    
    return dataArray;
    
}


@end
