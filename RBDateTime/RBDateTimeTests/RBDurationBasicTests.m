//
//  RBDurationBasicTests.m
//  RBDateTime
//
//  Created by Richard Bao on 9/2/15.
//  Copyright (c) 2015 Richard Bao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "RBDateTime.h"
#import "RBDuration.h"

@interface RBDurationBasicTests : XCTestCase {
    RBDateTime *_date1;
    RBDateTime *_date2;
    NSTimeInterval _timeInterval;

    double _days, _hours, _minutes, _seconds, _milliseconds;
    double _totalDays, _totalHours, _totalMinutes, _totalSeconds, _totalMilliseconds;
}

@end

@implementation RBDurationBasicTests

static NSTimeZone *UtcTime = nil;

+ (void)setUp {
    UtcTime = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
}

- (void)setUp {
    [super setUp];

    _date1 = [RBDateTime dateTimeWithYear:2015 month:1 day:6
                                     hour:9 minute:41 second:6 millisecond:12
                                 calendar:nil timeZone:UtcTime];
    _date2 = [RBDateTime dateTimeWithYear:2015 month:6 day:12
                                     hour:1 minute:6 second:9 millisecond:41
                                 calendar:nil timeZone:UtcTime];

    _days = 156;
    _hours = 15;
    _minutes = 25;
    _seconds = 3;
    _milliseconds = 29;

    _timeInterval = _days *24*60*60 + _hours *60*60 + _minutes *60 + _seconds + _milliseconds /1000;

    _totalSeconds = _timeInterval;
    _totalMilliseconds = _totalSeconds * 1000;
    _totalMinutes = _totalSeconds / 60;
    _totalHours = _totalMinutes / 60;
    _totalDays = _totalHours / 24;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitWithTimeInterval {
    RBDuration *duration = [[RBDuration alloc] initWithTimeInterval:_timeInterval];

    XCTAssertEqual(duration.days,           _days);
    XCTAssertEqual(duration.hours,          _hours);
    XCTAssertEqual(duration.minutes,        _minutes);
    XCTAssertEqual(duration.seconds,        _seconds);
    XCTAssertEqual(duration.milliseconds,   _milliseconds);
}

- (void)testInitWithDaysHoursMinutesSecondsMilliseconds {
    RBDuration *duration = [[RBDuration alloc] initWithDays:_days
                                                      hours:_hours minutes:_minutes seconds:_seconds
                                               milliseconds:_milliseconds];

    XCTAssertEqual(duration.days,           _days);
    XCTAssertEqual(duration.hours,          _hours);
    XCTAssertEqual(duration.minutes,        _minutes);
    XCTAssertEqual(duration.seconds,        _seconds);
    XCTAssertEqual(duration.milliseconds,   _milliseconds);
}

- (void)testDurationFromDateToDate {
    RBDuration *duration = [RBDuration durationFromDate:_date1 toDate:_date2];

    XCTAssertEqual(duration.days,           _days);
    XCTAssertEqual(duration.hours,          _hours);
    XCTAssertEqual(duration.minutes,        _minutes);
    XCTAssertEqual(duration.seconds,        _seconds);
    XCTAssertEqual(duration.milliseconds,   _milliseconds);
}

- (void)testComponents {
    RBDuration *duration = [[RBDuration alloc] initWithTimeInterval:_timeInterval];

    XCTAssertEqualWithAccuracy(duration.totalDays,          _totalDays,         0.00001);
    XCTAssertEqualWithAccuracy(duration.totalHours,         _totalHours,        0.0001);
    XCTAssertEqualWithAccuracy(duration.totalMinutes,       _totalMinutes,      0.001);
    XCTAssertEqualWithAccuracy(duration.totalSeconds,       _totalSeconds,      0.01);
    XCTAssertEqualWithAccuracy(duration.totalMilliseconds,  _totalMilliseconds, 0.1);
}



- (void)testEqualsTo {

}

@end
