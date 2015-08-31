//
//  RBDateTimeTests.m
//  RBDateTime
//
//  Created by Richard Bao on 8/24/15.
//  Copyright (c) 2015 Richard Bao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "RBDateTime.h"

@interface RBDateTimeTests : XCTestCase

@end

@implementation RBDateTimeTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitWithYearMonthDayHourMinuteSecondNanosecond {
    RBDateTime *ordinary = [[RBDateTime alloc] initWithYear:2015 month:1 day:6 hour:9 minute:41 second:6 nanosecond:12];

    XCTAssert(ordinary.year == 2015);
    XCTAssert(ordinary.month == 1);
    XCTAssert(ordinary.day == 6);

    RBDateTime *dayOverflow = [[RBDateTime alloc] initWithYear:2015 month:1 day:40 hour:9 minute:41 second:6 nanosecond:12];
    XCTAssert(dayOverflow.year == 2015);
    XCTAssert(dayOverflow.month == 2);
    XCTAssert(dayOverflow.day == 9);

}

- (void)testPerformance_initWithYearMonthDayHourMinuteSecondNanosecond {
    [self measureBlock:^{
        for (int i = 0; i < 1000; i++) {
            RBDateTime *ordinary = [[RBDateTime alloc] initWithYear:2015 month:1 day:6 hour:9 minute:41 second:6 nanosecond:12];
            ordinary = nil;
        }
    }];
}


@end
