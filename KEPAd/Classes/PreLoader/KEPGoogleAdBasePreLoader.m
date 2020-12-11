//
//  KEPGoogleAdBasePreLoader.m
//  Appirater
//
//  Created by Luka Li on 29/10/2018.
//

#import "KEPGoogleAdBasePreLoader.h"

@interface KEPGoogleAdBasePreLoader ()

@property (nonatomic, copy) NSString *unitId;
@property (nonatomic, strong) NSMutableArray *queue;

@end

@implementation KEPGoogleAdBasePreLoader
{
    NSTimer *_adRetryTimer;
}

- (void)dealloc
{
    [self stopAdRetryTimer];
}

- (instancetype)initWithUnitId:(NSString *)unitId
{
    if (!unitId.length) {
        return nil;
    }
    
    self = [super init];
    self.unitId = unitId;
    [self setup];
    
    return self;
}

- (void)setup
{
    self.queue = [NSMutableArray array];
}

- (void)startPreload
{
    // do nothing
}

- (NSInteger)availableAdCount
{
    return 0;
}

#pragma mark - Retry Timer

- (void)startAdRetryTimerWithInterval:(NSTimeInterval)interval
{
    [self stopAdRetryTimer];
    
    _adRetryTimer = [NSTimer scheduledTimerWithTimeInterval:interval
                                                           target:self
                                                         selector:@selector(onAdRetry)
                                                         userInfo:nil
                                                          repeats:NO];
}

- (void)stopAdRetryTimer
{
    [_adRetryTimer invalidate];
    _adRetryTimer = nil;
}

- (void)onAdRetry
{
    // do nothing
}

@end
