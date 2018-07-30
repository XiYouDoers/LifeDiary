//
//  ZDMessageCell.h
//  LifeDiary
//
//  Created by JACK on 2018/5/14.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDMessageCell : UITableViewCell

@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UILabel *remarkLabel;
@property(nonatomic,strong) UIImageView *pictureImageView;
@property(nonatomic,strong) UILabel *remainderTimeLabel;
@property(nonatomic,strong) UILabel *sumLabel;
@property (nonatomic,strong) UIStepper *stepper;


/**
 setting arc's startAngle and endAngle

 @param ratio   a rate of remainder/all
 */
- (void)setArc:(double )ratio saveTimeTimeInterval:(NSTimeInterval)timeInterval;
@end
