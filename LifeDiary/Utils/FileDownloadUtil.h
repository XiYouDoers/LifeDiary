//
//  FileDownloadUtil.h
//  sdata
//
//  Created by 白静 on 5/23/16.
//  Copyright © 2016 卢坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileDownloadUtil : NSObject
+(void) downloadCommentmp3:(NSString *)mp3 filePath:(NSString *)filePath;
+(void) downloadFromPath:(NSString *)url filePath:(NSString *)filePath;
@end
