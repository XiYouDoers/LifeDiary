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

@interface ZDMeViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate>{
    NSUserDefaults *_userDefaults;
    
}
@property(nonatomic,copy) NSArray *cellLabelDataArray;
@property(nonatomic,copy) NSArray *cellImageDataArray;
@property(nonatomic,strong) ZDMeTableHeaderView *tableHeaderView;


@end

@implementation ZDMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] init];
//    self.view.backgroundColor = [UIColor grayColor];
    backBtnItem.title = @"我的";
    self.navigationItem.backBarButtonItem = backBtnItem;
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    
    _meTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _meTableView.dataSource = self;
    _meTableView.delegate = self;
    _meTableView.scrollEnabled=NO;
    _meTableView.sectionHeaderHeight = 0.01f;
    _meTableView.sectionFooterHeight = 12.f;
    _meTableView.tableHeaderView= self.tableHeaderView;
    _meTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_meTableView];
    [_meTableView registerClass:[ZDMeDefaultCell class] forCellReuseIdentifier:@"meDefaultCell"];

    _cellLabelDataArray = [NSArray arrayWithObjects:@"回收站",@"耗尽物品",@"过期物品",@"关于", nil];
    _cellImageDataArray = [NSArray arrayWithObjects:@"recycle",@"expire", @"deplete", nil];    // Do any additional setup after loading the view.
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

- (ZDMeTableHeaderView *)tableHeaderView{
    if (!_tableHeaderView) {
        if(iPhoneX){
        _tableHeaderView = [[ZDMeTableHeaderView alloc]initWithFrame:CGRectMake(0, -50, WIDTH, HEIGHT/2)];
        }else{
        _tableHeaderView = [[ZDMeTableHeaderView alloc]initWithFrame:CGRectMake(0, -20, WIDTH, HEIGHT/5*2)];
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
    
    ZDPhotoManagerViewController *photoManagerVC = [[ZDPhotoManagerViewController alloc]initWithController:self Button:_tableHeaderView.headPictureButton];

    [photoManagerVC selectedWay];
}


/**
 section中cell的数量
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    if (section==0) {
         return 3;
    }else{
        return 1;
    }
}
/**
 TableView中section的数量
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 
    return 2;
   
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 55.f;
}
/**
 cell的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return 50;
    }else{
        return 50;
    }
}

/**
 cell数据源
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    if (indexPath.section==0){
    _meCell = [tableView dequeueReusableCellWithIdentifier:@"meDefaultCell"];
    _meCell.selectionStyle = UITableViewCellEditingStyleNone;
    _meCell.tabLabel.text = [_cellLabelDataArray objectAtIndex:indexPath.row];
    _meCell.tabImageView.image = [UIImage imageNamed:[_cellImageDataArray objectAtIndex:indexPath.row]];
          return _meCell;
    }else{
        _meCell = [tableView dequeueReusableCellWithIdentifier:@"meDefaultCell"];
        _meCell.selectionStyle = UITableViewCellEditingStyleNone;
 
        _meCell.tabLabel.text = @"关于";
        _meCell.tabImageView.image = [UIImage imageNamed:@"about"];
        return _meCell;
    }
}
/**
 cell点击方法
 
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
       if(indexPath.section==0){
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

