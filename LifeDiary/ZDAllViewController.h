//
//  ZDAllViewController.h
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZDAllCell,ZDMessageCell,ZDAllCollectionViewCell;

@interface ZDAllViewController : UIViewController

@property(nonatomic,strong) ZDMessageCell *messageCell;
@property(nonatomic,strong) NSMutableArray *dataMutableArray;
@property(nonatomic,strong) NSMutableArray *resultMutableArray;
@property(nonatomic,strong) UITableView *allTableView;
@property(nonatomic,strong) ZDAllCell *allCell;
@property(nonatomic,strong) UISearchBar *searchBar;
@property(nonatomic,strong) UIView *searchView;
@property(nonatomic,strong) UIButton *sortButton;

@end
