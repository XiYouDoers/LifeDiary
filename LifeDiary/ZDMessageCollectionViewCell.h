//
//  ZDMessageCollectionViewCell.h
//  LifeDiary
//
//  Created by Jack on 2018/8/1.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDMessageCollectionViewCell : UICollectionViewCell


@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UILabel *remarkLabel;
@property(nonatomic,strong) UIImageView *pictureImageView;
@property(nonatomic,strong) UILabel *remainderTimeLabel;
@property(nonatomic,strong) UILabel *sumLabel;
@property (nonatomic,strong) UIStepper *stepper;
@property (nonatomic) BOOL isChangeAlpha;
@property (nonatomic,strong) UIView *GrayColorView;
@property (nonatomic,strong) UIView *detailView;
/**
 setting arc's startAngle and endAngle
 
 @param ratio   a rate of remainder/all
 */
//- (void)setArc:(double )ratio saveTimeTimeInterval:(NSTimeInterval)timeInterval;
@end
