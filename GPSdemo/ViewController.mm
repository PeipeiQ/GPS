//
//  ViewController.m
//  GPSdemo
//
//  Created by 沛沛 on 2018/11/14.
//  Copyright © 2018年 沛沛. All rights reserved.
//

#import "ViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BMKLocationkit/BMKLocationComponent.h>
#import "InfoView.h"
#import "InfoModel.h"

@interface ViewController () <BMKLocationServiceDelegate, BMKLocationManagerDelegate>
@property(nonatomic, strong) BMKMapView *mapView;
@property(nonatomic, strong) BMKUserLocation *userLocation;
@property(nonatomic, strong) BMKLocationService *locService;
@property(nonatomic, strong) BMKLocationManager *locationManager;
@property(nonatomic, strong) InfoView *infoView;
@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置mapView
    [self initMapView];
    //启动定位服务
    [self initLocService];
    //设置精度圈
    [self customLocationAccuracyCircle];
    //设置定位并启动
    [self initLocation];
    [self initInfoView];
}

- (void)initMapView {
    _mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_mapView];
    //显示定位图层
    _mapView.showsUserLocation = NO;
    //设置定位的状态为普通定位模式
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    _mapView.zoomLevel = 18;
}

- (void)initLocService {
    _locService = [[BMKLocationService alloc]init];
    [_locService startUserLocationService];
}

- (void)initLocation {
    //初始化实例
    _locationManager = [[BMKLocationManager alloc] init];
    //设置delegate
    _locationManager.delegate = self;
    //设置返回位置的坐标系类型
    _locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
    //设置距离过滤参数
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    //设置预期精度参数
    _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    //设置应用位置类型
    _locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    //设置是否自动停止位置更新
    _locationManager.pausesLocationUpdatesAutomatically = NO;
    //设置是否允许后台定位
    _locationManager.allowsBackgroundLocationUpdates = NO;
    //设置位置获取超时时间
    _locationManager.locationTimeout = 10;
    //设置获取地址信息超时时间
    _locationManager.reGeocodeTimeout = 10;
    
    [self.locationManager setLocatingWithReGeocode:YES];
    [self.locationManager startUpdatingLocation];
}

- (void)initInfoView {
    CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;
    CGFloat screenHeight = UIScreen.mainScreen.bounds.size.height;

    _infoView = [[InfoView alloc] initWithFrame:CGRectMake(30, screenHeight *3/5, screenWidth - 60, screenHeight / 3)];
    _infoView.alpha = 0.8;
    [self.view addSubview:_infoView];
}

//自定义精度圈
- (void)customLocationAccuracyCircle {
    BMKLocationViewDisplayParam *param = [[BMKLocationViewDisplayParam alloc] init];
    param.isAccuracyCircleShow = false;
    [_mapView updateLocationViewWithParam:param];
}

//BMKLocationServiceDelegate
/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}

//BMKLocationManagerDelegate
- (void)BMKLocationManager:(BMKLocationManager *)manager didUpdateLocation:(BMKLocation *)location orError:(NSError *)error {
    if (error)
    {
        NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
    } if (location) {//得到定位信息，添加annotation
        if (location.location) {
            InfoModel *model = [[InfoModel alloc] init];
            //经度
            model.longitude = location.location.coordinate.longitude;
            //纬度
            model.latitude = location.location.coordinate.latitude;
            //速度
            model.speed = location.location.speed > 0 ? location.location.speed : 0;
            //水平精度
            model.hAccuracy = location.location.horizontalAccuracy;
            //垂直精度
            model.vAccuracy = location.location.verticalAccuracy;
            //海拔高度
            model.altitude = location.location.altitude;
            _infoView.infoModel = model;
        }
        if (location.rgcData) {
            NSLog(@"rgc = %@",[location.rgcData description]);
        }
    }
}

- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}







@end
