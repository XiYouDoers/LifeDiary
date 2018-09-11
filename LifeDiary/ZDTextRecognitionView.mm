//
//  ZDTextRecognitionView.m
//  LifeDiary
//
//  Created by Jack on 2018/8/29.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDTextRecognitionView.h"
#import "ocrSDK/OCRSDK.h"
#import "YDImageView.h"
#import "ZDGoods.h"
#import "ZDStringManager.h"


@interface ZDTextRecognitionView(){

}

@end

@implementation ZDTextRecognitionView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        self.imgView  = [[YDImageView alloc]init];
        self.goods = [[ZDGoods alloc]init];
       
    }
    return self;
}
- (void)setData:(UIImage *)image{
    self.imgView.image = image;
}
- (void)recognitionForText{
//    [HUDUtil show:self.view text:@"正在识别..."];
    YDTranslateInstance *yd = [YDTranslateInstance sharedInstance];
    yd.appKey = @"2b1c202a7b52cbd6";
    YDOCRRequest *request = [YDOCRRequest request];
    YDOCRParameter *param = [YDOCRParameter param];
    param.langType = @"en"; //设置识别语言为英文,langType支持"zh-en"和"en"，其中"zh-en"为中英识别，"en"参数表示只识别英文。若为 纯英文识别，"zh-en"的识别效果不如"en"，请妥善选择
    param.source = @"youdaoocr"; //设置源
    param.detectType = @"10012"; //设置识别类型，10011位片段识别，目前只支持片段识别
    request.param = param; 
    NSString *base64Str = [self image2DataURL:self.imgView.image];
    [request lookup:base64Str WithCompletionHandler:^(YDOCRRequest *request, YDOCRResult *result, NSError *error) {
        if (error) {
            //失败
            NSLog(@"error:%@", error);
            NSLog(@"!!!!!!!!!");
        }else {
            //成功
            [self showText:result];
            
            [self.delegate jumpToAddVC];
        }
    }];
}
- (NSString *)image2DataURL:(UIImage *)image {
    NSData *imageData = nil;
    
    //注意：1.图片最长宽不能超过768
    if (image.size.width > 768 || image.size.height > 768) {
        CGSize newSize;
        if (image.size.width > image.size.height) {
            newSize = CGSizeMake(768, image.size.height / image.size.width * 768);
        }else {
            newSize = CGSizeMake(image.size.width / image.size.height * 768, 768);
        }
        image = [self imageWithImage:image scaledToSize:newSize];
        self.imgView.image = image;
    }
    
    //注意：2.imageData压缩后不能超过1.5MB
    CGFloat imageDataSize = 0, compressionQuality = 0.9;
    do {
        imageData = UIImageJPEGRepresentation(image, compressionQuality);
        imageDataSize = imageData.length / 1024;
        compressionQuality = compressionQuality * 0.5;
    } while (imageDataSize > 1.5 * 1024);
    
    return [imageData base64EncodedStringWithOptions:0];
}
- (void )showText:(YDOCRResult *)result {
    if (result) {

        for (YDOCRRegion *region in result.regions) {
            for (YDOCRLine *line in region.lines) {

                if ([line.text rangeOfString:@"名称" options:NSCaseInsensitiveSearch].length >0) {

                    _goods.name=  [ZDStringManager separateInfo:line.text];
                }
                
                if ([line.text rangeOfString:@"保质" options:NSCaseInsensitiveSearch].length >0) {
                    
                    NSString *str =  [ZDStringManager separateInfo:line.text];
                    if ([str rangeOfString:@"年" options:NSCaseInsensitiveSearch].length >0 ||[str rangeOfString:@"月" options:NSCaseInsensitiveSearch].length >0 || [str rangeOfString:@"日" options:NSCaseInsensitiveSearch].length >0 ) {
                        //计算日期
                        str = [ZDStringManager caculateDate:str];
                    }
                    
                    NSLog(@"%@",str);
                    _goods.saveTime = str;

                }
                if (([line.text rangeOfString:@"2018" options:NSCaseInsensitiveSearch].length >0)||([line.text rangeOfString:@"2016" options:NSCaseInsensitiveSearch].length >0)||([line.text rangeOfString:@"2017" options:NSCaseInsensitiveSearch].length >0)) {
                    
                    NSString *str = [ZDStringManager deleteSpace:line.text];
                    str = [ZDStringManager addGangToDateString:str];
                    _goods.dateOfStart = str;
                }
            }
        }
    }
}
- (UIImage *)imageWithImage:(UIImage*)image
               scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end
