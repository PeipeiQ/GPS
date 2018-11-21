//
//  AppDelegate.h
//  GPSdemo
//
//  Created by 沛沛 on 2018/11/14.
//  Copyright © 2018年 沛沛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BMKLocationkit/BMKLocationComponent.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, BMKGeneralDelegate, BMKLocationAuthDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

