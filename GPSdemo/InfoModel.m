//
//  IndoModel.m
//  GPSdemo
//
//  Created by 沛沛 on 2018/11/18.
//  Copyright © 2018年 沛沛. All rights reserved.
//

#import "InfoModel.h"

@implementation InfoModel

@end

@implementation Info

- (id)initWithName:(NSString *)name data:(double)data
{
    if (self = [super init]) {
        _name = name;
        _data = data;
    }
    return self;
}
@end
