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

#define XCTAssertStringEqual(string1, string2) \
    XCTAssert([string1 isEqualToString:string2], @"\"%@\" is not equal to \"%@\"", string1, string2)

@interface RBDateTimeFormattingTests : XCTestCase

@end

@implementation RBDateTimeFormattingTests

static NSCalendar *HebrewCalendar = nil;
static NSTimeZone *UtcTime = nil;
static NSTimeZone *HonoluluTime = nil;
static NSLocale *USEnglishLocale = nil;
static NSLocale *FrenchLocale = nil;

+ (void)setUp {
    HebrewCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierHebrew];
    UtcTime = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    HonoluluTime = [NSTimeZone timeZoneWithName:@"Pacific/Honolulu"];
    USEnglishLocale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    FrenchLocale = [NSLocale localeWithLocaleIdentifier:@"fr_FR"];
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLocalizedStringWithDateStyleTimeStyle {
    RBDateTime *date = [RBDateTime dateTimeWithYear:2015 month:1 day:6 hour:9 minute:41 second:6
                                           timeZone:HonoluluTime];
    NSString *localizedStringDefault = [date localizedStringWithDateStyle:NSDateFormatterMediumStyle
                                                                timeStyle:NSDateFormatterShortStyle];
    NSString *localizedStringManual = [date localizedStringWithDateStyle:NSDateFormatterMediumStyle
                                                               timeStyle:NSDateFormatterShortStyle
                                                                timeZone:HonoluluTime
                                                                  locale:[NSLocale currentLocale]];

    XCTAssertStringEqual(localizedStringDefault, localizedStringManual);
}

- (void)testLocalizedStringWithDateStyleTimeStyleTimeZone {
    RBDateTime *date = [RBDateTime dateTimeWithYear:2015 month:1 day:6 hour:9 minute:41 second:6
                                           timeZone:HonoluluTime];
    NSString *localizedStringDefault = [date localizedStringWithDateStyle:NSDateFormatterMediumStyle
                                                                timeStyle:NSDateFormatterShortStyle
                                                                 timeZone:UtcTime];
    NSString *localizedStringManual = [date localizedStringWithDateStyle:NSDateFormatterMediumStyle
                                                               timeStyle:NSDateFormatterShortStyle
                                                                timeZone:UtcTime
                                                                  locale:[NSLocale currentLocale]];

    XCTAssertStringEqual(localizedStringDefault, localizedStringManual);
}

- (void)testLocalizedStringWithDateStyleTimeStyleTimeZoneLocale {
    RBDateTime *date = [RBDateTime dateTimeWithYear:2015 month:1 day:6 hour:9 minute:41 second:6
                                           timeZone:HonoluluTime];
    NSString *localizedString = [date localizedStringWithDateStyle:NSDateFormatterMediumStyle
                                                         timeStyle:NSDateFormatterShortStyle
                                                          timeZone:UtcTime
                                                            locale:FrenchLocale];

    XCTAssertStringEqual(localizedString, @"6 janv. 2015 19:41");
}

- (void)testLocalizedStringWithFormatTemplate {
    RBDateTime *date = [RBDateTime dateTimeWithYear:2015 month:1 day:6 hour:9 minute:41 second:6
                                           timeZone:HonoluluTime];
    NSString *localizedStringDefault = [date localizedStringWithFormatTemplate:@"eee yyyyMMMd Hms"];
    NSString *localizedStringManual = [date localizedStringWithFormatTemplate:@"eee yyyyMMMd Hms"
                                                                     timeZone:HonoluluTime
                                                                       locale:[NSLocale currentLocale]];

    XCTAssertStringEqual(localizedStringDefault, localizedStringManual);
}

- (void)testLocalizedStringWithFormatTemplateTimeZone {
    RBDateTime *date = [RBDateTime dateTimeWithYear:2015 month:1 day:6 hour:9 minute:41 second:6
                                           timeZone:HonoluluTime];
    NSString *localizedStringDefault = [date localizedStringWithFormatTemplate:@"eee yyyyMMMd Hms"
                                                                      timeZone:UtcTime];
    NSString *localizedStringManual = [date localizedStringWithFormatTemplate:@"eee yyyyMMMd Hms"
                                                                     timeZone:UtcTime
                                                                       locale:[NSLocale currentLocale]];

    XCTAssertStringEqual(localizedStringDefault, localizedStringManual);
}

- (void)testLocalizedStringWithFormatTemplateTimeZoneLocale {
    RBDateTime *date = [RBDateTime dateTimeWithYear:2015 month:1 day:6 hour:9 minute:41 second:6
                                           timeZone:HonoluluTime];
    NSString *localizedString = [date localizedStringWithFormatTemplate:@"eee yyyyMMMd Hms"
                                                               timeZone:UtcTime
                                                                 locale:FrenchLocale];

    XCTAssertStringEqual(localizedString, @"mar. 6 janv. 2015 19:41:06");
}

