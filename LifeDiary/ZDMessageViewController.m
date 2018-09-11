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
#import "ZDStringManager.h"
#import <UserNotifications/UNUserNotificationCenter.h>
#import <UserNotifications/UNNotificationContent.h>
#import <UserNotifications/UNNotificationSound.h>
#import <UserNotifications/UNNotificationTrigger.h>
#import <UserNotifications/UNNotificationRequest.h>
 #import <EventKit/EventKit.h>

NSDateFormatter const *_formatter;
@interface ZDMessageViewController () <ZDMessageCardViewDelegate>{
    ZDMessageCollectionViewCell *_tempCell;
    NSIndexPath *lastIndexPath;
}

@property(nonatomic,strong) UISegmentedControl *segmentControl;
@property(nonatomic,strong) UIRefreshControl *refreshControl;
@property(nonatomic,strong) ZDMessageCardView *messageCardView;
@property(nonatomic,strong) ZDDetailView *detailView;
@property(nonatomic,strong) NSMutableArray *allDataMutableArray;
@property(nonatomic,assign) bool isHiddenTabBar;
@property(nonatomic,strong) UIImageView *imageView;
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
    
    //每天检测到期
//    [NSTimer scheduledTimerWithTimeInterval:3600*24 repeats:YES block:^(NSTimer * _Nonnull timer) {
        _allDataMutableArray = [[ZDAllDataBase sharedDataBase]getAllGoods];
        NSDate *dateNow = [[NSDate alloc]init];
//        for (ZDGoods *goods in _allDataMutableArray) {
            ZDGoods *goods = _allDataMutableArray[0];
            NSDate *resDate = [_formatter dateFromString:goods.dateOfEnd];
            NSTimeInterval seconds = [resDate timeIntervalSinceDate:dateNow]/(60*60*24);
            [self sendNotifition:goods timeInterval:seconds];
        [self addEKEventStore:goods];
            //分类提醒
//            if (seconds<150 && [goods.family isEqualToString:@"日用品"]) {
//                [self sendNotifition:goods timeInterval:seconds];
//            }else if (seconds<200 &&[goods.family isEqualToString:@"药品"]) {
//                [self sendNotifition:goods timeInterval:seconds];
//            }else if (seconds<90 &&[goods.family isEqualToString:@"食品"]) {
//                [self sendNotifition:goods timeInterval:seconds];
//            }else if (seconds<70 && [goods.family isEqualToString:@"其他"]){
//                [self sendNotifition:goods timeInterval:seconds];
//            }
    
//        }
    
//    }];
    
    
    
}

- (void)addMessageCardView{
    
    _messageCardView = [[ZDMessageCardView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _messageCardView.delegate = self;
    [self.view addSubview:_messageCardView];
}
- (void)valueChanged:(UIStepper *)stepper{
    
    //当数量为0时直接删除物品
    if (!stepper.value) {
        UIAlertController *actionAlert = [UIAlertController alertControllerWithTitle:@"是否确认删除" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *rightToDeleteAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [_tempCell.sumLabel setText:@"数量：1"];
            [_detailView.sumLabel setText:@"数量：1"];
            ZDGoods *goods = _messageDataMutableArray[lastIndexPath.item];
            goods.sum = @"1";
            [[ZDAllDataBase sharedDataBase]updateGoods:goods];
            
        }];
        
        UIAlertAction *cancaelToDeleteAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            
        }];
        
        [actionAlert addAction:rightToDeleteAction];
        [actionAlert addAction:cancaelToDeleteAction];
        [self presentViewController:actionAlert animated:YES completion:nil];
    }else{
     //否则改变数量
    [_tempCell.sumLabel setText:[NSString stringWithFormat:@"数量：%d",(int)stepper.value ]];
    [_detailView.sumLabel setText:[NSString stringWithFormat:@"数量：%d",(int)stepper.value ]];
    ZDGoods *goods = _messageDataMutableArray[lastIndexPath.item];
    goods.sum = [NSString stringWithFormat:@"%d",(int)stepper.value ];
    [[ZDAllDataBase sharedDataBase]updateGoods:goods];
    }
    
}

- (void)setNavigationBar{
    
    //backBarButtonItem
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] init];

    backBtnItem.title = @"消息";
    self.navigationItem.backBarButtonItem = backBtnItem;
    //改变BarButtonItem图片颜色
    self.navigationController.navigationBar.tintColor = BARBUTTONITEMCOLOR;
    //allBarButtonItem
    UIBarButtonItem *allBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"全部" style:UIBarButtonItemStylePlain target:self action:@selector(openAll)];


    self.navigationItem.leftBarButtonItem = allBarButtonItem;
    
    //rightBarButtonItem
    UIImage *image = [UIImage imageNamed:@"me"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *meBarButtonItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(openMe)];

    self.navigationItem.rightBarButtonItem = meBarButtonItem;
    
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
    } else {
       
    }
    self.navigationItem.title = @"消息";
}


