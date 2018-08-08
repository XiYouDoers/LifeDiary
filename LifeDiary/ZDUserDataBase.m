//
//  ZDUserDataBase.m
//  LifeDiary
//
//  Created by JACK on 2018/6/24.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDUserDataBase.h"
#import "FMDB.h"
#import "ZDUser.h"

@implementation ZDUserDataBase{
    FMDatabase *_db;
}
+ (instancetype) sharedDataBase{
    
    static ZDUserDataBase *userDataBase = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userDataBase = [[ZDUserDataBase alloc]init];
        
        [userDataBase initDataBase];
        
    });
    return userDataBase;
}


- (void)initDataBase{
    
    NSString *filepath = [[NSString alloc]init];
    if(TARGET_IPHONE_SIMULATOR){
        
        filepath = @"/Users/jack/Public/iOS/userFmdb.db";
    }else{
        // 获得Documents目录路径
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        filepath = [documentsPath stringByAppendingPathComponent:@"messageModel.sqlite"];
    }
    
    _db = [FMDatabase databaseWithPath:filepath];

    // 实例化DataBase对象
    [_db open];
    // 初始化数据表
    NSString *goodsSql = @"CREATE TABLE IF NOT EXISTS user (id INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,user_name VARCHAR(255),user_personalitySignature VARCHAR(255),user_headPictureData blob)";
    [_db executeUpdate:goodsSql];
    
    [_db close];
    
}
-(void)dropDataBase
{
    [_db executeUpdate:@"drop table if exists user"];

}
- (void)updateUser:(ZDUser *)user{
    [_db open];
    
    [_db executeUpdate:@"update user",user.name];
    
    
    [_db close];
    
}
- (ZDUser *)getUserInfo{
    [_db open];
    
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM user"];
    ZDUser *user = [[ZDUser alloc] init];
    [res next];
        
        user.name = [res stringForColumn:@"user_name"];
//        user.perso  alitySignature = [res stringForColumn:@"user_personalitySignature"];
        user.headPictureData = [res dataForColumn:@"user_headPictureData"];
    
    [_db close];
    
    return user;
}

@end
