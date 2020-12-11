//
//  KEPGoogleAdBasePreLoader.h
//  Appirater
//
//  Created by Luka Li on 29/10/2018.
//

#import <Foundation/Foundation.h>

@interface KEPGoogleAdBasePreLoader : NSObject

@property (nonatomic, strong, readonly) NSMutableArray *queue;
@property (nonatomic, copy, readonly) NSString *unitId;

/**
 重写来对 PreLoader 做一些初始化工作，必须调用 super
 */
- (void)setup;

/**
 启动 PreLoader，基类不做任何事
 */
- (void)startPreload;

/**
 返回当前缓存池中，已经准备好的广告数量，基类默认返回0
 */
- (NSInteger)availableAdCount;

#pragma mark - Retry Timer

- (void)startAdRetryTimerWithInterval:(NSTimeInterval)interval;
- (void)stopAdRetryTimer;

/**
 当 timer 触发时调用，重写来自定义操作，基类不做任何事
 */
- (void)onAdRetry;

- (instancetype)initWithUnitId:(NSString *)unitId NS_DESIGNATED_INITIALIZER;
- (instancetype)init __attribute__((unavailable("can't use this method")));
+ (instancetype)new __attribute__((unavailable("can't use this method")));

@end
