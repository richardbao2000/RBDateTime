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

    XCTAssertEqual(date.year,           2015);
    XCTAssertEqual(date.month,          1);
    XCTAssertEqual(date.day,            6);
    XCTAssertEqual(date.hour,           9);
    XCTAssertEqual(date.minute,         41);
    XCTAssertEqual(date.second,         6);
    XCTAssertEqual(date.millisecond,    12);
    XCTAssertEqualWithAccuracy(date.timeIntervalSinceReferenceDate, sysDate.timeIntervalSinceReferenceDate, 1);
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

- (void)testInitWithYearMonthDayHourMinuteSecondMillisecondCalendarTimeZone {
    RBDateTime *date = [[RBDateTime alloc] initWithYear:2015 month:1 day:6
                                                   hour:9 minute:41 second:6 millisecond:12
                                               calendar:nil
                                               timeZone:nil];
    XCTAssertEqual(date.year,           2015);
    XCTAssertEqual(date.month,          1);
    XCTAssertEqual(date.day,            6);
    XCTAssertEqual(date.hour,           9);
    XCTAssertEqual(date.minute,         41);
    XCTAssertEqual(date.second,         6);
    XCTAssertEqual(date.millisecond,    12);

    RBDateTime *dayOverflow = [[RBDateTime alloc] initWithYear:2015 month:2 - 1 day:14 + 31 - 1
                                                          hour:9 + 24 - 1 minute:41 + 60 - 1 second:6 + 60 millisecond:12
                                                      calendar:nil
                                                      timeZone:nil];
    XCTAssertEqual(dayOverflow.year,        2015);
    XCTAssertEqual(dayOverflow.month,       2);
    XCTAssertEqual(dayOverflow.day,         14);
    XCTAssertEqual(dayOverflow.hour,        9);
    XCTAssertEqual(dayOverflow.minute,      41);
    XCTAssertEqual(dayOverflow.second,      6);
    XCTAssertEqual(dayOverflow.millisecond, 12);
}

- (void)testInitWithYearMonthDay {
    RBDateTime *date = [RBDateTime dateTimeWithYear:2015 month:1 day:6];

    XCTAssertEqual(date.year,   2015);
    XCTAssertEqual(date.month,  1);
    XCTAssertEqual(date.day,    6);
}

- (void)testInitWithYearMonthDayHourMinuteSecond {
    RBDateTime *date = [RBDateTime dateTimeWithYear:2015 month:1 day:6 hour:9 minute:41 second:6];

    XCTAssertEqual(date.year,   2015);
    XCTAssertEqual(date.month,  1);
    XCTAssertEqual(date.day,    6);
    XCTAssertEqual(date.hour,   9);
    XCTAssertEqual(date.minute, 41);
    XCTAssertEqual(date.second, 6);
}

