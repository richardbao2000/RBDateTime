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

@interface RBDateTimeAddingTests : XCTestCase

@end

@implementation RBDateTimeAddingTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAddDays {
    RBDateTime *date = [[RBDateTime alloc] initWithYear:2015 month:1 day:6
                                                   hour:9 minute:41 second:6];

    [date addDays:15];

    XCTAssertEqual(date.year,   2015);
    XCTAssertEqual(date.month,  1);
    XCTAssertEqual(date.day,    21);
    XCTAssertEqual(date.hour,   9);
    XCTAssertEqual(date.minute, 41);
    XCTAssertEqual(date.second, 6);

    [date addDays:20];

    XCTAssertEqual(date.year,   2015);
    XCTAssertEqual(date.month,  2);
    XCTAssertEqual(date.day,    10);
    XCTAssertEqual(date.hour,   9);
    XCTAssertEqual(date.minute, 41);
    XCTAssertEqual(date.second, 6);

    [date addDays:-5];

    XCTAssertEqual(date.year,   2015);
    XCTAssertEqual(date.month,  2);
    XCTAssertEqual(date.day,    5);
    XCTAssertEqual(date.hour,   9);
    XCTAssertEqual(date.minute, 41);
    XCTAssertEqual(date.second, 6);
}

- (void)testAddYearsMonthsDays {
    RBDateTime *date = [[RBDateTime alloc] initWithYear:2015 month:1 day:6
                                                   hour:9 minute:41 second:6 millisecond:12
                                               calendar:nil timeZone:nil];

    [date addYears:1 months:2 days:3];

    XCTAssertEqual(date.year,           2016);
    XCTAssertEqual(date.month,          3);
    XCTAssertEqual(date.day,            9);
    XCTAssertEqual(date.hour,           9);
    XCTAssertEqual(date.minute,         41);
    XCTAssertEqual(date.second,         6);
    XCTAssertEqual(date.millisecond,    12);

    [date addYears:10 months:20 days:30];

    XCTAssertEqual(date.year,           2027);
    XCTAssertEqual(date.month,          12);
    XCTAssertEqual(date.day,            9);
    XCTAssertEqual(date.hour,           9);
    XCTAssertEqual(date.minute,         41);
    XCTAssertEqual(date.second,         6);
    XCTAssertEqual(date.millisecond,    12);
}

- (void)testAddYearsMonthsDaysHoursMinutesSecondsMilliseconds {
    RBDateTime *date = [[RBDateTime alloc] initWithYear:2015 month:1 day:6
                                                   hour:9 minute:41 second:6 millisecond:12
                                               calendar:nil timeZone:nil];

    [date addYears:1 months:2 days:3 hours:4 minutes:5 seconds:6 milliseconds:7];

    XCTAssertEqual(date.year,           2016);
    XCTAssertEqual(date.month,          3);
    XCTAssertEqual(date.day,            9);
    XCTAssertEqual(date.hour,           13);
    XCTAssertEqual(date.minute,         46);
    XCTAssertEqual(date.second,         12);
    XCTAssertEqual(date.millisecond,    19);

    [date addYears:10 months:20 days:30 hours:40 minutes:50 seconds:60 milliseconds:70];

    XCTAssertEqual(date.year,           2027);
    XCTAssertEqual(date.month,          12);
    XCTAssertEqual(date.day,            11);
    XCTAssertEqual(date.hour,           6);
    XCTAssertEqual(date.minute,         37);
    XCTAssertEqual(date.second,         12);
    XCTAssertEqual(date.millisecond,    89);
}

@end
