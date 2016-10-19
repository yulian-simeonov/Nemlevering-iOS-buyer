//
//  GetTaxi.m
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 3/17/15.
//  Copyright (c) 2015 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import "GetTaxi.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

@interface GetTaxi ()

@end

@implementation GetTaxi
@synthesize objMapView;
@synthesize viewRatingToDriver;
@synthesize objLocationManager;
#pragma mark - VIEWCONTROLLER'S METHOD
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    arrDriverMarkers = [[NSMutableArray alloc]init];
    
    UITapGestureRecognizer *letterTapRecognizer = [[UITapGestureRecognizer alloc]init];
    letterTapRecognizer.numberOfTapsRequired=1;
    letterTapRecognizer.delegate=self;
    [self.view addGestureRecognizer:letterTapRecognizer];
    [self.view setUserInteractionEnabled:YES];

    [self NotificationAlert];
    btntag=1;
    
    objbtnBook.layer.cornerRadius=objbtnBook.frame.size.height/2;
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"Key_Passenger_Id"]);
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    isAlerShow = YES;
    //isbooked=NO;
    // Cancel button
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"" style: UIBarButtonItemStylePlain target:self action:nil];
    
    // Set Default Camera Position on Map
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:40.712784 longitude:-74.005941 zoom:20.0f];
    [objMapView setCamera:camera];
    [objMapView setMyLocationEnabled:YES];
    [objMapView animateToZoom:12.0f];
    [objMapView.settings setMyLocationButton:YES];
    [objMapView.settings setRotateGestures:NO];
    [objMapView setDelegate:self];
    objMapView.settings.myLocationButton =NO;
    
    if (IS_IPHONE_6)
    {
        CGRect frame = lblRemainingTime.frame;
        frame.size.width -=25;
        lblRemainingTime.frame = frame;
    }
    else if (IS_IPHONE_6P)
    {
        CGRect frame = lblRemainingTime.frame;
        frame.size.width -=45;
        lblRemainingTime.frame = frame;
    }
    
    btnSetPickupLocation.layer.cornerRadius = 15.0;
    btnSetPickupLocation.layer.masksToBounds = YES;
    btnSetPickupLocation.layer.borderColor = [[UIColor whiteColor] CGColor];
    btnSetPickupLocation.layer.borderWidth = 1.0;
    
    lblRemainingTime.layer.cornerRadius = 15.0;
    lblRemainingTime.layer.masksToBounds = YES;
    lblRemainingTime.layer.borderColor = [[UIColor whiteColor] CGColor];
    lblRemainingTime.layer.borderWidth = 1.0;
    
    btnPickupAddress.layer.cornerRadius = 3.0;
    btnPickupAddress.layer.masksToBounds = YES;
    
    btnDestinationAddress.layer.cornerRadius = 3.0;
    btnDestinationAddress.layer.masksToBounds = YES;
    
    // Setup control using iOS7 tint Color
    viewRatingToDriver.backgroundColor  = [UIColor clearColor];
    viewRatingToDriver.starImage = [[UIImage imageNamed:@"star-template"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    viewRatingToDriver.starHighlightedImage = [[UIImage imageNamed:@"star-highlighted-template"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    viewRatingToDriver.maxRating = 5.0;
    viewRatingToDriver.delegate = self;
    viewRatingToDriver.horizontalMargin = 10.0;
    viewRatingToDriver.editable=YES;
    [viewRatingToDriver  setNeedsDisplay];
    viewRatingToDriver.tintColor = [UIColor greenColor];
    
    // Set Action Sheet on btnSelectCar
    objActionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"txt_carsedan", @""), NSLocalizedString(@"txt_carsuv", @""), NSLocalizedString(@"txt_carLux", @""), NSLocalizedString(@"txt_carlimo", @""), nil];
    objActionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [self.view addSubview:objActionSheet];
    
    
    
    
    // Set Notification Observer
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ShowRoute) name:@"ShowRoute" object:nil];
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:@"DriverRequest" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getDriverAndSendRequest) name:@"DriverRequest" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DriverArrived) name:@"DriverArrived" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(EndTrip) name:@"EndTrip" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(apiCallforClearNotificationumber) name:@"apiCallforClearNotificationumber" object:nil];
    
    if (IS_IPHONE_4S) {
        imgViewCenterPin.center = CGPointMake(objMapView.center.x, objMapView.center.y-37);
        
    }else if (IS_IPHONE_5){
        imgViewCenterPin.center = CGPointMake(objMapView.center.x, objMapView.center.y-25);
        
    }else if (IS_IPHONE_6){
        imgViewCenterPin.center = CGPointMake(objMapView.center.x, objMapView.center.y-18);
        
    }else if (IS_IPHONE_6P){
        imgViewCenterPin.center = CGPointMake(objMapView.center.x, objMapView.center.y-10);
    }
    
    objLocationManager = [[CLLocationManager alloc] init];
    objLocationManager.delegate = self;
    //    objLocationManager.distanceFilter = kCLDistanceFilterNone; //whenever we move
    objLocationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    objLocationManager.activityType = CLActivityTypeAutomotiveNavigation;
    [objLocationManager setPausesLocationUpdatesAutomatically:YES];
    
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([objLocationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [objLocationManager requestWhenInUseAuthorization];
    }else if ([objLocationManager respondsToSelector:@selector(requestAlwaysAuthorization)]){
        [objLocationManager requestAlwaysAuthorization];
    }
    
    objActivityIndicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
    objActivityIndicator.center = lblRemainingTime.center;
    [objActivityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [lblRemainingTime addSubview:objActivityIndicator];
    
    if (timerUpdateAllDriver)
    {
        [timerUpdateAllDriver invalidate];
        timerUpdateAllDriver = nil;
    }
    isTagDriver = NO;
    timerUpdateAllDriver = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(GetDriverList) userInfo:nil repeats:YES];
    [timerUpdateAllDriver fire];
    
    // Initial Set Boolean Values
    //    isSetPickupLocation = NO;
    //    isPickupSelected = NO;
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"VehicalSelect"]isEqualToString:@"1"])
    {
        [btnBike setImage:[UIImage imageNamed:@"bike_red"] forState:UIControlStateNormal];
    }
    //[[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"VehicalSelect"];
    
    
    [appdelegate.deckNavigationController.navigationBar addSubview:appdelegate.leftBarButtonForMenu];
    appdelegate.leftBarButtonForMenu.hidden = NO;
    
    // For Fetching Current Location
    [objMapView addObserver:self forKeyPath:@"myLocation" options:NSKeyValueObservingOptionNew context:nil];
