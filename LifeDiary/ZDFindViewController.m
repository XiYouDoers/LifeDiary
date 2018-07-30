//
//  ZDFindViewController.m
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDFindViewController.h"
#import "ZDLifeViewController.h"
#import "ZDShoppingViewController.h"

@interface ZDFindViewController ()
@property(nonatomic,strong)  UISegmentedControl *segmentControl;
@property (nonatomic, weak) UIView *containerView;
@property (nonatomic, weak) UIViewController *currentSubViewController;
@end

@implementation ZDFindViewController
static NSString *const cellId = @"collectionViewCellId";
static NSString *const headerId = @"headerId";
static NSString *const footerId = @"footerId";

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] init];
    backBtnItem.title = @"发现";
    self.navigationItem.backBarButtonItem = backBtnItem;
    self.view.backgroundColor = [UIColor whiteColor];
self.navigationController.navigationBar.barTintColor = TABBARCOLOR;
   
    ZDShoppingViewController *shoppingViewController = [[ZDShoppingViewController alloc]init];
    ZDLifeViewController *lifeViewController = [[ZDLifeViewController alloc]init];
    UIView *container = [[UIView alloc] init];
    self.containerView = container;
    [self.view addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(WIDTH, HEIGHT));;
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
    }];
    
    
    [self addChildViewController:lifeViewController];
    [self addChildViewController:shoppingViewController];
    self.childViewControllers[0].view.frame = self.containerView.bounds;
    [self.containerView addSubview:self.childViewControllers[0].view];
    self.currentSubViewController = self.childViewControllers[0];
    
    //segmentControl
    NSArray *array = @[@"生活", @"购物"];
    _segmentControl = [[UISegmentedControl alloc] initWithItems:array];
    _segmentControl.selectedSegmentIndex = 0;
    _segmentControl.tintColor = [UIColor whiteColor];
    _segmentControl.momentary = NO;

    // 设置颜色
    [_segmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor], NSFontAttributeName:[UIFont systemFontOfSize:16]}
                                  forState:UIControlStateNormal];
    [_segmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:16]}
                                  forState:UIControlStateSelected];
    [_segmentControl setBackgroundColor:TABBARCOLOR];
    [_segmentControl addTarget:self action:@selector(doSomethingInSegment:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segmentControl];
    [_segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iPhoneX) {
        make.top.mas_equalTo(24+20);
        }else{
        make.top.mas_equalTo(24);
        }
        make.size.mas_equalTo(CGSizeMake(WIDTH/3, 30));
        make.left.mas_equalTo(WIDTH/3);
    }];

    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
//SegmentControl点击事件
-(void)doSomethingInSegment:(UISegmentedControl *)Seg
{
    NSInteger index = Seg.selectedSegmentIndex;
    UIViewController *selectedController = self.childViewControllers[index];
    selectedController.view.frame = self.containerView.bounds;
    
    if (self.currentSubViewController != self.childViewControllers[index]) {
        
        UIViewAnimationOptions options;
        if (self.currentSubViewController == self.childViewControllers[0]) {
             options = UIViewAnimationOptionTransitionCurlUp;
        }else {
            options = UIViewAnimationOptionTransitionCurlDown;
        }
        [self transitionFromViewController:self.currentSubViewController toViewController:self.childViewControllers[index] duration:0.8 options:options animations:^{} completion:^(BOOL finished) {
            if (finished) {
                self.currentSubViewController = self.childViewControllers[index];
            }
        }];
    }

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
