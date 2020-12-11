//
//  KEPGoogleAdRequestCreator.m
//  Test
//
//  Created by Luka Li on 23/10/2018.
//  Copyright © 2018 Luka Li. All rights reserved.
//

#import "KEPGoogleAdRequestCreator.h"
#import "KEPGoogleAdConfig.h"

@implementation KEPGoogleAdRequestCreator

+ (GADRequest *)createGADRequest
{
    GADRequest *request = [GADRequest request];
    
    NSString *npa = [KEPGoogleAdConfig sharedConfig].npa;
    if (npa) {
        GADExtras *extra = [[GADExtras alloc]init];
        extra.additionalParameters = @{@"npa": npa};
        [request registerAdNetworkExtras:extra];
    }

    return request;
}

@end
