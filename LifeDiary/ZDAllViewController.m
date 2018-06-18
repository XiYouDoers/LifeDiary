//
//  ZDAllViewController.m
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDAllViewController.h"
#import "ZDAllDataBase.h"
#import "ZDRecycleDataBase.h"
#import "ZDRoundView.h"

@interface ZDAllViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>{
    NSDateFormatter *_dateFormatter;
}


@end

@implementation ZDAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //_allTableView
    self.navigationItem.title = @"全部物品";

    _allTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _allTableView.dataSource = self;
    _allTableView.delegate = self;
    _allTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_allTableView];
    [_allTableView registerClass:[ZDAllCell class] forCellReuseIdentifier:@"allCell"];
    

    self.allTableView.tableHeaderView = self.searchView;
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    _dataMutableArray = [NSMutableArray array];
    _dataMutableArray = [[ZDAllDataBase sharedDataBase]getAllGoods];
    //隐藏tabBar
        CGRect  tabRect = self.tabBarController.tabBar.frame;
        tabRect.origin.y = [[UIScreen mainScreen] bounds].size.height+self.tabBarController.tabBar.frame.size.height;
        [UIView animateWithDuration:0.5f animations:^{
            self.tabBarController.tabBar.frame = tabRect;
        }completion:^(BOOL finished) {
            
        }];

    
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIView *)searchView
{
    if (!_searchView) {
        _searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
        _searchView.backgroundColor = [UIColor whiteColor];
        
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
        _searchBar.backgroundColor = [UIColor clearColor];
        _searchBar.showsCancelButton = NO;
        _searchBar.tintColor = [UIColor orangeColor];
        _searchBar.placeholder = @"搜索物品";
        _searchBar.delegate = self;

        for (UIView *subView in _searchBar.subviews) {
            if ([subView isKindOfClass:[UIView  class]]) {
                [[subView.subviews objectAtIndex:0] removeFromSuperview];
                if ([[subView.subviews objectAtIndex:0] isKindOfClass:[UITextField class]]) {
                    
                    
                    UITextField *textField = [subView.subviews objectAtIndex:0];
                    textField.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
                    
                    //设置输入框边框的颜色
                    //                    textField.layer.borderColor = [UIColor blackColor].CGColor;
                    //                    textField.layer.borderWidth = 1;
                    
                    //设置输入字体颜色
                    //                    textField.textColor = [UIColor lightGrayColor];
                    
                    //设置默认文字颜色
                    UIColor *color = [UIColor grayColor];
                    [textField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"搜索物品"
                                                                                        attributes:@{NSForegroundColorAttributeName:color}]];
                    //修改默认的放大镜图片
//                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 13, 13)];
//                    imageView.backgroundColor = [UIColor clearColor];
//                    imageView.image = [UIImage imageNamed:@"gww_search_ misplaces"];
//                    textField.leftView = imageView;
                }
            }
        }
        
        
        [_searchView addSubview:_searchBar];
        
        
        _cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH-70, 0, 60, 44)];
        _cancleBtn.backgroundColor = [UIColor clearColor];
        _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_cancleBtn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        _cancleBtn.hidden= YES;
        [_searchView addSubview:_cancleBtn];
        
        [_cancleBtn addTarget:self action:@selector(cancleBtnTouched) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _searchView;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    // do sth about get search result
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.searchBar becomeFirstResponder];
    searchBar.frame = CGRectMake(0, 0, WIDTH-80, 44);
    _cancleBtn.hidden = NO;

}

- (void)cancleBtnTouched
{
    [self.searchBar resignFirstResponder];
    self.searchBar.frame = CGRectMake(0, 0, WIDTH, 44);
    _cancleBtn.hidden = YES;
}

/**
 section中cell的数量
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.resultMutableArray.count) {
        return [self.resultMutableArray count];
    }else{
        return [self.dataMutableArray count];
    }
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
    return 150;
    
}

/**
 cell数据源
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     _allCell = [tableView dequeueReusableCellWithIdentifier:@"allCell"];
    ZDGoods *goods = [[ZDGoods alloc]init];
    if (self.resultMutableArray==nil) {

    goods = _dataMutableArray[indexPath.row];
    }else{
        
    goods = _resultMutableArray[indexPath.row];
    }
    
    _allCell.nameLabel.text = goods.name;
    _allCell.remarkLabel.text = goods.remark;
    _allCell.pictureImageView.image = [UIImage imageWithData:goods.imageData];
    _allCell.dateOfstartLabel.text = [NSString stringWithFormat:@"起始%@",goods.dateOfStart];
    _allCell.dateOfEndLabel.text = [NSString stringWithFormat:@"截止%@",goods.dateOfEnd];
    _allCell.saveTimeLabel.text = [NSString stringWithFormat:@"保质期%@",goods.saveTime];
     _allCell.sumLabel.text = [NSString stringWithFormat:@"数量：%@",goods.sum];
    //计算出保质期的时间戳
    NSDate *dateOfStart = [_dateFormatter dateFromString:goods.dateOfStart];
    NSDate *dateOfEnd = [_dateFormatter dateFromString:goods.dateOfEnd];
    NSTimeInterval timeIntervalOfStart = [dateOfStart timeIntervalSince1970];
    NSTimeInterval timeIntervalOfEnd = [dateOfEnd timeIntervalSince1970];
    [_allCell setArc:goods.ratio saveTimeTimeInterval:timeIntervalOfEnd-timeIntervalOfStart];
    
    return _allCell;
    
}
/**
 cell点击方法
 
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZDAllCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    if (selectedCell.selected==YES) {
        selectedCell.selected = !selectedCell.selected;
       
    }
}
/**
 cell是否可以左滑删除

 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
/**
 cell的删除方法

 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
     if (editingStyle == UITableViewCellEditingStyleDelete) {
         
         ZDGoods *deletedGoods = self.dataMutableArray[indexPath.row];
    // 从数据库中删除
         [[ZDAllDataBase sharedDataBase]deleteGoods:deletedGoods];
    // 回收站中添加
         [[ZDRecycleDataBase sharedDataBase]addGoods:deletedGoods];
         self.dataMutableArray = [[ZDAllDataBase sharedDataBase]getAllGoods];
         [self.allTableView reloadData];

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
