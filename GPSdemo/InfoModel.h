//
//  IndoModel.h
//  GPSdemo
//
//  Created by 沛沛 on 2018/11/18.
//  Copyright © 2018年 沛沛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfoModel : NSObject
@property(nonatomic, assign) double longitude;
@property(nonatomic, assign) double latitude;
@property(nonatomic, assign) double speed;
@property(nonatomic, assign) double hAccuracy;
@property(nonatomic, assign) double vAccuracy;
@property(nonatomic, assign) double altitude;
@end

@interface Info : NSObject
@property(nonatomic, strong) NSString *name;
@property(nonatomic, assign) double data;
- (id)initWithName:(NSString *)name data:(double)data;
@end
