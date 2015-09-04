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

@interface RBDurationOperationsTests : XCTestCase {
    NSTimeInterval _timeInterval1;
    NSTimeInterval _timeInterval2;

    double _days1, _hours1, _minutes1, _seconds1, _milliseconds1;
    double _days2, _hours2, _minutes2, _seconds2, _milliseconds2;
    double _totalDays1, _totalHours1, _totalMinutes1, _totalSeconds1, _totalMilliseconds1;
    double _totalDays2, _totalHours2, _totalMinutes2, _totalSeconds2, _totalMilliseconds2;
}

@end

@implementation RBDurationOperationsTests

static NSTimeZone *UtcTime = nil;

+ (void)setUp {
    UtcTime = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
}

- (void)setUp {
    [super setUp];

    _days1 = 156;
    _hours1 = 15;
    _minutes1 = 25;
    _seconds1 = 3;
    _milliseconds1 = 29;

    _timeInterval1 = _days1 *24*60*60 + _hours1 *60*60 + _minutes1 *60 + _seconds1 + _milliseconds1 /1000;

    _totalSeconds1 = _timeInterval1;
    _totalMilliseconds1 = _totalSeconds1 * 1000;
    _totalMinutes1 = _totalSeconds1 / 60;
    _totalHours1 = _totalMinutes1 / 60;
    _totalDays1 = _totalHours1 / 24;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAdd {
    RBDuration *duration1 = [RBDuration durationWithDays:1 hours:9 minutes:41 seconds:6 milliseconds:12];
    RBDuration *duration2 = [RBDuration durationWithDays:6 hours:12 minutes:1 seconds:9 milliseconds:41];

    RBDuration *sum = [duration1 durationByAdding:duration2];

    XCTAssertEqual(sum.days, 7);
    XCTAssertEqual(sum.hours, 21);
    XCTAssertEqual(sum.minutes, 42);
    XCTAssertEqual(sum.seconds, 15);
    XCTAssertEqual(sum.milliseconds, 53);
    XCTAssertEqual(sum.timeInterval, 7*24*60*60 + 21*60*60 + 42*60 + 15 + 53/1000.0);

    [duration1 add:duration2];

    XCTAssertEqual(duration1.days, 7);
    XCTAssertEqual(duration1.hours, 21);
    XCTAssertEqual(duration1.minutes, 42);
    XCTAssertEqual(duration1.seconds, 15);
    XCTAssertEqual(duration1.milliseconds, 53);
    XCTAssertEqual(duration1.timeInterval, sum.timeInterval);
}

- (void)testSubtract {
    RBDuration *duration2 = [RBDuration durationWithDays:6 hours:12 minutes:1 seconds:9 milliseconds:41];
    RBDuration *duration1 = [RBDuration durationWithDays:1 hours:9 minutes:41 seconds:6 milliseconds:12];

    RBDuration *difference = [duration2 durationBySubtracting:duration1];

    XCTAssertEqual(difference.days, 5);
    XCTAssertEqual(difference.hours, 2);
    XCTAssertEqual(difference.minutes, 20);
    XCTAssertEqual(difference.seconds, 3);
    XCTAssertEqual(difference.milliseconds, 29);

    [duration2 subtract:duration1];

    XCTAssertEqual(duration2.days, 5);
    XCTAssertEqual(duration2.hours, 2);
    XCTAssertEqual(duration2.minutes, 20);
    XCTAssertEqual(duration2.seconds, 3);
    XCTAssertEqual(duration2.milliseconds, 29);
}

- (void)testNegate {
    RBDuration *positive = [RBDuration durationWithDays:1 hours:9 minutes:41 seconds:6 milliseconds:12];
    RBDuration *negative = [RBDuration durationWithDays:-1 hours:-9 minutes:-41 seconds:-6 milliseconds:-12];

    RBDuration *negated = [positive negatedDuration];

    XCTAssertEqual(negated.timeInterval, negative.timeInterval);

    [positive negate];

    XCTAssertEqual(positive.timeInterval, negative.timeInterval);
}

- (void)testCompare {
    RBDuration *duration1 = [RBDuration durationWithDays:1 hours:9 minutes:41 seconds:6 milliseconds:12];
    RBDuration *duration2 = [RBDuration durationWithDays:6 hours:12 minutes:1 seconds:9 milliseconds:41];
    RBDuration *duration3 = [RBDuration durationWithDays:1 hours:9 minutes:41 seconds:6 milliseconds:12];

    XCTAssertEqual([duration1 compareTo:duration2], NSOrderedAscending);
    XCTAssertEqual([duration2 compareTo:duration1], NSOrderedDescending);
    XCTAssertEqual([duration1 compareTo:duration3], NSOrderedSame);

    XCTAssertTrue([duration1 equalsTo:duration3]);
    XCTAssertFalse([duration1 equalsTo:duration2]);
}

@end
