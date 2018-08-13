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
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, weak) UIViewController *currentSubViewController;
@end

@implementation ZDFindViewController
static NSString *const cellId = @"collectionViewCellId";
static NSString *const headerId = @"headerId";
static NSString *const footerId = @"footerId";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    [self setNavigationBar];
    self.view.backgroundColor = [UIColor whiteColor];

    
    
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
    NSArray *array = @[@"生活", @"商品"];
    _segmentControl = [[UISegmentedControl alloc] initWithItems:array];
    _segmentControl.selectedSegmentIndex = 0;
    _segmentControl.tintColor = LIGHTBLUE;
    _segmentControl.layer.borderWidth = 1.f;
    _segmentControl.layer.masksToBounds = YES;
    _segmentControl.layer.borderColor = LIGHTBLUE.CGColor;
    _segmentControl.layer.cornerRadius = 8.f;
//    _segmentControl.layer.masksToBounds = NO;
    _segmentControl.momentary = NO;

    // 设置颜色
    [_segmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:178.0/255 green:178.0/255 blue:178.0/255 alpha:1], NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                  forState:UIControlStateNormal];

    [_segmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                  forState:UIControlStateSelected];
    [_segmentControl setBackgroundColor:[UIColor  whiteColor]];
    [_segmentControl addTarget:self action:@selector(doSomethingInSegment:) forControlEvents:UIControlEventValueChanged];
    [self.navigationController.navigationBar addSubview:_segmentControl];
    [_segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iPhoneX) {
        make.bottom.mas_equalTo(-10);
        }else{
        make.bottom.mas_equalTo(-15);
        }
        make.size.mas_equalTo(CGSizeMake(WIDTH/3, 30));
        make.left.mas_equalTo(WIDTH/3);
    }];
    
    // Do any additional setup after loading the view.
}
- (void)setNavigationBar{
    
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] init];
    backBtnItem.title = @"生活";
    self.navigationItem.backBarButtonItem = backBtnItem;
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
    } else {
        // Fallback on earlier versions
    }
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.frame = CGRectMake(10, 0, 100, 44);
    _titleLabel.text = @"发现";
    _titleLabel.font = [UIFont boldSystemFontOfSize:34];
    [self.navigationController.navigationBar addSubview:_titleLabel];
    
    
    //改变BarButtonItem图片颜色
    self.navigationController.navigationBar.tintColor = BARBUTTONITEMCOLOR;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _segmentControl.hidden = NO;
    _titleLabel.hidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _segmentControl.hidden = YES;
    _titleLabel.hidden = YES;

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
             options = UIViewAnimationOptionLayoutSubviews;
        }else {
            options = UIViewAnimationOptionLayoutSubviews;
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
