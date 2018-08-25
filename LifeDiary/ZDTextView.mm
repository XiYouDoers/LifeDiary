//
//  ZDTextView.m
//  LifeDiary
//
//  Created by Jack on 2018/8/24.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import "ZDTextView.h"
#import <TesseractOCR/TesseractOCR.h>
@interface ZDTextView ()<G8TesseractDelegate>

@end
@implementation ZDTextView
//recognize image with tesseract
-(void)recognizeWithTesseract: (UIImage *)image{
    G8RecognitionOperation *operation = [[G8RecognitionOperation alloc] initWithLanguage:@"chi_sim"];
    operation.tesseract.engineMode = G8OCREngineModeTesseractOnly;
    operation.tesseract.pageSegmentationMode = G8PageSegmentationModeAutoOnly;
    operation.delegate = self;
    NSLog(@"start");
    operation.recognitionCompleteBlock = ^(G8Tesseract *tesseract) {
        NSLog(@"1");
        NSString *recognizedText = tesseract.recognizedText;
        NSLog(@"%@", recognizedText);
        [self progressImageRecognitionForTesseract:tesseract];
        
    };
    //    self.imageView.image = operation.tesseract.thresholdedImage;
}

//print the progress infos
- (void)progressImageRecognitionForTesseract:(G8Tesseract *)tesseract {
    NSLog(@"progress: %lu", (unsigned long)tesseract.progress);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
