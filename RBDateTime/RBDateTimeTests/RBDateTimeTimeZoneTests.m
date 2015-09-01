//
//  RBDateTimeTimeZoneTests.m
//  RBDateTime
//
//  Created by Richard Bao on 8/31/15.
//  Copyright (c) 2015 Richard Bao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "RBDateTime.h"

@interface RBDateTimeTimeZoneTests : XCTestCase

@end

@implementation RBDateTimeTimeZoneTests

static NSCalendar *_gregorian = nil;

static NSTimeZone *UtcTime = nil;
static NSTimeZone *LocalTime = nil;
static NSTimeZone *WesternTime = nil;
static NSTimeZone *EasternTime = nil;
static NSTimeZone *ShanghaiTime = nil;

+ (void)setUp {
    _gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

    UtcTime = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    LocalTime = [NSTimeZone localTimeZone];
    WesternTime = [NSTimeZone timeZoneWithName:@"America/Los_Angeles"];
    EasternTime = [NSTimeZone timeZoneWithName:@"America/New_York"];
    ShanghaiTime = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testUTCTime {
    RBDateTime *dateInPST = [[RBDateTime alloc] initWithYear:2015 month:1 day:6
                                                        hour:9 minute:41 second:6 millisecond:12
                                                    calendar:nil timeZone:WesternTime];
    RBDateTime *dateInUTC = [dateInPST utcTime];

    XCTAssertEqual(dateInUTC.day, 6);
    XCTAssertEqual(dateInUTC.hour, 17);
}

- (void)testLocalTime {
    RBDateTime *dateInUTC = [[RBDateTime alloc] initWithYear:2015 month:1 day:6
                                                        hour:9 minute:41 second:6 millisecond:12
                                                    calendar:nil timeZone:UtcTime];
    RBDateTime *dateInLocalConverted = [dateInUTC localTime];

    NSInteger totalOffsetInSeconds = LocalTime.secondsFromGMT - LocalTime.daylightSavingTimeOffset;

    RBDateTime *dateInLocalAssembled = [[RBDateTime alloc] initWithYear:2015 month:1 day:6
                                                                   hour:9 minute:41 second:6 + totalOffsetInSeconds millisecond:12
                                                               calendar:nil timeZone:UtcTime];

    XCTAssertEqual(dateInLocalConverted.day, dateInLocalAssembled.day);
    XCTAssertEqual(dateInLocalConverted.hour, dateInLocalAssembled.hour);
    XCTAssertEqual(dateInLocalConverted.minute, dateInLocalAssembled.minute);
}

- (void)testDateTimeInTimeZone {
    RBDateTime *dateInPST = [[RBDateTime alloc] initWithYear:2015 month:1 day:6
                                                        hour:9 minute:41 second:6 millisecond:12
                                                    calendar:nil timeZone:WesternTime];
    RBDateTime *dateInEST = [dateInPST dateTimeInTimeZone:EasternTime];
    RBDateTime *dateInShanghai = [dateInEST dateTimeInTimeZone:ShanghaiTime];
    RBDateTime *dateInUTC = [dateInShanghai dateTimeInTimeZone:UtcTime];

    XCTAssertEqual(dateInEST.day, 6);
    XCTAssertEqual(dateInEST.hour, 12);
    XCTAssertEqual(dateInShanghai.day, 7);
    XCTAssertEqual(dateInShanghai.hour, 1);
    XCTAssertEqual(dateInUTC.day, 6);
    XCTAssertEqual(dateInUTC.hour, 17);

    RBDateTime *dateInPDT = [[RBDateTime alloc] initWithYear:2015 month:6 day:12
                                                        hour:9 minute:41 second:6 millisecond:12
                                                    calendar:nil timeZone:WesternTime];
    RBDateTime *dateInEDT = [dateInPDT dateTimeInTimeZone:EasternTime];
    dateInShanghai = [dateInEDT dateTimeInTimeZone:ShanghaiTime];
    dateInUTC = [dateInShanghai dateTimeInTimeZone:UtcTime];

    XCTAssertEqual(dateInEDT.day, 12);
    XCTAssertEqual(dateInEDT.hour, 12);
    XCTAssertEqual(dateInShanghai.day, 13);
    XCTAssertEqual(dateInShanghai.hour, 0);
    XCTAssertEqual(dateInUTC.day, 12);
    XCTAssertEqual(dateInUTC.hour, 16);
}

@end