//    [self GetDriverList];
    
    
    [self.navigationItem setTitle:NSLocalizedString(@"txt_bookde",@" ")];
}
-(void)viewWillAppear:(BOOL)animated
{
    
    NSString *strCarId=[[NSUserDefaults standardUserDefaults]objectForKey:@"Key_CarId"];
    [[NSUserDefaults standardUserDefaults]setObject:strCarId forKey:@"btntag"];
    
    if ([strCarId length]==0)
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"btntag"];
    }

    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"btntag"]isEqualToString:@"1"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"VehicalSelect"];
        if (timerUpdateAllDriver)
        {
            [timerUpdateAllDriver invalidate];
            timerUpdateAllDriver = nil;
        }
        isTagDriver = NO;
        timerUpdateAllDriver = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(GetDriverList) userInfo:nil repeats:YES];
        [timerUpdateAllDriver fire];
        [btnBike setImage:[UIImage imageNamed:@"bike_red"] forState:UIControlStateNormal];
        [lblChange setText:NSLocalizedString(@"lbl_BIKE_MESSANGER",@" ")];
        [btnBerlingo setImage:[UIImage imageNamed:@"Berlingo"] forState:UIControlStateNormal];
        [btnBozTuck setImage:[UIImage imageNamed:@"boxtruck_gray"] forState:UIControlStateNormal];
        [btnVan setImage:[UIImage imageNamed:@"Van"] forState:UIControlStateNormal];
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"btntag"]isEqualToString:@"2"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:@"VehicalSelect"];
         [lblChange setText:NSLocalizedString(@"lbl_BIKE_MESSANGER",@" ")];
        if (timerUpdateAllDriver)
        {
            [timerUpdateAllDriver invalidate];
            timerUpdateAllDriver = nil;
        }
        isTagDriver = NO;
        timerUpdateAllDriver = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(GetDriverList) userInfo:nil repeats:YES];
        [timerUpdateAllDriver fire];
        [btnBerlingo setImage:[UIImage imageNamed:@"Berlingo_red"] forState:UIControlStateNormal];
        [btnBike setImage:[UIImage imageNamed:@"bike"] forState:UIControlStateNormal];
        [btnBozTuck setImage:[UIImage imageNamed:@"boxtruck_gray"] forState:UIControlStateNormal];
        [btnVan setImage:[UIImage imageNamed:@"Van"] forState:UIControlStateNormal];
        
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"btntag"]isEqualToString:@"3"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"3" forKey:@"VehicalSelect"];
         [lblChange setText:NSLocalizedString(@"lbl_BIKE_MESSANGER",@" ")];
        if (timerUpdateAllDriver)
        {
            [timerUpdateAllDriver invalidate];
            timerUpdateAllDriver = nil;
        }
        isTagDriver = NO;
        timerUpdateAllDriver = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(GetDriverList) userInfo:nil repeats:YES];
        [timerUpdateAllDriver fire];
        [btnBozTuck setImage:[UIImage imageNamed:@"boxtruck_gray"] forState:UIControlStateNormal];
        
        [btnBike setImage:[UIImage imageNamed:@"bike"] forState:UIControlStateNormal];
        [btnBerlingo setImage:[UIImage imageNamed:@"Berlingo"] forState:UIControlStateNormal];
        
        [btnVan setImage:[UIImage imageNamed:@"van_red"] forState:UIControlStateNormal];
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"btntag"]isEqualToString:@"4"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"4" forKey:@"VehicalSelect"];
         [lblChange setText:NSLocalizedString(@"lbl_BIKE_MESSANGER",@" ")];
        if (timerUpdateAllDriver)
        {
            [timerUpdateAllDriver invalidate];
            timerUpdateAllDriver = nil;
        }
        isTagDriver = NO;
        timerUpdateAllDriver = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(GetDriverList) userInfo:nil repeats:YES];
        [timerUpdateAllDriver fire];
        [btnVan setImage:[UIImage imageNamed:@"Van"] forState:UIControlStateNormal];
        
        [btnBike setImage:[UIImage imageNamed:@"bike"] forState:UIControlStateNormal];
        [btnBerlingo setImage:[UIImage imageNamed:@"Berlingo"] forState:UIControlStateNormal];
        [btnBozTuck setImage:[UIImage imageNamed:@"boxtruck_red"] forState:UIControlStateNormal];
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"btntag"]isEqualToString:@"5"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"5" forKey:@"VehicalSelect"];
        if (timerUpdateAllDriver)
        {
            [timerUpdateAllDriver invalidate];
            timerUpdateAllDriver = nil;
        }
        isTagDriver = NO;
        timerUpdateAllDriver = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(GetDriverList) userInfo:nil repeats:YES];
        [timerUpdateAllDriver fire];
        
        [lblChange setText:NSLocalizedString(@"lbl_TRUCK",@" ")];
        [btnBike setImage:[UIImage imageNamed:@"truck_red"] forState:UIControlStateNormal];
        btnBike.userInteractionEnabled=NO;
        [btnBerlingo setImage:[UIImage imageNamed:@"Berlingo"] forState:UIControlStateNormal];
        [btnBozTuck setImage:[UIImage imageNamed:@"boxtruck_gray"] forState:UIControlStateNormal];
        [btnVan setImage:[UIImage imageNamed:@"Van"] forState:UIControlStateNormal];
    }

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark gestureRecognizer Methods
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    [appdelegate.deckController closeLeftViewAnimated:YES];
    return YES;
}

#pragma mark GetDriverList custome Methods
-(void)GetDriverList
{
    if (!isTagDriver) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSString *strPassengerId = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_Passenger_Id"];
            NSString *strPickLat = [NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
            NSString *strPickLong = [NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
            
            NSString *strSelectedCar = [[NSUserDefaults standardUserDefaults]objectForKey:@"VehicalSelect"];
            
            NSLog(@"%@",strSelectedCar);
            //#pragma mark - URL Change
            
            
            // URL Request String
            // NSString *requestURL = [NSString stringWithFormat:@"http://54.153.20.98/api/android/getnearestdriver.php?pass_lat=%@&passLong=%@&passenger_id=%@&car=%@",strPickLat,strPickLong,strPassengerId,strSelectedCar];
            
            NSString *strURL = [NSString stringWithFormat:@"%@getnearestdriver.php?pass_lat=%@&passLong=%@&passenger_id=%@&car=%@",strBaseANURL,strPickLat,strPickLong,strPassengerId,strSelectedCar];
            
            // Allocation of Array of Driver list
            arrDriverList = [[NSMutableArray alloc]init];
            
            // Show Progressbar in Main View
            //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            NSURL *url = [[NSURL alloc]initWithString:[strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            
            NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
            
            NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            
            NSString *charlieSendString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            charlieSendString = [charlieSendString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            charlieSendString = [charlieSendString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
            NSDictionary* json = [charlieSendString JSONValue];
            
            //NSLog(@"Json Fo%@",json);
            // Change This Code.
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [objMapView clear];
            });
            
            NSLog(@"%@",json);
            if ([json count]!=0)
            {
                // Temperory Array of Response
                NSArray *arrResponse = [json objectForKey:@"driver_list"];
                
                // Add Object in Main Array from Received Response Dictionary
                for (NSDictionary *dicDriver in arrResponse)
                {
                    // add object in Main Array
                    [arrDriverList addObject:dicDriver];
                    //                dispatch_async(dispatch_get_main_queue(), ^{
                    //
                    //                    [objMapView clear];
                    //                });
                    
                }
                
                for (int j = 0; j<[arrDriverList count]; j++)
                {
                    NSString *strLatitude = [NSString stringWithFormat:@"%@",[arrDriverList[j] objectForKey:@"driver_lat"]];
                    NSString *strLongitude = [NSString stringWithFormat:@"%@",[arrDriverList[j] objectForKey:@"driver_long"]];
                    
                    // Change This Code.
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        GMSMarker *allDriver = [GMSMarker markerWithPosition:CLLocationCoordinate2DMake([strLatitude floatValue], [strLongitude floatValue])];
                        
                        if ([strSelectedCar isEqual:@"1"])
                        {
                            allDriver.icon = [UIImage imageNamed:@"loc_bike_gray"];
                        }
                        if ([strSelectedCar isEqual:@"2"])
                        {
                            allDriver.icon = [UIImage imageNamed:@"loc_berlingo_gray"];
                        }
                        if ([strSelectedCar isEqual:@"3"])
                        {
                            allDriver.icon = [UIImage imageNamed:@"loc_van_gray"];
                        }
                        if ([strSelectedCar isEqual:@"4"])
                        {
                            allDriver.icon = [UIImage imageNamed:@"loc_box_truck_gray"];
                        }
                        if ([strSelectedCar isEqual:@"5"])
                        {
                            allDriver.icon = [UIImage imageNamed:@"loc_truck_gray"];
                        }
                        
                        allDriver.map = objMapView;
                    });
                }
            }
        });

    }
}

#pragma mark Smooch.io View and Setting Token
-(void)settingSmoochToken
{
    //SKTSettings* settings = [SKTSettings settingsWithAppToken:@"4x83tyb8px3rd3vfn03gr6lv9"];
    NSString *letterCode = [[NSLocale preferredLanguages] objectAtIndex:0];
    if ([letterCode containsString:@"da"])
    {
        SKTSettings* settings = [SKTSettings settingsWithAppToken:@"4rfs6ra2rk6d8aaj491e0kj7s"];
        settings.conversationAccentColor = [UIColor colorWithRed:145.0/255 green:45.0/255 blue:141.0/255 alpha:1.0];
        [Smooch initWithSettings:settings];

    }
    else
    {
        SKTSettings* settings = [SKTSettings settingsWithAppToken:@"6e2gjzvfp8pe0kuuo8587gvaq"];
        settings.conversationAccentColor = [UIColor colorWithRed:145.0/255 green:45.0/255 blue:141.0/255 alpha:1.0];
        [Smooch initWithSettings:settings];
    }
    [Smooch setUserFirstName:FirstName lastName:LastName];
    
    [Smooch show];
}

#pragma mark GetAddressOfCameraPosition Methods..

