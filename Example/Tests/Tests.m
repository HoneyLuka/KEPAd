//
//  KEPAdTests.m
//  KEPAdTests
//
//  Created by Luka on 12/11/2020.
//  Copyright (c) 2020 Luka. All rights reserved.
//

@import XCTest;
#import <KEPAd/KEPGoogleAdHeader.h>

@interface Tests : XCTestCase

@end

@implementation Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLog
{
    KEPGADIntAdLog(@"test int ad log");
    KEPGADNativeAdLog(@"test native ad log");
}

@end

