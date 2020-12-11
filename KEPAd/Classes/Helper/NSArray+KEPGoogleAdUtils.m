//
//  NSArray+KEPGoogleAdUtils.m
//  Appirater
//
//  Created by Luka Li on 30/10/2018.
//

#import "NSArray+KEPGoogleAdUtils.h"
#import "NSObject+KEPGoogleAdUtils.h"

@implementation NSArray (KEPGoogleAdUtils)

- (BOOL)kep_isAdModelAtIndex:(NSInteger)index
{
    if (index < 0 || index >= self.count) {
        return NO;
    }
    
    id obj = [self objectAtIndex:index];
    return [obj kep_isAdModel];
}

@end
