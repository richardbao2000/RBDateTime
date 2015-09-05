# An Easy Date and Time API for iOS and OS X

Inspired by the `DateTime` and `TimeSpan` classes in .NET/C# Library, this `RBDateTime` and `RBDuration` classes provide a much easier and intuitive way to work with date and time values, time zones, and locale-aware formatting than the Cocoa Foundation API's.


## Installation

The easiest way to install is through CocoaPods:

```
pod 'RBDateTime'
```


## Usage

With RBDateTime, you can construct a date/time object using these convenient methods:

```objc
// The current date and time.
RBDateTime *now   = [RBDateTime now];
// Today's date without time part.
RBDateTime *today = [RBDateTime today];
// Date of Jan 6, 2015 without time part.
RBDateTime *date  = [RBDateTime dateTimeWithYear:2015 month:1 day:6];
// Jan 6, 2015, 9:41:00 AM.
RBDateTime *event = [RBDateTime dateTimeWithYear:2015 month:1 day:6 hour:9 minute:41 second:0];

// Duration of 100 days.
RBDuration *oneHundredDays = [RBDuration durationWithDays:100];
// Duration of 3 hours.
RBDuration *threeHours = [RBDuration durationWithHours:3];
```

Access to any component easily:

```objc
// Get the hour component of current time.
NSInteger currentHour = now.hour;
// Calculate the day of week today.
NSInteger dayOfWeek = now.dayOfWeek;
// Calculate how many minutes are there in three hours.
double minutesInThreeHours = threeHours.totalMinutes;
```

Add or subtract certain time:

```objc
// Event date/time: Jan 6, 2015, 9:41:00 AM.
RBDateTime *event = [RBDateTime dateTimeWithYear:2015 month:1 day:6 hour:9 minute:41 second:0];
// 100 days before the event.
RBDateTime *countdownFor100Days = [event dateTimeByAddingDays:-100];

// 30 minutes from now.
RBDateTime *reminderMeLater = [[RBDateTime now] addHours:0 minutes:30 seconds:0];

// Duration of 1.5 hours.
RBDuration *lengthOfMeeting = [RBDuration durationWithMinutes:90];
```

Time zone support:

```objc
// Current date and time expressed in UTC.
RBDateTime *nowUTC = [RBDateTime nowUTC];

NSTimeZone *pacificTime = [NSTimeZone timeZoneWithName:@"America/Los_Angeles"];
NSTimeZone *easternTime = [NSTimeZone timeZoneWithName:@"America/New_York"];

// Construct the date and time in Pacific Time.
RBDateTime *timeInLA = [RBDateTime dateTimeWithYear:2015 month:1 day:6 hour:9 minute:41 second:0 timeZone:pacificTime];
// Convert it to the local time.
RBDateTime *localTime = [timeInLA localTime];
// Convert it to UTC time.
RBDateTime *localTime = [timeInLA utcTime];
// Convert it to Eastern Time.
RBDateTime *timeInNYC = [timeInLA dateTimeInTimeZone:easternTime];
```

Localized text formatting:

```objc
// Jan 6, 2015, 9:41:00 AM.
RBDateTime *date = [RBDateTime dateTimeWithYear:2015 month:1 day:6 hour:9 minute:41 second:0];

// Default output in US English locale: Jan 6, 2015, 9:41 AM
NSString *dateTime = [date localizedString];
// Default output in US English locale: Jan 6, 2015
NSString *dateOnly = [date localizedDate];

NSLocale *enUS = [NSLocale localeWithLocaleIdentifier:@"en_US"];
NSLocale *enGB = [NSLocale localeWithLocaleIdentifier:@"en_GB"];

// Output: 1/6
NSString *dateTimeUS = [date localizedStringWithFormatTemplate:@"Md" timeZone:nil locale:en_US];
// Output: 6/1
NSString *dateTimeGB = [date localizedStringWithFormatTemplate:@"Md" timeZone:nil locale:en_GB];
```
