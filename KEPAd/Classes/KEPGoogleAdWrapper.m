//
//  KEPGoogleAdWrapper.m
//
//
//  Created by Luka Li on 15/10/2018.
//

#import "KEPGoogleAdWrapper.h"
#import <AdSupport/AdSupport.h>
#import "KEPGoogleAdRequestCreator.h"
#import "KEPGoogleAdInterstitialAdPreLoader.h"
#import "KEPGoogleAdHeader.h"
#include <UserMessagingPlatform/UserMessagingPlatform.h>

@interface KEPGoogleAdWrapper ()

@property (nonatomic, strong) KEPGoogleAdInterstitialAdPreLoader *interstitialAdLoader;
@property (nonatomic, strong) NSMutableDictionary *nativeAdLoaderDict;

@property (nonatomic, weak) UIViewController *consentViewController;

@end

@implementation KEPGoogleAdWrapper
{
    BOOL _initFlag;
    
    BOOL _isConsenting;
    BOOL _consentFinished;
}

+ (instancetype)sharedWrapper
{
    static KEPGoogleAdWrapper *kAdWrapper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kAdWrapper = [KEPGoogleAdWrapper new];
    });
    
    return kAdWrapper;
}

- (void)setupGoogleAdWrapper
{
    [[GADMobileAds sharedInstance] startWithCompletionHandler:^(GADInitializationStatus * _Nonnull status) {
        [self initFinished];
    }];
    
    [GADMobileAds sharedInstance].requestConfiguration.testDeviceIdentifiers = [KEPGoogleAdConfig sharedConfig].testDevices;
    [[GADMobileAds sharedInstance] disableSDKCrashReporting];
}

- (void)initFinished
{
    _initFlag = YES;
    
    [self initInterstitialAdIfNeeded];
    
    KEPGADIntAdLog(@"GADMobileAds init finshed");
}

- (void)initInterstitialAdIfNeeded
{
    if ([KEPGoogleAdConfig sharedConfig].interstitialAdEnabled) {
        NSString *unitId = [KEPGoogleAdConfig sharedConfig].interstitialAdUnitId;
        self.interstitialAdLoader = [[KEPGoogleAdInterstitialAdPreLoader alloc]initWithUnitId:unitId];
        [self.interstitialAdLoader startPreload];
    }
}

- (BOOL)isInited
{
    return _initFlag;
}

#pragma mark - Banner Ad

- (GADBannerView *)createBannerViewForWidth:(CGFloat)width atIndex:(NSInteger)index withRootViewController:(UIViewController *)viewController
{
    if (![KEPGoogleAdConfig sharedConfig].bannerAdEnabled) {
        return nil;
    }
    
    if (index >= [KEPGoogleAdConfig sharedConfig].bannerUnitIds.count) {
        return nil;
    }
    
    GADBannerView *bannerView = [GADBannerView new];
    bannerView.adUnitID = [KEPGoogleAdConfig sharedConfig].bannerUnitIds[index];
    bannerView.rootViewController = viewController;
    bannerView.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(width);
    [bannerView loadRequest:[KEPGoogleAdRequestCreator createGADRequest]];
    
    return bannerView;
}

- (void)showInterstitialAdFromViewController:(UIViewController *)viewController
{
    [self.interstitialAdLoader showInterstitialAdFromViewController:viewController];
}

@end
