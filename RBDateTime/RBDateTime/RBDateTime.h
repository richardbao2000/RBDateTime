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

/// Represents a date and time with specific calendar and time zone.
@interface RBDateTime : NSObject


#pragma mark - Initializers

/// Initializes a new @c RBDateTime instance that is set to the current date and time on the device,
/// expressed as the local time.
- (instancetype)init;

/// Initializes a new @c RBDateTime instance with a @c NSDate object for the specified calendar in
/// the specific time zone.
///
/// @param  date            The @c NSDate object.
/// @param  calendar        The calendar that is used to interpret year, month, and day.
///                         Gregorian calendar will be used if `nil` is passed.
/// @param  timeZone        The specified time zone used to express the time.
///                         The local time zone will be used if `nil` is passed.
- (instancetype)initWithNSDate:(NSDate *)date
                      calendar:(NSCalendar *)calendar
                      timeZone:(NSTimeZone *)timeZone;

/// Initializes a new @c RBDateTime instance with the time interval since the Reference Date for
/// the specifid calendar in the specified time zone.
///
/// @param  seconds         The number of seconds to add to the reference date (the first instant of
///                         1 January 2001, GMT). A negative value means the receiver will be
///                         earlier than the reference date.
/// @param  calendar        The calendar that is used to interpret year, month, and day.
///                         Gregorian calendar will be used if `nil` is passed.
/// @param  timeZone        The specified time zone used to express the time.
///                         The local time zone will be used if `nil` is passed.
- (instancetype)initWithTimeIntervalSinceReferenceDate:(NSTimeInterval)seconds
                                              calendar:(NSCalendar *)calendar
                                              timeZone:(NSTimeZone *)timeZone;

/// Initializes a new @c RBDateTime instance with a given year, month, day, hour, minute, and second
/// for the specified calendar in the specified time zone.
///
/// @param  year            The number of years.
/// @param  month           The number of months. The first month is 1.
/// @param  day             The number of days. The first day is 1.
/// @param  hour            The number of hours.
/// @param  minute          The number of minutes.
/// @param  second          The number of seconds.
/// @param  millisecond     The number of milliseconds.
/// @param  calendar        The calendar that is used to interpret year, month, and day.
///                         Gregorian calendar will be used if `nil` is passed.
/// @param  timeZone        The specified time zone used to express the time.
///                         The local time zone will be used if `nil` is passed.
- (instancetype)initWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
                        hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
                 millisecond:(NSInteger)millisecond
                    calendar:(NSCalendar *)calendar
                    timeZone:(NSTimeZone *)timeZone;

/// Creates a new @c RBDateTime initialized with a @c NSDate instance for the specified calendar in
/// the specified time zone.
///
/// @param  date            The @c NSDate object.
/// @param  calendar        The calendar that is used to interpret year, month, and day.
///                         Gregorian calendar will be used if `nil` is passed.
/// @param  timeZone        The specified time zone used to express the time.
///                         The local time zone will be used if `nil` is passed.
+ (instancetype)dateTimeWithNSDate:(NSDate *)date
                          calendar:(NSCalendar *)calendar
                          timezone:(NSTimeZone *)timeZone;

/// Creates a new @c RBDateTime initialized with the time interval since the Referenece Date for
/// the specifid calendar in the specified time zone.
///
/// @param  seconds         The number of seconds to add to the reference date (the first instant of
///                         1 January 2001, GMT). A negative value means the receiver will be
///                         earlier than the reference date.
/// @param  calendar        The calendar that is used to interpret year, month, and day.
///                         Gregorian calendar will be used if `nil` is passed.
/// @param  timeZone        The specified time zone used to express the time.
///                         The local time zone will be used if `nil` is passed.
+ (instancetype)dateTimeWithTimeIntervalSinceReferenceDate:(NSTimeInterval)timeIntervalSinceReferenceDate
                                                  calendar:(NSCalendar *)calendar
                                                  timezone:(NSTimeZone *)timeZone;

/// Creates a new @c RBDateTime initialized to a given year, month, and day.
///
/// @param  year            The number of years.
/// @param  month           The number of months. The first month is 1.
/// @param  day             The number of days. The first day is 1.
+ (instancetype)dateTimeWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

/// Creates a new @c RBDateTime initialized to a given year, month, day, hour, minute, and second.
///
/// @param  year            The number of years.
/// @param  month           The number of months. The first month is 1.
/// @param  day             The number of days. The first day is 1.
/// @param  hour            The number of hours.
/// @param  minute          The number of minutes.
/// @param  second          The number of seconds.
+ (instancetype)dateTimeWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
                            hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;

