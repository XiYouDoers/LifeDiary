//
//  ZDMeViewController.m
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDMeViewController.h"
#import "ZDRecycleViewController.h"
#import "ZDExpireViewController.h"
#import "ZDDepleteViewController.h"
#import "ZDAboutViewController.h"
#import "ZDMeTableHeaderView.h"
#import "ZDPhotoManagerViewController.h"
#import "ZDGoods.h"
#import "ZDMeDefaultCell.h"

@interface ZDMeViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate,ZDMeTableHeaderViewDelegate,ZDPhotoManagerViewControllerDelegate>{
    NSUserDefaults *_userDefaults;
    
}
@property(nonatomic,copy) NSArray *cellLabelDataArray;
@property(nonatomic,copy) NSArray *cellImageDataArray;
@property(nonatomic,strong) ZDMeTableHeaderView *tableHeaderView;


@end

@implementation ZDMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigationBar];
    _meTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    _meTableView.dataSource = self;
    _meTableView.delegate = self;
    _meTableView.scrollEnabled = YES;
    _meTableView.sectionHeaderHeight = 12.f;
    _meTableView.sectionFooterHeight = 0.01f;
    _meTableView.backgroundColor = [UIColor whiteColor];
    _meTableView.tableHeaderView= self.tableHeaderView;
    self.tableHeaderView.degegate = self;
    _meTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.view addSubview:_meTableView];
    [_meTableView registerClass:[ZDMeDefaultCell class] forCellReuseIdentifier:@"meDefaultCell"];

    _cellLabelDataArray = [NSArray arrayWithObjects:@"设置",@"反馈",@"收藏",@"关于", nil];
    _cellImageDataArray = [NSArray arrayWithObjects:@"recycle",@"expire", @"deplete",@"about", nil];    // Do any additional setup after loading the view.
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
- (void)setNavigationBar{
    
    //设置NavigationBar是否透明
    self.navigationController.navigationBar.translucent = NO;
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] init];
    //    self.view.backgroundColor = [UIColor grayColor];
    backBtnItem.title = @"我的";
    self.navigationItem.backBarButtonItem = backBtnItem;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    //改变BarButtonItem图片颜色
    self.navigationController.navigationBar.tintColor = BARBUTTONITEMCOLOR;


}
- (ZDMeTableHeaderView *)tableHeaderView{
    
    if (_tableHeaderView == nil) {
        if(iPhoneX){
        _tableHeaderView = [[ZDMeTableHeaderView alloc]initWithFrame:CGRectMake(0, -50, WIDTH, HEIGHT*0.72)];
        }else{
        _tableHeaderView = [[ZDMeTableHeaderView alloc]initWithFrame:CGRectMake(0, -20, WIDTH, HEIGHT*0.72)];
        }
        _userDefaults = [NSUserDefaults standardUserDefaults];
        if ([_userDefaults stringForKey:@"user_name"]) {
            _tableHeaderView.nameTextField.text = [_userDefaults stringForKey:@"user_name"];
        }else{
            _tableHeaderView.nameTextField.text = @"LifeDiary";
        }
        if ([_userDefaults stringForKey:@"user_personalitySignature"]) {
            _tableHeaderView.personalitySignatureTextField.text = [_userDefaults stringForKey:@"user_personalitySignature"];
        }else{
            _tableHeaderView.personalitySignatureTextField.text = @"没有个性，何来签名";
        }
        _tableHeaderView.nameTextField.delegate = self;
        _tableHeaderView.personalitySignatureTextField.delegate = self;
        [_tableHeaderView.headPictureButton addTarget:self action:@selector(willChangeHeadPicture) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tableHeaderView;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self saveToUserDeafault];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [_tableHeaderView.nameTextField resignFirstResponder];
    [_tableHeaderView.personalitySignatureTextField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self saveToUserDeafault];
    return YES;
}

- (void)saveToUserDeafault{
    
    [_userDefaults setObject:_tableHeaderView.nameTextField.text forKey:@"user_name"];
    [_userDefaults setObject:_tableHeaderView.personalitySignatureTextField.text forKey:@"user_personalitySignature"];
    [_userDefaults synchronize];
}
- (void)willChangeHeadPicture{
    ZDPhotoManagerViewController *photoManagerVC = [[ZDPhotoManagerViewController alloc]init];
    photoManagerVC.delegate = self;
    [photoManagerVC selectedWay];
}


/**
 section中cell的数量
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return 4;
}

/**
 TableView中section的数量
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 
    return 1;
   
}
/**
 cell的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

/**
 cell数据源
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    _meCell = [tableView dequeueReusableCellWithIdentifier:@"meDefaultCell"];
    _meCell.tabLabel.text = [_cellLabelDataArray objectAtIndex:indexPath.row];
    return _meCell;
}
/**
 cell点击方法
 
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==3) {
        ZDAboutViewController *aboutVC = [[ZDAboutViewController alloc]init];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
}

@end

