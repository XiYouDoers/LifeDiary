//
//  ZDShoppingModel.h
//  LifeDiary
//
//  Created by Jack on 2018/8/16.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol ZDProductInfo
@end
@interface ZDProductInfo : JSONModel
@property (copy, nonatomic) NSString<Optional> *good;
@property (copy, nonatomic) NSURL<Optional> *imageUrl;
@property (copy, nonatomic) NSString<Optional> *name;
@property (copy, nonatomic) NSString<Optional> *price;
@property (copy, nonatomic) NSURL<Optional> *url;
@end

@interface ZDShoppingModel : JSONModel
@property (strong, nonatomic) NSMutableArray <ZDProductInfo,Optional> *productInfo;
@end
