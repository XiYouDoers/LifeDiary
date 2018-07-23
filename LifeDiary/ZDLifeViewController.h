//
//  ZDLifeViewController.h
//  LifeDiary
//
//  Created by Jack on 2018/7/23.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDCollectionViewCell.h"
#import "ZDOrderModel.h"

@interface ZDLifeViewController : UIViewController

@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) ZDCollectionViewCell *collectionViewCell;

@property(nonatomic,strong) NSMutableArray <ZDContentlistModel > *contentlistArray;
@end
