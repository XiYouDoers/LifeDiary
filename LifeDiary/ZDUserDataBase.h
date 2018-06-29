//
//  ZDUserDataBase.h
//  LifeDiary
//
//  Created by JACK on 2018/6/24.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZDUser.h"
@interface ZDUserDataBase : NSObject

+ (instancetype)sharedDataBase;
- (ZDUser *)getUserInfo;
- (void)updateUser:(ZDUser *)user;
- (void)initDataBase;
@end
