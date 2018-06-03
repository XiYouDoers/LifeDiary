//
//  ZDDepleteDataBase.m
//  LifeDiary
//
//  Created by wuxinyi on 18/5/14.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDDepleteDataBase.h"
#import "FMDB.h"

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
    NSString *depleteGoodsSql = @"CREATE TABLE depleteGoods ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,depleteGoods_name VARCHAR(255),depleteGoods_remark VARCHAR(255),depleteGoods_imageData blob,depleteGoods_dateOfStart VARCHAR(255),depleteGoods_dateOfEnd VARCHAR(255),depleteGoods_saveTime VARCHAR(255))";
    [_db executeUpdate:depleteGoodsSql];
    
    [_db close];
    
}
#pragma mark - 接口

- (void)addDepleteGoods:(ZDGoods *)depleteGoods{
    [_db open];
    
    [_db executeUpdate:@"INSERT INTO depleteGoods(depleteGoods_name,depleteGoods_remark,depleteGoods_imageData,depleteGoods_dateOfStart,depleteGoods_dateOfEnd,depleteGoods_saveTime)VALUES(?,?,?,?,?,?)",depleteGoods.name,depleteGoods.remark,depleteGoods.imageData,depleteGoods.dateOfStart,depleteGoods.dateOfEnd,depleteGoods.saveTime];
    
    
    [_db close];
    
}

- (void)deleteDepleteGoods:(ZDGoods *)depleteGoods{
    [_db open];
    
    [_db executeUpdate:@"DELETE FROM person WHERE goods_name = ?",depleteGoods.name];
    
    [_db close];
}
- (NSMutableArray *)getAllDepleteGoods{
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM goods"];
    
    while ([res next]) {
        ZDGoods *depleteGoods = [[ZDGoods alloc] init];
        depleteGoods.name = [res stringForColumn:@"person_name"];
        depleteGoods.remark = [res stringForColumn:@"person_remark"];
        depleteGoods.imageData = [res dataForColumn:@"person_imageData"];
        depleteGoods.dateOfStart = [res stringForColumn:@"person_dateOfStart"];
        depleteGoods.dateOfEnd = [res stringForColumn:@"person_dateOfEnd"];
        depleteGoods.saveTime = [res stringForColumn:@"person_saveTime"];
        
    }
    
    [_db close];
    
    
    
    return dataArray;
    
    
}


@end
