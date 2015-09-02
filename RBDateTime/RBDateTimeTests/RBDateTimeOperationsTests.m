//
//  RBDateTimeAddingTests.m
//  RBDateTime
//
//  Created by Richard Bao on 9/1/15.
//  Copyright (c) 2015 Richard Bao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "RBDateTime.h"

@interface RBDateTimeOperationsTests : XCTestCase

@end

@implementation RBDateTimeOperationsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAddDays {
    RBDateTime *original = [RBDateTime dateTimeWithYear:2015 month:1 day:6
                                                   hour:9 minute:41 second:6 millisecond:12
                                               calendar:nil timeZone:nil];
    RBDateTime *date = [original dateTimeByAddingDays:15];

    XCTAssertEqual(date.year,   2015);
    XCTAssertEqual(date.month,  1);
    XCTAssertEqual(date.day,    21);
    XCTAssertEqual(date.hour,   9);
    XCTAssertEqual(date.minute, 41);
    XCTAssertEqual(date.second, 6);

    [original addDays:15];

    XCTAssert([original equalsTo:date]);

    date = [original dateTimeByAddingDays:20];

    XCTAssertEqual(date.year,   2015);
    XCTAssertEqual(date.month,  2);
    XCTAssertEqual(date.day,    10);
    XCTAssertEqual(date.hour,   9);
    XCTAssertEqual(date.minute, 41);
    XCTAssertEqual(date.second, 6);

    [original addDays:20];

    XCTAssert([original equalsTo:date]);

    date = [original dateTimeByAddingDays:-5];

    XCTAssertEqual(date.year,   2015);
    XCTAssertEqual(date.month,  2);
    XCTAssertEqual(date.day,    5);
    XCTAssertEqual(date.hour,   9);
    XCTAssertEqual(date.minute, 41);
    XCTAssertEqual(date.second, 6);

    [original addDays:-5];

    XCTAssert([original equalsTo:date]);
}

- (void)testAddYearsMonthsDays {
    RBDateTime *original = [[RBDateTime alloc] initWithYear:2015 month:1 day:6
                                                       hour:9 minute:41 second:6 millisecond:12
                                                   calendar:nil timeZone:nil];
    RBDateTime *date = [original dateTimeByAddingYears:1 months:2 days:3];

    XCTAssertEqual(date.year,           2016);
    XCTAssertEqual(date.month,          3);
    XCTAssertEqual(date.day,            9);
    XCTAssertEqual(date.hour,           9);
    XCTAssertEqual(date.minute,         41);
    XCTAssertEqual(date.second,         6);
    XCTAssertEqual(date.millisecond,    12);

    [original addYears:1 months:2 days:3];

    XCTAssert([original equalsTo:date]);

    date = [original dateTimeByAddingYears:10 months:20 days:30];

    XCTAssertEqual(date.year,           2027);
    XCTAssertEqual(date.month,          12);
    XCTAssertEqual(date.day,            9);
    XCTAssertEqual(date.hour,           9);
    XCTAssertEqual(date.minute,         41);
    XCTAssertEqual(date.second,         6);
    XCTAssertEqual(date.millisecond,    12);

    [original addYears:10 months:20 days:30];

    XCTAssert([original equalsTo:date]);
}

- (void)testAddHoursMinutesSeconds {
    RBDateTime *original = [[RBDateTime alloc] initWithYear:2015 month:1 day:6
                                                       hour:9 minute:41 second:6 millisecond:12
                                                   calendar:nil timeZone:nil];
    RBDateTime *date = [original dateTimeByAddingHours:4 minutes:5 seconds:6];

    XCTAssertEqual(date.year,           2015);
    XCTAssertEqual(date.month,          1);
    XCTAssertEqual(date.day,            6);
    XCTAssertEqual(date.hour,           13);
    XCTAssertEqual(date.minute,         46);
    XCTAssertEqual(date.second,         12);
    XCTAssertEqual(date.millisecond,    12);

    [original addHours:4 minutes:5 seconds:6];

    XCTAssert([original equalsTo:date]);

    date = [original dateTimeByAddingHours:40 minutes:50 seconds:60];

    XCTAssertEqual(date.year,           2015);
    XCTAssertEqual(date.month,          1);
    XCTAssertEqual(date.day,            8);
    XCTAssertEqual(date.hour,           6);
    XCTAssertEqual(date.minute,         37);
    XCTAssertEqual(date.second,         12);
    XCTAssertEqual(date.millisecond,    12);

    [original addHours:40 minutes:50 seconds:60];

    XCTAssert([original equalsTo:date]);
}

