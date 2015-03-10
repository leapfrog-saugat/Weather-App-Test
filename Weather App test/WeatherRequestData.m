//
//  WeatherData.m
//  Weather App test
//
//  Created by Saugat Gautam on 3/3/15.
//  Copyright (c) 2015 Saugat Gautam. All rights reserved.
//

#import "WeatherRequestData.h"
NSString *const ModelChangeNotificationKey = @"FILE_WRITE_NOTIFICATION";

@implementation WeatherRequestData



+ (instancetype)staticWeatherRequestDataObject {
    static WeatherRequestData *data = nil;
    if (!data){
        data = [[WeatherRequestData alloc] initWithPrivate];
        
    }
    
    return data;
}

- (instancetype)initWithPrivate{
    self = [super init];
    
    [_weatherIconDictionary setValue:@"cloud" forKey:@"clear"];
    return self;
}

- (instancetype)init{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Singleton" userInfo:nil];
    return nil;
}
- (void)saveJsonWithData:(NSData *)data{
    
    NSString *jsonPath=[[NSSearchPathForDirectoriesInDomains(NSUserDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingFormat:@"/data.json"];
    
    [data writeToFile:jsonPath atomically:YES];
    
}
- (void)saveJsonWithData2:(NSDictionary*)weatherDictionary{
    
    //[NSJSONSerialization]
}

- (void)testingNotification{
    NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
    [notification postNotificationName:ModelChangeNotificationKey object:nil];
}

- (void)storeData{
    NSLog(@"Initiating store data");
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* mySession;
    mySession=  [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
    NSString* location = @"Kathmandu";
    NSString* requestString = [[@"https://api.worldweatheronline.com/free/v2/weather.ashx?q=" stringByAppendingString:location] stringByAppendingString:@"&key=4a4f3166bbe0bafdfa3c5eb5d6245&format=json"];
    
    NSURL* url = [NSURL URLWithString:requestString];
    NSURLRequest* req = [NSURLRequest requestWithURL:url];
    //NSLog(@"Request req = %@", req);
    
    //__weak WeatherData *weakSelf = self;
    //NSError *error;
    NSURLSessionDataTask* dataTask =[
                                     mySession
                                     dataTaskWithRequest:req
                                     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
                                         
                                         NSMutableDictionary *jsonObject = [[NSMutableDictionary alloc] init];
                                         jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                                         
                                         NSURL *documentsDirectoryURL = [[[NSFileManager defaultManager]
                                                                          URLsForDirectory:NSDocumentDirectory
                                                                          inDomains:NSUserDomainMask]
                                                                         lastObject];
                                         NSString *weatherDirectoryPath = [NSString stringWithFormat:@"%@",documentsDirectoryURL];
                                         NSString *weatherFilePath = [weatherDirectoryPath stringByAppendingPathComponent:@"weatherDataFormat.json"];
                                         //NSLog(@"Weather File Path : %@",weatherFilePath);
                                                                         
                                         //NSLog(@"Documents: %@",documentsDirectoryURL);
                                         
                                         
                                         //Creating or writing to a file in Documents directory
                                         
                                         NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
                                         NSString *filePath = [docDir stringByAppendingPathComponent:@"weatherDataFormat2.json"];
                                         
                                         
                                         NSFileManager *fm = [NSFileManager defaultManager];
                                         if([data length] != 0){
                                             if(![fm fileExistsAtPath:filePath])
                                             {
                                                 if([fm createFileAtPath:filePath contents:data attributes:nil]){
                                                     NSLog(@"Directory Created");
                                                     [data writeToFile:filePath atomically:YES];
                                                 }else
                                                     NSLog(@"Directory Creation Failed");
                                             }else{
                                                 NSLog(@"File already exists!!!");
                                                 [data writeToFile:filePath atomically:YES];
                                             }
                                         }else{
                                             NSLog(@"No internet connection");
                                         }
                                         NSLog(@"Inside the block");
                                         [self testingNotification];
                                         
                                         //-----------------------------------------------------
                                         
                                      }
                                     ];
    
    
    
    
    [dataTask resume];
    NSLog(@"Data storage complete!!!");
}
- (NSDictionary*) fetchAllData{
    
    //Reading from the file weatherDataFormat2.json
    NSMutableDictionary *jsonObjectReader = [[NSMutableDictionary alloc] init];
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *fileName = @"weatherDataFormat2.json";

    NSString *filePathReader = [documentsPath stringByAppendingPathComponent:fileName];
    
    NSData *JSONData = [NSData dataWithContentsOfFile:filePathReader options:NSDataReadingMappedIfSafe error:nil];
    //NSLog(@"%@",error);
    
    jsonObjectReader = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:nil];
    //Getting the dictionary with key nanmed "data" located inside the root dictionary jsonObjectReader
    NSString* rootKey = @"data";
    //Notice the rootKey variable!!!
    self.weatherDictionary = [[NSMutableDictionary alloc] initWithDictionary:jsonObjectReader[rootKey]] ;
    //NSLog(@"Json Object Reader : %@",jsonObjectReader);
    NSLog(@"Date %@",_weatherDictionary[@"weather"][1][@"maxtempC"]);
    
    return self.weatherDictionary;
}

- (NSDictionary*) fetchCurrentData{
    NSMutableDictionary* currentData = [[NSMutableDictionary alloc] initWithDictionary:[self fetchAllData][@"current_condition"][0]];
    [currentData setValuesForKeysWithDictionary:self.weatherDictionary[@"request"][0]];//Adding current loacation key value pairs to currentData dictionary.
    //NSLog(@"Current Condition : %@",currentData);
    
    
    return [currentData copy];
}

@end