- (void)testLocalizedStringWithFormat {
    RBDateTime *date = [RBDateTime dateTimeWithYear:2015 month:1 day:6 hour:9 minute:41 second:6
                                           timeZone:HonoluluTime];
    NSString *localizedStringDefault = [date localizedStringWithFormat:@"eee, MMM d, yyyy, H:mm:ss"];
    NSString *localizedStringManual = [date localizedStringWithFormat:@"eee, MMM d, yyyy, H:mm:ss"
                                                             timeZone:HonoluluTime
                                                               locale:[NSLocale currentLocale]];

    XCTAssertStringEqual(localizedStringDefault, localizedStringManual);
}

- (void)testLocalizedStringWithFormatTimeZone {
    RBDateTime *date = [RBDateTime dateTimeWithYear:2015 month:1 day:6 hour:9 minute:41 second:6
                                               timeZone:HonoluluTime];
    NSString *localizedStringDefault = [date localizedStringWithFormat:@"eee, MMM d, yyyy, H:mm:ss"
                                                              timeZone:UtcTime];
    NSString *localizedStringManual = [date localizedStringWithFormat:@"eee, MMM d, yyyy, H:mm:ss"
                                                             timeZone:UtcTime
                                                               locale:[NSLocale currentLocale]];

    XCTAssertStringEqual(localizedStringDefault, localizedStringManual);
}

- (void)testLocalizedStringWithFormatTimeZoneLocale {
    RBDateTime *date = [RBDateTime dateTimeWithYear:2015 month:1 day:6 hour:9 minute:41 second:6
                                               timeZone:HonoluluTime];
    NSString *localizedString = [date localizedStringWithFormat:@"eee, MMM d, yyyy, H:mm:ss"
                                                       timeZone:UtcTime
                                                         locale:FrenchLocale];

    XCTAssertStringEqual(localizedString, @"mar., janv. 6, 2015, 19:41:06");
}

- (void)testLocalizedDate {
    RBDateTime *date = [RBDateTime dateTimeWithYear:2015 month:1 day:6 hour:9 minute:41 second:6
                                               timeZone:HonoluluTime];
    [RBDateTime setDefaultDateStyle:NSDateFormatterFullStyle];

    NSString *localizedDate = [date localizedDate];
    NSString *localizedStringManual = [date localizedStringWithDateStyle:NSDateFormatterFullStyle
                                                               timeStyle:NSDateFormatterNoStyle];

    XCTAssertStringEqual(localizedDate, localizedStringManual);
}

- (void)testLocalizedTime {
    RBDateTime *date = [RBDateTime dateTimeWithYear:2015 month:1 day:6 hour:9 minute:41 second:6
                                               timeZone:HonoluluTime];
    [RBDateTime setDefaultTimeStyle:NSDateFormatterFullStyle];

    NSString *localizedTime = [date localizedTime];
    NSString *localizedStringManual = [date localizedStringWithDateStyle:NSDateFormatterNoStyle
                                                               timeStyle:NSDateFormatterFullStyle];

    XCTAssertStringEqual(localizedTime, localizedStringManual);
}

- (void)testLocalizedString {
    RBDateTime *date = [RBDateTime dateTimeWithYear:2015 month:1 day:6 hour:9 minute:41 second:6
                                               timeZone:HonoluluTime];

    [RBDateTime setDefaultDateStyle:NSDateFormatterShortStyle];
    [RBDateTime setDefaultTimeStyle:NSDateFormatterShortStyle];

    NSString *styled = [date localizedString];
    NSString *styledManual = [date localizedStringWithDateStyle:NSDateFormatterShortStyle
                                                      timeStyle:NSDateFormatterShortStyle];

    XCTAssertStringEqual(styled, styledManual);

    [RBDateTime setDefaultDateTimeFormatTemplate:@"eee yyyyMMMd Hms"];

    NSString *templated = [date localizedString];
    NSString *templatedManual = [date localizedStringWithFormatTemplate:@"eee yyyyMMMd Hms"];

    XCTAssertStringEqual(templated, templatedManual);

    [RBDateTime setDefaultDateTimeFormat:@"eee, MMM d, yyyy, H:mm:ss"];

    NSString *formatted = [date localizedString];
    NSString *formattedManual = [date localizedStringWithFormat:@"eee, MMM d, yyyy, H:mm:ss"];

    XCTAssertStringEqual(formatted, formattedManual);
}

- (void)testFormattedUnixTimestamp {
    RBDateTime *date = [RBDateTime dateTimeWithYear:2015 month:1 day:6 hour:9 minute:41 second:6
                                               timeZone:HonoluluTime];
    NSString *unixTimestamp = [date formattedUnixTimestamp];

    XCTAssertStringEqual(unixTimestamp, @"2015-01-06T09:41:06Z");
}

