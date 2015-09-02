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

#import "RBDateTime.h"


@implementation RBDateTime (Formatting)

static NSDateFormatterStyle _defaultDateStyle = NSDateFormatterMediumStyle;
static NSDateFormatterStyle _defaultTimeStyle = NSDateFormatterShortStyle;
static NSString *_defaultDateTimeFormatTemplate = nil;
static NSString *_defaultDateTimeFormat = nil;

static NSString * kUnixTimeStampFormat = @"yyyy'-'MM'-'dd'T'HH:mm:ss'Z'";

static NSDateFormatter *_formatter = nil;

+ (void)_initializeDateFormatter {
    if (_formatter == nil) {
        _formatter = [[NSDateFormatter alloc] init];
    }
}



#pragma mark - Formatting

- (NSString *)localizedStringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle {
    return [self localizedStringWithDateStyle:dateStyle
                                    timeStyle:timeStyle
                                     timeZone:nil];
}

- (NSString *)localizedStringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle timeZone:(NSTimeZone *)timeZone {
    return [self localizedStringWithDateStyle:dateStyle
                                    timeStyle:timeStyle
                                     timeZone:timeZone
                                       locale:nil];
}

- (NSString *)localizedStringWithDateStyle:(NSDateFormatterStyle)dateStyle
                                 timeStyle:(NSDateFormatterStyle)timeStyle
                                  timeZone:(NSTimeZone *)timeZone
                                    locale:(NSLocale *)locale {
    [RBDateTime _initializeDateFormatter];

    _formatter.dateStyle = dateStyle;
    _formatter.timeStyle = timeStyle;
    _formatter.timeZone = timeZone != nil ? timeZone : self.timeZone;
    _formatter.locale = locale;

    return [_formatter stringFromDate:self.NSDate];
}

- (NSString *)localizedStringWithFormatTemplate:(NSString *)formatTemplate {
    return [self localizedStringWithFormatTemplate:formatTemplate
                                          timeZone:nil];
}

- (NSString *)localizedStringWithFormatTemplate:(NSString *)formatTemplate
                                       timeZone:(NSTimeZone *)timeZone {
    return [self localizedStringWithFormatTemplate:formatTemplate
                                          timeZone:timeZone
                                            locale:[NSLocale currentLocale]];
}
- (NSString *)localizedStringWithFormatTemplate:(NSString *)formatTemplate
                                       timeZone:(NSTimeZone *)timeZone
                                         locale:(NSLocale *)locale {
    [RBDateTime _initializeDateFormatter];

    _formatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:formatTemplate
                                                            options:0
                                                             locale:locale];
    _formatter.timeZone = timeZone != nil ? timeZone : self.timeZone;
    _formatter.locale = locale;

    return [_formatter stringFromDate:self.NSDate];
}

- (NSString *)localizedStringWithFormat:(NSString *)format {
    return [self localizedStringWithFormat:format
                                  timeZone:nil];
}

- (NSString *)localizedStringWithFormat:(NSString *)format
                               timeZone:(NSTimeZone *)timeZone {
    return [self localizedStringWithFormat:format
                                  timeZone:timeZone
                                    locale:[NSLocale currentLocale]];
}

- (NSString *)localizedStringWithFormat:(NSString *)format
                               timeZone:(NSTimeZone *)timeZone
                                 locale:(NSLocale *)locale {
    [RBDateTime _initializeDateFormatter];

    _formatter.dateFormat = format;
    _formatter.timeZone = timeZone != nil ? timeZone : self.timeZone;
    _formatter.locale = locale;

    return [_formatter stringFromDate:self.NSDate];
}

+ (void)setDefaultDateStyle:(NSDateFormatterStyle)dateStyle {
    _defaultDateStyle = dateStyle;
    _defaultDateTimeFormatTemplate = nil;
    _defaultDateTimeFormat = nil;
}

+ (void)setDefaultTimeStyle:(NSDateFormatterStyle)timeStyle {
    _defaultTimeStyle = timeStyle;
    _defaultDateTimeFormatTemplate = nil;
    _defaultDateTimeFormat = nil;
}

+ (void)setDefaultDateTimeFormatTemplate:(NSString *)dateTimeFormatTemplate {
    _defaultDateTimeFormatTemplate = dateTimeFormatTemplate;
    _defaultDateTimeFormat = nil;
}

+ (void)setDefaultDateTimeFormat:(NSString *)dateTimeFormat {
    _defaultDateTimeFormat = dateTimeFormat;
}

- (NSString *)localizedDate {
    return [self localizedStringWithDateStyle:_defaultDateStyle timeStyle:NSDateFormatterNoStyle];
}

- (NSString *)localizedTime {
    return [self localizedStringWithDateStyle:NSDateFormatterNoStyle timeStyle:_defaultTimeStyle];
}

- (NSString *)localizedString {
    if (_defaultDateTimeFormat != nil) {
        return [self localizedStringWithFormat:_defaultDateTimeFormat];
    } else if (_defaultDateTimeFormatTemplate != nil) {
        return [self localizedStringWithFormatTemplate:_defaultDateTimeFormatTemplate];
    } else {
        return [self localizedStringWithDateStyle:_defaultDateStyle timeStyle:_defaultTimeStyle];
    }
}

- (NSString *)formattedUnixTimestamp {
    return [self localizedStringWithFormat:kUnixTimeStampFormat
                                  timeZone:self.timeZone
                                    locale:nil];
}

- (NSString *)formattedUnixTimestampUTC {
    return [self localizedStringWithFormat:kUnixTimeStampFormat
                                  timeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]
                                    locale:nil];
}



#pragma mark - Parsing

+ (instancetype)dateTimeByParsingString:(NSString *)string withFormat:(NSString *)format {
    return [RBDateTime dateTimeByParsingString:string withFormat:format
                                      timeZone:[NSTimeZone localTimeZone]];
}

+ (instancetype)dateTimeByParsingString:(NSString *)string withFormat:(NSString *)format
                               timeZone:(NSTimeZone *)timeZone {
    [RBDateTime _initializeDateFormatter];
    _formatter.dateFormat = format;
    _formatter.timeZone = timeZone != nil ? timeZone : [NSTimeZone localTimeZone];

    NSDate *parsedDate = [_formatter dateFromString:string];

    if (parsedDate) {
        return [RBDateTime dateTimeWithNSDate:parsedDate calendar:nil timezone:_formatter.timeZone];
    } else {
        return nil;
    }
}

+ (instancetype)dateTimeByParsingUnixTimestamp:(NSString *)unixTimestamp {
    return [RBDateTime dateTimeByParsingUnixTimestamp:unixTimestamp timeZone:nil];
}

+ (instancetype)dateTimeByParsingUnixTimestampUTC:(NSString *)unixTimestamp {
    return [RBDateTime dateTimeByParsingUnixTimestamp:unixTimestamp
                                             timeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
}

+ (instancetype)dateTimeByParsingUnixTimestamp:(NSString *)unixTimestamp timeZone:(NSTimeZone *)timeZone {
    [RBDateTime _initializeDateFormatter];
    _formatter.dateFormat = kUnixTimeStampFormat;
    _formatter.timeZone = timeZone != nil ? timeZone : [NSTimeZone localTimeZone];

    NSDate *parsedDate = [_formatter dateFromString:unixTimestamp];

    if (parsedDate) {
        return [RBDateTime dateTimeWithNSDate:parsedDate calendar:nil timezone:_formatter.timeZone];
    } else {
        return nil;
    }
}


@end