-(void)GetAddressOfCameraPosition
{
    if (isSetPickupLocation == YES)
    {
        NSMutableArray *allLocations = [[NSMutableArray alloc]init];
        CLLocation *myLoc = [[CLLocation alloc]initWithLatitude:coorPickup.latitude longitude:coorPickup.longitude];
        
        for (int j = 0; j<[arrDriverList count]; j++)
        {
            NSString *strLatitude = [NSString stringWithFormat:@"%@",[arrDriverList[j] objectForKey:@"driver_lat"]];
            NSString *strLongitude = [NSString stringWithFormat:@"%@",[arrDriverList[j] objectForKey:@"driver_long"]];
            
                //markerPickup = [GMSMarker markerWithPosition:CLLocationCoordinate2DMake([strLatitude floatValue], [strLongitude floatValue])];
            //            markerPickup.title = lblAddress.text;
            //            markerPickup.icon = [UIImage imageNamed:@"top-map.png"];
                    //   markerPickup.map = objMapView;
            
            CLLocation *loc = [[CLLocation alloc]initWithLatitude:[strLatitude floatValue] longitude:[strLongitude floatValue]];
            
            [allLocations addObject:loc];
        }
        
        CLLocation *closestLocation;
        CLLocationDistance closestLocationDistance = -1;
        
        for (CLLocation *location in allLocations)
        {
            if (!closestLocation)
            {
                closestLocation = location;
                closestLocationDistance = [myLoc distanceFromLocation:location];
                continue;
            }
            
            CLLocationDistance currentDistance = [myLoc distanceFromLocation:location];
            
            if (currentDistance < closestLocationDistance)
            {
                closestLocation = location;
                closestLocationDistance = currentDistance;
            }
        }
        
        // NSLog(@"%@",closestLocation);
#pragma mark - URL Change
        
        // Direction API of Google Maps
        NSString *str = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&radius=1000&sensor=true", closestLocation.coordinate.latitude, closestLocation.coordinate.longitude, coorPickup.latitude, coorPickup.longitude];
        
        // Encode String by NSUTF8String
        NSURL *url = [[NSURL alloc]initWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        // Create URL Reqest
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        
        // Get Response in Data Format
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
         {
             NSDictionary* json = [[NSDictionary alloc]init];
             
             @try
             {
                 // Get Response Dictionary
                 json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&connectionError];
             }
             @catch (NSException *exception)
             {
                 
             }
             @finally
             {
                 
             }
             if ([[json objectForKey:@"status"]isEqualToString:@"OK"])
             {
                 NSLog(@"%@",[[[[[[json objectForKey:@"routes"] objectAtIndex:0]objectForKey:@"legs"] objectAtIndex:0]objectForKey:@"duration"] objectForKey:@"text"]);
                 
                 [objActivityIndicator stopAnimating];
                 
                 lblRemainingTime.text = [NSString stringWithFormat:@"%@",[[[[[[json objectForKey:@"routes"] objectAtIndex:0]objectForKey:@"legs"] objectAtIndex:0]objectForKey:@"duration"] objectForKey:@"text"]];
             }
         }];
    }
    if (isPickupSelected == YES)
    {
        GMSGeocoder *geoCoder_ = [[GMSGeocoder alloc] init];
        
        CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
        [geocoder reverseGeocodeLocation:currentLocation
                       completionHandler:^(NSArray *placemarks, NSError *error) {
                           if (error){
                               NSLog(@"Geocode failed with error: %@", error);
                               return;
                           }
                           CLPlacemark *placemark = [placemarks objectAtIndex:0];
                           NSLog(@"placemark.ISOcountryCode %@",placemark.ISOcountryCode);
                           
                       }];
        
        [geoCoder_ reverseGeocodeCoordinate:coorCameraPosition completionHandler:^(GMSReverseGeocodeResponse *respones, NSError *error)
         {
             if([respones firstResult])
             {
//                 [btnPickupAddress setTitle:@"" forState:UIControlStateNormal];
//                 GMSAddress* address = [respones firstResult];
//                 NSString *fullAddress = [address.lines componentsJoinedByString:@", "];
//                 
//                lblPIckUp.text=fullAddress;
//                 NSString *strpicadd=[NSString stringWithFormat:@"%@",lblPIckUp.text];
//                [[NSUserDefaults standardUserDefaults]setObject:strpicadd forKey:@"Key_PicupAdress"];
//                CLLocationCoordinate2D coord = address.coordinate;
//            
//                CoordPickup = [[NSString alloc] initWithFormat:@"%f,%f", coord.latitude,coord.longitude];
//                 [objActivityIndicator startAnimating];
             }
             else
             {
                 [btnPickupAddress setTitle:@"" forState:UIControlStateNormal];
             }
             if (error)
             {
                //[[[UIAlertView alloc]initWithTitle:@"Taxi" message:@"Please check your internet connection." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
             }
         }];
    }
    else if (isPickupSelected == NO)
    {
        GMSGeocoder *geoCoder_ = [[GMSGeocoder alloc] init];
        
        [geoCoder_ reverseGeocodeCoordinate:coorCameraPosition completionHandler:^(GMSReverseGeocodeResponse *respones, NSError *error)
         {
             if([respones firstResult])
             {
                 if (isbooked==YES)
                 {
//                     [btnDestinationAddress setTitle:@"" forState:UIControlStateNormal];
//                     GMSAddress* address = [respones firstResult];
//                     NSString *fullAddress = [address.lines componentsJoinedByString:@", "];
//                     
//                     lblDestination.text=fullAddress;
//                     NSString *strdesadd=[NSString stringWithFormat:@"%@",lblDestination.text];
//                     [[NSUserDefaults standardUserDefaults]setObject:strdesadd forKey:@"Key_DestinationAdress"];
//                     
//                     
//                     
//                     CLLocationCoordinate2D coord = address.coordinate;
//                     CoordDestination = [[NSString alloc] initWithFormat:@"%f,%f", coord.latitude,coord.longitude];
                 }
             }
             else
             {
                 [btnDestinationAddress setTitle:@"" forState:UIControlStateNormal];
             }
             if (error)
             {
                 
             }
         }];
    }
}

#pragma mark CaDraw Polyline to Route Methods..

-(void)setOriginLatitude:(float)OriginLat OriginLongitude:(float)OriginLong DestinationLatitude:(float)DestLat DestinationLongitude:(float)DestLong
{
#pragma mark - URL Change
    // Direction API of Google Maps
    NSString *str = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&radius=1000&sensor=true", OriginLat, OriginLong, DestLat, DestLong];
    
    // Encode String by NSUTF8String
    NSURL *url = [[NSURL alloc]initWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    // Create URL Reqest
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    // Get Response in Data Format
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    // If any Error Occure store in Error
    NSError* error;
    
    // Get Response Dictionary
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    // Found routes from Array
    NSArray* latestRoutes = [json objectForKey:@"routes"];
    NSString *points;
    
    if ([latestRoutes count]!=0)
    {
        points=[[[latestRoutes objectAtIndex:0] objectForKey:@"overview_polyline"] objectForKey:@"points"];
    }
    
    if ([[json objectForKey:@"status"]isEqualToString:@"OK"])
    {
        @try
        {
            NSArray *temp = [self decodePolyLine:[points mutableCopy]];
            
            GMSMutablePath *path = [GMSMutablePath path];
            
            for(int idx = 0; idx < [temp count]; idx++)
            {
                CLLocation *location=[temp objectAtIndex:idx];
                [path addCoordinate:location.coordinate];
            }
            
            // create the polyline based on the array of points.
            GMSPolyline *rectangle = [GMSPolyline polylineWithPath:path];
            //        rectangle.strokeColor = [UIColor colorWithRed:255/255.f green:255/255.f blue:0/255.f alpha:1.0f];
            rectangle.strokeColor = [UIColor blackColor];
            //            rectangle.strokeColor = [UIColor colorWithRed:50/255.f green:150/255.f blue:225/255.f alpha:1.0f];
            rectangle.strokeWidth= 5.0;
            rectangle.map = objMapView;
            isTagDriver = YES;
            
            // Manage Bounds Area
            [self focusMapToShowAllMarkers];
        }
        @catch (NSException *exception)
        {
                [[[UIAlertView alloc]initWithTitle:appName message:@"We are unable to draw route, please try after sometime." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
        }
    }
}
- (void)focusMapToShowAllMarkers
{
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] init];
    NSArray *markerArray = @[markerPickup,markerDestination];
    for (GMSMarker *marker in markerArray)
    {
        bounds = [bounds includingCoordinate:marker.position];
    }
    [objMapView animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:50.0f]];
}

-(NSMutableArray *)decodePolyLine: (NSMutableString *)encoded
{
    [encoded replaceOccurrencesOfString:@"\\\\" withString:@"\\"
                                options:NSLiteralSearch
                                  range:NSMakeRange(0, [encoded length])];
    NSInteger len = [encoded length];
    NSInteger index = 0;
    NSMutableArray *array = [[NSMutableArray alloc] init] ;
    NSInteger lat=0;
    NSInteger lng=0;
    while (index < len)
    {
        NSInteger b;
        NSInteger shift = 0;
        NSInteger result = 0;
        do
        {
            b = [encoded characterAtIndex:index++] - 63;
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        NSInteger dlat = ((result & 1) ? ~(result >> 1) : (result >> 1));
        lat += dlat;
        shift = 0;
        result = 0;
        do
        {
            b = [encoded characterAtIndex:index++] - 63;
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        NSInteger dlng = ((result & 1) ? ~(result >> 1) : (result >> 1));
        lng += dlng;
        NSNumber *latitude = [[NSNumber alloc] initWithFloat:lat * 1e-5] ;
        NSNumber *longitude = [[NSNumber alloc] initWithFloat:lng * 1e-5] ;
        printf("[%f,", [latitude doubleValue]);
        printf("%f]", [longitude doubleValue]);
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:[latitude floatValue] longitude:[longitude floatValue]];
        [array addObject:loc];
    }
    return array;
}

#pragma mark Callapi For Clear Notification Methods..

-(void)apiCallforClearNotificationumber
{
    
    [self dismisAlert];
        //http://cargo.technostacks.com/android/badge_count_clear.php?user_type=1&&device_token=e82a8baacf7117e6d1c0b53bb925442d5dad1e5b283dbb5623840474593e156a
    
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
//    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    // URL Request String
     NSString *requestURL = [NSString stringWithFormat:@"%@badge_count_clear.php",strBaseANURL];
    
    // AFNetworking Request Manager
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    
    NSString *token=[[NSUserDefaults standardUserDefaults]valueForKey:@"Device_Token"];
    
    if ([token length]==0) {
        token = [NSString stringWithFormat:@"123456789010"];
    }
    
    NSDictionary *params = @{@"user_type":@"1", @"device_token":token};
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];

    [manager GET:requestURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // Set Progressbar hide from View
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        // Response Dictionary Received from API
        NSDictionary *dicResponse = responseObject;
        
        NSLog(@"%@",dicResponse);
        if ([[dicResponse objectForKey:@"status"]isEqualToString:@"1"])
        {
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Set Progressbar hide from View
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"%@",[error description]);
        
        
    }];
}
#pragma mark AlertController Methods...
-(void)alertWitheTitle:(NSString*)title andMessage:(NSString*)message {
    
    
    openpop = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:openpop animated:YES completion:nil];
    
