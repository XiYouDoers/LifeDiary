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
    NSString *expireGoodsSql = @"CREATE TABLE expireGoods ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,expireGoods_name VARCHAR(255),expireGoods_remark VARCHAR(255),expireGoods_imageData blob,expireGoods_dateOfStart VARCHAR(255),expireGoods_dateOfEnd VARCHAR(255),expireGoods_saveTime VARCHAR(255))";
    [_db executeUpdate:expireGoodsSql];
    
    [_db close];
    
}
#pragma mark - 接口

- (void)addExpireGoods:(ZDGoods *)expireGoods{
    [_db open];
    
    [_db executeUpdate:@"INSERT INTO expireGoods(expireGoods_name,expireGoods_remark,expireGoods_imageData,expireGoods_dateOfStart,expireGoods_dateOfEnd,expireGoods_saveTime)VALUES(?,?,?,?,?,?)",expireGoods.name,expireGoods.remark,expireGoods.imageData,expireGoods.dateOfStart,expireGoods.dateOfEnd,expireGoods.saveTime];
    
    
    [_db close];
    
}

- (void)deleteExpireGoods:(ZDGoods *)expireGoods{
    [_db open];
    
    [_db executeUpdate:@"DELETE FROM person WHERE goods_name = ?",expireGoods.name];
    
    [_db close];
}
- (NSMutableArray *)getAllExpireGoods{
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM goods"];
    
    while ([res next]) {
        ZDGoods *expireGoods = [[ZDGoods alloc] init];
        expireGoods.name = [res stringForColumn:@"person_name"];
        expireGoods.remark = [res stringForColumn:@"person_remark"];
        expireGoods.imageData = [res dataForColumn:@"person_imageData"];
        expireGoods.dateOfStart = [res stringForColumn:@"person_dateOfStart"];
        expireGoods.dateOfEnd = [res stringForColumn:@"person_dateOfEnd"];
        expireGoods.saveTime = [res stringForColumn:@"person_saveTime"];
        
    }
    
    [_db close];
    
    
    
    return dataArray;
    
    
}


@end
