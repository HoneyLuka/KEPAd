//
//  KEPGoogleAdHeader.h
//  Test
//
//  Created by Luka Li on 23/10/2018.
//  Copyright © 2018 Luka Li. All rights reserved.
//

#ifndef KEPGoogleAdHeader_h
#define KEPGoogleAdHeader_h

#import <LKFoundation/LKFoundation.h>

#define KEPGADIntAdLog(fmt, ...) LKLogInfo(@"KEPGADIntAd", nil, fmt, ##__VA_ARGS__)
#define KEPGADNativeAdLog(fmt, ...) LKLogInfo(@"KEPGADNativeAd", nil, fmt, ##__VA_ARGS__)

typedef NS_ENUM(NSUInteger, KEPGoogleAdSourceType) {
    KEPGoogleAdSourceTypeNative,
    KEPGoogleAdSourceTypeNativeBanner,
};

#endif


