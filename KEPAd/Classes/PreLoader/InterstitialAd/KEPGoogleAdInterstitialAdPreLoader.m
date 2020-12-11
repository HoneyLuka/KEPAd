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

@interface KEPGoogleAdInterstitialAdPreLoader () <GADInterstitialDelegate>

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
    NSInteger count = 0;
    for (int i = 0; i < self.queue.count; i++) {
        GADInterstitial *interstitial = self.queue[i];
        if (interstitial.isReady) {
            count++;
        }
    }
    
    return count;
}

- (void)showInterstitialAdFromViewController:(UIViewController *)viewController
{
    if (!viewController) {
        return;
    }
    
    GADInterstitial *interstitial = [self getValidInterstitial];
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

- (GADInterstitial *)getValidInterstitial
{
    for (int i = 0; i < self.queue.count; i++) {
        GADInterstitial *interstitial = self.queue[i];
        if (interstitial.isReady) {
            return interstitial;
        }
    }
    
    return nil;
}

- (void)fillQueueIfNeeded
{
    KEPGADIntAdLog(@"check if need to fill queue");
    
    if (self.queue.count >= [KEPGoogleAdConfig sharedConfig].interstitialPreloadLimit) {
        KEPGADIntAdLog(@"queue if full");
        return;
    }
    
    // enqueue
    KEPGADIntAdLog(@"create ad model and enqueue");
    
    GADInterstitial *interstitial = [self createInterstitial];
    [self.queue addObject:interstitial];
    
    GADRequest *request = [KEPGoogleAdRequestCreator createGADRequest];
    [interstitial loadRequest:request];
    
    [self fillQueueIfNeeded];
}

- (void)dequeueInterstitial:(GADInterstitial *)interstitial
{
    [self.queue removeObject:interstitial];
}

- (GADInterstitial *)createInterstitial
{
    GADInterstitial *interstitial = [[GADInterstitial alloc]initWithAdUnitID:self.unitId];
    interstitial.delegate = self;
    return interstitial;
}

- (void)onAdRetry
{
    [self fillQueueIfNeeded];
}

#pragma mark - GADInterstitialDelegate

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad
{
    _interstitialErrorCount = 0;
    
    KEPGADIntAdLog(@"interstitialDidReceiveAd");
    [self logQueue];
}

- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error
{
    [self dequeueInterstitial:ad];
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

- (void)interstitialWillPresentScreen:(GADInterstitial *)ad
{
    KEPGADIntAdLog(@"interstitialWillPresentScreen");
}

- (void)interstitialDidFailToPresentScreen:(GADInterstitial *)ad
{
    KEPGADIntAdLog(@"interstitialDidFailToPresentScreen");
}

- (void)interstitialWillDismissScreen:(GADInterstitial *)ad
{
    KEPGADIntAdLog(@"interstitialWillDismissScreen");
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)ad
{
    KEPGADIntAdLog(@"interstitialDidDismissScreen");
}

- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad
{
    KEPGADIntAdLog(@"interstitialWillLeaveApplication");
}

- (void)logQueue
{
    [self logCurrentAdCount];
    [self logCurrentReadyAdCount];
}

- (void)logCurrentAdCount
{
    KEPGADIntAdLog(@"current queue count = %ld", self.queue.count);
}

- (void)logCurrentReadyAdCount
{
    NSInteger readyCount = 0;
    for (GADInterstitial *inter in self.queue) {
        if (inter.isReady) {
            readyCount++;
        }
    }
    
    KEPGADIntAdLog(@"current queue ready count = %ld", readyCount);
}

@end