//    [self performSelector:@selector(dismisAlert) withObject:nil afterDelay:5.0];
}

- (void)dismisAlert
{
    [openpop dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)actionSendRequestforRide
{
    NSString *strPickupLat = [[NSString alloc]init];
    NSString *strPickupLong = [[NSString alloc]init];
    
    if (CLLocationCoordinate2DIsValid(coorPickup))
    {
        strPickupLat = [NSString stringWithFormat:@"%f",coorPickup.latitude];
        strPickupLong = [NSString stringWithFormat:@"%f",coorPickup.longitude];
    }
    else
    {
        strPickupLat = [NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
        strPickupLong = [NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
    }
#pragma mark - URL Change
    
    // URL Request String
    //      NSString *requestURL = [NSString stringWithFormat:@"http://54.153.20.98/api/android/getnearestdriver.php"];
    
    NSString *strURL = [NSString stringWithFormat:@"%@getnearestdriver.php",strBaseANURL];
    
    // Show Progressbar in Main View
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // AFNetworking Request Manager
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *strPassengerId = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_Passenger_Id"];
    NSString *strSelectedCar =[[NSUserDefaults standardUserDefaults]objectForKey:@"VehicalSelect"];
    //[NSString stringWithFormat:@"%d",selectedCar];
    
    NSDictionary *params = @{@"pass_lat":strPickupLat,@"pass_long":strPickupLong,@"passenger_id":strPassengerId,@"car":strSelectedCar};
    
    // Set Acceptable Contenttype of Response
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:strURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         // Set Progressbar hide from View
         //        [MBProgressHUD hideHUDForView:self.view animated:YES];
         
         // Response Dictionary Received from API
         NSDictionary *dicResponse = responseObject;
         
         NSLog(@"%@",dicResponse);
         
         //[self setOriginLatitude:coorPickup.latitude OriginLongitude:coorPickup.longitude DestinationLatitude:coorDestination.latitude DestinationLongitude:coorDestination.longitude];
         
         NSArray *arrTemp = [dicResponse objectForKey:@"driver_list"];
         arrNearestDriver = [[NSMutableArray alloc]init];
         
         for (NSDictionary *tempDict in arrTemp)
         {
             [arrNearestDriver addObject:tempDict];
         }
         
         [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"Key_DriverArray_Index"];
         [[NSUserDefaults standardUserDefaults]synchronize];
         
         [self getDriverAndSendRequest];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         // Set Progressbar hide from View
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         
         NSLog(@"%@",[error description]);
         [self dismisAlert];
         // Show Alert if Request Session Failed
         UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"alert_nodriver", @"") message:NSLocalizedString(@"alert_neardr", @"") delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"alert_tryagin", @""),NSLocalizedString(@"alert_talk", @""), nil];

         alert.tag = 1000;
         [alert show];
        
         //imgViewCenterPin.hidden = NO;
     }];
}
-(void)getDriverAndSendRequest
{
    NSInteger intArrayIndex = [[NSUserDefaults standardUserDefaults]integerForKey:@"Key_DriverArray_Index"];
    
    if (intArrayIndex<[arrNearestDriver count])
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSString *strDriverFirstName = [[arrNearestDriver objectAtIndex:intArrayIndex] objectForKey:@"first_name"];
        NSString *strDriverLastName = [[arrNearestDriver objectAtIndex:intArrayIndex] objectForKey:@"last_name"];
        NSString *strImage = [NSString stringWithFormat:@"%@",[[arrNearestDriver objectAtIndex:intArrayIndex] objectForKey:@"image"]];
        NSString *strDriverName = [NSString stringWithFormat:@"%@ %@",strDriverFirstName, strDriverLastName];
        
        [[NSUserDefaults standardUserDefaults]setObject:strDriverName forKey:@"Key_Driver_Name"];
        [[NSUserDefaults standardUserDefaults]setObject:strImage forKey:@"Key_Driver_Image"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSString *strDriverId = [[arrNearestDriver objectAtIndex:intArrayIndex]objectForKey:@"driver_id"];
        NSString *strPassengerId = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_Passenger_Id"];
        NSString *strPickLat = [NSString stringWithFormat:@"%f",coorPickup.latitude];
        NSString *strPickLong = [NSString stringWithFormat:@"%f",coorPickup.longitude];
        
       
        // Set Current Date
        NSLocale* currentLocale = [NSLocale currentLocale];
         [[NSDate date] descriptionWithLocale:currentLocale];
    
         NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
         NSString *strCurrentDatetime=[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[NSDate date]]];
        
        NSString *encodedDateTime = [strCurrentDatetime stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSString *strPicAdd=[[NSUserDefaults standardUserDefaults] objectForKey:@"Key_PicupAdress"];
        NSString *strDesAdd=[[NSUserDefaults standardUserDefaults]objectForKey:@"Key_DestinationAdress"];
        
       
         NSRange stringRange = {0, MIN([strPicAdd length],40)};
            
            // adjust the range to include dependent chars
            stringRange = [strPicAdd rangeOfComposedCharacterSequencesForRange:stringRange];
            
            // Now you can create the short string
            NSString *shortString = [strPicAdd substringWithRange:stringRange];
        
        
        
        
         NSRange stringRange1 = {0, MIN([strDesAdd length],40)};
            
            // adjust the range to include dependent chars
            stringRange1 = [strDesAdd rangeOfComposedCharacterSequencesForRange:stringRange1];
            
            // Now you can create the short string
            NSString *shortString1 = [strDesAdd substringWithRange:stringRange1];
        
         NSString *encodedpicadd = [shortString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *encodedDescadd=[shortString1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        
        
        //[self sendRequestToDriver:strDriverId byPassenger:strPassengerId withPassengerLat:strPickLat PassengerLong:strPickLong pickupLocation:CoordPickup destinationLocation:CoordDestination withCurrentDatetime:encodedDateTime];
         [self sendRequestToDriver:strDriverId byPassenger:strPassengerId withPassengerLat:strPickLat PassengerLong:strPickLong pickupLocation:encodedpicadd destinationLocation:encodedDescadd withCurrentDatetime:encodedDateTime];
        
    }
    else
        
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self dismisAlert];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"alert_nodriver", @"") message:NSLocalizedString(@"alert_neardr", @"") delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"alert_tryagin", @""),NSLocalizedString(@"alert_talk", @""), nil];

        alert.tag = 1000;
        
       // imgViewCenterPin.hidden = NO;
//        
        //if (isAlerShow)
//        {
            [alert show];
//            isAlerShow = NO;
//        }
    }
}

