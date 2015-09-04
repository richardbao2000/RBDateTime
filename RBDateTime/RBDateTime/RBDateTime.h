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

#import "RBDuration.h"

@interface RBDateTime : NSObject


#pragma mark - Initializers

- (instancetype)init;

- (instancetype)initWithNSDate:(NSDate *)date
                      calendar:(NSCalendar *)calendar
                      timeZone:(NSTimeZone *)timeZone;

- (instancetype)initWithTimeIntervalSinceReferenceDate:(NSTimeInterval)seconds
                                              calendar:(NSCalendar *)calendar
                                              timeZone:(NSTimeZone *)timeZone;

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



#pragma mark - Components

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



#pragma mark - Convenient Computation

@property (nonatomic, readonly) NSTimeInterval timeIntervalSinceReferenceDate;
@property (nonatomic, readonly) NSTimeInterval unixTimestamp;

@property (nonatomic, readonly) BOOL isLeapYear;
@property (nonatomic, readonly) BOOL isLeapMonth;

@property (nonatomic, readonly) RBDateTime *date;
@property (nonatomic, readonly) RBDuration *timeOfDay;

@property (nonatomic, readonly) NSInteger dayOfWeek;
@property (nonatomic, readonly) NSInteger dayOfYear;



#pragma mark - Info

+ (BOOL)isLeapYear:(NSInteger)year;



#pragma mark - Operations

- (instancetype)dateTimeByAddingYears:(NSInteger)years months:(NSInteger)months days:(NSInteger)days;
- (instancetype)dateTimeByAddingDays:(NSInteger)days;
- (instancetype)dateTimeByAddingHours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds;

- (instancetype)dateTimeByAddingYears:(NSInteger)years months:(NSInteger)months days:(NSInteger)days
                                hours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds
                         milliseconds:(NSInteger)milliseconds;

- (instancetype)dateTimeByAddingDuration:(RBDuration *)duration;
- (instancetype)dateTimeBySubtractingDuration:(RBDuration *)duration;

- (void)addYears:(NSInteger)years months:(NSInteger)months days:(NSInteger)days;
- (void)addDays:(NSInteger)days;
- (void)addHours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds;

- (void)addYears:(NSInteger)years months:(NSInteger)months days:(NSInteger)days
           hours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds
    milliseconds:(NSInteger)milliseconds;

- (void)addDuration:(RBDuration *)duration;
- (void)subtractDuration:(RBDuration *)duration;

- (BOOL)equalsTo:(RBDateTime *)dateTime;



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
