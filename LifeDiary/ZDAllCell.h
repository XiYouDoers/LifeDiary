//
//  ZDAllCell.h
//  LifeDiary
//
//  Created by JACK on 2018/6/24.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDAllCell : UITableViewCell

@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UILabel *remarkLabel;
@property(nonatomic,strong) UIImageView *pictureImageView;
@property(nonatomic,strong) UILabel *dateOfstartLabel;
@property(nonatomic,strong) UILabel *dateOfEndLabel;
@property(nonatomic,strong) UILabel *saveTimeLabel;
@property(nonatomic,strong) UILabel *sumLabel;
@property (nonatomic,strong) UIView *shadowView;
@property (nonatomic,strong) UIView *exhibitView;

/**
 setting arc's startAngle and endAngle
 
 @param ratio   a rate of remainder/all
 */
//- (void)setArc:(double )ratio saveTimeTimeInterval:(NSTimeInterval)timeInterval;
@end