-(void)sendRequestToDriver:(NSString *) strDriverId byPassenger:(NSString *) strPassengerId withPassengerLat:(NSString *) passLat PassengerLong:(NSString *) passLong pickupLocation:(NSString *) strpickupLocation destinationLocation:(NSString *) strdestinationLocation withCurrentDatetime:(NSString *) strdateTime
{
#pragma mark - URL Change
//    
//        NSString *pessengerID = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_Passenger_Id"];
//     NSString *url = [NSString stringWithFormat:@"http://54.153.20.98/api/android/ride_booking.php?pass_lat=%@&pass_long=%@&passenger_id=%@&driver_id=%@",passLat,passLong,strPassengerId,strDriverId];
    
    NSString *strURL = [NSString stringWithFormat:@"%@ride_booking.php?pass_lat=%@&pass_long=%@&passenger_id=%@&driver_id=%@&pick_up_location=%@&destination_location=%@&time_stamp=%@",strBaseANURL,passLat,passLong,strPassengerId,strDriverId,strpickupLocation,strdestinationLocation,strdateTime];
    
    
    NSData *responseData = [[NSData alloc]initWithContentsOfURL:[[NSURL alloc] initWithString:strURL]];
 
    NSString *strResponse = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSDictionary *dictResponse = [[NSDictionary alloc]initWithDictionary:[strResponse JSONValue]];
    NSLog(@"%@",dictResponse);
    
    NSString *status = [NSString stringWithFormat:@"%@",[dictResponse objectForKey:@"success"]];
    if ([status isEqualToString:@"1"])
    {
        
        
       [self alertWitheTitle:appName andMessage:NSLocalizedString(@"alert_pop", @"")];
        
        
    }
    else
    {
        NSInteger index = [[NSUserDefaults standardUserDefaults]integerForKey:@"Key_DriverArray_Index"];
        index ++;
        
        [[NSUserDefaults standardUserDefaults]setInteger:index forKey:@"Key_DriverArray_Index"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [self getDriverAndSendRequest];
    }
}

-(void)ShowRoute
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self dismisAlert];
    
    if (timerUpdateAllDriver) {
        [timerUpdateAllDriver invalidate];
        timerUpdateAllDriver = nil;
    }

    [btnRequestPickup setHidden:YES];
    [imgViewDriverProfile setHidden:NO];
    [lblDriverName setHidden:NO];
    [btnEnterPromoCode setHidden:NO];
    
    NSString *strImage = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_Driver_Image"];
    [imgViewDriverProfile setImageWithURL:[NSURL URLWithString:strImage] placeholderImage:[UIImage imageNamed:@"person-placeholder.jpg"]];
    
    [lblDriverName setText:[[NSUserDefaults standardUserDefaults] objectForKey:@"Key_Driver_Name"]];
    
    NSString *strDriverLat = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_Driver_Lat"];
    NSString *strDriverLong = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_Driver_Long"];
    CLLocation *loca = [[CLLocation alloc]initWithLatitude:markerPickup.position.latitude longitude:markerPickup.position.longitude];
    
    // CLLocation *loca = [[CLLocation alloc]initWithLatitude:markerDestination.position.latitude longitude:markerDestination.position.longitude];
    
    [objMapView clear];
    
    [self setOriginLatitude:[strDriverLat floatValue] OriginLongitude:[strDriverLong floatValue] DestinationLatitude:loca.coordinate.latitude DestinationLongitude:loca.coordinate.longitude];
    
   //[self setOriginLatitude:[strDriverLat floatValue] OriginLongitude:[strDriverLong floatValue] DestinationLatitude:loca.coordinate.latitude DestinationLongitude:loca.coordinate.longitude];
    
        //[self setOriginLatitude:[strDriverLat floatValue] OriginLongitude:[strDriverLong floatValue] DestinationLatitude:markerPickup.position.latitude DestinationLongitude:markerPickup.position.longitude];
    //[self setOriginLatitude:markerPickup.position.latitude OriginLongitude:markerPickup.position.longitude DestinationLatitude:loca.coordinate.latitude DestinationLongitude:loca.coordinate.longitude];
    
    markerPickup = [GMSMarker markerWithPosition:coorPickup];
    markerPickup.icon = [UIImage imageNamed:@"pickup_pin.png"];
    markerPickup.map = objMapView;
    
//    CLLocationCoordinate2D coorDriver = CLLocationCoordinate2DMake([strDriverLat floatValue], [strDriverLong floatValue]);
//    markerDriver = [GMSMarker markerWithPosition:coorDriver];
//    markerDriver.icon = [UIImage imageNamed:@"top-map.png"];
//    markerDriver.map = objMapView;

    
    //-----
//    [self setOriginLatitude:loca.coordinate.latitude OriginLongitude:loca.coordinate.longitude DestinationLatitude:coorDestination.latitude DestinationLongitude:coorDestination.longitude];
//    
//    markerDestination=[GMSMarker markerWithPosition:coorDestination];
//    markerDestination.icon = [UIImage imageNamed:@"destination_pin.png"];
//    markerDestination.map = objMapView;
    //------
    
//        CLLocationCoordinate2D coorDriver = CLLocationCoordinate2DMake([strDriverLat floatValue], [strDriverLong floatValue]);
//        markerDriver = [GMSMarker markerWithPosition:coorDriver];
    
#pragma mark Change Image Static
    //markerDriver.icon = [UIImage imageNamed:@"top-map.png"];
    //markerDriver.map = objMapView;
    
    if (timerUpdateRideLocation)
    {
        [timerUpdateRideLocation invalidate];
    }
    timerUpdateRideLocation = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(getRequestAcceptedDriverLocation) userInfo:nil repeats:YES];
}

-(void)getRequestAcceptedDriverLocation
{
    NSString *strDriverId = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_Driver_Id"];
    NSString *strPassengerId = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_Passenger_Id"];
#pragma mark - URL Change
    
    // Direction API of Google Maps
    // NSString *str = [NSString stringWithFormat:@"http://54.153.20.98/api/android/get_pass_updatedriverlocation.php?driver_id=%@&passenger_id=%@",strDriverId,strPassengerId];
    
    NSString *strURL = [NSString stringWithFormat:@"%@get_pass_updatedriverlocation.php?driver_id=%@&passenger_id=%@",strBaseANURL,strDriverId,strPassengerId];
    
    // Encode String by NSUTF8String
    NSURL *url = [[NSURL alloc]initWithString:[strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    // Create URL Reqest
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    // Get Response in Data Format
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        // Get Response Dictionary
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&connectionError];
        
        if ([[json objectForKey:@"status"]isEqualToString:@"1"]) {
            
            NSString *strLat = [json objectForKey:@"driver_lat"];
            NSString *strLong = [json objectForKey:@"driver_long"];
            
            float latLocation = [strLat floatValue];
            float longLocation = [strLong floatValue];
            
            CLLocationCoordinate2D target = CLLocationCoordinate2DMake(latLocation, longLocation);
            
            markerDriver.map = nil;
            markerDriver = [GMSMarker markerWithPosition:target];
            
            
#pragma mark - Change Image Static
            //markerDriver.icon = [UIImage imageNamed:@""];
            markerDriver.map = objMapView;
        }
    }];
}

-(void)DriverArrived
{
    [objMapView clear];
    imgViewCenterPin.hidden = YES;
    [self apiCallforClearNotificationumber];
    
    //    viewTabbar.hidden = YES;
    //    btnPickupLocation.hidden = YES;
    //    btnDestinationLocation.hidden = YES;
}

