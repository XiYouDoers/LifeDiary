//
//  ZDHtmlScrollView.m
//  LifeDiary
//
//  Created by Jack on 2018/8/1.
//  Copyright © 2018年 JACK. All rights reserved.
//
#define SPACING 15.f
#import "ZDHtmlScrollView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ZDHtmlScrollView
- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        self.directionalLockEnabled = YES;//指定控件是否只能在一个方向上滚动(默认NO)
        self.bounces = YES;//是否有弹簧效果
        self.scrollEnabled = YES;//控制控件是否能滚动（默认YES）
        self.contentSize = CGSizeMake(WIDTH, HEIGHT*2);
//        self.userInteractionEnabled = YES;
        
        //_titleLabel
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.frame = CGRectMake(SPACING, SPACING ,WIDTH-SPACING*2, 120);
        _titleLabel.font  = [UIFont fontWithName:@"Arial Rounded MT Bold" size:25.0];
        [self addSubview:_titleLabel];
//        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(5);
//            make.left.mas_offset(10);
//            make.right.mas_offset(-10);
//            make.height.mas_equalTo(200);
//        }];
        //_headImageView
        _headImageView = [[UIImageView alloc]init];
        _headImageView.frame = CGRectMake(SPACING, 70, WIDTH-SPACING*2, 200);
        [self addSubview:_headImageView];
//        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(_titleLabel.mas_bottom).with.offset(20);
//            make.left.mas_offset(10);
//            make.right.mas_offset(-10);
//            make.height.mas_equalTo(200);
//        }];
        
        //_htmlLabel
        _htmlLabel = [[UILabel alloc]init];
        _htmlLabel.frame = CGRectMake(SPACING, 300, WIDTH-SPACING*2, 1000);
        [self addSubview:_htmlLabel];
//        [_htmlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(_headImageView.mas_bottom).with.offset(10);
//            make.left.mas_offset(10);
//            make.right.mas_offset(-10);
//            make.height.mas_equalTo(200);
//        }];
        
        
        //_footImageView
        _footImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 900, WIDTH-SPACING*2, 200)];
        [self addSubview:_footImageView];
//        [_footImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.top.mas_equalTo(_htmlLabel.mas_bottom).with.offset(20);
//            make.left.mas_offset(10);
//            make.right.mas_offset(-10);
//            make.height.mas_equalTo(200);
//        }];
        
        
    }
    return self;
}

-(void)updateHtmlView:(ZDContentlistModel *)contentlistModel{
    
    if (contentlistModel) {
        //添加图片
        if (contentlistModel.imageurls.count) {
            ZDPicModel *picModel = [contentlistModel.imageurls objectAtIndex:0];
            [_headImageView sd_setImageWithURL:picModel.url placeholderImage:[UIImage imageNamed:@"LifePlaceholderImage"]];
             if (contentlistModel.imageurls.count>2){
                ZDPicModel *picModel = [contentlistModel.imageurls objectAtIndex:1];
                [_footImageView sd_setImageWithURL:picModel.url placeholderImage:[UIImage imageNamed:@"LifePlaceholderImage"]];
             }
        }else{
            [_headImageView setImage:[UIImage imageNamed:@"LifePlaceholderImage"]];
        }
       
        
        _titleLabel.text = contentlistModel.title;
        _htmlLabel.text = [self attributeStringByHtmlString:contentlistModel.html].string;

        _titleLabel.numberOfLines = 10;
        self.htmlLabel.numberOfLines = 40;
        CGSize size = CGSizeMake(WIDTH-SPACING*2, 2000);
        NSDictionary *attributesForTitleLabel = @{NSFontAttributeName:_titleLabel.font};
        CGRect rectForTitleLabel = [_titleLabel.text boundingRectWithSize:size
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:attributesForTitleLabel
                                                    context:nil];
        _titleLabel.frame = CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.origin.y, _titleLabel.frame.size.width, rectForTitleLabel.size.height);
        _headImageView.frame = CGRectMake(_headImageView.frame.origin.x, SPACING + _titleLabel.frame.size.height+SPACING, _headImageView.frame.size.width, 200);
        NSDictionary *attributesForHtmlLabel = @{NSFontAttributeName:self.htmlLabel.font};
        CGRect rectForHtmlLabel = [_htmlLabel.text boundingRectWithSize:size
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:attributesForHtmlLabel
                                                  context:nil];
        
        
        self.htmlLabel.frame = CGRectMake(self.htmlLabel.frame.origin.x, _headImageView.frame.origin.y+_headImageView.frame.size.height+SPACING, self.htmlLabel.frame.size.width, rectForHtmlLabel.size.height);
        
        self.contentSize = CGSizeMake(WIDTH, self.htmlLabel.frame.origin.y+self.htmlLabel.frame.size.height+20);
    }
}
- (NSAttributedString *)attributeStringByHtmlString:(NSString *)htmlString {
    
    NSAttributedString *attributeString;
    NSData *htmlData = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *importParams = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                   NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]
                                   };
    NSError *error = nil;
    attributeString = [[NSAttributedString alloc] initWithData:htmlData options:importParams documentAttributes:NULL error:&error];
    return attributeString;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
