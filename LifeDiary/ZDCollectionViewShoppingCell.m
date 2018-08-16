//
//  ZDCollectionViewShoppingCell.m
//  LifeDiary
//
//  Created by Jack on 2018/7/24.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDCollectionViewShoppingCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ZDOrderModel.h"
#import "ZDShoppingModel.h"

@implementation ZDCollectionViewShoppingCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        
        [self.contentView addSubview:self.shadowView];
        [self.shadowView addSubview:self.exhibitView];
        self.contentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _exhibitView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
        
        //_imageView
        [self.exhibitView addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-16);
            make.size.height.mas_equalTo(self.frame.size.height/5*3);
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
            make.top.mas_equalTo(_nameLabel.mas_bottom).with.offset(1);
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
        [self.exhibitView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_imageView.mas_top).with.offset(-10);
            make.right.mas_equalTo(_messageLabel.mas_left).with.offset(-18);
            make.size.mas_equalTo(CGSizeMake(22, 15));
        }];
        
        //saveImageView
        [self.exhibitView addSubview:self.priceImageView];
        [self.priceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_priceLabel.mas_top).with.offset(-5);
            make.right.mas_equalTo(_messageImageView.mas_left).with.offset(-18);
            make.size.mas_equalTo(CGSizeMake(23, 21));
        }];
        //_zanLabel
        
        [self.exhibitView addSubview:self.zanLabel];
        [_zanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_imageView.mas_top).with.offset(-10);
            make.right.mas_equalTo(_priceLabel.mas_left).with.offset(-18);
            make.size.mas_equalTo(CGSizeMake(22, 15));
        }];
        
        //_zanImageView
        [self.exhibitView addSubview:self.zanImageView];
        [_zanImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_priceLabel.mas_top).with.offset(-5);
            make.right.mas_equalTo(_priceImageView.mas_left).with.offset(-18);
            make.size.mas_equalTo(CGSizeMake(22, 19));
        }];
        
    }
    return self;
}
- (UIView *)shadowView{
    if (_shadowView == nil) {
        
        //_shadowView
        _shadowView = [[UIView alloc]init];
        _shadowView.backgroundColor = [UIColor purpleColor];
        //        _shadowView.layer.shadowColor =  [UIColor colorWithRed:97.0/255 green:191.0/255 blue:246.0/255 alpha:1].CGColor;
        _shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
        _shadowView.layer.shadowOffset = CGSizeMake(0, 0);
        _shadowView.layer.shadowRadius = 0 ;
        _shadowView.layer.shadowOpacity = 1;
        _shadowView.layer.shouldRasterize = YES;
    }
    return _shadowView;
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
        _nameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _nameLabel;
}
- (UILabel *)sourceLabel{
    if (_sourceLabel == nil) {
        //_sourceLabel
        
        _sourceLabel = [[UILabel alloc]init];
        _sourceLabel.textColor = [UIColor lightGrayColor];
        _sourceLabel.font = [UIFont systemFontOfSize:13];
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
- (UIImageView *)priceImageView{
    if (_priceImageView == nil) {
        //_saveImageView
        
        _priceImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"save"]];
    }
    return _priceImageView;
}
- (UILabel *)priceLabel{
    if (_priceLabel == nil) {
        //_saveLabel
        
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = [UIFont systemFontOfSize:9];
        _priceLabel.textColor = [UIColor colorWithRed:178.0/255 green:178.0/255 blue:178.0/255 alpha:1];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _priceLabel;
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
- (void)updateCell:(ZDProductInfo *)productInfo{

    [_imageView sd_setImageWithURL:productInfo.imageUrl];
    self.nameLabel.text = productInfo.name;
    self.priceLabel.text = productInfo.price;

}
@end
