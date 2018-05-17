//
//  ZDMeViewController.m
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDMeViewController.h"
#import "ZDUserInfoViewController.h"
#import "ZDRecycleViewController.h"
#import "ZDExpireViewController.h"
#import "ZDDepleteViewController.h"
#import "ZDAboutViewController.h"

@interface ZDMeViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
}


@end

@implementation ZDMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] init];
    backBtnItem.title = @"我";
    self.navigationItem.backBarButtonItem = backBtnItem;
    
    self.view.backgroundColor = [UIColor whiteColor];
    _meTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _meTableView.dataSource = self;
    _meTableView.delegate = self;
    _meTableView.scrollEnabled=NO;
    _meTableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectZero];
    _meTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_meTableView];
    [_meTableView registerClass:[ZDMeTopCell class] forCellReuseIdentifier:@"meTopCell"];
    [_meTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"meDefaultCell"];
    
    _cellDataArray = [NSArray arrayWithObjects:@"回收站",@"耗尽物品",@"过期物品",@"关于", nil];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:0.5f animations:^{
        CGRect  tabRect=self.tabBarController.tabBar.frame;
        tabRect.origin.y = [[UIScreen mainScreen] bounds].size.height-self.tabBarController.tabBar.frame.size.height;
        [UIView animateWithDuration:0.5f animations:^{
            self.tabBarController.tabBar.frame = tabRect;
        }completion:^(BOOL finished) {
            
        }];
    }completion:^(BOOL finished) {
        
    }];
    
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

/**
 section中cell的数量
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if(section==1) {
        return 3;
    }else{
        return 1;
    }
}
/**
 TableView中section的数量
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
/**
 cell的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return 90;
    }else if(indexPath.section==0){
        return 50;
    }else{
        return 50;
    }
    
}

/**
 cell数据源
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0&&indexPath.row==0) {
        _topCell = [tableView dequeueReusableCellWithIdentifier:@"meTopCell"];
        _topCell.nameLabel.text = @"LifeDiary";
        _topCell.personalitySignatureLabel.text = @"没有个性，何来签名";
        _topCell.headPictureImageView.image = [UIImage imageNamed:@"headPictureImage"];
            return _topCell;
    }else if (indexPath.section==1){
    _meCell = [tableView dequeueReusableCellWithIdentifier:@"meDefaultCell"];
    _meCell.selectionStyle = UITableViewCellEditingStyleNone;
    _meCell.textLabel.text = [_cellDataArray objectAtIndex:indexPath.row];
          return _meCell;
    }else{
        _meCell = [tableView dequeueReusableCellWithIdentifier:@"meDefaultCell"];
        _meCell.selectionStyle = UITableViewCellEditingStyleNone;

        _meCell.textLabel.text = @"关于";
        return _meCell;
    }
}
/**
 cell点击方法
 
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.row==0) {
        ZDUserInfoViewController *userInfoViewController = [[ZDUserInfoViewController alloc]init];
        [self.navigationController pushViewController:userInfoViewController animated:YES];
    }else if(indexPath.section==1){
        if (indexPath.row==0) {
            ZDRecycleViewController *recycleViewController = [[ZDRecycleViewController alloc]init];
            [self.navigationController pushViewController:recycleViewController animated:YES];
        }else if(indexPath.row==1) {
            ZDExpireViewController *expireViewController = [[ZDExpireViewController alloc]init];
            [self.navigationController pushViewController:expireViewController animated:YES];
        }else if(indexPath.row==2) {
            ZDDepleteViewController *depleteViewController = [[ZDDepleteViewController alloc]init];
            [self.navigationController pushViewController:depleteViewController animated:YES];
        }
    }else{
        //indexPath.section==2&&indexPath.row==0
            ZDAboutViewController *aboutViewController = [[ZDAboutViewController alloc]init];
            [self.navigationController pushViewController:aboutViewController animated:YES];
    }

    
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

