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

#import <Foundation/Foundation.h>

@class RBDateTime;

/// Represents a duration of time.
@interface RBDuration : NSObject


#pragma mark - Initializers

/// Initializes a new @c RBDuration instance with given time interval.
///
/// @param  seconds         The number of seconds.
- (instancetype)initWithTimeInterval:(NSTimeInterval)seconds;

/// Initializes a new @c RBDuration instance with given numbers of days, hours, minutes, seconds, and
/// milliseconds.
///
/// @param  days            The number of days.
/// @param  hours           The number of hours.
/// @param  minutes         The number of minutes.
/// @param  seconds         The number of seconds.
/// @param  milliseconds    The number of milliseconds.
- (instancetype)initWithDays:(NSInteger)days
                       hours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds
                milliseconds:(NSInteger)milliseconds;

/// Creates a new @c RBDuration instance with given numbers of days, hours, minutes, seconds, and
/// milliseconds.
///
/// @param  days            The number of days.
/// @param  hours           The number of hours.
/// @param  minutes         The number of minutes.
/// @param  seconds         The number of seconds.
/// @param  milliseconds    The number of milliseconds.
+ (instancetype)durationWithDays:(NSInteger)days
                           hours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds
                    milliseconds:(NSInteger)milliseconds;
/// Creates a new @c RBDuration instance with given numbers of hours, minutes, and seconds.
///
/// @param  hours           The number of hours.
/// @param  minutes         The number of minutes.
/// @param  seconds         The number of seconds.
+ (instancetype)durationWithHours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds;

/// Creates a new @c RBDuration instance with a given number of days.
/// @param  days            The number of days.
+ (instancetype)durationWithDays:(NSInteger)days;
/// Creates a new @c RBDuration instance with a given number of hours.
/// @param  hours           The number of hours.
+ (instancetype)durationWithHours:(NSInteger)hours;
/// Creates a new @c RBDuration instance with a given number of minutes.
/// @param  minutes         The number of minutes.
+ (instancetype)durationWithMinutes:(NSInteger)minutes;
/// Creates a new @c RBDuration instance with a given number of seconds.
/// @param  seconds         The number of seconds.
+ (instancetype)durationWithSeconds:(NSInteger)seconds;
/// Creates a new @c RBDuration instance with a given number of milliseconds.
/// @param  milliseconds    The number of milliseconds.
+ (instancetype)durationWithMilliseconds:(NSInteger)milliseconds;

/// Returns a @c RBDuration instance that is the difference between two given dates. A negative
/// duration will be returned if the start date is later than the end date.
///
/// @param  date1           The start date for the calculation.
/// @param  date2           The end date for the calculation.
+ (instancetype)durationFromDate:(RBDateTime *)date1 toDate:(RBDateTime *)date2;



#pragma mark - Components

/// Returns the time interval of this duration.
@property (nonatomic, readonly) NSTimeInterval timeInterval;

/// Returns the days component.
@property (nonatomic, readonly) NSInteger days;
/// Returns the hours component.
@property (nonatomic, readonly) NSInteger hours;
/// Returns the minutes component.
@property (nonatomic, readonly) NSInteger minutes;
/// Returns the seconds component.
@property (nonatomic, readonly) NSInteger seconds;
/// Returns the milliseconds component.
@property (nonatomic, readonly) NSInteger milliseconds;



#pragma mark - Convenient Computation

/// Returns the value of this duration expressed in whole and fractional days.
@property (nonatomic, readonly) double totalDays;
/// Returns the value of this duration expressed in whole and fractional hours.
@property (nonatomic, readonly) double totalHours;
/// Returns the value of this duration expressed in whole and fractional minutes.
@property (nonatomic, readonly) double totalMinutes;
/// Returns the value of this duration expressed in whole and fractional seconds.
@property (nonatomic, readonly) double totalSeconds;
/// Returns the value of this duration expressed in whole and fractional milliseconds.
@property (nonatomic, readonly) double totalMilliseconds;



#pragma mark - Operations

/// Returns a new @c RBDuration that adds the given duration to the value of this instance.
/// @param  duration        The specific duration to add.
- (instancetype)durationByAdding:(RBDuration *)duration;
/// Returns a new @c RBDuration that subtracts the given duration to the value of this instance.
/// @param  duration        The specified duration to subtract.
- (instancetype)durationBySubtracting:(RBDuration *)duration;

/// Adds the value of the given @c RBDuration to the value of this instance.
/// @param  duration        The specified duration to add.
- (void)add:(RBDuration *)duration;
/// Subtracts the value of the given @c RBDuration to the value of this instance.
/// @param  duration        The specified duration to subtract.
- (void)subtract:(RBDuration *)duration;

/// Returns a new @c RBDuration that is the negated value of this instance.
- (instancetype)negatedDuration;
/// Negates the value of this instance.
- (void)negate;

/// Compares two @c RBDuration instances and returns a @c NSComparisonResult that indicates
/// whether the first value is shorter than, equal to, or longer than the second value.
///
/// @param  duration1       The first duration to compare.
/// @param  duration2       The second duration to compare.
+ (NSComparisonResult)compare:(RBDuration *)duration1 to:(RBDuration *)duration2;
/// Compares this instance to a given @c RBDuration instance and returns a @c NSComparisonResult
/// that indicates whether this instance is shorter than, equal to, or longer than the given
/// @c RBDuration instance.
///
/// @param  duration        The other @RBDuration instance to compare with.
- (NSComparisonResult)compareTo:(RBDuration *)duration;

/// Returns a Boolean value that indicates whether the given duration equals to this instance.
///
/// @param  duration        The other @RBDuration instance to compare with.
- (BOOL)equalsTo:(RBDuration *)duration;


@end
