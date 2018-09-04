//
//  ZDMessageCardView.h
//  LifeDiary
//
//  Created by Jack on 2018/8/14.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSDateFormatter const *_formatter;
@class ZDMessageCollectionViewCell;

@protocol ZDMessageCardViewDelegate
@optional
- (void) hiddenDetailView;
- (void) notHiddenDetailView:(ZDMessageCollectionViewCell *)messageCell selectedIndexPath:(NSIndexPath *)indexPath;
@end
@interface ZDMessageCardView : UIView
@property(nonatomic,strong) NSMutableArray *messageDataMutableArray;
@property(nonatomic,strong) NSMutableArray *allDataMutableArray;
@property(nonatomic,weak) id <ZDMessageCardViewDelegate> delegate;
@end
