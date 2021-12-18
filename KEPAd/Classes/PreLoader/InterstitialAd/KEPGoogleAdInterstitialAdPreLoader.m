//
//  KEPGoogleAdInterstitialAdPreLoader.m
//  Test
//
//  Created by Luka Li on 23/10/2018.
//  Copyright © 2018 Luka Li. All rights reserved.
//

#import "KEPGoogleAdInterstitialAdPreLoader.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "KEPGoogleAdHeader.h"
#import "KEPGoogleAdConfig.h"
#import "KEPGoogleAdRequestCreator.h"

@interface KEPGoogleAdInterstitialAdPreLoader () <GADFullScreenContentDelegate>

/// 是否正在请求广告的flag
@property (nonatomic, assign) BOOL adIsRequesting;

@end

@implementation KEPGoogleAdInterstitialAdPreLoader
{
    NSInteger _interstitialErrorCount;
}

- (void)startPreload
{
    [self fillQueueIfNeeded];
}

- (NSInteger)availableAdCount
{
    return self.queue.count;
}

- (void)showInterstitialAdFromViewController:(UIViewController *)viewController
{
    if (!viewController) {
        return;
    }
    
    GADInterstitialAd *interstitial = [self getValidInterstitial];
    if (!interstitial) {
        KEPGADIntAdLog(@"no ad to show");
        return;
    }
    
    KEPGADIntAdLog(@"will show ad");
    
    [interstitial presentFromRootViewController:viewController];
    [self dequeueInterstitial:interstitial];
    
    [self logQueue];
    [self fillQueueIfNeeded];
}

- (GADInterstitialAd *)getValidInterstitial
{
    return self.queue.firstObject;
}

- (void)fillQueueIfNeeded
{
    KEPGADIntAdLog(@"check if need to fill queue");
    
    if (self.queue.count >= [KEPGoogleAdConfig sharedConfig].interstitialPreloadLimit) {
        KEPGADIntAdLog(@"queue if full");
        return;
    }
    
    if (self.adIsRequesting) {
        // is requesting
        return;
    }
    
    // enqueue
    KEPGADIntAdLog(@"request ad and enqueue");
    
    self.adIsRequesting = YES;
    GADRequest *request = [KEPGoogleAdRequestCreator createGADRequest];
    [GADInterstitialAd loadWithAdUnitID:self.unitId request:request completionHandler:^(GADInterstitialAd * _Nullable interstitialAd, NSError * _Nullable error) {
        self.adIsRequesting = NO;
        
        if (error) {
            [self onRequestFailed:error];
            return;
        }
        
        [self onReceiveAd:interstitialAd];
        [self fillQueueIfNeeded];
    }];
}

- (void)dequeueInterstitial:(GADInterstitialAd *)interstitial
{
    [self.queue removeObject:interstitial];
}

- (void)onAdRetry
{
    [self fillQueueIfNeeded];
}

#pragma mark - GADInterstitialDelegate

- (void)onReceiveAd:(GADInterstitialAd *)ad
{
    KEPGADIntAdLog(@"interstitialDidReceiveAd");
    
    _interstitialErrorCount = 0;
    ad.fullScreenContentDelegate = self;
    [self.queue addObject:ad];
    [self logQueue];
}

- (void)onRequestFailed:(NSError *)error
{
    _interstitialErrorCount++;
    
    KEPGADIntAdLog(@"didFailToReceiveAdWithError = %@, current error count = %ld",
                   error, _interstitialErrorCount);
    [self logQueue];
    
    // retry
    NSInteger errorLimit = [KEPGoogleAdConfig sharedConfig].interstitialPreloadErrorLimit;
    
    if (_interstitialErrorCount < errorLimit) {
        KEPGADIntAdLog(@"will retry");
        [self fillQueueIfNeeded];
        return;
    }
    
    // retry timer
    KEPGADIntAdLog(@"stop retry, waiting for relaunch");
    NSTimeInterval interval = [KEPGoogleAdConfig sharedConfig].interstitialPreloadRelaunchTimeInterval;
    [self startAdRetryTimerWithInterval:interval];
}

- (void)logQueue
{
    [self logCurrentAdCount];
}

- (void)logCurrentAdCount
{
    KEPGADIntAdLog(@"current queue count = %ld", self.queue.count);
}

@end