- (void)openAll{
    
    ZDAllViewController *allViewController = [[ZDAllViewController alloc]init];
    [self.navigationController pushViewController:allViewController animated:YES];
}
- (void)openMe{

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
            for (ZDGoods *depleteGoods in _allDataMutableArray) {
                
                if (goods == depleteGoods) {
                    key=1;
                }
            }
            
            if (key) {
                //耗尽数据库中添加物品
                [[ZDDepleteDataBase sharedDataBase]addGoods:goods];
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
            
            for (ZDGoods *expireGoods in _allDataMutableArray) {
                
                if (goods == expireGoods) {
                    
                    key = 1;
                }
            }
            
            if (key) {
                //过期数据库中添加物品
                [[ZDExpireDataBase sharedDataBase]addGoods:goods];
                //全部物品数据库中删除物品
                [[ZDAllDataBase sharedDataBase]deleteGoods:goods];
                _allDataMutableArray = [[ZDAllDataBase sharedDataBase]getAllGoods];
            }
        }else{
            //分类提醒
            if (seconds<150 && [goods.family isEqualToString:@"日用品"]) {
                [_messageDataMutableArray addObject:goods];
            }else if (seconds<200 &&[goods.family isEqualToString:@"药品"]) {
                [_messageDataMutableArray addObject:goods];
            }else if (seconds<90 &&[goods.family isEqualToString:@"食品"]) {
                [_messageDataMutableArray addObject:goods];
            }else if (seconds<70 && [goods.family isEqualToString:@"其他"]){
                [_messageDataMutableArray addObject:goods];
            }
        }
        
    }
    _messageCardView.messageDataMutableArray = self.messageDataMutableArray;
    //显示tabBar
    [self setTabBarHidden:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [self hiddenDetailView];
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
- (void) notHiddenDetailView:(ZDMessageCollectionViewCell *)messageCell selectedIndexPath:(NSIndexPath *)indexPath{
    [UIView animateWithDuration:0.3 animations:^{
        _detailView.frame = CGRectMake(0, HEIGHT-49-49, WIDTH, 49);
    }];

    _detailView.sumLabel.text = messageCell.sumLabel.text;
    NSString *str = [ZDStringManager switchToNumberString:messageCell.sumLabel.text];
    _detailView.stepper.value = [str intValue];
    _detailView.remainderTimeLabel.text = messageCell.remainderTimeLabel.text;
    _tempCell = messageCell;
    lastIndexPath = indexPath;
}
- (void)hiddenDetailView{
    
    [UIView animateWithDuration:0.3 animations:^{
        _detailView.frame = CGRectMake(0, HEIGHT, WIDTH,49);
    }];
}
- (void)sendNotifition:(ZDGoods *)goods timeInterval:(NSTimeInterval)timeInterval{
    
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
    content.body = [NSString stringWithFormat:@"您添加的%@距离到期还有%f个月，赶快使用吧",goods.name,timeInterval];
    NSNumber *number = [NSNumber numberWithInteger:1];
    content.badge = number;
    UNNotificationSound *sound = [UNNotificationSound soundNamed:@"wakeup.caf"];
    content.sound = sound;
    
    //第三步：通知触发机制。（重复提醒，时间间隔要大于60s）
    UNTimeIntervalNotificationTrigger *trigger1 = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:65  repeats:YES];
    
    //第四步：创建UNNotificationRequest通知请求对象
    NSString *requertIdentifier = @"RequestIdentifier";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requertIdentifier content:content trigger:trigger1];
    
    //第五步：将通知加到通知中心
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"Error:%@",error);
        
    }];
    //日历事件
//    [self addEKEventStore:goods];
    
}
// 添加日历事件
-(void)addEKEventStore:(ZDGoods *)goods{
    //创建事件市场
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    // the selector is available, so we must be on iOS 6 or newer
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error)
            {
                //当发生了错误会
                NSLog(@"发生了错误:%@",error);
            }
            else if (!granted)
            {
                //被用户拒绝，不允许访问日历
            }
            else
            {
                //创建事件
                EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
                //给事件添加标题
                event.title  = @"LifeDiary";
                //设置地点
                event.location = @"";
                //创建测试时间，这里可以改为任意时间
                NSDate *date = [NSDate date];
                //开始时间(必须传)
//                event.startDate = [_formatter dateFromString:date];
                //结束时间(必须传)
                event.endDate = date;
                //全天的事件
                event.allDay = YES;
                //添加提醒
                //第一次提醒 设置事件开始之前1分钟提醒
                [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f *60]];
                //第二次提醒 设置事件开始之前2分钟提醒
                //                [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -2.0f]];
                //第N次提醒 设置事件提醒
                //                [event addAlarm:[EKAlarm alarmWithRelativeOffset:秒]];
                //事件类容备注
                NSString * str = @"您有物品即将到期，请打开LifeDiary查看";
                event.notes = [NSString stringWithFormat:@"%@",str];
                //添加事件到日历中
                [event setCalendar:[eventStore defaultCalendarForNewEvents]];
                NSError *err;
                [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
                //保存事件id，方便查询和删除
                [[NSUserDefaults standardUserDefaults]setObject:event.eventIdentifier forKey:[NSString stringWithFormat:@"lifeDiaryEvent%@%@",goods.name,goods.identifier]];
            }
        });
    }];
    
}
@end
