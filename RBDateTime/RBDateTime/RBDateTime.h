//
//  RBDateTime.h
//  RBDateTime
//
//  Created by Richard Bao on 8/24/15.
//  Copyright (c) 2015 Richard Bao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RBTimeSpan;

@interface RBDateTime : NSObject


#pragma mark - Initializers

- (instancetype)init;

- (instancetype)initWithNSDate:(NSDate *)date
                      calendar:(NSCalendar *)calendar
                      timezone:(NSTimeZone *)timeZone;

- (instancetype)initWithTimeIntervalSinceReferenceDate:(NSTimeInterval)timeIntervalSinceReferenceDate
                                              calendar:(NSCalendar *)calendar
                                              timezone:(NSTimeZone *)timeZone;

- (instancetype)initWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

- (instancetype)initWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
                        hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;

- (instancetype)initWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
                        hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
                    timeZone:(NSTimeZone *)timeZone;

- (instancetype)initWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
                        hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
                  nanosecond:(NSInteger)nanosecond
                    calendar:(NSCalendar *)calendar;

- (instancetype)initWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
                        hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
                  nanosecond:(NSInteger)nanosecond
                    calendar:(NSCalendar *)calendar
                    timeZone:(NSTimeZone *)timeZone;

+ (instancetype)now;
+ (instancetype)nowUTC;

+ (instancetype)today;
+ (instancetype)todayUTC;

+ (instancetype)dateWithNSDate:(NSDate *)date
                      calendar:(NSCalendar *)calendar
                      timezone:(NSTimeZone *)timeZone;

+ (instancetype)dateWithTimeIntervalSinceReferenceDate:(NSTimeInterval)timeIntervalSinceReferenceDate
                                              calendar:(NSCalendar *)calendar
                                              timezone:(NSTimeZone *)timeZone;

+ (instancetype)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

+ (instancetype)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
                        hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;

+ (instancetype)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
                        hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
                    timeZone:(NSTimeZone *)timeZone;

+ (instancetype)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
                        hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
                  nanosecond:(NSInteger)nanosecond
                    calendar:(NSCalendar *)calendar;

+ (instancetype)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
                        hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
                  nanosecond:(NSInteger)nanosecond
                    calendar:(NSCalendar *)calendar
                    timeZone:(NSTimeZone *)timeZone;



#pragma mark - Properties

@property (nonatomic, readonly) NSDate *NSDate;

@property (nonatomic, readonly) NSInteger year;
@property (nonatomic, readonly) NSInteger month;
@property (nonatomic, readonly) NSInteger day;
@property (nonatomic, readonly) NSInteger hour;
@property (nonatomic, readonly) NSInteger minute;
@property (nonatomic, readonly) NSInteger second;
@property (nonatomic, readonly) NSInteger millisecond;

@property (nonatomic, readonly) NSCalendar *calendar;
@property (nonatomic, readonly) NSTimeZone *timeZone;

@property (nonatomic, readonly) NSTimeInterval timeIntervalSinceReferenceDate;

@property (nonatomic, readonly) BOOL isLeapYear;
@property (nonatomic, readonly) BOOL isLeapMonth;

@property (nonatomic, readonly) RBDateTime *date;
//@property (nonatomic, readonly) RBTimeSpan *timeOfDay;

@property (nonatomic, readonly) NSInteger dayOfWeek;
@property (nonatomic, readonly) NSInteger dayOfYear;



#pragma mark - Info

+ (BOOL)isLeapYear:(NSInteger)year;



#pragma mark - Constructing by altering

- (instancetype)dateTimeByAddingDays:(NSInteger)days;

- (instancetype)dateTimeByAddingYears:(NSInteger)years months:(NSInteger)months days:(NSInteger)days
                                hours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds
                          nanoseconds:(NSInteger)nanoseconds;

//- (instancetype)dateTimeByAddingTimeSpan:(RBTimeSpan *)timeSpan;
//- (instancetype)dateTimeBySubtractingTimeSpan:(RBTimeSpan *)timeSpan;



#pragma mark - Time Zone Converting

- (instancetype)convertToUTCTime;
- (instancetype)convertToLocalTime;
- (instancetype)convertToTimeZone:(NSTimeZone *)targetTimeZone;




#pragma mark - Formatting


#pragma mark - Parsing


@end
