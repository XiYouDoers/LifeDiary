//
//  ZDOrderModel.h
//  LifeDiary
//
//  Created by Jack on 2018/7/18.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@protocol ZDContentlistModel
@end

@interface ZDImagesModel : JSONModel
@property (copy, nonatomic) NSURL<Optional> *u;
@property (copy, nonatomic) NSNumber<Optional> *w;
@property (copy, nonatomic) NSNumber<Optional> *h;
@property (copy, nonatomic) NSNumber<Optional> *t;
@end


@interface ZDContentlistModel :JSONModel
@property (copy, nonatomic) NSString<Optional> *media_name;
@property (copy, nonatomic) NSString<Optional> *title;
@property (copy, nonatomic) NSString<Optional> *ctime;
@property (copy, nonatomic) NSString<Optional> *url;
@property (copy, nonatomic) NSString<Optional> *intro;
@property (strong, nonatomic) ZDImagesModel <Optional> *images;

@end


@interface ZDPagebeanModel : JSONModel
@property (copy, nonatomic) NSNumber<Optional> *allNum;
@property (strong, nonatomic) NSMutableArray<ZDContentlistModel,Optional> *contentlist;
@end

@interface  ZDBodyModel: JSONModel
@property (strong, nonatomic)  ZDPagebeanModel<Optional> *pagebean;
@end

@interface ZDOrderModel : JSONModel
@property (strong, nonatomic)  ZDBodyModel<Optional> *showapi_res_body;
@end
