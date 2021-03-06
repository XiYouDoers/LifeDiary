//
//  ZDLinkViewController.m
//  LifeDiary
//
//  Created by Jack on 2018/7/18.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDLinkViewController.h"
#import "ZDHtmlScrollView.h"
#import "ZDOrderModel.h"

@interface ZDLinkViewController ()

@end

@implementation ZDLinkViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    //rightBarButtonItem
    UIBarButtonItem *shareBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareToOther)];
    if (@available(iOS 11.0, *)) {
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
    } else {
        // Fallback on earlier versions
    }
    
    [shareBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:BARBUTTONITEMCOLOR} forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = shareBarButtonItem;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    _htmlScrollView = [[ZDHtmlScrollView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-20)];
    
    [_htmlScrollView updateHtmlView:_contentlistModel];
    [self.view addSubview: _htmlScrollView];
    
    
}


- (void)shareToOther{
    //分享的标题

        NSString *textToShare = [NSString stringWithFormat:@"%@",_contentlistModel.title];
        UIImage *imageToShare;
        if (_contentlistModel.imageurls.count) {
            ZDPicModel *picModel = _contentlistModel.imageurls[0];
            NSData *imageData = [NSData dataWithContentsOfURL:picModel.url];
            //分享的图片
            imageToShare = [UIImage imageWithData:imageData];
        }
    
    
        //分享的url
        NSURL *urlToShare = [NSURL URLWithString:[NSString stringWithFormat:@"%@",_contentlistModel.link]];
    
//    在这里呢 如果想分享图片 就把图片添加进去  文字什么的通上
    NSArray *activityItems = @[textToShare,imageToShare, urlToShare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    //不出现在活动项目
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    [self presentViewController:activityVC animated:YES completion:nil];
    // 分享之后的回调
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed) {
            //分享 成功
        } else  {
            //分享 取消
        }
    };
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    CGRect  tabRect = self.tabBarController.tabBar.frame;
    //下移tabBar
    tabRect.origin.y = [[UIScreen mainScreen] bounds].size.height+self.tabBarController.tabBar.frame.size.height;
    [UIView animateWithDuration:0.5f animations:^{
        self.tabBarController.tabBar.frame = tabRect;
    }completion:^(BOOL finished) {
        
    }];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //上移tabBar
    CGRect  tabRect = self.tabBarController.tabBar.frame;
    tabRect.origin.y = [[UIScreen mainScreen] bounds].size.height-self.tabBarController.tabBar.frame.size.height;
    [UIView animateWithDuration:0.5f animations:^{
        self.tabBarController.tabBar.frame = tabRect;
    }completion:^(BOOL finished) {
        
    }];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
