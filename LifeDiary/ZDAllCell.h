//
//  ZDAllCell.h
//  LifeDiary
//
//  Created by JACK on 2018/6/24.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZDAllCellDelegate<NSObject>
@optional
- (void)deleteButtonWasClicked;
- (void)editButtonWasClicked;
@end
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
@property (nonatomic,strong) UILabel *classificationLabel;
@property (nonatomic,strong) UIView *manageView;
@property (nonatomic,strong) UIButton *deleteButton;
@property (nonatomic,strong) UIButton *editButton;

@property(nonatomic,weak) id <ZDAllCellDelegate> delegate;
/**
 setting arc's startAngle and endAngle
 
 @param ratio   a rate of remainder/all
 */
//- (void)setArc:(double )ratio saveTimeTimeInterval:(NSTimeInterval)timeInterval;
@end
