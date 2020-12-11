//
//  KEPGoogleAdHeader.h
//  Test
//
//  Created by Luka Li on 23/10/2018.
//  Copyright © 2018 Luka Li. All rights reserved.
//

#ifndef KEPGoogleAdHeader_h
#define KEPGoogleAdHeader_h

#if KEPGADDebugLogEnabled

#define KEPGADIntAdLog(fmt, ...) NSLog((@"KEPGoogleIntAd: " fmt), ##__VA_ARGS__)
#define KEPGADNativeAdLog(fmt, ...) NSLog((@"KEPGoogleNativeAd: " fmt), ##__VA_ARGS__)
#define KEPGADConsentLog(fmt, ...) NSLog((@"KEPGoogleConsent: " fmt), ##__VA_ARGS__)

#else

#define KEPGADIntAdLog(...)
#define KEPGADNativeAdLog(...)
#define KEPGADConsentLog(fmt, ...)

#endif

typedef NS_ENUM(NSUInteger, KEPGoogleAdSourceType) {
    KEPGoogleAdSourceTypeNative,
    KEPGoogleAdSourceTypeNativeBanner,
};

#endif