/// Creates a new @c RBDateTime initialized to a given year, month, day, hour, minute, and second in
/// the specified time zone.
///
/// @param  year            The number of years.
/// @param  month           The number of months. The first month is 1.
/// @param  day             The number of days. The first day is 1.
/// @param  hour            The number of hours.
/// @param  minute          The number of minutes.
/// @param  second          The number of seconds.
/// @param  timeZone        The specified time zone used to express the time.
///                         The local time zone will be used if `nil` is passed.
+ (instancetype)dateTimeWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
                            hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
                        timeZone:(NSTimeZone *)timeZone;

/// Creates a new @c RBDateTime initialized to a given year, month, day, hour, minute, and second
/// for the specified calendar.
///
/// @param  year            The number of years.
/// @param  month           The number of months. The first month is 1.
/// @param  day             The number of days. The first day is 1.
/// @param  hour            The number of hours.
/// @param  minute          The number of minutes.
/// @param  second          The number of seconds.
/// @param  calendar        The calendar that is used to interpret year, month, and day.
///                         Gregorian calendar will be used if `nil` is passed.
+ (instancetype)dateTimeWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
                            hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
                        calendar:(NSCalendar *)calendar;

/// Creates a new @c RBDateTime initialized to a given year, month, day, hour, minute, and second
/// for the specified calendar in the specified time zone.d
///
/// @param  year            The number of years.
/// @param  month           The number of months. The first month is 1.
/// @param  day             The number of days. The first day is 1.
/// @param  hour            The number of hours.
/// @param  minute          The number of minutes.
/// @param  second          The number of seconds.
/// @param  millisecond     The number of milliseconds.
/// @param  calendar        The calendar that is used to interpret year, month, and day.
///                         Gregorian calendar will be used if `nil` is passed.
/// @param  timeZone        The specified time zone used to express the time.
///                         The local time zone will be used if `nil` is passed.
+ (instancetype)dateTimeWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
                            hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
                     millisecond:(NSInteger)millisecond
                        calendar:(NSCalendar *)calendar
                        timeZone:(NSTimeZone *)timeZone;

/// Gets a @c RBDateTime instance that is set to the current date and time on the device, expressed
/// as the local time.
+ (instancetype)now;
/// Gets a @c RBDateTime instance that is set to the current date and time on the device, expressed
/// as the UTC time.
+ (instancetype)nowUTC;

/// Gets a @c RBDateTime instance that is set to the current date without time part on the device,
/// expressed as the local time.
+ (instancetype)today;
/// Gets a @c RBDateTime instance that is set to the current date without time part on the device,
/// expressed as the UTC time.
+ (instancetype)todayUTC;



#pragma mark - Components

/// Returns a @c NSDate instance that represents the same date and time. (read-only)
@property (nonatomic, readonly) NSDate *NSDate;

/// Returns the number of years. (read-only)
@property (nonatomic, readonly) NSInteger year;
/// Returns the number of month. The first month is 1. (read-only)
@property (nonatomic, readonly) NSInteger month;
/// Returns the number of days. The first day is 1. (read-only)
@property (nonatomic, readonly) NSInteger day;
/// Returns the number of hours. (read-only)
@property (nonatomic, readonly) NSInteger hour;
/// Returns the number of minutes. (read-only)
@property (nonatomic, readonly) NSInteger minute;
/// Returns the number of seconds. (read-only)
@property (nonatomic, readonly) NSInteger second;
/// Returns the number of milliseconds. (read-only)
@property (nonatomic, readonly) NSInteger millisecond;

/// Returns the calendar used to interpret year, month, and day. (read-only)
@property (nonatomic, readonly) NSCalendar *calendar;
/// Returns the time zone. (read-only)
@property (nonatomic, readonly) NSTimeZone *timeZone;



#pragma mark - Convenient Computation

/// Returns the interval between the date object and January 1, 2001, at 12:00 AM GMT. (read-only)
@property (nonatomic, readonly) NSTimeInterval timeIntervalSinceReferenceDate;
/// Returns the UNIX-style timestamp, which is defined by the interval between the date object and
/// January 1, 1970, at 12:00 AM GMT. (read-only)
@property (nonatomic, readonly) NSTimeInterval unixTimestamp;

/// Returns a Boolean value that indicates whether the year of the date is a leap year. (read-only)
@property (nonatomic, readonly) BOOL isLeapYear;
/// Returns a Boolean value that indicates whether the month of the date is a leap month.
/// In Gregorian calendar, the second months (February) of leap years are leap months. (read-only)
@property (nonatomic, readonly) BOOL isLeapMonth;

/// Returns a @c RBDateTime instance that only contains the date portion without the time of the day.
/// (read-only)
@property (nonatomic, readonly) RBDateTime *date;
/// Returns a @c RBDuration instance that contains the time portion (from midnight to date).
/// (read-only)
@property (nonatomic, readonly) RBDuration *timeOfDay;

