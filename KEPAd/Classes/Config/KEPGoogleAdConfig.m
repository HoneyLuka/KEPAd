//
//  KEPGoogleAdConfig.m
//  Test
//
//  Created by Luka Li on 23/10/2018.
//  Copyright © 2018 Luka Li. All rights reserved.
//

#import "KEPGoogleAdConfig.h"

@implementation KEPGoogleAdConfig

+ (instancetype)sharedConfig
{
    static KEPGoogleAdConfig *kConfig = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kConfig = [KEPGoogleAdConfig new];
    });
    
    return kConfig;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _setup];
    }
    return self;
}

- (void)_setup
{
    [self loadDefaultConfig];
}

- (void)loadDefaultConfig
{
    _nativeAdPreloadLimit = 3;
    _nativeAdPreloadErrorLimit = 3;
    _nativeAdPreloadRelaunchTimeInterval = 15;
    
    _interstitialPreloadLimit = 3;
    _interstitialPreloadErrorLimit = 3;
    _interstitialPreloadRelaunchTimeInterval = 15;
}

@end
