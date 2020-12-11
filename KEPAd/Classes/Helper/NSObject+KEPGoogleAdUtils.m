//
//  NSObject+KEPGoogleAdUtils.m
//  Appirater
//
//  Created by Luka Li on 25/10/2018.
//

#import "NSObject+KEPGoogleAdUtils.h"
#import "KEPGoogleAdBaseModel.h"

@implementation NSObject (KEPGoogleAdUtils)

- (BOOL)kep_isAdModel
{
    return [self isKindOfClass:KEPGoogleAdBaseModel.class];
}

@end
