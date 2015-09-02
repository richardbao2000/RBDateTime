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

@interface RBDuration : NSObject


#pragma mark - Initializers

- (instancetype)initWithTimeInterval:(NSTimeInterval)timeInterval;

- (instancetype)initWithDays:(NSInteger)days
                       hours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds
                milliseconds:(NSInteger)milliseconds;

+ (instancetype)durationWithDays:(NSInteger)days
                           hours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds
                    milliseconds:(NSInteger)milliseconds;
+ (instancetype)durationWithHours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds;

+ (instancetype)durationWithDays:(NSInteger)days;
+ (instancetype)durationWithHours:(NSInteger)hours;
+ (instancetype)durationWithMinutes:(NSInteger)minutes;
+ (instancetype)durationWithSeconds:(NSInteger)seconds;
+ (instancetype)durationWithMilliseconds:(NSInteger)milliseconds;

+ (instancetype)durationFromDate:(RBDateTime *)date1 toDate:(RBDateTime *)date2;



#pragma mark - Components

@property (nonatomic, readonly) NSTimeInterval timeInterval;

@property (nonatomic, readonly) NSInteger days;
@property (nonatomic, readonly) NSInteger hours;
@property (nonatomic, readonly) NSInteger minutes;
@property (nonatomic, readonly) NSInteger seconds;
@property (nonatomic, readonly) NSInteger milliseconds;



#pragma mark - Convenient Computation


@property (nonatomic, readonly) double totalDays;
@property (nonatomic, readonly) double totalHours;
@property (nonatomic, readonly) double totalMinutes;
@property (nonatomic, readonly) double totalSeconds;
@property (nonatomic, readonly) double totalMilliseconds;



#pragma mark - Operations

- (instancetype)durationByAdding:(RBDuration *)duration;
- (instancetype)durationBySubtracting:(RBDuration *)duration;

- (void)add:(RBDuration *)duration;
- (void)subtract:(RBDuration *)duration;

- (instancetype)negativeDuration;
- (void)negate;

+ (NSComparisonResult)compare:(RBDuration *)duration1 to:(RBDuration *)duration2;
- (NSComparisonResult)compareTo:(RBDuration *)duration;

- (BOOL)equalsTo:(RBDuration *)duration;


@end
