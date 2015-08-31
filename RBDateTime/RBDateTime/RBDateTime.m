//
//  RBDateTime.m
//  RBDateTime
//
//  Created by Richard Bao on 8/24/15.
//  Copyright (c) 2015 Richard Bao. All rights reserved.
//

#import "RBDateTime.h"


@interface RBDateTime ()

/// @remarks Internal date time is used to maintain a cached NSDate instance for quick access. It
/// should be always generated from components except when the date value is calculated from time
/// interval – even thus components should be generated and kept as the source of truth right after.
@property (nonatomic, strong) NSDate *_internalDateTime;

/// @remarks The source of truth date/time value, including year/month/day, hour/minute/second/nanosecond,
/// time zone, and calendar used. All component values from outside must be validated by system
/// date/time API and re-stored immediately to process overflow and/or other data errors.
@property (nonatomic, strong) NSDateComponents *_components;

- (instancetype)_initWithComponents:(NSDateComponents *)components requireValidation:(BOOL)requireValidation;

@end


@implementation RBDateTime

static NSCalendar *_gregorian = nil;
static NSTimeZone *_utcTimeZone = nil;
static NSCalendarUnit kValidCalendarUnits =
    NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitNanosecond |
    NSCalendarUnitCalendar | NSCalendarUnitTimeZone;

+ (void)initialize {
    _gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    _utcTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
}


#pragma mark - Initializers

- (instancetype)initWithNSDate:(NSDate *)date
                      calendar:(NSCalendar *)calendar
                      timezone:(NSTimeZone *)timeZone {
    self = [super init];
    if (self) {
        self._internalDateTime = date;

        self.calendar = calendar;
        self.timeZone = timeZone;

        [self _generateComponentsFromNSDate];
    }

    return self;
}

- (instancetype)initWithTimeIntervalSinceReferenceDate:(NSTimeInterval)timeIntervalSinceReferenceDate
                                              calendar:(NSCalendar *)calendar
                                              timeZone:(NSTimeZone *)timeZone {
    self = [super init];
    if (self) {
        self._internalDateTime = [NSDate dateWithTimeIntervalSinceReferenceDate:timeIntervalSinceReferenceDate];

        self.calendar = calendar;
        self.timeZone = timeZone;

        [self _generateComponentsFromNSDate];
    }

    return self;
}

- (instancetype)initWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
                        hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
                  nanosecond:(NSInteger)nanosecond
                    calendar:(NSCalendar *)calendar
                    timeZone:(NSTimeZone *)timeZone {
    self = [super init];
    if (self) {
        self._components = [[NSDateComponents alloc] init];

        self._components.year = year;
        self._components.month = month;
        self._components.day = day;
        self._components.hour = hour;
        self._components.minute = minute;
        self._components.second = second;
        self._components.nanosecond = nanosecond;

        self.calendar = calendar;
        self.timeZone = timeZone;

        [self _validateComponents];
    }

    return self;
}



#pragma mark - Internals

- (instancetype)_initWithComponents:(NSDateComponents *)components requireValidation:(BOOL)requireValidation {
    self = [super init];
    if (self) {
        self._components = components;

        if (requireValidation) {
            [self _validateComponents];
        }
    }

    return self;
}

- (void)setCalendar:(NSCalendar *)calendar {
    self._components.calendar = calendar != nil ? [calendar copy] : [_gregorian copy];
}

- (void)setTimeZone:(NSTimeZone *)timeZone {
    self._components.timeZone = timeZone != nil ? [timeZone copy] : [NSTimeZone defaultTimeZone];
    self._components.calendar.timeZone = self._components.timeZone;
}

- (void)_invalidateNSDateCache {
    self._internalDateTime = nil;
}

- (void)_generateNSDateCacheFromComponents {
    self._internalDateTime = [self.calendar dateFromComponents:self._components];
}

- (void)_generateComponentsFromNSDate {
    NSDateComponents *newComps = [_gregorian components:kValidCalendarUnits
                                               fromDate:self._internalDateTime];
    newComps.calendar = self._components.calendar;
    newComps.timeZone = self._components.timeZone;

    self._components = newComps;
}

- (void)_validateComponents {
    [self _generateNSDateCacheFromComponents];
    [self _generateComponentsFromNSDate];
}



#pragma mark - Properties

- (NSDate *)NSDate {
    if (self._internalDateTime == nil) {
        [self _generateNSDateCacheFromComponents];
    }

    return self._internalDateTime;
}

- (NSInteger)year {
    return self._components.year;
}

- (NSInteger)month {
    return self._components.month;
}

- (NSInteger)day {
    return self._components.day;
}

- (NSCalendar *)calendar {
    return self._components.calendar;
}

- (NSTimeZone *)timeZone {
    return self._components.timeZone;
}

- (NSTimeInterval)timeIntervalSinceReferenceDate {
    return self._internalDateTime.timeIntervalSinceReferenceDate;
}

- (BOOL)isLeapYear {
    return [RBDateTime isLeapYear:self.year];
}

- (BOOL)isLeapMonth {
    return self.isLeapYear && self.month == 2;
}

- (RBDateTime *)date {
    NSDateComponents *comps = [self._components copy];
    comps.hour = 0;
    comps.minute = 0;
    comps.second = 0;
    comps.nanosecond = 0;

    return [[RBDateTime alloc] _initWithComponents:comps requireValidation:NO];
}



#pragma mark - Info

+ (BOOL)isLeapYear:(NSInteger)year {
    return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
}



#pragma mark - Constructing by altering

- (instancetype)dateTimeByAddingDays:(NSInteger)days {
    NSDateComponents *newComps = [self._components copy];
    newComps.day += days;

    return [[RBDateTime alloc] _initWithComponents:newComps requireValidation:YES];
}

- (instancetype)dateTimeByAddingYears:(NSInteger)years months:(NSInteger)months days:(NSInteger)days
                                hours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds
                          nanoseconds:(NSInteger)nanoseconds {
    NSDateComponents *newComps = [self._components copy];
    newComps.year += years;
    newComps.month += months;
    newComps.day += days;
    newComps.hour += hours;
    newComps.minute += minutes;
    newComps.second += seconds;
    newComps.nanosecond += nanoseconds;

    return [[RBDateTime alloc] _initWithComponents:newComps requireValidation:YES];
}



#pragma mark - Time Zone Converting

- (instancetype)convertToUTCTime {
    return [self convertToTimeZone:_utcTimeZone];
}

- (instancetype)convertToLocalTime {
    return [self convertToTimeZone:[NSTimeZone localTimeZone]];
}

- (instancetype)convertToTimeZone:(NSTimeZone *)targetTimeZone {
    NSDateComponents *newComps = [self._components.calendar componentsInTimeZone:targetTimeZone
                                                                        fromDate:self._internalDateTime];
    return [[RBDateTime alloc] _initWithComponents:newComps requireValidation:YES];
}











@end



























