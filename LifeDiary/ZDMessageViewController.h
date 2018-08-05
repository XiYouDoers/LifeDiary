//
//  ZDMessageViewController.h
//  LifeDiary
//
//  Created by JACK on 2018/5/16.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDViewController.h"
//#import "ZDMessageCell.h"
#import "ZDAllCell.h"
#import "ZDMessageCollectionViewCell.h"

@interface ZDMessageViewController : ZDViewController
@property(nonatomic,strong) NSMutableArray *messageDataMutableArray;
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) ZDMessageCollectionViewCell *messageCollectionViewCell;
//@property(nonatomic,strong) UITableView *messageTableView;
@property(nonatomic,strong) ZDAllCell *allCell;
@end
