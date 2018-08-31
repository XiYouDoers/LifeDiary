//
//  HUDUtil.m
//  sdata
//
//  Created by 白静 on 5/21/16.
//  Copyright © 2016 Netease Youdao. All rights reserved.
//

#import "HUDUtil.h"
#import "MBProgressHUD.h"
@implementation HUDUtil
+(void)show:(UIView *)view text:(NSString *)text{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    HUD.mode = MBProgressHUDModeCustomView;// MBProgressHUDModeText;
    HUD.labelText = text;
    //显示对话框
    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(1);
    } completionBlock:^{
        [HUD removeFromSuperview];
    }];
}
@end
