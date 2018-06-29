//
//  ZDExpireDataBase.m
//  LifeDiary
//
//  Created by wuxinyi on 18/5/14.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDExpireDataBase.h"
#import "FMDB.h"

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
        filepath = @"/Users/jack/Public/iOS/expireGoodsFmdb.db";
        
    }else{
        // 获得Documents目录路径
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        filepath = [documentsPath stringByAppendingPathComponent:@"expireModel.sqlite"];
    }
    
    _db = [FMDatabase databaseWithPath:filepath];
    
    [_db open];
    // 初始化数据表
    NSString *expireGoodsSql = @"CREATE TABLE IF NOT EXISTS expireGoods ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,expireGoods_identifier VARCHAR(255),expireGoods_name VARCHAR(255),expireGoods_remark VARCHAR(255),expireGoods_imageData blob,expireGoods_dateOfStart VARCHAR(255),expireGoods_dateOfEnd VARCHAR(255),expireGoods_saveTime VARCHAR(255),expireGoods_sum VARCHAR(255),expireGoods_ratio double)";
    [_db executeUpdate:expireGoodsSql];
    
    [_db close];
    
}
#pragma mark - 接口

- (void)addGoods:(ZDGoods *)expireGoods{
    [_db open];
    
    NSNumber *maxID = @(0);
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM expireGoods "];
    //获取数据库中最大的ID
    while ([res next]) {
        if ([maxID integerValue] < [[res stringForColumn:@"expireGoods_identifier"] integerValue]) {
            maxID = @([[res stringForColumn:@"expireGoods_identifier"] integerValue] ) ;
        }
        
    }
    maxID = @([maxID integerValue] + 1);
    NSNumber *ratioNumber = @(expireGoods.ratio);
    [_db executeUpdate:@"INSERT INTO expireGoods(expireGoods_identifier,expireGoods_name,expireGoods_remark,expireGoods_imageData,expireGoods_dateOfStart,expireGoods_dateOfEnd,expireGoods_saveTime,expireGoods_sum,expireGoods_ratio)VALUES(?,?,?,?,?,?,?,?,?)",maxID,expireGoods.name,expireGoods.remark,expireGoods.imageData,expireGoods.dateOfStart,expireGoods.dateOfEnd,expireGoods.saveTime,expireGoods.sum,ratioNumber];
    
    
    [_db close];

    
}

- (void)deleteGoods:(ZDGoods *)expireGoods{
    [_db open];
    
    [_db executeUpdate:@"DELETE FROM expireGoods WHERE expireGoods_identifier = ?",expireGoods.identifier];
    
    [_db close];
}
- (NSMutableArray *)getAllGoods{
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM expireGoods"];
    
    while ([res next]) {
        ZDGoods *expireGoods = [[ZDGoods alloc] init];
        expireGoods.identifier = @([[res stringForColumn:@"expireGoods_identifier"] integerValue]);
        expireGoods.name = [res stringForColumn:@"expireGoods_name"];
        expireGoods.remark = [res stringForColumn:@"expireGoods_remark"];
        expireGoods.imageData = [res dataForColumn:@"expireGoods_imageData"];
        expireGoods.dateOfStart = [res stringForColumn:@"expireGoods_dateOfStart"];
        expireGoods.dateOfEnd = [res stringForColumn:@"expireGoods_dateOfEnd"];
        expireGoods.saveTime = [res stringForColumn:@"expireGoods_saveTime"];
        expireGoods.sum = [res stringForColumn:@"expireGoods_sum"];
        expireGoods.ratio = [res doubleForColumn:@"expireGoods_saveTime"];
        [dataArray addObject:expireGoods];
    }
    
    [_db close];
    
    
    
    return dataArray;
    
    
}


@end
