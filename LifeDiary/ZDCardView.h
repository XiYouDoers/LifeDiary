//
//  ZDCardView.h
//  LifeDiary
//
//  Created by Jack on 2018/8/14.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZDContentlistModel,ZDCollectionViewCell;
@protocol ZDContentlistModel;
@protocol ZDCardViewDelegate
- (void)changeBackgroundImageView:(NSInteger)index;
- (void)pushToNextViewController:(NSInteger)index;

@end
@interface ZDCardView : UIView
@property(nonatomic,strong) NSMutableArray <ZDContentlistModel> *contentlistArray;
//当前选中位置
@property (nonatomic, assign, readwrite) NSInteger selectedIndex;
@property(nonatomic,strong) UICollectionView *collectionView;

@property(nonatomic,weak) id<ZDCardViewDelegate> delegate;
@end