/// Returns the 1-based number of days in the week.
/// In Gregorian calendar, Sunday is the first day of a week, which is represented by 1.
@property (nonatomic, readonly) NSInteger dayOfWeek;
/// Returns the 1-based number of days in the year.
/// In Gregorian calendar, January 1 is the first day, which is represented by 1.
@property (nonatomic, readonly) NSInteger dayOfYear;



#pragma mark - Info

/// Returns a Boolean value that indicates whether the given year is a leap year.
///
/// @param  year        The year for the leap year test.
+ (BOOL)isLeapYear:(NSInteger)year;



#pragma mark - Operations

/// Returns a new @c RBDateTime that adds the given number of years, months, and days to the value
/// of this instance.
///
/// @param  year            The number of years.
/// @param  month           The number of months. The first month is 1.
/// @param  day             The number of days. The first day is 1.
- (instancetype)dateTimeByAddingYears:(NSInteger)years months:(NSInteger)months days:(NSInteger)days;
/// Returns a new @c RBDateTime that adds the given number of days to the value
/// of this instance.
///
/// @param  day             The number of days. The first day is 1.
- (instancetype)dateTimeByAddingDays:(NSInteger)days;
/// Returns a new @c RBDateTime that adds the given number of hours, minutes, and seconds to the value
/// of this instance.
///
/// @param  hour            The number of hours.
/// @param  minute          The number of minutes.
/// @param  second          The number of seconds.
- (instancetype)dateTimeByAddingHours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds;

/// Returns a new @c RBDateTime that adds the given number of years, months, days, hours, minutes,
/// seconds, and milliseconds to the value of this instance.
///
/// @param  year            The number of years.
/// @param  month           The number of months. The first month is 1.
/// @param  day             The number of days. The first day is 1.
/// @param  hour            The number of hours.
/// @param  minute          The number of minutes.
/// @param  second          The number of seconds.
/// @param  millisecond     The number of milliseconds.
- (instancetype)dateTimeByAddingYears:(NSInteger)years months:(NSInteger)months days:(NSInteger)days
                                hours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds
                         milliseconds:(NSInteger)milliseconds;

/// Returns a new @c RBDateTime that adds the value of the given @c RBDuration to the value
/// of this instance.
///
/// @param  duration        The specified duration to add.
- (instancetype)dateTimeByAddingDuration:(RBDuration *)duration;
/// Returns a new @c RBDateTime that subtracts the value of the given @c RBDuration to the value
/// of this instance.
///
/// @param  duration        The specified duration to subtract.
- (instancetype)dateTimeBySubtractingDuration:(RBDuration *)duration;

/// Adds the given number of years, months, and days to the value of this instance.
///
/// @param  year            The number of years.
/// @param  month           The number of months. The first month is 1.
/// @param  day             The number of days. The first day is 1.
- (void)addYears:(NSInteger)years months:(NSInteger)months days:(NSInteger)days;
/// Adds the given number of days to the value of this instance.
///
/// @param  day             The number of days. The first day is 1.
- (void)addDays:(NSInteger)days;
/// Adds the given number of hours, minutes, seconds, and milliseconds
/// to the value of this instance.
///
/// @param  hour            The number of hours.
/// @param  minute          The number of minutes.
/// @param  second          The number of seconds.
- (void)addHours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds;

/// Adds the given number of years, months, days, hours, minutes, seconds, and milliseconds
/// to the value of this instance.
///
/// @param  year            The number of years.
/// @param  month           The number of months. The first month is 1.
/// @param  day             The number of days. The first day is 1.
/// @param  hour            The number of hours.
/// @param  minute          The number of minutes.
/// @param  second          The number of seconds.
/// @param  millisecond     The number of milliseconds.
- (void)addYears:(NSInteger)years months:(NSInteger)months days:(NSInteger)days
           hours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds
    milliseconds:(NSInteger)milliseconds;

/// Adds the value of the given @c RBDuration to the value of this instance.
- (void)addDuration:(RBDuration *)duration;
/// Subtracts the value of the given @c RBDuration to the value of this instance.
- (void)subtractDuration:(RBDuration *)duration;

/// Returns a Boolean value that indicates whether the given date time equals to this instance.
///
/// @remarks Only the absolute date/time values from both instance are compared. Their calendars and
/// time zones are not necessarily to be the same to be equal.
///
/// @param  dateTime        The other @RBDateTime instance to compare with.
- (BOOL)equalsTo:(RBDateTime *)dateTime;



#pragma mark - Time Zone Converting

/// Returns a new @c RBDateTime that converts this instance to Coordinated Universal Time (UTC).
- (instancetype)utcTime;
/// Returns a new @c RBDateTime that converts this instance to local time.
- (instancetype)localTime;
/// Returns a new @c RBDateTime that converts this instance to the given time zone.
///
/// @param  targetTimeZone  The target time zone to convert to. If `nil` is passed, the local time
///                         zone will be used instead.
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
