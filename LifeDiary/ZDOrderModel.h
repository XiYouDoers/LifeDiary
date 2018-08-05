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
@protocol ZDPicModel
@end
@interface ZDPicModel : JSONModel
@property (copy, nonatomic) NSURL<Optional> *url;
@end

@interface ZDContentlistModel :JSONModel
@property (copy, nonatomic) NSString<Optional> *title;
@property (copy, nonatomic) NSString<Optional> *channelName;
@property (copy, nonatomic) NSString<Optional> *source;
@property (copy, nonatomic) NSString<Optional> *pubDate;
@property (copy, nonatomic) NSString<Optional> *link;
@property (copy, nonatomic) NSString<Optional> *html;
@property (copy, nonatomic) NSArray <ZDPicModel,Optional> *imageurls;

@end

@interface ZDPagebeanModel :JSONModel
@property (copy, nonatomic) NSNumber<Optional> *allNum;
@property (strong, nonatomic) NSMutableArray<ZDContentlistModel,Optional> *contentlist;
@end

@interface  ZDBodyModel: JSONModel
@property (strong, nonatomic)  ZDPagebeanModel<Optional> *pagebean;
@end

@interface  ZDOrderModel: JSONModel
@property (strong, nonatomic)  ZDBodyModel<Optional> *showapi_res_body;
@end
