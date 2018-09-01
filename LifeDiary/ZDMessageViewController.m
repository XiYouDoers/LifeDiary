//
//  ZDMessageViewController.m
//  LifeDiary
//
//  Created by JACK on 2018/5/16.
//  Copyright © 2018年 JACK. All rights reserved.
//
#define HEIGHT_REFRESH 64+50.f
#import "ZDMessageViewController.h"
#import "ZDMessageDataBase.h"
#import "ZDAllDataBase.h"
#import "ZDExpireDataBase.h"
#import "ZDDepleteDataBase.h"
#import "ZDAllViewController.h"
#import "ZDAddViewController.h"
#import "ZDEditViewController.h"
#import "ZDMessageCollectionViewCell.h"
#import "ZDDetailView.h"
#import "ZDMessageCardView.h"
#import "ZDMeViewController.h"

#import <UserNotifications/UNUserNotificationCenter.h>
#import <UserNotifications/UNNotificationContent.h>
#import <UserNotifications/UNNotificationSound.h>
#import <UserNotifications/UNNotificationTrigger.h>
#import <UserNotifications/UNNotificationRequest.h>

NSDateFormatter const *_formatter;
@interface ZDMessageViewController () <ZDMessageCardViewDelegate>{
    ZDMessageCollectionViewCell *_tempCell;
}

@property(nonatomic,strong) UISegmentedControl *segmentControl;
@property(nonatomic,strong) UIRefreshControl *refreshControl;
@property(nonatomic,strong) ZDMessageCardView *messageCardView;
@property(nonatomic,strong) ZDDetailView *detailView;
@property(nonatomic,strong) NSMutableArray *allDataMutableArray;
@property(nonatomic,assign) bool isHiddenTabBar;

/**
 用来保存上一次滑动后的位置y参数
 */
@property(nonatomic,assign) CGFloat historyY;

@end

@implementation ZDMessageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setNavigationBar];
    _formatter = [[NSDateFormatter alloc]init];
    [_formatter setDateFormat:@"yyyy-MM-dd"];
    self.view.backgroundColor = [UIColor whiteColor];

    
    _tempCell = [[ZDMessageCollectionViewCell alloc]init];
    
    [self addMessageCardView];
    //_detailView
    _detailView = [[ZDDetailView alloc]init];
    _detailView.frame = CGRectMake(0, HEIGHT-49, WIDTH, 49);
    [_detailView.stepper addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_detailView];
    
    

    // Do any additional setup after loading the view.
}
- (void)addMessageCardView{
    _messageCardView = [[ZDMessageCardView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _messageCardView.delegate = self;
    [self.view addSubview:_messageCardView];
}
- (void)valueChanged:(UIStepper *)stepper{
    
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:stepper.tag - 200 inSection:0];
//    ZDMessageCollectionViewCell *cell = (ZDMessageCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    _tempCell.sumLabel.text = [NSString stringWithFormat:@"数量：%d",(int)stepper.value ];
//    ZDGoods *goods = _messageDataMutableArray[indexPath.item];
//    goods.sum = [NSString stringWithFormat:@"%d",(int)stepper.value ];
//    [[ZDAllDataBase sharedDataBase]updateGoods:goods];
    
}

- (void)setNavigationBar{
    
    //backBarButtonItem
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] init];
//    [backBtnItem setTitleTextAttributes:@{NSForegroundColorAttributeName:BUTTONITEMCOLOR } forState:UIControlStateNormal];
    backBtnItem.title = @"消息";
    self.navigationItem.backBarButtonItem = backBtnItem;
    //改变BarButtonItem图片颜色
    self.navigationController.navigationBar.tintColor = BARBUTTONITEMCOLOR;
    //allBarButtonItem
    UIBarButtonItem *allBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"全部" style:UIBarButtonItemStylePlain target:self action:@selector(openAll)];

//    [allBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:BUTTONITEMCOLOR} forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = allBarButtonItem;
    
    
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:BUTTONITEMCOLOR}];
    
    //rightBarButtonItem
    UIImage *image = [UIImage imageNamed:@"me"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *meBarButtonItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(openMe)];

    
//    [addBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:BUTTONITEMCOLOR} forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = meBarButtonItem;
    
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
    } else {
        // Fallback on earlier versions
    }
    self.navigationItem.title = @"消息";
}


