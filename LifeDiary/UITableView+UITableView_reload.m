//
//  UITableView+UITableView_reload.m
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "UITableView+UITableView_reload.h"
#import <objc/runtime.h>

@implementation UITableView (UITableView_reload)
+ (void)load {
    
    Method reloadData = class_getInstanceMethod(self, @selector(reloadData));
    
    Method xy_reloadData = class_getInstanceMethod(self, @selector(xy_reloadData));
    
    method_exchangeImplementations(reloadData, xy_reloadData);
    
}
- (void)xy_reloadData {
    
    [self xy_reloadData];
    
    // 刷新完成之后检测数据量
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSInteger numberOfSections = [self numberOfSections];
        
        BOOL havingData = NO;
        
        for (NSInteger i = 0; i < numberOfSections; i++) {
            
            if ([self numberOfRowsInSection:i] > 0) {
                
                havingData = YES;
                
                break;
                
            }
            
        }
        
        [self xy_havingData:havingData];
        
    });
    
}
- (void)xy_havingData:(BOOL)havingData {
    //占位图问题未解决
    if (havingData) {
        
        self.backgroundView = nil;
        
    } else {
        UIView *backgroundView =[[ UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
   
        UILabel *noViewLabel = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-50,[UIScreen mainScreen].bounds.size.height/2-40, 100, 20)];
        noViewLabel.textAlignment = NSTextAlignmentCenter;
        noViewLabel.text = @"空空如也...";
        noViewLabel.textColor = [UIColor lightGrayColor];
        [backgroundView addSubview:noViewLabel];
        self.backgroundView = backgroundView;
        
    }
    
}
@end
