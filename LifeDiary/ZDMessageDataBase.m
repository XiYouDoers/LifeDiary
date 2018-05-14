//
//  ZDMessageDataBase.m
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDMessageDataBase.h"
#import "FMDB.h"

static ZDMessageDataBase *_messageDataBase = nil;
@implementation ZDMessageDataBase{
    FMDatabase *_db;
}
+ (instancetype) sharedDataBase{
    if (_messageDataBase ==nil) {
        _messageDataBase = [[ZDMessageDataBase alloc]init];
        
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
//    
//    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    
//    // 文件路径
//    
//    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"messageModel.sqlite"];
    
    // 实例化FMDataBase对象
    
    _db = [FMDatabase databaseWithPath:@"/Users/jack/Public/iOS/messageFmdb.db"];
    
    [_db open];
    // 初始化数据表
    NSString *goodsSql = @"CREATE TABLE goods ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,goods_name VARCHAR(255),goods_remark VARCHAR(255),goods_imageData blob,goods_dateOfStart VARCHAR(255),goods_dateOfEnd VARCHAR(255),goods_saveTime VARCHAR(255))";
    [_db executeUpdate:goodsSql];
    
    [_db close];
    
}
#pragma mark - 接口

- (void)addGoods:(ZDGoods *)goods{
    [_db open];
    
    [_db executeUpdate:@"INSERT INTO goods(goods_name,goods_remark,goods_imageData,goods_dateOfStart,goods_dateOfEnd,goods_saveTime)VALUES(?,?,?,?,?,?)",goods.name,goods.remark,goods.imageData,goods.dateOfStart,goods.dateOfEnd,goods.saveTime];
    
    
    [_db close];
    
}

- (void)deleteGoods:(ZDGoods *)goods{
    [_db open];
    
    [_db executeUpdate:@"DELETE FROM person WHERE goods_name = ?",goods.name];
    
    [_db close];
}
- (NSMutableArray *)getAllGoods{
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM goods"];
    
    while ([res next]) {
        ZDGoods *goods = [[ZDGoods alloc] init];
        goods.name = [res stringForColumn:@"person_name"];
        goods.remark = [res stringForColumn:@"person_remark"];
        goods.imageData = [res dataForColumn:@"person_imageData"];
        goods.dateOfStart = [res stringForColumn:@"person_dateOfStart"];
        goods.dateOfEnd = [res stringForColumn:@"person_dateOfEnd"];
        goods.saveTime = [res stringForColumn:@"person_saveTime"];

    }
    
    [_db close];
    
    
    
    return dataArray;
    
    
}
@end
