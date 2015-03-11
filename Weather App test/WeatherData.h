//
//  WeatherData.h
//  Weather App test
//
//  Created by Saugat Gautam on 3/10/15.
//  Copyright (c) 2015 Saugat Gautam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherRequestData.h"

@interface WeatherData : NSObject
@property (nonatomic,weak, readonly) WeatherRequestData *objWeatherRequestData;

//Today's weather Condition
@property (nonatomic, weak, readwrite) NSString *currentDate;
@property (nonatomic, weak, readwrite) NSString *currentTemperatureC;
@property (nonatomic, weak, readwrite) NSString *currentTemperatureF;
@property (nonatomic, weak, readwrite) NSString *currentHumidity;
@property (nonatomic, weak, readwrite) NSString *currentCondition;
@property (nonatomic, weak, readwrite) NSString *todaysMaxTemperatureC;
@property (nonatomic, weak, readwrite) NSString *todaysMaxTemperatureF;
@property (nonatomic, weak, readwrite) NSString *todaysMinTemperatureC;
@property (nonatomic, weak, readwrite) NSString *todaysMinTemperatureF;

//@property to hold image

//Second day's weather condition
@property (nonatomic, weak, readwrite) NSString *secondDay;
@property (nonatomic, weak, readwrite) NSString *secondDayMaxTemperatureC;
@property (nonatomic, weak, readwrite) NSString *secondDayMaxTemperatureF;
@property (nonatomic, weak, readwrite) NSString *secondDayMinTemperatureC;
@property (nonatomic, weak, readwrite) NSString *secondDayMinTemperatureF;
@property (nonatomic, weak, readwrite) NSString *secondDayCondition;
//@property to hold image

//Third day's weather condition
@property (nonatomic, weak, readwrite) NSString *thirdDay;
@property (nonatomic, weak, readwrite) NSString *thirdDayMaxTemperatureC;
@property (nonatomic, weak, readwrite) NSString *thirdDayMaxTemperatureF;
@property (nonatomic, weak, readwrite) NSString *thirdDayMinTemperatureC;
@property (nonatomic, weak, readwrite) NSString *thirdDayMinTemperatureF;
@property (nonatomic, weak, readwrite) NSString *thirdDayCondition;
//@property to hold image

//Fourth day's weather condition
@property (nonatomic, weak, readwrite) NSString *fourthDay;
@property (nonatomic, weak, readwrite) NSString *fourthDayMaxTemperatureC;
@property (nonatomic, weak, readwrite) NSString *fourthDayMaxTemperatureF;
@property (nonatomic, weak, readwrite) NSString *fourthDayMinTemperatureC;
@property (nonatomic, weak, readwrite) NSString *fourthDayMinTemperatureF;
@property (nonatomic, weak, readwrite) NSString *fourthDayCondition;

//Fifth day's weather condition
@property (nonatomic, weak, readwrite) NSString *fifthDay;
@property (nonatomic, weak, readwrite) NSString *fifthDayMaxTemperatureC;
@property (nonatomic, weak, readwrite) NSString *fifthDayMaxTemperatureF;
@property (nonatomic, weak, readwrite) NSString *fifthDayMinTemperatureC;
@property (nonatomic, weak, readwrite) NSString *fifthDayMinTemperatureF;
@property (nonatomic, weak, readwrite) NSString *fifthDayCondition;

//All five days weather condition array
@property (nonatomic, strong, readwrite) NSArray *maxTempCArray;
@property (nonatomic, strong, readwrite) NSArray *minTempCArray;
@property (nonatomic, strong, readwrite) NSArray *maxTempFArray;
@property (nonatomic, strong, readwrite) NSArray *minTempFArray;

+ (instancetype)staticWeatherDataObject;




@end
