//
//  RBDateTime.m
//  RBDateTime
//
//  Created by Richard Bao on 8/24/15.
//  Copyright (c) 2015 Richard Bao. All rights reserved.
//

#import "RBDateTime.h"


@interface RBDateTime () {
    /// @remarks Internal date time is used to maintain a cached NSDate instance for quick access. It
    /// should be always generated from components except when the date value is calculated from time
    /// interval – even thus components should be generated and kept as the source of truth right after.
    NSDate *_nsDateTime;

    /// @remarks The source of truth date/time value, including year/month/day, hour/minute/second/nanosecond,
    /// time zone, and calendar used. All component values from outside must be validated by system
    /// date/time API and re-stored immediately to process overflow and/or other data errors.
    NSDateComponents *_components;
}

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

- (instancetype)init {
    self = [super init];
    if (self) {
        _nsDateTime = [NSDate new];

        self.calendar = nil;
        self.timeZone = nil;

        [self _generateComponentsFromNSDate];
    }

    return self;
}

- (instancetype)initWithNSDate:(NSDate *)date
                      calendar:(NSCalendar *)calendar
                      timeZone:(NSTimeZone *)timeZone {
    self = [super init];
    if (self) {
        _nsDateTime = date;

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
        _nsDateTime = [NSDate dateWithTimeIntervalSinceReferenceDate:timeIntervalSinceReferenceDate];

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
        _components = [[NSDateComponents alloc] init];

        _components.year = year;
        _components.month = month;
        _components.day = day;
        _components.hour = hour;
        _components.minute = minute;
        _components.second = second;
        _components.nanosecond = nanosecond;

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
        _components = components;

        if (requireValidation) {
            [self _validateComponents];
        }
    }

    return self;
}

- (void)setCalendar:(NSCalendar *)calendar {
    _components.calendar = calendar != nil ? calendar : _gregorian;
}

- (void)setTimeZone:(NSTimeZone *)timeZone {
    _components.timeZone = timeZone != nil ? timeZone : [NSTimeZone localTimeZone];
}

- (void)_invalidateNSDateCache {
    _nsDateTime = nil;
}

- (void)_generateNSDateCacheFromComponents {
    _nsDateTime = [self.calendar dateFromComponents:_components];
}

- (void)_generateComponentsFromNSDate {
    NSDateComponents *newComps = [_gregorian components:kValidCalendarUnits
                                               fromDate:_nsDateTime];
    newComps.calendar = _components.calendar;
    newComps.timeZone = _components.timeZone;

    _components = newComps;
}

- (void)_validateComponents {
    [self _generateNSDateCacheFromComponents];
    [self _generateComponentsFromNSDate];
}



#pragma mark - Properties

- (NSDate *)NSDate {
    if (_nsDateTime == nil) {
        [self _generateNSDateCacheFromComponents];
    }

    return _nsDateTime;
}

- (NSInteger)year {
    return _components.year;
}

- (NSInteger)month {
    return _components.month;
}

- (NSInteger)day {
    return _components.day;
}

- (NSCalendar *)calendar {
    return _components.calendar;
}

- (NSTimeZone *)timeZone {
    return _components.timeZone;
}

- (NSTimeInterval)timeIntervalSinceReferenceDate {
    return _nsDateTime.timeIntervalSinceReferenceDate;
}

- (BOOL)isLeapYear {
    return [RBDateTime isLeapYear:self.year];
}

- (BOOL)isLeapMonth {
    return self.isLeapYear && self.month == 2;
}

- (RBDateTime *)date {
    NSDateComponents *comps = [_components copy];
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
    NSDateComponents *newComps = [_components copy];
    newComps.day += days;

    return [[RBDateTime alloc] _initWithComponents:newComps requireValidation:YES];
}

- (instancetype)dateTimeByAddingYears:(NSInteger)years months:(NSInteger)months days:(NSInteger)days
                                hours:(NSInteger)hours minutes:(NSInteger)minutes seconds:(NSInteger)seconds
                          nanoseconds:(NSInteger)nanoseconds {
    NSDateComponents *newComps = [_components copy];
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
    NSDateComponents *newComps = [_components.calendar componentsInTimeZone:targetTimeZone
                                                                   fromDate:_nsDateTime];
    return [[RBDateTime alloc] _initWithComponents:newComps requireValidation:YES];
}











@end



