- (void)testFormattedUnixTimestampUTC {
    RBDateTime *date = [RBDateTime dateTimeWithYear:2015 month:1 day:6 hour:9 minute:41 second:6
                                               timeZone:HonoluluTime];
    NSString *unixTimestamp = [date formattedUnixTimestampUTC];

    XCTAssertStringEqual(unixTimestamp, @"2015-01-06T19:41:06Z");
}

- (void)testPerformance_localizedString_Styles {
    RBDateTime *date = [RBDateTime dateTimeWithYear:2015 month:1 day:6];

    [RBDateTime setDefaultDateStyle:NSDateFormatterShortStyle];
    [RBDateTime setDefaultTimeStyle:NSDateFormatterShortStyle];

    [self measureBlock:^{
        for (int i = 0; i < 1000; i++) {
            [date localizedString];
        }
    }];
}

- (void)testPerformance_localizedString_Templates {
    RBDateTime *date = [RBDateTime dateTimeWithYear:2015 month:1 day:6];

    [RBDateTime setDefaultDateTimeFormatTemplate:@"eee yyyyMMMd Hms"];

    [self measureBlock:^{
        for (int i = 0; i < 1000; i++) {
            [date localizedString];
        }
    }];
}

- (void)testPerformance_localizedString_Format {
    RBDateTime *date = [RBDateTime dateTimeWithYear:2015 month:1 day:6];

    [RBDateTime setDefaultDateTimeFormat:@"eee, MMM d, yyyy, H:mm:ss"];

    [self measureBlock:^{
        for (int i = 0; i < 1000; i++) {
            [date localizedString];
        }
    }];
}

- (void)testParseStringWithFormat {
    RBDateTime *parsed = [RBDateTime dateTimeByParsingString:@"1/6/2015 9:41:06"
                                                  withFormat:@"M/d/yyyy h:m:s"];
    RBDateTime *assembled = [RBDateTime dateTimeWithYear:2015 month:1 day:6
                                                    hour:9 minute:41 second:6
                                                timeZone:[NSTimeZone localTimeZone]];

    XCTAssertEqual(parsed.timeIntervalSinceReferenceDate, assembled.timeIntervalSinceReferenceDate);
}

- (void)testParseStringWithFormatTimeZone {
    RBDateTime *parsed = [RBDateTime dateTimeByParsingString:@"1/6/2015 9:41:06"
                                                  withFormat:@"M/d/yyyy h:m:s"
                                                    timeZone:HonoluluTime];
    RBDateTime *assembled = [RBDateTime dateTimeWithYear:2015 month:1 day:6
                                                    hour:9 minute:41 second:6
                                                timeZone:HonoluluTime];

    XCTAssertEqual(parsed.timeIntervalSinceReferenceDate, assembled.timeIntervalSinceReferenceDate);

    RBDateTime *failedToParse = [RBDateTime dateTimeByParsingString:@"123456"
                                                         withFormat:@"M/d/yyyy h:m"
                                                           timeZone:HonoluluTime];
    XCTAssertNil(failedToParse);
}

- (void)testParseUnixTimestamp {
    RBDateTime *parsed = [RBDateTime dateTimeByParsingUnixTimestamp:@"2015-01-06T09:41:06Z"];
    RBDateTime *assembled = [RBDateTime dateTimeWithYear:2015 month:1 day:6
                                                    hour:9 minute:41 second:6
                                                timeZone:[NSTimeZone localTimeZone]];

    XCTAssertEqual(parsed.timeIntervalSinceReferenceDate, assembled.timeIntervalSinceReferenceDate);
}

- (void)testParseUnixTimestampUTC {
    RBDateTime *parsed = [RBDateTime dateTimeByParsingUnixTimestampUTC:@"2015-01-06T09:41:06Z"];
    RBDateTime *assembled = [RBDateTime dateTimeWithYear:2015 month:1 day:6
                                                    hour:9 minute:41 second:6
                                                timeZone:UtcTime];

    XCTAssertEqual(parsed.timeIntervalSinceReferenceDate, assembled.timeIntervalSinceReferenceDate);
}

- (void)testParseUnixTimestampTimeZone {
    RBDateTime *parsed = [RBDateTime dateTimeByParsingUnixTimestamp:@"2015-01-06T09:41:06Z"
                                                      timeZone:HonoluluTime];
    RBDateTime *assembled = [RBDateTime dateTimeWithYear:2015 month:1 day:6
                                                    hour:9 minute:41 second:6
                                                timeZone:HonoluluTime];

    XCTAssertEqual(parsed.timeIntervalSinceReferenceDate, assembled.timeIntervalSinceReferenceDate);

    RBDateTime *failedToParse = [RBDateTime dateTimeByParsingUnixTimestamp:@"123456"
                                                                  timeZone:HonoluluTime];
    XCTAssertNil(failedToParse);
}

@end