- (void)testAddYearsMonthsDaysHoursMinutesSecondsMilliseconds {
    RBDateTime *original = [[RBDateTime alloc] initWithYear:2015 month:1 day:6
                                                   hour:9 minute:41 second:6 millisecond:12
                                               calendar:nil timeZone:nil];
    RBDateTime *date = [original dateTimeByAddingYears:1 months:2 days:3
                                                 hours:4 minutes:5 seconds:6 milliseconds:7];
    XCTAssertEqual(date.year,           2016);
    XCTAssertEqual(date.month,          3);
    XCTAssertEqual(date.day,            9);
    XCTAssertEqual(date.hour,           13);
    XCTAssertEqual(date.minute,         46);
    XCTAssertEqual(date.second,         12);
    XCTAssertEqual(date.millisecond,    19);

    [original addYears:1 months:2 days:3 hours:4 minutes:5 seconds:6 milliseconds:7];

    XCTAssert([original equalsTo:date]);

    date = [date dateTimeByAddingYears:10 months:20 days:30 hours:40 minutes:50 seconds:60 milliseconds:70];

    XCTAssertEqual(date.year,           2027);
    XCTAssertEqual(date.month,          12);
    XCTAssertEqual(date.day,            11);
    XCTAssertEqual(date.hour,           6);
    XCTAssertEqual(date.minute,         37);
    XCTAssertEqual(date.second,         12);
    XCTAssertEqual(date.millisecond,    89);

    [original addYears:10 months:20 days:30 hours:40 minutes:50 seconds:60 milliseconds:70];

    XCTAssert([original equalsTo:date]);
}

- (void)testAddDuration {
    RBDateTime *original = [[RBDateTime alloc] initWithYear:2015 month:1 day:6
                                                       hour:9 minute:41 second:6 millisecond:12
                                                   calendar:nil timeZone:nil];
    RBDuration *duration = [RBDuration durationWithDays:3 hours:4 minutes:5 seconds:6 milliseconds:7];

    RBDateTime *date = [original dateTimeByAddingDuration:duration];

    XCTAssertEqual(date.year,           2015);
    XCTAssertEqual(date.month,          1);
    XCTAssertEqual(date.day,            9);
    XCTAssertEqual(date.hour,           13);
    XCTAssertEqual(date.minute,         46);
    XCTAssertEqual(date.second,         12);
    XCTAssertEqual(date.millisecond,    19);

    [original addDuration:duration];
    
    XCTAssert([original equalsTo:date]);
}

- (void)testSubtractDuration {
    RBDateTime *date = [[RBDateTime alloc] initWithYear:2015 month:1 day:9
                                                   hour:13 minute:46 second:12 millisecond:19
                                               calendar:nil timeZone:nil];
    RBDuration *duration = [RBDuration durationWithDays:3 hours:4 minutes:5 seconds:6 milliseconds:7];

    [date subtractDuration:duration];

    XCTAssertEqual(date.year,           2015);
    XCTAssertEqual(date.month,          1);
    XCTAssertEqual(date.day,            6);
    XCTAssertEqual(date.hour,           9);
    XCTAssertEqual(date.minute,         41);
    XCTAssertEqual(date.second,         6);
    XCTAssertEqual(date.millisecond,    12);
}

- (void)testEqualsTo {
    RBDateTime *date1 = [RBDateTime dateTimeWithYear:2015 month:1 day:6 hour:9 minute:41 second:6];
    RBDateTime *date2 = [RBDateTime dateTimeWithYear:2015 month:1 day:6 hour:9 minute:41 second:6];
    RBDateTime *date3 = [RBDateTime dateTimeWithYear:2015 month:1 day:9 hour:6 minute:12 second:41];

    XCTAssertTrue([date1 equalsTo:date2]);
    XCTAssertFalse([date1 equalsTo:date3]);
}

@end
