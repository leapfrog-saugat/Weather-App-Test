//
//  WeatherData.m
//  Weather App test
//
//  Created by Saugat Gautam on 3/10/15.
//  Copyright (c) 2015 Saugat Gautam. All rights reserved.
//

#import "WeatherData.h"
#import "WeatherRequestData.h"



@implementation WeatherData

- (instancetype)initWithValue{
    self = [super init];
    [self storeData];
    
    
    NSString *keyRoot = @"data";
    NSString *keyCurrentWeatherSummary = @"current_condition";
    NSString *keyCurrentTempInC = @"temp_C";
    NSString *keyCurrentTempInF = @"temp_F";
    NSString *keyCurrentHumidity = @"humidity";
    NSString *keyWeatherInfo = @"weather";
    NSString *keyMaxTempC = @"maxtempC";
    NSString *keyMaxTempF = @"maxtempF";
    NSString *keyMinTempC = @"mintempC";
    NSString *keyMinTempF = @"mintempF";
    NSString *keyDate = @"date";
    
    NSInteger indexFirstDay = 0;
    NSInteger indexSecondDay = 1;
    NSInteger indexThirdDay = 2;
    NSInteger indexFourthDay = 3;
    NSInteger indexFifthDay = 4;

    
    NSDictionary *allWeatherInfo = [[NSDictionary alloc] initWithDictionary:[self fetchAllData]];
    NSDictionary *currentWeatherInfo = [[NSDictionary alloc] initWithDictionary:[self fetchCurrentData]];
    
    //[@"data"][@"weather"][1][@"maxtempC"]
    
    [self setCurrentDate:allWeatherInfo[keyWeatherInfo][indexFirstDay][keyDate]];
    
    NSInteger indexFirstValueInWeatherDescription = 0;
    [self setCurrentCondition:currentWeatherInfo[@"WeatherDesc"][indexFirstValueInWeatherDescription][@"value"]];
    [self setCurrentTemperatureC:currentWeatherInfo[keyCurrentTempInC]];
    [self setCurrentHumidity:currentWeatherInfo[keyCurrentHumidity]];
    [self setCurrentTemperatureF:currentWeatherInfo[keyCurrentTempInF]];
    [self setTodaysMaxTemperatureC:allWeatherInfo[keyWeatherInfo][indexFirstDay][keyMaxTempC]];
    [self setTodaysMaxTemperatureF:allWeatherInfo[keyWeatherInfo][indexFirstDay][keyMaxTempF]];
    
    [self setSecondDay:allWeatherInfo[keyWeatherInfo][indexSecondDay][keyDate]];

    return self;
}
- (void)storeData{
    _objWeatherRequestData = [WeatherRequestData staticWeatherRequestDataObject];
    [_objWeatherRequestData storeData];
}
- (NSDictionary*)fetchAllData{
    return [_objWeatherRequestData fetchAllData];
}
- (NSDictionary*)fetchCurrentData{
    return [_objWeatherRequestData fetchCurrentData];
}




@end
