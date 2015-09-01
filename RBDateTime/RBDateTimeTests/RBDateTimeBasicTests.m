//
//  RBDateTimeInitializationTests.m
//  RBDateTime
//
//  Created by Richard Bao on 8/31/15.
//  Copyright (c) 2015 Richard Bao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "RBDateTime.h"

@interface RBDateTimeBasicTests : XCTestCase

@end

@implementation RBDateTimeBasicTests

static NSCalendar *_gregorian = nil;
const NSCalendarUnit kValidCalendarUnits =
    NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitNanosecond |
    NSCalendarUnitCalendar | NSCalendarUnitTimeZone;
const double kNanosecondsInMilliseconds = 1000000;

+ (void)setUp {
    _gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInit {
    RBDateTime *now = [[RBDateTime alloc] init];
    NSDate *systemNow = [NSDate new];
    NSDateComponents *sysComps = [_gregorian componentsInTimeZone:[NSTimeZone localTimeZone] fromDate:systemNow];

    XCTAssertEqual(now.year, sysComps.year);
    XCTAssertEqual(now.month, sysComps.month);
    XCTAssertEqual(now.day, sysComps.day);
    XCTAssertEqual(now.hour, sysComps.hour);
    XCTAssertEqual(now.minute, sysComps.minute);
    XCTAssertEqual(now.second, sysComps.second);
}

- (void)testInitWithNSDate {
    NSDate *sysDate = [_gregorian dateWithEra:1
                                         year:2015 month:1 day:6 hour:9 minute:41 second:6
                                   nanosecond:12 * kNanosecondsInMilliseconds];
    RBDateTime *date = [[RBDateTime alloc] initWithNSDate:sysDate calendar:_gregorian timeZone:nil];

    XCTAssertEqual(date.year, 2015);
    XCTAssertEqual(date.month, 1);
    XCTAssertEqual(date.day, 6);
    XCTAssertEqual(date.hour, 9);
    XCTAssertEqual(date.minute, 41);
    XCTAssertEqual(date.second, 6);
    XCTAssertEqual(date.millisecond, 12);
    XCTAssertEqual(date.timeIntervalSinceReferenceDate, sysDate.timeIntervalSinceReferenceDate);
}

- (void)testInitWithTimeIntervalSinceReferenceDate {
    NSDate *systemNow = [NSDate new];
    NSDateComponents *sysComps = [_gregorian componentsInTimeZone:[NSTimeZone localTimeZone] fromDate:systemNow];
    NSTimeInterval timeInterval = systemNow.timeIntervalSinceReferenceDate;

    RBDateTime *now = [[RBDateTime alloc] initWithTimeIntervalSinceReferenceDate:timeInterval
                                                                        calendar:nil
                                                                        timeZone:nil];
    XCTAssertEqual(now.year, sysComps.year);
    XCTAssertEqual(now.month, sysComps.month);
    XCTAssertEqual(now.day, sysComps.day);
    XCTAssertEqual(now.hour, sysComps.hour);
    XCTAssertEqual(now.minute, sysComps.minute);
    XCTAssertEqual(now.second, sysComps.second);
    XCTAssertEqual(now.millisecond, round(sysComps.nanosecond / kNanosecondsInMilliseconds));
}

- (void)testInitWithYearMonthDayHourMinuteSecondNanosecond {
    RBDateTime *ordinary = [[RBDateTime alloc] initWithYear:2015 month:1 day:6
                                                       hour:9 minute:41 second:6 millisecond:12
                                                   calendar:nil
                                                   timeZone:nil];
    XCTAssertEqual(ordinary.year, 2015);
    XCTAssertEqual(ordinary.month, 1);
    XCTAssertEqual(ordinary.day, 6);
    XCTAssertEqual(ordinary.hour, 9);
    XCTAssertEqual(ordinary.minute, 41);
    XCTAssertEqual(ordinary.second, 6);
    XCTAssertEqual(ordinary.millisecond, 12);

    RBDateTime *dayOverflow = [[RBDateTime alloc] initWithYear:2015 month:2 - 1 day:14 + 31 - 1
                                                          hour:9 + 24 - 1 minute:41 + 60 - 1 second:6 + 60 millisecond:12
                                                      calendar:nil
                                                      timeZone:nil];
    XCTAssertEqual(dayOverflow.year, 2015);
    XCTAssertEqual(dayOverflow.month, 2);
    XCTAssertEqual(dayOverflow.day, 14);
    XCTAssertEqual(dayOverflow.hour, 9);
    XCTAssertEqual(dayOverflow.minute, 41);
    XCTAssertEqual(dayOverflow.second, 6);
    XCTAssertEqual(dayOverflow.millisecond, 12);
}

- (void)testPerformance_init {
    [self measureBlock:^{
        for (int i = 0; i < 1000; i++) {
            RBDateTime *ordinary = [[RBDateTime alloc] init];
            ordinary = nil;
        }
    }];
}

- (void)testPerformance_initWithYearMonthDayHourMinuteSecondMillisecond {
    [self measureBlock:^{
        for (int i = 0; i < 1000; i++) {
            RBDateTime *ordinary = [[RBDateTime alloc] initWithYear:2015 month:1 day:6
                                                               hour:9 minute:41 second:6 millisecond:12
                                                           calendar:nil
                                                           timeZone:nil];
            ordinary = nil;
        }
    }];
}

- (void)testLeapYear {
    XCTAssert([RBDateTime isLeapYear:1990] == NO);
    XCTAssert([RBDateTime isLeapYear:2000] == YES);
    XCTAssert([RBDateTime isLeapYear:2001] == NO);
    XCTAssert([RBDateTime isLeapYear:2002] == NO);
    XCTAssert([RBDateTime isLeapYear:2003] == NO);
    XCTAssert([RBDateTime isLeapYear:2004] == YES);

    // TODO: Test -isLeapYear and -isLeapMonth after convenient initializers are ready.
}


@end
