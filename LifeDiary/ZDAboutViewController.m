//
//  ZDAboutViewController.m
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDAboutViewController.h"

@interface ZDAboutViewController ()
@property(nonatomic,strong) UILabel *projectInfoLabel;
@property(nonatomic,strong) UIImageView *projectPictureImageView;
@end

@implementation ZDAboutViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"关于";
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view NightWithType:UIViewColorTypeBlue];
    UIImageView *appHeadPictureImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"appHeadPictureImageView"]];
        [self.view addSubview:appHeadPictureImageView];
    [appHeadPictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(HEIGHT/5);
        make.left.mas_equalTo((WIDTH-70)/2);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];

    
    UILabel *appNameLabel = [[UILabel alloc]init];
    appNameLabel.text = @"LifeDiary";
    appNameLabel.font  = [UIFont systemFontOfSize:15];
    appNameLabel.textAlignment =  NSTextAlignmentCenter;
    [self.view addSubview:appNameLabel];
    [appNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(appHeadPictureImageView.mas_bottom).with.offset(10);
        make.centerX.mas_equalTo(appHeadPictureImageView);
        make.size.mas_equalTo(CGSizeMake(70, 30));
        
    }];
    
    UILabel *sourceLabel = [[UILabel alloc]init];
    sourceLabel.text = @"西邮移动应用开发实验室";
    sourceLabel.font  = [UIFont systemFontOfSize:12];
    sourceLabel.textAlignment =  NSTextAlignmentCenter;
    [self.view addSubview:sourceLabel];
    [sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo((WIDTH-150)/2);
        make.bottom.mas_equalTo(-20);
        make.size.mas_equalTo(CGSizeMake(150, 20));
        
    }];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


@end