- (void)testInitWithYearMonthDayHourMinuteSecondTimeZone {
    RBDateTime *date = [RBDateTime dateTimeWithYear:2015 month:1 day:6 hour:9 minute:41 second:6
                                           timeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    XCTAssertEqual(date.year,   2015);
    XCTAssertEqual(date.month,  1);
    XCTAssertEqual(date.day,    6);
    XCTAssertEqual(date.hour,   9);
    XCTAssertEqual(date.minute, 41);
    XCTAssertEqual(date.second, 6);
    XCTAssertEqual(date.timeZone.secondsFromGMT, 0);
}

- (void)testInitWithYearMonthDayHourMinuteSecondCalendar {
    RBDateTime *date = [RBDateTime dateTimeWithYear:2015 month:1 day:6 hour:9 minute:41 second:6
                                           calendar:[NSCalendar calendarWithIdentifier:NSCalendarIdentifierHebrew]];
    XCTAssertEqual(date.year,   2015);
    XCTAssertEqual(date.month,  1);
    XCTAssertEqual(date.day,    6);
    XCTAssertEqual(date.hour,   9);
    XCTAssertEqual(date.minute, 41);
    XCTAssertEqual(date.second, 6);
    XCTAssertEqual(date.calendar.calendarIdentifier, NSCalendarIdentifierHebrew);
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

- (void)testDate {
    RBDateTime *date = [[RBDateTime dateTimeWithYear:2015 month:1 day:6 hour:9 minute:41 second:6] date];
    
    XCTAssertEqual(date.year,   2015);
    XCTAssertEqual(date.month,  1);
    XCTAssertEqual(date.day,    6);
    XCTAssertEqual(date.hour,   0);
    XCTAssertEqual(date.minute, 0);
    XCTAssertEqual(date.second, 0);
}

- (void)testTimeOfDay {
    RBDateTime *date = [RBDateTime dateTimeWithYear:2015 month:1 day:6 hour:9 minute:41 second:6];
    RBDuration *timeOfDay = date.timeOfDay;

    XCTAssertEqual(timeOfDay.days,      0);
    XCTAssertEqual(timeOfDay.hours,     9);
    XCTAssertEqual(timeOfDay.minutes,   41);
    XCTAssertEqual(timeOfDay.seconds,   6);

    RBDuration *duration = [RBDuration durationWithHours:9 minutes:41 seconds:6];

    XCTAssert([timeOfDay equalsTo:duration]);
}

- (void)testDayOfWeek {
    RBDateTime *date = [RBDateTime dateTimeWithYear:2015 month:1 day:6 hour:9 minute:41 second:6];
    XCTAssertEqual([date dayOfWeek], 3); // Tuesday
}

- (void)testDayOfYear {
    RBDateTime *date = [RBDateTime dateTimeWithYear:2015 month:6 day:12 hour:9 minute:41 second:6];
    XCTAssertEqual([date dayOfYear], 31 + 28 + 31 + 30 + 31 + 12);
}

- (void)testLeapYear {
    XCTAssert([RBDateTime isLeapYear:1990] == NO);
    XCTAssert([RBDateTime isLeapYear:2000] == YES);
    XCTAssert([RBDateTime isLeapYear:2001] == NO);
    XCTAssert([RBDateTime isLeapYear:2002] == NO);
    XCTAssert([RBDateTime isLeapYear:2003] == NO);
    XCTAssert([RBDateTime isLeapYear:2004] == YES);

    XCTAssert([RBDateTime dateTimeWithYear:1990 month:1 day:1].isLeapYear == NO);
    XCTAssert([RBDateTime dateTimeWithYear:2000 month:1 day:1].isLeapYear == YES);
    XCTAssert([RBDateTime dateTimeWithYear:2001 month:1 day:1].isLeapYear == NO);
    XCTAssert([RBDateTime dateTimeWithYear:2002 month:1 day:1].isLeapYear == NO);
    XCTAssert([RBDateTime dateTimeWithYear:2003 month:1 day:1].isLeapYear == NO);
    XCTAssert([RBDateTime dateTimeWithYear:2004 month:1 day:1].isLeapYear == YES);

    XCTAssert([RBDateTime dateTimeWithYear:1990 month:2 day:1].isLeapMonth == NO);
    XCTAssert([RBDateTime dateTimeWithYear:2000 month:2 day:1].isLeapMonth == YES);
    XCTAssert([RBDateTime dateTimeWithYear:2001 month:2 day:1].isLeapMonth == NO);
    XCTAssert([RBDateTime dateTimeWithYear:2002 month:2 day:1].isLeapMonth == NO);
    XCTAssert([RBDateTime dateTimeWithYear:2003 month:2 day:1].isLeapMonth == NO);
    XCTAssert([RBDateTime dateTimeWithYear:2004 month:2 day:1].isLeapMonth == YES);

    XCTAssert([RBDateTime dateTimeWithYear:1990 month:1 day:1].isLeapMonth == NO);
    XCTAssert([RBDateTime dateTimeWithYear:2000 month:3 day:1].isLeapMonth == NO);
    XCTAssert([RBDateTime dateTimeWithYear:2001 month:4 day:1].isLeapMonth == NO);
    XCTAssert([RBDateTime dateTimeWithYear:2002 month:5 day:1].isLeapMonth == NO);
    XCTAssert([RBDateTime dateTimeWithYear:2003 month:6 day:1].isLeapMonth == NO);
    XCTAssert([RBDateTime dateTimeWithYear:2004 month:7 day:1].isLeapMonth == NO);
}


@end
