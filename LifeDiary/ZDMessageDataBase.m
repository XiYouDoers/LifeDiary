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
@interface ZDMessageDataBase()<NSCopying,NSMutableCopying>{
    FMDatabase  *_db;
    
}

@end

@implementation ZDMessageDataBase
+ (instancetype) sharedDataBase{
    if (_messageDataBase == nil) {
         @synchronized(self) {
        _messageDataBase = [[ZDMessageDataBase alloc]init];
        
        [_messageDataBase initDataBase];
         }
        
    }
    return _messageDataBase;
}
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    if (_messageDataBase == nil) {
         @synchronized(self) {
        _messageDataBase = [super allocWithZone:zone];
         }
        
    }
    
    return _messageDataBase;
    
}
-(id)copy{
    
    return self;
    
}

-(id)mutableCopy{
    
    return self;
    
}

-(id)copyWithZone:(NSZone *)zone{
    
    return self;
    
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    
    return self;
    
}
- (void)initDataBase{

    // 获得Documents目录路径
//    
//    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    
//    // 文件路径
//    
//    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"messageModel.sqlite"];
//    _db = [FMDatabase databaseWithPath:filePath];
    // 实例化FMDataBase对象
    
    _db = [FMDatabase databaseWithPath:@"/Users/jack/Public/iOS/messageFmdb.db"];
    
    [_db open];
    // 初始化数据表
    NSString *goodsSql = @"CREATE TABLE IF NOT EXISTS goods (id INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,goods_identifier VARCHAR(255),goods_name VARCHAR(255),goods_remark VARCHAR(255),goods_imageData blob,goods_dateOfStart VARCHAR(255),goods_dateOfEnd VARCHAR(255),goods_saveTime VARCHAR(255),goods_sum VARCHAR(255),goods_ratio VARCHAR(255))";
    [_db executeUpdate:goodsSql];
    
    [_db close];
    
}
#pragma mark - 接口

- (void)addGoods:(ZDGoods *)goods{
    [_db open];
    NSNumber *maxID = @(0);
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM goods "];
    //获取数据库中最大的ID
    while ([res next]) {
        if ([maxID integerValue] < [[res stringForColumn:@"goods_id"] integerValue]) {
            maxID = @([[res stringForColumn:@"goods_id"] integerValue] ) ;
        }
        
    }
    maxID = @([maxID integerValue] + 1);
    
    
    [_db executeUpdate:@"INSERT INTO goods(goods_identifier,goods_name,goods_remark,goods_imageData,goods_dateOfStart,goods_dateOfEnd,goods_saveTime,goods_sum,goods_ratio)VALUES(?,?,?,?,?,?,?,?,?)",maxID,goods.name,goods.remark,goods.imageData,goods.dateOfStart,goods.dateOfEnd,goods.saveTime,goods.sum,goods.ratio];
    
    
    [_db close];
    
}
//deleteGoods
- (void)deleteGoods:(ZDGoods *)goods{
    [_db open];
    
    [_db executeUpdate:@"DELETE FROM goods WHERE goods_identifier = ?",goods.identifier];
    
    [_db close];
}
//修改数据
-(void)updateGoods:(ZDGoods*)goods
{
    [_db open];
    BOOL result = [_db executeUpdate:@"UPDATE goods SET goods_sum = ? WHERE goods_identifier = ?",goods.sum,goods.identifier];
    
    if(result){
        NSLog(@"更新数据成功");

    }else{
        NSLog(@"更新数据失败");
    }
    [_db close];
}
- (NSMutableArray *)getAllGoods{
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM goods"];
    while ([res next]) {
        
        ZDGoods *goods = [[ZDGoods alloc] init];
        goods.identifier = @([[res stringForColumn:@"goods_identifier"]integerValue]);
        goods.name = [res stringForColumn:@"goods_name"];
        goods.remark = [res stringForColumn:@"goods_remark"];
        goods.imageData = [res dataForColumn:@"goods_imageData"];
        goods.dateOfStart = [res stringForColumn:@"goods_dateOfStart"];
        goods.dateOfEnd = [res stringForColumn:@"goods_dateOfEnd"];
        goods.saveTime = [res stringForColumn:@"goods_saveTime"];
        goods.sum = [res stringForColumn:@"goods_sum"];
        goods.ratio = ([[res stringForColumn:@"goods_ratio"]doubleValue]);
        [dataArray addObject:goods];

    }
    
    [_db close];
    return dataArray;
}
@end