- (void)openAll{
    
    ZDAllViewController *allViewController = [[ZDAllViewController alloc]init];
    [self.navigationController pushViewController:allViewController animated:YES];
}
- (void)openMe{
    
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter  currentNotificationCenter];
    //请求获取通知权限（角标，声音，弹框）
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //获取用户是否同意开启通知
            NSLog(@"request authorization successed!");
        }
    }];
    
    //第二步：新建通知内容对象
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"物品过期通知";
    content.subtitle = @"您有新的物品即将到期";
    content.body = @"您添加的旺仔牛奶距离到期还有3个月，赶快使用吧";
    content.badge = @1;
    UNNotificationSound *sound = [UNNotificationSound soundNamed:@"wakeup.caf"];
    content.sound = sound;
    
    //第三步：通知触发机制。（重复提醒，时间间隔要大于60s）
    UNTimeIntervalNotificationTrigger *trigger1 = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:362 repeats:YES];
    
    //第四步：创建UNNotificationRequest通知请求对象
    NSString *requertIdentifier = @"RequestIdentifier";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requertIdentifier content:content trigger:trigger1];
    
    //第五步：将通知加到通知中心
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"Error:%@",error);
        
    }];
    
    
    ZDMeViewController *meVC = [[ZDMeViewController alloc]init];
    [self.navigationController pushViewController:meVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    _messageDataMutableArray = [NSMutableArray array];
    
    _allDataMutableArray = [NSMutableArray array];
    _allDataMutableArray = [[ZDAllDataBase sharedDataBase]getAllGoods];
    NSDate *dateNow = [[NSDate alloc]init];
    
    for (ZDGoods *goods in _allDataMutableArray) {
        
        //判断是否加入耗尽数据库
        if ([goods.sum isEqualToString:@"0"]||[goods.sum isEqualToString:@""]) {
            int key=0;
            //根据identifier判断是否存在于全部数据库中
            for (ZDGoods *expireGoods in _allDataMutableArray) {
                
                if (goods == expireGoods) {
                    key=1;
                }
            }
            
            if (key) {
                //耗尽数据库中添加物品
                [[ZDExpireDataBase sharedDataBase]addGoods:goods];
                //全部物品数据库中删除物品
                [[ZDAllDataBase sharedDataBase]deleteGoods:goods];
                _allDataMutableArray = [[ZDAllDataBase sharedDataBase]getAllGoods];
            }
        }
        
        NSDate *resDate = [_formatter dateFromString:goods.dateOfEnd];
        NSTimeInterval seconds = [resDate timeIntervalSinceDate:dateNow]/(60*60*24);
        //判断是否加入过期数据库
        
        
        if (seconds<=0){
            
            int key=0;
            //根据identifier判断是否存在于全部数据库中
            
            for (ZDGoods *depleteGoods in _allDataMutableArray) {
                
                if (goods == depleteGoods) {
                    
                    key = 1;
                }
            }
            
            if (key) {
                //过期数据库中添加物品
                [[ZDDepleteDataBase sharedDataBase]addGoods:goods];
                //全部物品数据库中删除物品
                [[ZDAllDataBase sharedDataBase]deleteGoods:goods];
                _allDataMutableArray = [[ZDAllDataBase sharedDataBase]getAllGoods];
            }
        }else if (seconds<100 ) {
            [_messageDataMutableArray addObject:goods];
        }
        
        
    }
    _messageCardView.messageDataMutableArray = self.messageDataMutableArray;
    //显示tabBar
    [self setTabBarHidden:NO];
}

//设置tabBar
- (void)setTabBarHidden:(BOOL)hidden
{
    
    CGRect  tabRect=self.tabBarController.tabBar.frame;
    
    if (hidden) {
        tabRect.origin.y=[[UIScreen mainScreen] bounds].size.height+self.tabBarController.tabBar.frame.size.height;
    } else {
        tabRect.origin.y=[[UIScreen mainScreen] bounds].size.height-self.tabBarController.tabBar.frame.size.height;
    }
    
    [UIView animateWithDuration:0.5f animations:^{
        self.tabBarController.tabBar.frame = tabRect;
    }completion:^(BOOL finished) {
        
    }];
}
- (void) notHiddenDetailView:(ZDMessageCollectionViewCell *)messageCell{
    [UIView animateWithDuration:0.3 animations:^{
        _detailView.frame = CGRectMake(0, HEIGHT-49-49, WIDTH, 49);
    }];
    _detailView.sumLabel.text = messageCell.sumLabel.text;
    _detailView.remainderTimeLabel.text = messageCell.remainderTimeLabel.text;
    _tempCell = messageCell;
}
- (void)hiddenDetailView{
    
    [UIView animateWithDuration:0.3 animations:^{
        _detailView.frame = CGRectMake(0, HEIGHT, WIDTH,49);
    }];
}

@end
