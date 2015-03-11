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
    NSString *keyHourly = @"hourly";
    
    NSInteger indexFirstDay = 0;
    NSInteger indexSecondDay = 1;
    NSInteger indexThirdDay = 2;
    NSInteger indexFourthDay = 3;
    NSInteger indexFifthDay = 4;
    
    NSInteger indexThirdHour = 2;

    
    NSDictionary *allWeatherInfo = [[NSDictionary alloc] initWithDictionary:[self fetchAllData]];
    NSDictionary *currentWeatherInfo = [[NSDictionary alloc] initWithDictionary:[self fetchCurrentData]];
    
    //[@"data"][@"weather"][1][@"maxtempC"]
    
    [self setCurrentDate:allWeatherInfo[keyWeatherInfo][indexFirstDay][keyDate]];
    
    NSInteger indexFirstValueInWeatherDescription = 0;
    
    //Current weather condition
    [self setCurrentCondition:currentWeatherInfo[@"WeatherDesc"][indexFirstValueInWeatherDescription][@"value"]];
    [self setCurrentTemperatureC:currentWeatherInfo[keyCurrentTempInC]];
    [self setCurrentHumidity:currentWeatherInfo[keyCurrentHumidity]];
    [self setCurrentTemperatureF:currentWeatherInfo[keyCurrentTempInF]];
    [self setTodaysMaxTemperatureC:allWeatherInfo[keyWeatherInfo][indexFirstDay][keyMaxTempC]];
    [self setTodaysMaxTemperatureF:allWeatherInfo[keyWeatherInfo][indexFirstDay][keyMaxTempF]];
    
    //Second day weather condition
    [self setSecondDay:allWeatherInfo[keyWeatherInfo][indexSecondDay][keyDate]];
    [self setSecondDayMaxTemperatureC:allWeatherInfo[keyWeatherInfo][indexSecondDay][keyMaxTempC]];
    [self setSecondDayMaxTemperatureF:allWeatherInfo[keyWeatherInfo][indexSecondDay][keyMaxTempF]];
    [self setSecondDayMinTemperatureC:allWeatherInfo[keyWeatherInfo][indexSecondDay][keyMinTempC]];
    [self setSecondDayMinTemperatureF:allWeatherInfo[keyWeatherInfo][indexSecondDay][keyMinTempF]];
    [self setSecondDayCondition:allWeatherInfo[keyWeatherInfo][indexSecondDay][keyHourly][indexThirdHour][@"weatherDesc"][0][@"value"]];
    
    //Third day weather condition
    [self setThirdDay:allWeatherInfo[keyWeatherInfo][indexThirdDay][keyDate]];
    [self setThirdDayMaxTemperatureC:allWeatherInfo[keyWeatherInfo][indexThirdDay][keyMaxTempC]];
    [self setThirdDayMaxTemperatureF:allWeatherInfo[keyWeatherInfo][indexThirdDay][keyMaxTempF]];
    [self setThirdDayMinTemperatureF:allWeatherInfo[keyWeatherInfo][indexThirdDay][keyMinTempC]];
    [self setThirdDayMinTemperatureC:allWeatherInfo[keyWeatherInfo][indexThirdDay][keyMinTempF]];
    [self setThirdDayCondition:allWeatherInfo[keyWeatherInfo][indexThirdDay][keyHourly][indexThirdHour][@"weatherDesc"][0][@"value"]];
    
    //Fourth day weather conditon
    [self setFourthDay:allWeatherInfo[keyWeatherInfo][indexFourthDay][keyDate]];
    [self setFourthDayMaxTemperatureC:allWeatherInfo[keyWeatherInfo][indexFourthDay][keyMaxTempC]];
    [self setFourthDayMaxTemperatureF:allWeatherInfo[keyWeatherInfo][indexFourthDay][keyMaxTempF]];
    [self setFourthDayMinTemperatureF:allWeatherInfo[keyWeatherInfo][indexFourthDay][keyMinTempC]];
    [self setFourthDayMinTemperatureC:allWeatherInfo[keyWeatherInfo][indexFourthDay][keyMinTempF]];
    [self setFourthDayCondition:allWeatherInfo[keyWeatherInfo][indexFourthDay][keyHourly][indexThirdHour][@"weatherDesc"][0][@"value"]];
    
    //Fifth day weather condition
    [self setFifthDay:allWeatherInfo[keyWeatherInfo][indexFifthDay][keyDate]];
    [self setFifthDayMaxTemperatureC:allWeatherInfo[keyWeatherInfo][indexFifthDay][keyMaxTempC]];
    [self setFifthDayMaxTemperatureF:allWeatherInfo[keyWeatherInfo][indexFifthDay][keyMaxTempF]];
    [self setFifthDayMinTemperatureF:allWeatherInfo[keyWeatherInfo][indexFifthDay][keyMinTempC]];
    [self setFifthDayMinTemperatureC:allWeatherInfo[keyWeatherInfo][indexFifthDay][keyMinTempF]];
    [self setFifthDayCondition:allWeatherInfo[keyWeatherInfo][indexFifthDay][keyHourly][indexThirdHour][@"weatherDesc"][0][@"value"]];
    
    //All day weather condition array
    _maxTempCArray = [[NSArray alloc] initWithObjects:_todaysMaxTemperatureC, _secondDayMaxTemperatureC, _thirdDayMaxTemperatureC, _fourthDayMaxTemperatureC, _fifthDayMaxTemperatureC, nil];

    return self;
}
+ (instancetype)staticWeatherDataObject{
    static WeatherData *obj = nil;
    if (!obj){
        obj = [[WeatherData alloc] initWithValue];
        
    }
    
    return obj;
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
