//
//  ZDLinkViewController.h
//  LifeDiary
//
//  Created by Jack on 2018/7/18.
//  Copyright © 2018年 JACK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDHtmlScrollView.h"
#import "ZDOrderModel.h"

@interface ZDLinkViewController : UIViewController

@property(nonatomic,strong) ZDHtmlScrollView *htmlScrollView;
@property(nonatomic,strong) ZDContentlistModel *contentlistModel;
@end
