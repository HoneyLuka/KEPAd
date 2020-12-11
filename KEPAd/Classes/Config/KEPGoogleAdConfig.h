//
//  KEPGoogleAdConfig.h
//  Test
//
//  Created by Luka Li on 23/10/2018.
//  Copyright © 2018 Luka Li. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 广告模块的配置类，请在调用主类的 setupGoogleAdWrapper 方法之前配置完成
 */
@interface KEPGoogleAdConfig : NSObject

+ (instancetype)sharedConfig;


#pragma mark - Common Config

/**
 app 内的隐私协议URL，会在欧洲地区用户的个性化广告询问框中使用，必须要指定
 */
@property (nonatomic, copy) NSString *appPrivacyURL;

/**
 个性化广告 flag，"1" 表示非个性化广告，nil 表示个性化广告，通常不用手动设置，内部逻辑已 handle
 */
@property (nonatomic, copy) NSString *npa;


#pragma mark - Debug

@property (nonatomic, copy) NSArray *testDevices;
@property (nonatomic, copy) NSArray *consentDebugDevices;
@property (nonatomic, assign) BOOL simulateEEALocation;
@property (nonatomic, assign) BOOL randomFacebookTestAdTypeEnabled;

#pragma mark - Native Ad Config

/**
 原生广告开关，默认是 NO
 */
@property (nonatomic, assign) BOOL nativeAdEnabled;

/**
 原生广告 UnitId Map，key 为 KEPGoogleAdSourceType 的 NSNumber，value 为与之对应的 UnitId
 */
@property (nonatomic, copy) NSDictionary *nativeAdUnitIdDict;

/**
 原生广告最大缓存数量，默认是3
 */
@property (nonatomic, assign) NSInteger nativeAdPreloadLimit;

/**
 原生广告最多连续出错次数（达到最大出错次数后会暂时停止预加载逻辑，nativeAdPreloadRelaunchTimeInterval 间隔后再次启动），默认是3
 */
@property (nonatomic, assign) NSInteger nativeAdPreloadErrorLimit;

/**
 原生广告预加载逻辑暂停后，再次重启的间隔，默认是15秒
 */
@property (nonatomic, assign) NSTimeInterval nativeAdPreloadRelaunchTimeInterval;

#pragma mark - Interstitial Ad Config

/**
 插页广告开关，默认是 NO
 */
@property (nonatomic, assign) BOOL interstitialAdEnabled;

/**
 插页广告UnitId
 */
@property (nonatomic, copy) NSString *interstitialAdUnitId;

/**
 插页广告最大缓存数量，默认是3
 */
@property (nonatomic, assign) NSInteger interstitialPreloadLimit;

/**
 插页广告预加载最多连续出错次数（达到最大出错次数后会暂时停止预加载逻辑，interstitialPreloadRelaunchTimeInterval 间隔后再次启动），默认是3
 */
@property (nonatomic, assign) NSInteger interstitialPreloadErrorLimit;

/**
 插页广告预加载逻辑暂停后，再次重启的间隔，默认是15秒
 */
@property (nonatomic, assign) NSTimeInterval interstitialPreloadRelaunchTimeInterval;

#pragma mark - Banner Ad Config

@property (nonatomic, assign) BOOL bannerAdEnabled;

@property (nonatomic, copy) NSArray *bannerUnitIds;

@end
