//
//  ZDCollectionViewCell.m
//  LifeDiary
//
//  Created by JACK on 2018/5/31.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ZDOrderModel.h"

@implementation ZDCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {

       
        [self.contentView addSubview:self.exhibitView];
        self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _exhibitView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);

        //_imageView
        [self.exhibitView addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-16);
            make.height.mas_equalTo(self.frame.size.height/5*3);
            make.left.mas_equalTo(14);
            make.right.mas_equalTo(-14);
        }];
        
        
        //_nameLabel
        [self.exhibitView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(31);
            make.size.mas_equalTo(CGSizeMake(self.frame.size.width, 12));
            make.left.mas_equalTo(15);
        }];
        
        //_sourceLabel
        
        [self.exhibitView addSubview:self.sourceLabel];
        [_sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_nameLabel.mas_bottom).with.offset(5);
            make.left.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(100,30));
        }];
        
        //messageLabel
        [self.exhibitView addSubview:self.messageLabel];
        [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
             make.bottom.mas_equalTo(_imageView.mas_top).with.offset(-10);
            make.right.mas_equalTo(-20);
            make.size.mas_equalTo(CGSizeMake(22, 15));
        }];
        
        //messageImageView
        [self.exhibitView addSubview:self.messageImageView];
        [self.messageImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_messageLabel.mas_top).with.offset(-5);
            make.right.mas_equalTo(-20);
            make.size.mas_equalTo(CGSizeMake(22, 19));
        }];
        
        //saveLabel
        [self.exhibitView addSubview:self.saveLabel];
        [self.saveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_imageView.mas_top).with.offset(-10);
            make.right.mas_equalTo(_messageLabel.mas_left).with.offset(-18);
            make.size.mas_equalTo(CGSizeMake(22, 15));
        }];
        
        //saveImageView
        [self.exhibitView addSubview:self.saveImageView];
        [self.saveImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_saveLabel.mas_top).with.offset(-5);
            make.right.mas_equalTo(_messageImageView.mas_left).with.offset(-18);
            make.size.mas_equalTo(CGSizeMake(23, 21));
        }];
        //_zanLabel
        
        [self.exhibitView addSubview:self.zanLabel];
        [_zanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_imageView.mas_top).with.offset(-10);
            make.right.mas_equalTo(_saveLabel.mas_left).with.offset(-18);
            make.size.mas_equalTo(CGSizeMake(22, 15));
        }];
        
        //_zanImageView
        [self.exhibitView addSubview:self.zanImageView];
        [_zanImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_saveLabel.mas_top).with.offset(-5);
            make.right.mas_equalTo(_saveImageView.mas_left).with.offset(-18);
            make.size.mas_equalTo(CGSizeMake(22, 19));
        }];
  
    }
    return self;
}

- (UIView *)exhibitView{
    if (_exhibitView == nil) {
        //_exhibitView
        _exhibitView = [[UIView alloc]init];
        _exhibitView.backgroundColor = [UIColor whiteColor];
        _exhibitView.layer.cornerRadius = 10;
        _exhibitView.layer.masksToBounds = YES;
    }
    return _exhibitView;
}
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        //_nameLabel
        
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.numberOfLines = 0;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont systemFontOfSize:17];
    }
    return _nameLabel;
}
- (UILabel *)sourceLabel{
    if (_sourceLabel == nil) {
        //_sourceLabel
        
        _sourceLabel = [[UILabel alloc]init];
        _sourceLabel.textColor = [UIColor lightGrayColor];
        _sourceLabel.font = [UIFont systemFontOfSize:15];
        _sourceLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _sourceLabel;
}
- (UIImageView *)messageImageView {
    if (_messageImageView ==  nil) {

        _messageImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"message"]];
    }
    return _messageImageView;
}


- (UIImageView *)imageView{
    if (_imageView == nil) {
        //_imageView
        _imageView = [[UIImageView alloc]init];
        _imageView.layer.cornerRadius = 10.f;
        _imageView.layer.masksToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

- (UIImageView *)zanImageView{
    if (_zanImageView == nil) {
        //_zanImageView

        _zanImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zan"]];
    }
    return _zanImageView;
}
- (UILabel *)zanLabel{
    if (_zanLabel == nil) {
        //_zanLabel

        _zanLabel = [[UILabel alloc]init];
        _zanLabel.font = [UIFont systemFontOfSize:9];
        _zanLabel.textColor = [UIColor colorWithRed:178.0/255 green:178.0/255 blue:178.0/255 alpha:1];
        _zanLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _zanLabel;
}
- (UIImageView *)saveImageView{
    if (_saveImageView == nil) {
        //_saveImageView

        _saveImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"save"]];
    }
    return _saveImageView;
}
- (UILabel *)saveLabel{
    if (_saveLabel == nil) {
        //_saveLabel

        _saveLabel = [[UILabel alloc]init];
        _saveLabel.font = [UIFont systemFontOfSize:9];
        _saveLabel.textColor = [UIColor colorWithRed:178.0/255 green:178.0/255 blue:178.0/255 alpha:1];
        _saveLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _saveLabel;
}
- (UILabel *)messageLabel{
    if (_messageLabel == nil) {
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.font = [UIFont systemFontOfSize:9];
        _messageLabel.textColor = [UIColor colorWithRed:178.0/255 green:178.0/255 blue:178.0/255 alpha:1];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _messageLabel;
}
- (void)updateCell:(ZDContentlistModel *)contentlistModel{
    
    
    NSInteger value;
    value = arc4random_uniform(50);
    while (value < 20) {
        value = arc4random_uniform(50);
    }
    _zanLabel.text = [NSString stringWithFormat:@"%ld",value] ;
    value = arc4random_uniform(50);
    while (value < 20) {
        value = arc4random_uniform(50);
    }
    _saveLabel.text = [NSString stringWithFormat:@"%ld",value] ;
    
    value = arc4random_uniform(50);
    while (value < 20) {
        value = arc4random_uniform(50);
    }
    _messageLabel.text = [NSString stringWithFormat:@"%ld",value] ;
    if (contentlistModel) {
        //添加图片
        if (contentlistModel.imageurls.count) {
            ZDPicModel *picModel = [contentlistModel.imageurls objectAtIndex:0];
            [_imageView sd_setImageWithURL:picModel.url placeholderImage:[UIImage imageNamed:@"LifePlaceholderImage"]];
        }
        self.nameLabel.text = contentlistModel.title;
        self.sourceLabel.text = contentlistModel.channelName;
    }
}
@end
