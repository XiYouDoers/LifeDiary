//
//  ZDCardForShoppingView.h
//  LifeDiary
//
//  Created by Jack on 2018/8/15.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZDCardForShoppingViewDelegate
- (void)changeBackgroundImageView:(NSInteger)index;
- (void)pushToNextViewController:(NSInteger)index;

@end
@interface ZDCardForShoppingView : UIView
@property(nonatomic,strong) NSMutableArray *dataMutableArray;
//当前选中位置
@property (nonatomic, assign, readwrite) NSInteger selectedIndex;
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,weak) id<ZDCardForShoppingViewDelegate> delegate;
@end