-(void)EndTrip
{
    viewInvoice.hidden = NO;
    NSString *strTripDuration = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_TripDuration"];
    NSString *strTripFare =[[NSUserDefaults standardUserDefaults]objectForKey:@"Key_TripFare"];
    NSString *strMyPromoCode = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_PromoCode"];
   // NSString *strBasePrice=[[NSUserDefaults standardUserDefaults]objectForKey:@"Key_BasePrice"];
    
    NSString *strDiscount;
    
    if ([strMyPromoCode length]!=0)
    {
        NSArray *arrPromoValue = [strMyPromoCode componentsSeparatedByString:@"."];
        NSLog(@"%@",[arrPromoValue objectAtIndex:0]);
        NSString *strFullPromo = [arrPromoValue objectAtIndex:0];
        
        strDiscount = [NSString stringWithFormat:@"%@.00",[strFullPromo substringFromIndex:5]];
        
        NSLog(@"%@",strDiscount);
        lblPromoCode.text = [NSString stringWithFormat:@"%@ : %@",NSLocalizedString(@"txt_prmcode", @""),strMyPromoCode];
        
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"Key_PromoCode"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    else
    {
        strDiscount = [NSString stringWithFormat:@"0.00"];
        lblPromoCode.text = NSLocalizedString(@"txt_nopromoappld", @"");
    }
    
    lblTripDuration.text = [NSString stringWithFormat:@"%@ :%@",NSLocalizedString(@"txt_tripd", @""),strTripDuration];
    
    //int totalFare = [strTripFare intValue] + [strDiscount intValue];
    
    lblTotalFare.text = [NSString stringWithFormat:@"%@ :%d.00",NSLocalizedString(@"txt_totalfar", @""),[strTripFare intValue]];
    lblDiscountRate.text = [NSString stringWithFormat:@"%@ :%@",NSLocalizedString(@"txt_dicount", @""),strDiscount];
    
    lblRideFare.text=[NSString stringWithFormat:@"%@",strTripFare];
    lblRideFare.textAlignment = NSTextAlignmentCenter;
    
}

#pragma mark - LOCATION SUPPORTING METHODS
// For Fetching Current Location
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if([keyPath isEqualToString:@"myLocation"])
    {
        CLLocation *location = [object myLocation];
        NSLog(@"Location, %@,", location);
        
        CLLocationCoordinate2D target = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
        currentLocation = location;
        
        [objMapView animateToLocation:target];
        [objMapView animateToZoom:10.0f];
        [objMapView removeObserver:self forKeyPath:@"myLocation"];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D target = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
    
    currentLocation = location;
    [objMapView animateToLocation:target];
}

// Calling When Camera Position Changed
- (void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position
{
    CGPoint point = mapView.center;
    CLLocationCoordinate2D coor = [mapView.projection coordinateForPoint:point];
    
    coorCameraPosition = coor;
    
    if (isPickupSelected == YES)
    {
        //lblPIckUp.text=NSLocalizedString(@"btn_titpin", @"");
        //[btnPickupAddress setTitle:NSLocalizedString(@"btn_titpin", @"") forState:UIControlStateNormal];
#pragma mark - Change
        //coorPickup = coor;
    }
    else if (isPickupSelected == NO)
    {
        // [btnDestinationAddress setTitle:NSLocalizedString(@"btn_titpin", @"") forState:UIControlStateNormal];
        //lblDestination.text=NSLocalizedString(@"btn_titpin", @"");
        
#pragma mark - Change
       // coorDestination = coor;
    }
    
    if (timerMapViewScroll)
    {
        [timerMapViewScroll invalidate];
    }
    
    timerMapViewScroll=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(GetAddressOfCameraPosition) userInfo:nil repeats:NO];
    
   
}
#pragma mark - GET RATING FROM DELEGATE METHOD
-(void)starsSelectionChanged:(EDStarRating *)control rating:(float)rating
{
    NSString *ratingString = [NSString stringWithFormat:@"%@:%.1f",NSLocalizedString(@"txt_rating", @"") ,rating];
    
    _strRatingValue = [NSString stringWithFormat:@"%.0f",rating];
    
    if( [control isEqual:viewRatingToDriver])
    {
        NSLog(@"%@",ratingString);
    }
    else
    {
        NSLog(@"%@",ratingString);
    }
}
#pragma mark- autocompleat delegate method
- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place
{
    
       // Do something with the selected place.
    NSLog(@"Place name %@", place.name);
    NSString *strAddress= [[NSString alloc] init];
    NSArray *arrString = [place.formattedAddress componentsSeparatedByString:@","];
    if (arrString.count > 2)
    {
        NSMutableArray *myarray = [NSMutableArray arrayWithArray:arrString];
        [myarray removeLastObject];
        [myarray removeLastObject];
        for (int a=0; a<myarray.count; a++)
        {
            if (a== myarray.count-1)
                strAddress = [strAddress stringByAppendingString:[NSString stringWithFormat:@"%@",[myarray objectAtIndex:a]]];
            
            else
                strAddress = [strAddress stringByAppendingString:[NSString stringWithFormat:@"%@,",[myarray objectAtIndex:a]]];
        }
    }
    else
    {
        strAddress = place.formattedAddress;
    }
    NSLog(@"%@",strAddress);
    NSLog(@"Place address %@", place.formattedAddress);
    NSLog(@"Place attributions %@", place.attributions.string);

    NSLog(@"%f",place.coordinate.latitude);
    NSLog(@"%f",place.coordinate.longitude);
    
    if (tagAuto==1)
    {
        lblPIckUp.text=strAddress;
        //lblPIckUp.text=place.formattedAddress;
        coorPickup =place.coordinate;
        NSString *strpicadd=[NSString stringWithFormat:@"%@",lblPIckUp.text];
        [[NSUserDefaults standardUserDefaults]setObject:strpicadd forKey:@"Key_PicupAdress"];
        CLLocationCoordinate2D coord = place.coordinate;
        CoordPickup = [[NSString alloc] initWithFormat:@"%f,%f", coord.latitude,coord.longitude];
        NSString *strpicup=[NSString stringWithFormat:@"%@",CoordPickup];
        [[NSUserDefaults standardUserDefaults]setObject:strpicup forKey:@"Key_Latitude"];
    }
    else
    {
        lblDestination.text=strAddress;
        //lblDestination.text=place.formattedAddress;
        NSString *strdesadd=[NSString stringWithFormat:@"%@",lblDestination.text];
        coorDestination = place.coordinate;
        [[NSUserDefaults standardUserDefaults]setObject:strdesadd forKey:@"Key_DestinationAdress"];
        CLLocationCoordinate2D coord = place.coordinate;
        CoordDestination = [[NSString alloc] initWithFormat:@"%f,%f", coord.latitude,coord.longitude];
        NSString *strDestination=[NSString stringWithFormat:@"%@",CoordDestination];
        [[NSUserDefaults standardUserDefaults]setObject:strDestination forKey:@"Key_Logitude"];
    }
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (void)viewController:(GMSAutocompleteViewController *)viewController
didFailAutocompleteWithError:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"Error: %@", [error description]);
}
- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
- (void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
#pragma  mark ButtonAction Methods.
-(IBAction)tabbtnPressed:(UIButton *)sender
{
    
    if (sender.tag==1)
    {
        btntag=1;
        
        [self apiCallforUpadetCarid];
        isTagDriver = NO;
        [self GetDriverList];
        btnBike.userInteractionEnabled=YES;
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"btntag"];
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"VehicalSelect"];
        [btnBike setImage:[UIImage imageNamed:@"bike_red"] forState:UIControlStateNormal];
        [btnBerlingo setImage:[UIImage imageNamed:@"Berlingo"] forState:UIControlStateNormal];
        [btnBozTuck setImage:[UIImage imageNamed:@"boxtruck_gray"] forState:UIControlStateNormal];
        [btnVan setImage:[UIImage imageNamed:@"Van"] forState:UIControlStateNormal];
    }
    else if (sender.tag==2)
    {
        btnBike.userInteractionEnabled=YES;
        btntag=2;
        
        [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:@"VehicalSelect"];
        [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:@"btntag"];
        
        [self apiCallforUpadetCarid];
        isTagDriver = NO;
        [self GetDriverList];
        [lblChange setText:NSLocalizedString(@"lbl_BIKE_MESSANGER",@" ")];
        [btnBike setImage:[UIImage imageNamed:@"bike"] forState:UIControlStateNormal];
        [btnBerlingo setImage:[UIImage imageNamed:@"Berlingo_red"] forState:UIControlStateNormal];
        [btnBozTuck setImage:[UIImage imageNamed:@"boxtruck_gray"] forState:UIControlStateNormal];
        [btnVan setImage:[UIImage imageNamed:@"Van"] forState:UIControlStateNormal];
    }
    else if (sender.tag==3)
    {
        btnBike.userInteractionEnabled=YES;
        btntag=3;
        
        [[NSUserDefaults standardUserDefaults]setObject:@"3" forKey:@"VehicalSelect"];
        [[NSUserDefaults standardUserDefaults]setObject:@"3" forKey:@"btntag"];
        
        [self apiCallforUpadetCarid];
        isTagDriver = NO;
        [self GetDriverList];
        [lblChange setText:NSLocalizedString(@"lbl_BIKE_MESSANGER",@" ")];
        [btnBike setImage:[UIImage imageNamed:@"bike"] forState:UIControlStateNormal];
        [btnBerlingo setImage:[UIImage imageNamed:@"Berlingo"] forState:UIControlStateNormal];
        [btnBozTuck setImage:[UIImage imageNamed:@"boxtruck_gray"] forState:UIControlStateNormal];
        [btnVan setImage:[UIImage imageNamed:@"van_red"] forState:UIControlStateNormal];
    }
    else if (sender.tag==4)
    {
        btnBike.userInteractionEnabled=YES;
        btntag=4;
        [[NSUserDefaults standardUserDefaults]setObject:@"4" forKey:@"VehicalSelect"];
        [[NSUserDefaults standardUserDefaults]setObject:@"4" forKey:@"btntag"];
        [self apiCallforUpadetCarid];
        isTagDriver = NO;
        [self GetDriverList];

        [lblChange setText:NSLocalizedString(@"lbl_BIKE_MESSANGER",@" ")];
        [btnBike setImage:[UIImage imageNamed:@"bike"] forState:UIControlStateNormal];
        [btnBerlingo setImage:[UIImage imageNamed:@"Berlingo"] forState:UIControlStateNormal];
        [btnBozTuck setImage:[UIImage imageNamed:@"boxtruck_red"] forState:UIControlStateNormal];
        [btnVan setImage:[UIImage imageNamed:@"Van"] forState:UIControlStateNormal];
    }
    else if (sender.tag==5)
    {
        
        btnBike.userInteractionEnabled=YES;
        
        if (IPAD)
        {
            SelectVehicalViewController *objVc = [[SelectVehicalViewController alloc]initWithNibName:@"selectVehicalView_Ipad" bundle:nil];
            
//            [timerUpdateAllDriver invalidate];
            
            [btnBike setImage:[UIImage imageNamed:@"bike"] forState:UIControlStateNormal];
            [btnBerlingo setImage:[UIImage imageNamed:@"Berlingo"] forState:UIControlStateNormal];
            [btnBozTuck setImage:[UIImage imageNamed:@"boxtruck_gray"] forState:UIControlStateNormal];
            [btnVan setImage:[UIImage imageNamed:@"Van"] forState:UIControlStateNormal];
            [self.navigationController pushViewController:objVc animated:NO];
        }
        else
        {
            SelectVehicalViewController *objVc = [[SelectVehicalViewController alloc]initWithNibName:@"SelectVehicalViewController" bundle:nil];
            
          //  [timerUpdateAllDriver invalidate];
            
            [btnBike setImage:[UIImage imageNamed:@"bike"] forState:UIControlStateNormal];
            [btnBerlingo setImage:[UIImage imageNamed:@"Berlingo"] forState:UIControlStateNormal];
            [btnBozTuck setImage:[UIImage imageNamed:@"boxtruck_gray"] forState:UIControlStateNormal];
            [btnVan setImage:[UIImage imageNamed:@"Van"] forState:UIControlStateNormal];
            [self.navigationController pushViewController:objVc animated:NO];
        }
    }
}

