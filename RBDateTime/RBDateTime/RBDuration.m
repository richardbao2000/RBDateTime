//
//  RBDateTime
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

#import "RBDuration.h"

#import "RBDateTime.h"

@interface RBDuration () {
    NSTimeInterval _timeInterval;
    NSDateComponents *_components;
}

@end

@implementation RBDuration

static double kTimeIntervalForMillisecond   = 1 / 1000.0;
static double kTimeIntervalForSecond        = 1;
static double kTimeIntervalForMinute        = 60;
static double kTimeIntervalForHour          = 60 * 60;
static double kTimeIntervalForDay           = 60 * 60 * 24;



#pragma mark - Initializers

- (instancetype)initWithTimeInterval:(NSTimeInterval)seconds {
    self = [super init];
    if (self) {
        _timeInterval = seconds;
    }

    return self;
}

- (instancetype)initWithDays:(NSInteger)days
                       hours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds
                milliseconds:(NSInteger)milliseconds {
    self = [super init];
    if (self) {
        _timeInterval = (days * kTimeIntervalForDay +
                         hours * kTimeIntervalForHour +
                         minutes * kTimeIntervalForMinute +
                         seconds * kTimeIntervalForSecond +
                         milliseconds * kTimeIntervalForMillisecond);
    }

    return self;
}

+ (instancetype)durationWithDays:(NSInteger)days hours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds milliseconds:(NSInteger)milliseconds {
    return [[RBDuration alloc] initWithDays:days hours:hours minutes:minutes seconds:seconds milliseconds:milliseconds];
}

+ (instancetype)durationWithHours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds {
    return [[RBDuration alloc] initWithDays:0 hours:hours minutes:minutes seconds:seconds milliseconds:0];
}

+ (instancetype)durationWithDays:(NSInteger)days {
    return [RBDuration durationWithDays:days hours:0 minutes:0 seconds:0 milliseconds:0];
}

+ (instancetype)durationWithHours:(NSInteger)hours {
    return [RBDuration durationWithHours:hours minutes:0 seconds:0];
}

+ (instancetype)durationWithMinutes:(NSInteger)minutes {
    return [RBDuration durationWithHours:0 minutes:minutes seconds:0];
}

+ (instancetype)durationWithSeconds:(NSInteger)seconds {
    return [RBDuration durationWithHours:0 minutes:0 seconds:seconds];
}

+ (instancetype)durationWithMilliseconds:(NSInteger)milliseconds {
    return [RBDuration durationWithDays:0 hours:0 minutes:0 seconds:0 milliseconds:milliseconds];
}

+ (instancetype)durationFromDate:(RBDateTime *)date1 toDate:(RBDateTime *)date2 {
    NSTimeInterval timeInterval = date2.timeIntervalSinceReferenceDate - date1.timeIntervalSinceReferenceDate;
    return [[RBDuration alloc] initWithTimeInterval:timeInterval];
}



#pragma mark - Components

- (NSTimeInterval)timeInterval {
    return _timeInterval;
}

- (NSInteger)days {
    return (NSInteger)trunc(_timeInterval / kTimeIntervalForDay);
}

- (NSInteger)hours {
    return (NSInteger)trunc(_timeInterval / kTimeIntervalForHour) % 24;
}

- (NSInteger)minutes {
    return (NSInteger)trunc(_timeInterval / kTimeIntervalForMinute) % 60;
}

- (NSInteger)seconds {
    return (NSInteger)trunc(_timeInterval / kTimeIntervalForSecond) % 60;
}

- (NSInteger)milliseconds {
    return (NSInteger)round(_timeInterval / kTimeIntervalForMillisecond) % 1000;
}



#pragma mark - Convenient Computation

- (double)totalDays {
    return _timeInterval / kTimeIntervalForDay;
}

- (double)totalHours {
    return _timeInterval / kTimeIntervalForHour;
}

- (double)totalMinutes {
    return _timeInterval / kTimeIntervalForMinute;
}

- (double)totalSeconds {
    return _timeInterval;
}

- (double)totalMilliseconds {
    return _timeInterval / kTimeIntervalForMillisecond;
}



#pragma mark - Operations

- (instancetype)durationByAdding:(RBDuration *)duration {
    return [[RBDuration alloc] initWithTimeInterval:self.timeInterval + duration.timeInterval];
}

- (instancetype)durationBySubtracting:(RBDuration *)duration {
    return [[RBDuration alloc] initWithTimeInterval:self.timeInterval - duration.timeInterval];
}

- (void)add:(RBDuration *)duration {
    _timeInterval += duration.timeInterval;
}

- (void)subtract:(RBDuration *)duration {
    _timeInterval -= duration.timeInterval;
}

- (instancetype)negatedDuration {
    return [[RBDuration alloc] initWithTimeInterval:-self.timeInterval];
}

- (void)negate {
    _timeInterval = -_timeInterval;
}

+ (NSComparisonResult)compare:(RBDuration *)duration1 to:(RBDuration *)duration2 {
    double difference = duration1.timeInterval - duration2.timeInterval;

    if (difference < 0) {
        return NSOrderedAscending;
    } else if (difference > 0) {
        return NSOrderedDescending;
    } else {
        return NSOrderedSame;
    }
}

- (NSComparisonResult)compareTo:(RBDuration *)duration {
    return [RBDuration compare:self to:duration];
}

- (BOOL)equalsTo:(RBDuration *)duration {
    return fabs(self.timeInterval - duration.timeInterval) < kTimeIntervalForMillisecond;
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[RBDuration class]]) {
        return [self equalsTo:object];
    } else {
        return [super isEqual:object];
    }
}


@end
