//
//  FileDownloadUtil.m
//  sdata
//
//  Created by 白静 on 5/23/16.
//  Copyright © 2016 卢坤. All rights reserved.
//

#import "FileDownloadUtil.h"
#import "XUtil.h"

@implementation FileDownloadUtil

+(void) downloadCommentmp3:(NSString *)mp3 filePath:(NSString *)filePath {
    [self downloadFromPath:mp3 filePath:filePath];
}


+(void) downloadFromPath:(NSString *)url filePath:(NSString *)filePath{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error) {
            NSLog(@"Download Error:%@",error.description);
        }
        if (data) {
            [data writeToFile:filePath atomically:YES];
            NSLog(@"File is saved to %@",filePath);
        }
    }];
}
@end