-(void)apiCallforUpadetCarid
{
    NSString *requestURL = [NSString stringWithFormat:@"%@update_car.php",strBaseANURL];
    
    
    // Show Progressbar in Main View
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *strPassengerId = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_Passenger_Id"];
    NSString *strCarId=[NSString stringWithFormat:@"%d",btntag];
    
    if ([strCarId length]==0)
    {
        strCarId=@"1";
    }
    // AFNetworking Request Manager
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // Set Acceptable Contenttype of Response
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *params = @{@"passenger_id":strPassengerId,@"car_id":strCarId,@"user_update":@"1"};
    
    [manager GET:requestURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        
        [[NSUserDefaults standardUserDefaults]setObject:[responseObject objectForKey:@"car_id"] forKey:@"Key_CarId"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        [objMapView clear];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }];
}
- (IBAction)actionSelectCar:(id)sender
{
    [objActionSheet showInView:self.view];
}

//- (IBAction)actionRequestPickup:(id)sender
//{
//    if (timerUpdateAllDriver)
//    {
//        [timerUpdateAllDriver invalidate];
//    }
//    
//    UIButton *button = (UIButton *)sender;
//    if ([button.titleLabel.text isEqualToString:NSLocalizedString(@"btn_pickh", @"")])
//    {
//        markerPickup = [GMSMarker markerWithPosition:coorPickup];
//        markerPickup.icon = [UIImage imageNamed:@"pickup_pin.png"];
//        markerPickup.map = objMapView;
//        
//        [button setTitle:NSLocalizedString(@"btn_reqdsh", @"") forState:UIControlStateNormal];
//        isPickupSelected = NO;
//        btnDestinationAddress.hidden = NO;
//        [self actionSendRequestforRide];
//        
//    }
//    else if ([button.titleLabel.text isEqualToString:NSLocalizedString(@"btn_reqdsh", @"")])
//    {
//        markerDestination = [GMSMarker markerWithPosition:coorDestination];
//        markerDestination.icon = [UIImage imageNamed:@"destination_pin.png"];
//        markerDestination.map = objMapView;
//        imgViewCenterPin.hidden = YES;
//        [button setTitle:NSLocalizedString(@"btn_reseth", @"") forState:UIControlStateNormal];
//        
//        // Fetch Location Path
//        [self setOriginLatitude:coorPickup.latitude OriginLongitude:coorPickup.longitude DestinationLatitude:coorDestination.latitude DestinationLongitude:coorDestination.longitude];
//        
//    }
//    else if ([button.titleLabel.text isEqualToString:NSLocalizedString(@"btn_reseth", @"")])
//    {
//        imgViewCenterPin.hidden = NO;
//        isPickupSelected = YES;
//        [button setTitle:NSLocalizedString(@"btn_pickh", @"") forState:UIControlStateNormal];
//        [objMapView clear];
//        
//        [UIView animateWithDuration:0.20 animations:^{
//            [objMapView animateToZoom:12.0f];
//            [btnSetPickupLocation setTitle:NSLocalizedString(@"txt_pickloc", @"") forState:UIControlStateNormal];
//            btnSetPickupLocation.hidden = NO;
//            isSetPickupLocation = YES;
//            isPickupSelected = YES;
//            lblRemainingTime.hidden = NO;
//            btnSelectCar.hidden = NO;
//            button.hidden = YES;
//            btnRequestPickup.hidden = YES;
//            btnDestinationAddress.hidden = YES;
//            
//            if (timerUpdateAllDriver)
//            {
//                [timerUpdateAllDriver invalidate];
//            }
//            
//            timerUpdateAllDriver = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(GetDriverList) userInfo:nil repeats:YES];
//        }];
//    }
//}
- (IBAction)actionSetPickupLocation:(id)sender
{
    UIButton *btnSender = (UIButton *)sender;
    [objMapView animateToZoom:16.0f];
    btnSelectCar.hidden = YES;
    btnRequestPickup.hidden = NO;
    btnSender.hidden = YES;
    lblRemainingTime.hidden = YES;
    isSetPickupLocation = NO;
}
- (IBAction)actionPickupAddress:(id)sender
{
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    tagAuto=1;
    
    [btnPickupAddress setTitle:@"" forState:UIControlStateNormal];
    isSetPickupLocation = YES;
    isPickupSelected =YES;
    btnDestinationAddress.userInteractionEnabled=YES;
    isbooked=NO;
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil]
     setDefaultTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIColor *WhiteColor = [UIColor whiteColor];
    NSDictionary *placeholderAttributes = @{
                                            NSForegroundColorAttributeName: WhiteColor,
                                            NSFontAttributeName : [UIFont systemFontOfSize:[UIFont systemFontSize]]
                                            };
    
    
    NSAttributedString *attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:@"Search"
                                    attributes:placeholderAttributes];
    
    if (IPAD)
    {
        
    }
    else
    {
        [UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]]
        .attributedPlaceholder = attributedPlaceholder;
    }
    
   
    
    [[UISearchBar appearance] setImage:[UIImage imageNamed:@"searchW"]
                      forSearchBarIcon:UISearchBarIconSearch
                                 state:UIControlStateNormal];
    
    
    
    [self presentViewController:acController animated:YES completion:nil];
}
- (IBAction)actionDestinationAddress:(id)sender
{
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    tagAuto=2;
    
    isPickupSelected =NO;
    isSetPickupLocation = NO;
    isbooked=YES;
    [btnDestinationAddress setTitle:@"" forState:UIControlStateNormal];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil]
     setDefaultTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIColor *WhiteColor = [UIColor whiteColor];
    NSDictionary *placeholderAttributes = @{
                                            NSForegroundColorAttributeName: WhiteColor,
                                            NSFontAttributeName : [UIFont systemFontOfSize:[UIFont systemFontSize]]
                                            };
    
    NSAttributedString *attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:@"Search"
                                    attributes:placeholderAttributes];
    
    if (IPAD)
    {
        
    }
    else
    {
        [UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]]
        .attributedPlaceholder = attributedPlaceholder;
    }
    
    
    [[UISearchBar appearance] setImage:[UIImage imageNamed:@"searchW"]
                      forSearchBarIcon:UISearchBarIconSearch
                                 state:UIControlStateNormal];
    
    
    [self presentViewController:acController animated:YES completion:nil];
}
- (IBAction)actionSubmit:(id)sender
{
    int rating = [_strRatingValue intValue];
    
    if (rating <= 4)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"alrt_comtitle", @"") message:NSLocalizedString(@"alrt_comtext", @"") delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"btn_Skip", @""),NSLocalizedString(@"btn_ok", @""),nil];
        [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
        alertView.tag = 1002;
        [alertView show];
    }else
    {
        [self sendRatingWithComment:@""];
    }
}

