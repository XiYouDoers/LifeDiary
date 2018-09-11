//
//  ZDAllViewController.m
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//
#define cellWidth  100
#define cellHeight  90
#import "ZDAllViewController.h"
#import "ZDAllDataBase.h"
#import "ZDRecycleDataBase.h"
#import "ZDRoundView.h"
#import "ZDEditViewController.h"
#import "ZDAllCell.h"
#import "ZDMessageCell.h"
#import "ZDAllCollectionViewCell.h"
#import "ZDSortView.h"
#import "HUDUtil.h"


@interface ZDAllViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,ZDAllCellDelegate,ZDSortViewDelegate,ZDEditVCDelegate>{
    NSDateFormatter *_dateFormatter;
    ZDSortView *_sortView;
    NSMutableDictionary *selectedIndexes;
    NSIndexPath *lastIndexPath;
    BOOL isReclickCell;
    BOOL isSorted;
}
@property(nonatomic,strong) UIView *sortView;
@end

@implementation ZDAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [self setNavigationBar];

    [self.view NightWithType:UIViewColorTypeNormal];
    selectedIndexes = [NSMutableDictionary dictionary];
    self.view.backgroundColor = [UIColor whiteColor];
   
    //_allTableView
    _allTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+54, WIDTH, HEIGHT-(64+54)) style:UITableViewStylePlain];
    //取消cell间的分割线
    _allTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _allTableView.dataSource = self;
    _allTableView.delegate = self;
    //是否展示竖直滚动条
    _allTableView.showsVerticalScrollIndicator = YES;
    _allTableView.backgroundColor = [UIColor colorWithDisplayP3Red:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    [_allTableView NightWithType:UIViewColorTypeNormal];
    _allTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_allTableView];
    [_allTableView registerClass:[ZDAllCell class] forCellReuseIdentifier:@"allCell"];
    [self.view addSubview: self.searchView];
    
    
    //sortView
    _sortView = [[ZDSortView alloc]initWithFrame:CGRectMake(0, 64+54, WIDTH, 155+50)];
    _sortView.delegate = self;
    _sortView.hidden = YES;
    [self.view addSubview:_sortView];
    
    
}
- (void)setNavigationBar{
   
    //backBarButtonItem
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] init];
    backBtnItem.title = @"全部";
    self.navigationItem.backBarButtonItem = backBtnItem;
    if (@available(iOS 11.0, *)) {
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
    } else {
        
    }
}
- (void)openRepertory{
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //隐藏顶部tabbar分割线
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    _dataMutableArray = [NSMutableArray array];
    _dataMutableArray = [[ZDAllDataBase sharedDataBase]getAllGoods];
    _resultMutableArray = [NSMutableArray array];
    _sortMutableArray = [NSMutableArray array];
    [self.allTableView reloadData];
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
    [self.navigationController.navigationBar setShadowImage:nil];
}


#pragma mark - searchbar
- (UIView *)searchView
{
    if (!_searchView) {
        _searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, 54)];
        _searchView.backgroundColor = [UIColor whiteColor];
        [_searchView NightWithType:UIViewColorTypeNormal];
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 7, WIDTH-20, 40)];
        _searchBar.backgroundColor = [UIColor clearColor];
