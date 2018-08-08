//
//  ZDMessageViewController.h
//  LifeDiary
//
//  Created by JACK on 2018/5/16.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDViewController.h"

@class ZDAllCell,ZDMessageCollectionViewCell;


@interface ZDMessageViewController : ZDViewController

@property(nonatomic,strong) NSMutableArray *messageDataMutableArray;
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) ZDMessageCollectionViewCell *messageCollectionViewCell;
@property (nonatomic,strong) UIView *detailView;
@property(nonatomic,strong) ZDAllCell *allCell;

@end