- (IBAction)actionEnterPromoCode:(id)sender {
    EnterPromoCode *objEnterPromoCode = [[EnterPromoCode alloc]initWithNibName:@"EnterPromoCode" bundle:nil];
    [appdelegate.deckNavigationController presentViewController:objEnterPromoCode animated:YES completion:nil];
}
- (IBAction)btnBookPressed:(id)sender
{
    if (timerUpdateAllDriver)
    {
        [timerUpdateAllDriver invalidate];
        timerUpdateAllDriver = nil;
    }
    
    tagAuto = YES;
    
    NSLog(@"%d",[timerUpdateAllDriver isValid]);
    
    if ([lblPIckUp.text length]==0)
    {
        
        [[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"title_setpk", @"") message:@"" delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles:nil]show];
        [btnPickupAddress setTitle:NSLocalizedString(@"title_setpk", @"") forState:UIControlStateNormal];
        [btnDestinationAddress setTitle:NSLocalizedString(@"title_dest", @"") forState:UIControlStateNormal];
        
    }
    
    else if([lblDestination.text length]==0)
    {
        [[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"title_dest", @"") message:@"" delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles:nil]show];
        [btnDestinationAddress setTitle:NSLocalizedString(@"title_dest", @"") forState:UIControlStateNormal];
    }
    else
    {
        if (isPickupSelected == YES)
        {
            isPickupSelected=NO;
            [objbtnBook setTitle:NSLocalizedString(@"btn_book", @"") forState:UIControlStateNormal];
            
            markerPickup = [GMSMarker markerWithPosition:coorPickup];
            markerPickup.icon = [UIImage imageNamed:@"pickup_pin.png"];
            markerPickup.map = objMapView;
            //btnPickupAddress.userInteractionEnabled=NO;
            btnDestinationAddress.userInteractionEnabled=YES;
            
            //[self actionSendRequestforRide];
        }
        else
        {
            isbooked=NO;
            markerDestination = [GMSMarker markerWithPosition:coorDestination];
            markerDestination.icon = [UIImage imageNamed:@"destination_pin.png"];
            markerDestination.map = objMapView;
            imgViewCenterPin.hidden = YES;
            
            markerPickup = [GMSMarker markerWithPosition:coorPickup];
            markerPickup.icon = [UIImage imageNamed:@"pickup_pin.png"];
            markerPickup.map = objMapView;
            
            // Fetch Location Path
            [self setOriginLatitude:coorPickup.latitude OriginLongitude:coorPickup.longitude DestinationLatitude:coorDestination.latitude DestinationLongitude:coorDestination.longitude];
            [self actionSendRequestforRide];
            
//            lblPIckUp.text=@"";
//            lblDestination.text=@"";
//            [btnPickupAddress setTitle:NSLocalizedString(@"title_setpk", @"") forState:UIControlStateNormal];
//            [btnDestinationAddress setTitle:NSLocalizedString(@"title_dest", @"") forState:UIControlStateNormal];
            
        }
    }
}
-(void)actionBookRide:(id)sender
{
    
    
}
-(void)sendRatingWithComment:(NSString *) comment
{
    if (timerUpdateAllDriver)
    {
        [timerUpdateAllDriver invalidate];
        timerUpdateAllDriver = nil;
    }
    isTagDriver = NO;
    timerUpdateAllDriver = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(GetDriverList) userInfo:nil repeats:YES];
    
    NSString *strTripId = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"Key_TripId"]];
#pragma mark - URL Change
    
    // URL String
    //  NSString *stringPost = [NSString stringWithFormat:@"http://54.153.20.98/api/android/pass_to_driver_rating.php"];
    
    NSString *strURL = [NSString stringWithFormat:@"%@pass_to_driver_rating.php",strBaseANURL];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // Set Acceptable Contenttype of Response
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSDictionary *params;
    
    if (_strRatingValue == nil)
    {
        _strRatingValue = @"";
    }
    
    if (([_strRatingValue length]!=0 && [strTripId length] !=0) || [comment length] !=0)
    {
        params = @{@"driver_rating":_strRatingValue,@"trip_id":strTripId,@"driver_comment":comment};
    }
    
    [manager GET:strURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         // Get Encoding Data in Dictionary
         NSDictionary *responseDictionary = responseObject;
        // [self setOriginLatitude:coorPickup.latitude OriginLongitude:coorPickup.longitude DestinationLatitude:coorDestination.latitude DestinationLongitude:coorDestination.longitude];
         NSLog(@"RatingResponse >>> %@",responseDictionary);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"alert_srvr", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles:nil]show];
     }];
    
    //    // URL Request
    //    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:stringPost]];
    //    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //
    //    // Conncection Block
    //    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler: ^(NSURLResponse *res, NSData *data, NSError *err) {
    //        //        [MBProgressHUD hideHUDForView:self.view animated:YES];
    //
    //        NSError *error;
    //
    //        // Get Encoding Data in Dictionary
    //        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    //        NSLog(@"%@",[error description]);
    //
    //        NSString *status = [NSString stringWithFormat:@"%@",[responseDictionary objectForKey:@"success"]];
    //        if ([status isEqualToString:@"1"]) {
    //
    //        }
    //        NSLog(@"%@",responseDictionary);
    //    }];
    
    //    if ([_strRatingValue length]!=0)
    //    {
    imgViewCenterPin.hidden = NO;
    isSetPickupLocation = NO;
    isPickupSelected = NO;
    
    lblPIckUp.text=@"";
    lblDestination.text=@"";
    [btnPickupAddress setTitle:NSLocalizedString(@"title_setpk", @"") forState:UIControlStateNormal];
    [btnDestinationAddress setTitle:NSLocalizedString(@"title_dest", @"") forState:UIControlStateNormal];
    //  [btnRequestPickup setTitle:NSLocalizedString(@"btn_pickh", @"") forState:UIControlStateNormal];
    [objMapView clear];
    viewInvoice.hidden = YES;
    // [imgViewDriverProfile setHidden:YES];
    // [lblDriverName setHidden:YES];
    // [btnEnterPromoCode setHidden:YES];
    
    [UIView animateWithDuration:0.20 animations:^{
        //            objMapView.padding = UIEdgeInsetsMake(0.0,0.0,0.0,0.0);
        [objMapView animateToZoom:12.0f];
        // [btnSetPickupLocation setTitle:NSLocalizedString(@"txt_pickloc", @"") forState:UIControlStateNormal];
        // btnSetPickupLocation.hidden = NO;
        // lblRemainingTime.hidden = NO;
        // btnSelectCar.hidden = NO;
        // btnRequestPickup.hidden = YES;
        //btnDestinationAddress.hidden = YES;
    }];
    // }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1000)
    {
        if (buttonIndex==0){
            
            
            [objMapView clear];
            
            if (timerUpdateAllDriver)
            {
                [timerUpdateAllDriver invalidate];
                timerUpdateAllDriver = nil;
            }
            isTagDriver = NO;
            timerUpdateAllDriver = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(GetDriverList) userInfo:nil repeats:YES];
            //[timerUpdateAllDriver fire];
            lblPIckUp.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"Key_PicupAdress"];
            lblDestination.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"Key_DestinationAdress"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [btnPickupAddress setTitle:@"" forState:UIControlStateNormal];
            [btnDestinationAddress setTitle:@"" forState:UIControlStateNormal];
        }
        else{
             [self settingSmoochToken];
            [objMapView clear];
            
            lblPIckUp.text=@"";
            lblDestination.text=@"";
            [btnPickupAddress setTitle:NSLocalizedString(@"title_setpk", @"") forState:UIControlStateNormal];
            [btnDestinationAddress setTitle:NSLocalizedString(@"title_dest", @"") forState:UIControlStateNormal];
            imgViewCenterPin.hidden = NO;
        }
    }
    else if (alertView.tag == 1002)
    {
        
        if (buttonIndex==0)
        {
            [objMapView clear];
            imgViewCenterPin.hidden = NO;
            isSetPickupLocation = NO;
            isPickupSelected = NO;
            lblPIckUp.text=@"";
            lblDestination.text=@"";
            [btnPickupAddress setTitle:NSLocalizedString(@"title_setpk", @"") forState:UIControlStateNormal];
            [btnDestinationAddress setTitle:NSLocalizedString(@"title_dest", @"") forState:UIControlStateNormal];
            viewInvoice.hidden = YES;
            [UIView animateWithDuration:0.20 animations:^{
                
                [objMapView animateToZoom:12.0f];
                
            }];
            
        }
        else
        {
            UITextField *textfield =  [alertView textFieldAtIndex:0];
            NSLog(@"%@",textfield.text);
            [self sendRatingWithComment:textfield.text];
            [objMapView clear];
        }
    }
}

//#pragma mark - ACTION SHEET DELEGATE
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
//    switch (buttonIndex) {
//        case 0:{
//            [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:@"VehicalSelect"];
//            [self GetDriverList];
//            [btnSelectCar setImage:[UIImage imageNamed:@"Sedan.png"] forState:UIControlStateNormal];
//            break;
//        }case 1:{
//            [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:@"VehicalSelect"];
//            [self GetDriverList];
//            [btnSelectCar setImage:[UIImage imageNamed:@"SUV.png"] forState:UIControlStateNormal];
//            break;
//        }case 2:{
//            [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:@"VehicalSelect"];
//            [self GetDriverList];
//            [btnSelectCar setImage:[UIImage imageNamed:@"Luxury.png"] forState:UIControlStateNormal];
//            break;
//        }case 3:{
//            [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:@"VehicalSelect"];
//            [self GetDriverList];
//            [btnSelectCar setImage:[UIImage imageNamed:@"Limo.png"] forState:UIControlStateNormal];
//            break;
//        }
//        default:
//        {
//            break;
//        }
//    }
//}
-(void)NotificationAlert
{
    //    // Let the device know we want to receive push notifications
    //    if ([UIApplication respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
    //    {
    //        // iOS 8 Notifications
    //        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
    //
    //        [[UIApplication sharedApplication] registerForRemoteNotifications];
    //    }else{
    //        // iOS < 8 Notifications
    //        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
    //         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
    //    }
    
    if([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] == NSOrderedDescending)
    {
        UIUserNotificationType types = UIUserNotificationTypeBadge |
        UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        
        UIUserNotificationSettings *mySettings =
        [UIUserNotificationSettings settingsForTypes:types categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeNone];
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge)];
    }
}
@end
