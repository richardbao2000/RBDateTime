//
//  RBDuration.h
//  RBDateTime
//
//  Created by Richard Bao on 8/24/15.
//  Copyright (c) 2015 Richard Bao. All rights reserved.
//

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
