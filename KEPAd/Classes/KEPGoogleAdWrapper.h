//
//  KEPGoogleAdWrapper.h
//  
//
//  Created by Luka Li on 15/10/2018.
//

#import <UIKit/UIKit.h>
#import "KEPGoogleAdConfig.h"
#import "KEPGoogleAdBaseModel.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

/**
 广告模块的主类，使用之前请先调用初始化方法进行初始化
 */
@interface KEPGoogleAdWrapper : NSObject

+ (instancetype)sharedWrapper;

/**
 模块初始化，需要在其他任何调用之前调用（请先将 KEPGoogleAdConfig 配置完之后调用）
 */
- (void)setupGoogleAdWrapper;

/**
 是否已经初始化过
 */
- (BOOL)isInited;

#pragma mark - Banner Ad

- (GADBannerView *)createBannerViewForWidth:(CGFloat)width atIndex:(NSInteger)index withRootViewController:(UIViewController *)viewController;

#pragma mark - Interstitial Ad

- (void)showInterstitialAdFromViewController:(UIViewController *)viewController;

@end
