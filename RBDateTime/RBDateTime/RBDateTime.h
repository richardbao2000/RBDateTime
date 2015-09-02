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
                      timeZone:(NSTimeZone *)timeZone;

- (instancetype)initWithTimeIntervalSinceReferenceDate:(NSTimeInterval)timeIntervalSinceReferenceDate
                                              calendar:(NSCalendar *)calendar
                                              timeZone:(NSTimeZone *)timeZone;

- (instancetype)initWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

- (instancetype)initWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
                        hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;

- (instancetype)initWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
                        hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
                    timeZone:(NSTimeZone *)timeZone;

- (instancetype)initWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
                        hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
                    calendar:(NSCalendar *)calendar;

- (instancetype)initWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
                        hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
                 millisecond:(NSInteger)millisecond
                    calendar:(NSCalendar *)calendar
                    timeZone:(NSTimeZone *)timeZone;

+ (instancetype)dateTimeWithNSDate:(NSDate *)date
                      calendar:(NSCalendar *)calendar
                      timezone:(NSTimeZone *)timeZone;

+ (instancetype)dateTimeWithTimeIntervalSinceReferenceDate:(NSTimeInterval)timeIntervalSinceReferenceDate
                                              calendar:(NSCalendar *)calendar
                                              timezone:(NSTimeZone *)timeZone;

+ (instancetype)dateTimeWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

+ (instancetype)dateTimeWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
                        hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;

+ (instancetype)dateTimeWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
                        hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
                    timeZone:(NSTimeZone *)timeZone;

+ (instancetype)dateTimeWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
                        hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
                    calendar:(NSCalendar *)calendar;

+ (instancetype)dateTimeWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
                        hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
                 millisecond:(NSInteger)millisecond
                    calendar:(NSCalendar *)calendar
                    timeZone:(NSTimeZone *)timeZone;

+ (instancetype)now;
+ (instancetype)nowUTC;

+ (instancetype)today;
+ (instancetype)todayUTC;



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
@property (nonatomic, readonly) NSTimeInterval unixTimestamp;

@property (nonatomic, readonly) BOOL isLeapYear;
@property (nonatomic, readonly) BOOL isLeapMonth;

@property (nonatomic, readonly) RBDateTime *date;
//@property (nonatomic, readonly) RBTimeSpan *timeOfDay;

@property (nonatomic, readonly) NSInteger dayOfWeek;
@property (nonatomic, readonly) NSInteger dayOfYear;



#pragma mark - Info

+ (BOOL)isLeapYear:(NSInteger)year;



#pragma mark - Adding and Subtracting

- (instancetype)dateTimeByAddingYears:(NSInteger)years months:(NSInteger)months days:(NSInteger)days;
- (instancetype)dateTimeByAddingDays:(NSInteger)days;
- (instancetype)dateTimeByAddingHours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds;

- (instancetype)dateTimeByAddingYears:(NSInteger)years months:(NSInteger)months days:(NSInteger)days
                                hours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds
                         milliseconds:(NSInteger)milliseconds;

//- (instancetype)dateTimeByAddingTimeSpan:(RBTimeSpan *)timeSpan;
//- (instancetype)dateTimeBySubtractingTimeSpan:(RBTimeSpan *)timeSpan;

- (void)addYears:(NSInteger)years months:(NSInteger)months days:(NSInteger)days;
- (void)addDays:(NSInteger)days;
- (void)addHours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds;

- (void)addYears:(NSInteger)years months:(NSInteger)months days:(NSInteger)days
                   hours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds
            milliseconds:(NSInteger)milliseconds;



#pragma mark - Time Zone Converting

- (instancetype)utcTime;
- (instancetype)localTime;
- (instancetype)dateTimeInTimeZone:(NSTimeZone *)targetTimeZone;


@end



@interface RBDateTime (Formatting)

#pragma mark - Formatting

- (NSString *)localizedStringWithDateStyle:(NSDateFormatterStyle)dateStyle
                                 timeStyle:(NSDateFormatterStyle)timeStyle;

- (NSString *)localizedStringWithDateStyle:(NSDateFormatterStyle)dateStyle
                                 timeStyle:(NSDateFormatterStyle)timeStyle
                                  timeZone:(NSTimeZone *)timeZone;

- (NSString *)localizedStringWithDateStyle:(NSDateFormatterStyle)dateStyle
                                 timeStyle:(NSDateFormatterStyle)timeStyle
                                  timeZone:(NSTimeZone *)timeZone
                                    locale:(NSLocale *)locale;

- (NSString *)localizedStringWithFormatTemplate:(NSString *)formatTemplate;

- (NSString *)localizedStringWithFormatTemplate:(NSString *)formatTemplate
                                       timeZone:(NSTimeZone *)timeZone;

- (NSString *)localizedStringWithFormatTemplate:(NSString *)formatTemplate
                                       timeZone:(NSTimeZone *)timeZone
                                         locale:(NSLocale *)locale;

- (NSString *)localizedStringWithFormat:(NSString *)format;

- (NSString *)localizedStringWithFormat:(NSString *)format
                               timeZone:(NSTimeZone *)timeZone;

- (NSString *)localizedStringWithFormat:(NSString *)format
                               timeZone:(NSTimeZone *)timeZone
                                 locale:(NSLocale *)locale;

+ (void)setDefaultDateStyle:(NSDateFormatterStyle)dateStyle;
+ (void)setDefaultTimeStyle:(NSDateFormatterStyle)timeStyle;
+ (void)setDefaultDateTimeFormatTemplate:(NSString *)dateTimeFormatTemplate;
+ (void)setDefaultDateTimeFormat:(NSString *)dateTimeFormat;

- (NSString *)localizedDate;
- (NSString *)localizedTime;
- (NSString *)localizedString;

- (NSString *)formattedUnixTimestamp;
- (NSString *)formattedUnixTimestampUTC;


#pragma mark - Parsing

+ (instancetype)dateTimeByParsingString:(NSString *)string withFormat:(NSString *)format;
+ (instancetype)dateTimeByParsingString:(NSString *)string withFormat:(NSString *)format
                               timeZone:(NSTimeZone *)timeZone;

+ (instancetype)dateTimeByParsingUnixTimestamp:(NSString *)unixTimestamp;
+ (instancetype)dateTimeByParsingUnixTimestampUTC:(NSString *)unixTimestamp;
+ (instancetype)dateTimeByParsingUnixTimestamp:(NSString *)unixTimestamp timeZone:(NSTimeZone *)timeZone;


@end
