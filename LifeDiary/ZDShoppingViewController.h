//
//  ZDShoppingViewController.h
//  LifeDiary
//
//  Created by Jack on 2018/7/23.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDCollectionViewCell.h"

@interface ZDShoppingViewController : UIViewController

@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) ZDCollectionViewCell *collectionViewCell;

@end