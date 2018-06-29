//
//  ZDUser.h
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDUser : NSObject
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *personalitySignature;
@property(nonatomic,strong) NSData *headPictureData;

@end
