//
//  RBDateTime Unit Tests
//
//  Copyright (c) 2015 Richard Bao. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

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