//        _searchBar.layer.masksToBounds = YES;
//        _searchBar.layer.cornerRadius = 20.f;
        _searchBar.showsCancelButton = NO;
        _searchBar.tintColor = [UIColor whiteColor];
        _searchBar.placeholder = @"搜索物品";
        _searchBar.delegate = self;
        
        for (UIView *subView in _searchBar.subviews) {
            if ([subView isKindOfClass:[UIView  class]]) {
                [[subView.subviews objectAtIndex:0] removeFromSuperview];
                if ([[subView.subviews objectAtIndex:0] isKindOfClass:[UITextField class]]) {
                    
                    
                    UITextField *textField = [subView.subviews objectAtIndex:0];
                    textField.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
                    textField.layer.masksToBounds = YES;
                    textField.layer.cornerRadius = 20.f;
                    
                    //设置输入框边框的颜色
                    //                    textField.layer.borderColor = [UIColor blackColor].CGColor;
                    //                    textField.layer.borderWidth = 1;
                    
                    //设置输入字体颜色
                    //                    textField.textColor = [UIColor lightGrayColor];
                    
                    //设置默认文字颜色
                    UIColor *color = [UIColor whiteColor];
                    [textField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"搜索物品"
                                                                                        attributes:@{NSForegroundColorAttributeName:color}]];
                    //修改默认的放大镜图片
                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
                    imageView.backgroundColor = [UIColor clearColor];
                    imageView.image = [UIImage imageNamed:@"放大镜"];
                    textField.leftView = imageView;
                    textField.tintColor = [UIColor whiteColor];
                }
            }
        }
        
        
        [_searchView addSubview:_searchBar];
        
        
        _sortButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH-54+10, 13, 27,29)];
        _sortButton.backgroundColor = [UIColor clearColor];
        _sortButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        UIImage *sortImage = [UIImage imageNamed:@"sortNormal"];
        sortImage = [sortImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_sortButton setImage:sortImage forState:UIControlStateNormal];
        [_sortButton setImage:[UIImage imageNamed:@"sortSelected"] forState:UIControlStateSelected];
        [_sortButton setTitleColor:LIGHTBLUE forState:UIControlStateNormal];
        [_sortButton setTitleColor:LIGHTBLUE forState:UIControlStateHighlighted];
        _sortButton.hidden= YES;
        [_searchView addSubview:_sortButton];
        [_sortButton addTarget:self action:@selector(sortTouched:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _searchView;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];

}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.searchBar becomeFirstResponder];
    searchBar.frame = CGRectMake(10, 5, WIDTH-54-10, 44);
    _sortButton.hidden = NO;
}
// 滑动收起键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView == self.allTableView) {
        [self.searchBar resignFirstResponder];
    }
}
#pragma SortViewDelegte
- (void)confirmToSort:(NSString *)classString sort:(NSString *)sortString{
    isSorted = NO;
    [_sortMutableArray removeAllObjects];
    if ([classString isEqualToString:@"全部"]) {
        [_sortMutableArray removeAllObjects];
    }else{
    for (ZDGoods *goods in _dataMutableArray) {
        isSorted = YES;
        if ([goods.family isEqualToString:classString]) {
            [_sortMutableArray addObject:goods];
        }
    }
    }

    [self sortTouched:_sortButton];
    [self.allTableView reloadData];
}
- (void)hiddenSortView{
    [self sortTouched:_sortButton];
}
#pragma sortButton点击事件
- (void)sortTouched:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [UIView animateWithDuration:0.3 animations:^{

            self.allTableView.frame = CGRectMake(0, 64+54+180+50, WIDTH, HEIGHT-(64+54+180));
        }];
        [NSTimer scheduledTimerWithTimeInterval:0.3 repeats:NO block:^(NSTimer * _Nonnull timer) {
        [UIView animateWithDuration:0.2 animations:^{
            _sortView.hidden = NO;
        }];
        }];
        
    }else{
        
        [UIView animateWithDuration:0.2 animations:^{
            _sortView.hidden = YES;
        }];
        [NSTimer scheduledTimerWithTimeInterval:0.2 repeats:NO block:^(NSTimer * _Nonnull timer) {
            [UIView animateWithDuration:0.3 animations:^{
                self.allTableView.frame = CGRectMake(0, 64+54, WIDTH, HEIGHT-(64+54));
            }];
        }];
        
       
    }
    
    [self.searchBar resignFirstResponder];

}
#pragma mark - tableView代理方法
/**
 section中cell的数量
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.resultMutableArray.count) {
        return [self.resultMutableArray count];
    }else if (isSorted){
        
        return [self.sortMutableArray count];
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
- (BOOL)cellIsSelected:(NSIndexPath*)indexPath {
    
    // Return whether the cell at the specified index path is selected or not
    
    NSNumber *selectedIndex = [selectedIndexes objectForKey:indexPath];
    
    return selectedIndex == nil ? FALSE : [selectedIndex boolValue];
    
}
/**
 cell的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([self cellIsSelected:indexPath]) {
        ZDAllCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [UIView animateWithDuration:0.3 animations:^{
            cell.manageView.frame = CGRectMake(87.5, 140, 200, 40);
        }];
        return 160+50;
    }
    return 160;
    
}
//搜框中输入关键字的事件响应
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    //需要事先清理存放搜索结果的数组
    [self.resultMutableArray removeAllObjects];
    
    //加个多线程，否则数量量大的时候，有明显的卡顿现象
    //这里最好放在数据库里面再进行搜索，效率会更快一些
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    dispatch_async(globalQueue, ^{
        if (searchText != nil && searchText.length > 0) {
            
            //遍历需要搜索的所有内容w，其中dataMutableArray为存放总数据的数组
            for (ZDGoods *goods in self.dataMutableArray) {
                NSString *tempStr = goods.name;
                //
                //----------->把所有的搜索结果转成成拼音
                //                NSString *pinyin = [self transformToPinyin:searchText];
                
                if ([tempStr rangeOfString:searchText options:NSCaseInsensitiveSearch].length >0 ) {
                    //把搜索结果存放self.resultArray数组
                    [self.resultMutableArray addObject:goods];
                }
            }
            
        }
        //回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.allTableView reloadData];
        });
    });
}
- (NSString *)transformToPinyin:(NSString *)aString
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    NSArray *pinyinArray = [str componentsSeparatedByString:@" "];
    NSMutableString *allString = [NSMutableString new];
    
    int count = 0;
    
    for (int  i = 0; i < pinyinArray.count; i++)
    {
        
        for(int i = 0; i < pinyinArray.count;i++)
        {
            if (i == count) {
                [allString appendString:@"#"];//区分第几个字母
            }
            [allString appendFormat:@"%@",pinyinArray[i]];
            
        }
        [allString appendString:@","];
        count ++;
        
    }
    
    NSMutableString *initialStr = [NSMutableString new];//拼音首字母
    
    for (NSString *s in pinyinArray)
    {
        if (s.length > 0)
        {
            
            [initialStr appendString:  [s substringToIndex:1]];
        }
    }
    
    [allString appendFormat:@"#%@",initialStr];
    [allString appendFormat:@",#%@",aString];
    
    return allString;
}

/**
 cell数据源
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _allCell = [tableView dequeueReusableCellWithIdentifier:@"allCell" forIndexPath:indexPath];
    _allCell.delegate = self;
    ZDGoods *goods = [[ZDGoods alloc]init];
    if (self.resultMutableArray.count) {

        goods = _resultMutableArray[indexPath.row];
    }else  if (isSorted){

        goods = _sortMutableArray[indexPath.row];
    }else{

        goods = _dataMutableArray[indexPath.row];
    }
    
    [_allCell setData:goods];
    return _allCell;
    
}

/**
 cell点击方法
 
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (isReclickCell && (lastIndexPath.row != indexPath.row) && [self cellIsSelected:lastIndexPath]) {

        NSNumber *selectedIndex = [NSNumber numberWithBool:NO];
        [selectedIndexes setObject:selectedIndex forKey:lastIndexPath];
           _allCell.manageView.frame = CGRectMake(87.5, 100, 200, 40);
        [UIView animateWithDuration:0.4 animations:^{
            [self.allTableView layoutIfNeeded];
        }];
        
    }

    BOOL isSelected = ![self cellIsSelected:indexPath];
    NSNumber *selectedIndex = [NSNumber numberWithBool:isSelected];
    [selectedIndexes setObject:selectedIndex forKey:indexPath];
    
        if ([self cellIsSelected:indexPath]) {
            isReclickCell = 1;
            lastIndexPath = indexPath;
            [NSThread sleepForTimeInterval:0.1];
            
            [self.allTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [UIView animateWithDuration:0.3 animations:^{
                _allCell.manageView.frame = CGRectMake(87.5, 140, 200, 40);
            }];
            
        }else{
            isReclickCell = 0;
            [self.allTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [UIView animateWithDuration:0.3 animations:^{
                _allCell.manageView.frame = CGRectMake(87.5, 100, 200, 40);
            }];
            
        }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5.f;
}
/**
 cell是否可以左滑删除
 
 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}
/**
 cell的删除方法
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
//
//        ZDGoods *deletedGoods = [[ZDGoods alloc]init];
//        if (self.resultMutableArray.count) {
//            //计算在搜索结果中要删除的cell在总数据序列
//            deletedGoods = self.resultMutableArray[indexPath.row];
//            for(ZDGoods *goods in self.dataMutableArray){
//                if (deletedGoods==goods) {
//                    NSInteger index = [self.dataMutableArray indexOfObject:deletedGoods];
//                    deletedGoods = self.dataMutableArray[index];
//                }
//            }
//        }else{
//            deletedGoods = self.dataMutableArray[indexPath.row];
//        }
//
//        // 从数据库中删除
//        [[ZDAllDataBase sharedDataBase]deleteGoods:deletedGoods];
//        //从搜索列表中删除
//        for (ZDGoods *goods in  self.resultMutableArray) {
//            if (goods==deletedGoods) {
//
//                [_resultMutableArray removeObject:deletedGoods];
//            }
//        }
//        // 回收站中添加
//        [[ZDRecycleDataBase sharedDataBase]addGoods:deletedGoods];
//        self.dataMutableArray = [[ZDAllDataBase sharedDataBase]getAllGoods];
//        [self.allTableView reloadData];
        
    }
}


- (void)deleteButtonWasClicked{
    
    //折叠cell
    BOOL isSelected = ![self cellIsSelected:lastIndexPath];
    NSNumber *selectedIndex = [NSNumber numberWithBool:isSelected];
    [selectedIndexes setObject:selectedIndex forKey:lastIndexPath];
    //push
    ZDGoods *deletedGoods = [[ZDGoods alloc]init];
    if (self.resultMutableArray.count) {
        //计算在搜索结果中要删除的cell在总数据序列
        deletedGoods = self.resultMutableArray[lastIndexPath.row];
        for(ZDGoods *goods in self.dataMutableArray){
            if (deletedGoods==goods) {
                NSInteger index = [self.dataMutableArray indexOfObject:deletedGoods];
                deletedGoods = self.dataMutableArray[index];
            }
        }
    }else{
        deletedGoods = self.dataMutableArray[lastIndexPath.row];
    }
    
    // 从数据库中删除
    [[ZDAllDataBase sharedDataBase]deleteGoods:deletedGoods];
    //从搜索列表中删除
    for (ZDGoods *goods in  self.resultMutableArray) {
        if (goods==deletedGoods) {
            
            [_resultMutableArray removeObject:deletedGoods];
        }
    }
    // 回收站中添加
    [[ZDRecycleDataBase sharedDataBase]addGoods:deletedGoods];
    self.dataMutableArray = [[ZDAllDataBase sharedDataBase]getAllGoods];
    [self.allTableView reloadData];
    [HUDUtil show:self.view text:@"删除成功"];

    
}
- (void)exhibitSucceed{
    [HUDUtil show:self.view text:@"修改成功"];
}
- (void)editButtonWasClicked{

    //折叠cell
    BOOL isSelected = ![self cellIsSelected:lastIndexPath];
    NSNumber *selectedIndex = [NSNumber numberWithBool:isSelected];
    [selectedIndexes setObject:selectedIndex forKey:lastIndexPath];
    //push
        ZDGoods *goods =  _dataMutableArray[lastIndexPath.row];
        ZDEditViewController *editVC = [[ZDEditViewController alloc]init];
        editVC.delegate = self;
        editVC.goods = goods;
        [self.navigationController pushViewController:editVC animated:YES];
}



@end
