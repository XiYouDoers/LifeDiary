//
//  ZDFindViewController.h
//  LifeDiary
//
//  Created by JACK on 2018/5/13.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDCollectionViewCell.h"
#import "ZDOrderModel.h"


@interface ZDFindViewController : UIViewController
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) ZDCollectionViewCell *collectionViewCell;

@property(nonatomic,strong) NSMutableArray <ZDContentlistModel > *contentlistArray;
@end
