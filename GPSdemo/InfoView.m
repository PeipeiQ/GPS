//
//  InfoView.m
//  GPSdemo
//
//  Created by 沛沛 on 2018/11/18.
//  Copyright © 2018年 沛沛. All rights reserved.
//

#import "InfoView.h"
@interface InfoView() <UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray<Info *> *info;
@end

@implementation InfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initTableView];
    }
    return self;
}

- (void)initTableView {
    _tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self addSubview:_tableView];
}


- (void)setInfoModel:(InfoModel *)infoModel {
    NSMutableArray *info = [[NSMutableArray alloc] init];
    [info addObject:[[Info alloc] initWithName:@"经度" data:infoModel.longitude]];
    [info addObject:[[Info alloc] initWithName:@"纬度" data:infoModel.latitude]];
    [info addObject:[[Info alloc] initWithName:@"速度" data:infoModel.speed]];
    [info addObject:[[Info alloc] initWithName:@"水平精度" data:infoModel.hAccuracy]];
    [info addObject:[[Info alloc] initWithName:@"垂直精度" data:infoModel.vAccuracy]];
    [info addObject:[[Info alloc] initWithName:@"海拔高度" data:infoModel.altitude]];
    _info = info;
    [self.tableView reloadData];
}

//datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _info.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    Info *info = _info[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ : %f", info.name, info.data];
    return cell;
}

@end
