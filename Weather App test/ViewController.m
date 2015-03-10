//
//  ViewController.m
//  Weather App test
//
//  Created by Saugat Gautam on 2/27/15.
//  Copyright (c) 2015 Saugat Gautam. All rights reserved.
//

#import "ViewController.h"
#import "WeatherRequestData.h"
#import "DisplayVC.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblCellLabel;


@property (strong, nonatomic) IBOutlet UIImageView *imageViewer;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrentTemp;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrentHumidity;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrentCondition;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrentLocation;
@property (weak, nonatomic) IBOutlet UILabel *tblViewLabel;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tblMainTable;

@property (strong, nonatomic) NSDictionary *weatherDataVC;

- (void) displayData:(NSDictionary*)weatherData;

@end

@implementation ViewController
//Testing TableViewController

NSArray *recipes;
NSArray *imageNames;

//--------------------------------------------------------------------------------------------------
- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:TRUE];
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Kathmandu-2.jpg"]];
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Testing TableViewController
    
    recipes = [NSArray arrayWithObjects:@"Today",@"Tomorrow",@"Wednesday", @"Thursday", nil];
    imageNames = [NSArray arrayWithObjects:@"cloud",@"Kathmandu-2", @"Kathmandu-2",nil];
    
    //----------------------------------------------------------------------------------------------
    
    
   
    

    
    NSLog(@"Store data called!!");
    WeatherRequestData *weatherData = [WeatherRequestData staticWeatherRequestDataObject];//Change this name
    [weatherData storeData];
    
    _weatherDataVC = [[NSDictionary alloc] initWithDictionary:[weatherData fetchCurrentData]];
    [self displayData:_weatherDataVC];
    
    NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
    
    [notification addObserver:self
                         selector:@selector(checkForChangeInModel:)
                             name:ModelChangeNotificationKey
                           object:nil];
        
    
    
}

- (void)checkForChangeInModel:(NSNotificationCenter*)notification{
    
    NSLog(@"Notification Received!!!");
    //[self setLblCurrentHumidity].text = @"test";
    __weak WeatherRequestData *weakWeatherData = [WeatherRequestData staticWeatherRequestDataObject];
    dispatch_async(dispatch_get_main_queue(),^{
        _weatherDataVC = [[NSDictionary alloc] initWithDictionary:[weakWeatherData fetchCurrentData]];
        [self displayData:_weatherDataVC];
        _lblCurrentHumidity.text = @"Testing Humidity";
        
    });
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Forecast";
}
//- (NSString *)tab
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [recipes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString* simpleTableIdentifier = @"SimpleTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];

//    if (cell == nil){
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
//    }
    
    tableView.backgroundColor = [UIColor clearColor];
    //tableView.alpha = 0.2;
   
    //cell.textLabel.textColor = [UIColor whiteColor];
    //cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row] ;
    //cell.textLabel.text = [NSString stringWithFormat:@"%@", [recipes objectAtIndex:indexPath.row]];
    //cell.textLabel.alpha = 1;
    //cell.textLabel.backgroundColor = [UIColor clearColor];
    
    
    //cell.imageView.image = [UIImage imageNamed:[imageNames objectAtIndex:indexPath.row]];
    //cell.imageView.alpha = 1;
    //cell.imageView.backgroundColor = [UIColor brownColor];
    
    cell.contentView.backgroundColor = [UIColor clearColor];
    //cell.contentView.
    UILabel *lblDay = (UILabel *)[cell viewWithTag:101];
    //lblDay.text = @"Label inside cell";
    lblDay.text = [NSString stringWithFormat:@"%@", [recipes objectAtIndex:indexPath.row]];
    UILabel *lblMaxTemperature = (UILabel *)[cell viewWithTag:102];
    lblMaxTemperature.text = @"23";
    UILabel *lblMinTemperature = (UILabel *)[cell viewWithTag:103];
    lblMinTemperature.text = @"9";
    
    
    
    
    
    
    
    
    
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)displayData:(NSDictionary*)weatherData{
    //[self displayImage];
    NSDictionary* currentWeatherDataDictionary = [[NSDictionary alloc] initWithDictionary:weatherData];
    _lblCurrentTemp.text = [NSString stringWithFormat:@"%@˚C",currentWeatherDataDictionary[@"temp_C"]];
    _lblCurrentHumidity.text = [NSString stringWithFormat:@"Humidity: %@", currentWeatherDataDictionary[@"humidity"]];
    
    _lblCurrentCondition.text = [NSString stringWithFormat:@"%@", currentWeatherDataDictionary[@"weatherDesc"][0][@"value"]];
    [self displayImage:currentWeatherDataDictionary[@"weatherDesc"][0][@"value"]];
    _lblCurrentLocation.text = [NSString stringWithFormat:@"%@", currentWeatherDataDictionary[@"query"]];
    
    
    
}
- (void)displayImage{
    
    NSString* requestString = @"https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQRyODs0KrvdfgfebATAE-sR0i7UXuW_N77-GYdrjw8CIE5DA8vIXCHuNn2";
    //NSString* requestString = [self weatherDictionary][@"data"][@"current_condition"][1][@"weatherIconUrl"];
    
    dispatch_queue_t backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(backgroundQueue,^{
        NSURL* url = [NSURL URLWithString:requestString];
        UIImage* image;
        NSData* data;
        
        // background process
        data = [NSData dataWithContentsOfURL:url];
        
        
        image = [UIImage imageWithData:data];
        dispatch_async(mainQueue,^{
            // _imageViewer = [[UIImageView alloc] initWithImage:image];
            //[_imageViewer setImage:image];
            //[_imageViewer setBackgroundColor:[UIColor redColor]];
        });
    });

    
}
- (void)displayImage:(NSString *)imageKey{
    UIImage *image;
    NSData *data;
    image = [UIImage imageNamed:@"cloud"];
    [_imageViewer setImage:image];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"SENDER: %@", sender);
    if ([[segue identifier] isEqual:@"asd"]){
    
        DisplayVC *object = [segue destinationViewController];
        object.str=@"asd";
        
    
    }
}

@end
