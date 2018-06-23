//
//  ZDSearchViewModel.h
//  LifeDiary
//
//  Created by JACK on 2018/6/23.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "RACSubject.h"

@interface ZDSearchViewModel : NSObject<UITableViewDelegate,
UITableViewDataSource>

@property(nonatomic, strong) RACSubject *rac_update;
@property (nonatomic, strong) NSMutableArray *dataArray; //存储数据
@property (nonatomic, strong) NSMutableArray *afterFilterDataArray; // 搜索得到的数据

- (void)dealData;
- (void)filterObjectsWithKeyWords:(NSString *)words;
@end
