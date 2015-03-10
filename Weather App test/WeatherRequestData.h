//
//  WeatherData.h
//  Weather App test
//
//  Created by Saugat Gautam on 3/3/15.
//  Copyright (c) 2015 Saugat Gautam. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WeatherRequestData : NSObject
@property (nonatomic, strong, readwrite) NSMutableDictionary* weatherDictionary;
@property (nonatomic, strong, readwrite) NSMutableDictionary* weatherIconDictionary;
@property (nonatomic, weak, readwrite) NSURLSession* mySession;


+ (instancetype)staticWeatherRequestDataObject;
- (void)storeData;
- (NSDictionary*) fetchAllData;
- (NSDictionary*) fetchCurrentData;
extern NSString* const ModelChangeNotificationKey;



@end
