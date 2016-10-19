//
//  DriverLocationViewController.m
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 9/29/14.
//  Copyright (c) 2014 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import "DriverLocationViewController.h"

@interface DriverLocationViewController ()

@end

@implementation DriverLocationViewController
@synthesize latitude, longitude;

#pragma mark -VIEWCONTROLLER'S DELEGATE METHODS
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Cancel button
    UIBarButtonItem *btnCancel = [[UIBarButtonItem alloc] initWithTitle: @"" style: UIBarButtonItemStylePlain target: self action:nil];
    self.navigationItem.leftBarButtonItem = btnCancel;
    
    // Set Initial MapView
    if (!IS_IPHONE_5) {
        @try {
            GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude longitude:longitude zoom:15.0f];
            mapView_ = [GMSMapView mapWithFrame:CGRectMake(0, 64, 320, 366) camera:camera];
            mapView_.myLocationEnabled = YES;
            [mapView_ animateToZoom:15.0f];
            mapView_.delegate=self;
            [self.view addSubview:mapView_];
            
            markerPickup = [GMSMarker markerWithPosition:CLLocationCoordinate2DMake(latitude, longitude)];
            markerPickup.title = lblAddress.text;
            markerPickup.icon = [UIImage imageNamed:@"home_map_pin.png"];
            markerPickup.map = mapView_;
        }
        @catch (NSException *exception) {
            [[[UIAlertView alloc]initWithTitle:appName message:[exception description] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
        }
    }else {
        @try {
            GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude longitude:longitude zoom:15.0f];
            mapView_ = [GMSMapView mapWithFrame:CGRectMake(0, 64, 320, 454) camera:camera];
            mapView_.myLocationEnabled = YES;
            [mapView_ animateToZoom:15.0f];
            mapView_.delegate=self;
            [self.view addSubview:mapView_];
            
            markerPickup = [GMSMarker markerWithPosition:CLLocationCoordinate2DMake(latitude, longitude)];
            markerPickup.title = lblAddress.text;
            markerPickup.icon = [UIImage imageNamed:@"home_map_pin.png"];
            markerPickup.map = mapView_;
            
        }
        @catch (NSException *exception) {
            [[[UIAlertView alloc]initWithTitle:appName message:[exception description] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
        }
    }
    
    // set Driver Information View
//    viewDriverInfo = [[UIView alloc]initWithFrame:CGRectMake(0, 64, 320, 60)];
//    viewDriverInfo.backgroundColor = [UIColor colorWithRed:2/255.f green:124/255.f blue:225/255.f alpha:1.0f];
//    [self.view addSubview:viewDriverInfo];
//    [viewDriverInfo bringSubviewToFront:mapView_];
    
    UILabel *lblDriverName = [[UILabel alloc]initWithFrame:CGRectMake(90, 5, 200, 21)];
//    lblDriverName.text = strDriverName;
    [self.view addSubview:lblDriverName];
    
//    UIView *viewEmpty = [[UIView alloc]initWithFrame:CGRectMake(0, 126, 320, 7)];
//    viewEmpty.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:viewEmpty];
//    [viewEmpty bringSubviewToFront:mapView_];
    
    // set center PinView
//    imgCenterPin = [[UIImageView alloc]initWithFrame:CGRectMake(mapView_.frame.size.width/2, mapView_.frame.size.height/2, 14, 37)];
//    imgCenterPin.image = [UIImage imageNamed:@"home_map_pin.png"];
//    imgCenterPin.center = mapView_.center;
//    [self.view addSubview:imgCenterPin];
//    [imgCenterPin bringSubviewToFront:mapView_];
    
    // Label for Address above Center Pin
    lblAddress = [[UILabel alloc]initWithFrame:CGRectMake(70, 220, 230, 20)];
    lblAddress.font = [UIFont systemFontOfSize:12.0f];
    lblAddress.textColor = [UIColor lightGrayColor];
    lblAddress.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lblAddress];
    [lblAddress bringSubviewToFront:mapView_];
    
//    // Button for Selection
//    btnSelectLocation = [[UIButton alloc]initWithFrame:CGRectMake(120, 350, 80, 21)];
//    btnSelectLocation.titleLabel.font = [UIFont systemFontOfSize:15.0f];
//    [btnSelectLocation setTitle:@"Pickup" forState:UIControlStateNormal];
//    [btnSelectLocation.titleLabel setTextColor:[UIColor whiteColor]];
//    [btnSelectLocation setBackgroundColor:[UIColor darkGrayColor]];
//    [btnSelectLocation addTarget:self action:@selector(isLocationSelected:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btnSelectLocation];
//    [btnSelectLocation bringSubviewToFront:mapView_];
// For Fetching Current Location
//    [mapView_ addObserver:self forKeyPath:@"myLocation" options:NSKeyValueObservingOptionNew context:nil];
    
#pragma mark -SET TABBAR VIEW
    // Set Tabbar Image
    viewTabbar = [[UIView alloc]initWithFrame:CGRectMake(0, 518, 320, 50)];
    [viewTabbar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Bottom-Menu.png"]]];
    [self.view addSubview:viewTabbar];
    
    // Set Tabbar Search Button
    btnTabbarSearch = [[UIButton alloc]initWithFrame:CGRectMake(20, 15, 24, 24)];
    [btnTabbarSearch setBackgroundImage:[UIImage imageNamed:@"home_tabbar_search.png"] forState:UIControlStateNormal];
    [viewTabbar addSubview:btnTabbarSearch];
    
    // Set Tabbar Phone Button
    btnTabbarPhone = [[UIButton alloc]initWithFrame:CGRectMake(279, 15, 24, 24)];
    [btnTabbarPhone setBackgroundImage:[UIImage imageNamed:@"home_tabbar_phone.png"] forState:UIControlStateNormal];
    [viewTabbar addSubview:btnTabbarPhone];
    
    // Set Tabbar Select Car Popup Button
    btnSelectCar = [[UIButton alloc]initWithFrame:CGRectMake(122, -36, 76, 76)];
    [btnSelectCar setBackgroundImage:[UIImage imageNamed:@"Bottom icon.png"] forState:UIControlStateNormal];
    [viewTabbar addSubview:btnSelectCar];
}

-(void)viewWillAppear:(BOOL)animated {
    
//    gAppDelegate.lblTitleLabel.text = @"Taxi";
}

-(void)viewDidAppear:(BOOL)animated {
    
    if (!IS_IPHONE_5)
    {
        
        viewTabbar.frame = CGRectMake(0, 430, 320, 50);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -TEXTFIELD DELEGATE METHOD
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark -MAP DELEGATE & CUSTOM METHOD

// For Fetching Current Location
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"myLocation"]) {
        CLLocation *location = [object myLocation];
        NSLog(@"Location, %@,", location);
        
        CLLocationCoordinate2D target = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
        [mapView_ animateToLocation:target];
        [mapView_ animateToZoom:15];
    }
    
    [mapView_ removeObserver:self forKeyPath:@"myLocation"];
}

// Calling When Camera Position Changed
- (void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position{
    CGPoint point = mapView.center;
    CLLocationCoordinate2D coor = [mapView.projection coordinateForPoint:point];
    
    geoCoder_ = [[GMSGeocoder alloc] init];
    
    [geoCoder_ reverseGeocodeCoordinate:coor completionHandler:^(GMSReverseGeocodeResponse *respones, NSError *error) {
//            GMSAddress* address = [respones firstResult];
//            NSString* fullAddress = [address.lines componentsJoinedByString:@", "];
//            //            NSString *strAddress = [NSString stringWithFormat:@"%@, %@",address.thoroughfare, address.subLocality];
//            lblAddress.text = fullAddress;
//        } else {
//            lblAddress.text = @"";
//        }
//        if (error) {
//            [[[UIAlertView alloc]initWithTitle:@"Taxi" message:@"Please check your internet connection." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
//        }
    }];
}

// Draw Polyline to Route
-(void)setOriginLatitude:(float)OriginLat OriginLongitude:(float)OriginLong DestinationLatitude:(float)DestLat DestinationLongitude:(float)DestLong {
    
#pragma mark - URL Change
    
    NSString *str = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&radius=100&sensor=true", OriginLat, OriginLong, DestLat, DestLong];
    
    NSURL *url=[[NSURL alloc]initWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSArray* latestRoutes = [json objectForKey:@"routes"];
    
    NSString *points=[[[latestRoutes objectAtIndex:0] objectForKey:@"overview_polyline"] objectForKey:@"points"];
    
    if ([[json objectForKey:@"status"]isEqualToString:@"OK"]) {
        @try {
            NSArray *temp= [self decodePolyLine:[points mutableCopy]];
            
            GMSMutablePath *path = [GMSMutablePath path];
            
            for(int idx = 0; idx < [temp count]; idx++)
            {
                CLLocation *location=[temp objectAtIndex:idx];
                
                [path addCoordinate:location.coordinate];
                
            }
            
            // create the polyline based on the array of points.
            GMSPolyline *rectangle = [GMSPolyline polylineWithPath:path];
            //        rectangle.strokeColor = [UIColor colorWithRed:255/255.f green:255/255.f blue:0/255.f alpha:1.0f];
            //        rectangle.strokeColor = [UIColor purpleColor];
            rectangle.strokeColor = [UIColor colorWithRed:0/255.f green:100/255.f blue:0/255.f alpha:1.0f];
            rectangle.strokeWidth= 5.0;
            rectangle.map = mapView_;
            [self focusMapToShowAllMarkers];
        }
        @catch (NSException *exception) {
            [[[UIAlertView alloc]initWithTitle:appName message:[exception description] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
        }
    }
}

- (void)focusMapToShowAllMarkers {
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] init];
    NSArray *markerArray = @[markerPickup,markerDestination];
    for (GMSMarker *marker in markerArray) {
        bounds = [bounds includingCoordinate:marker.position];
    }
    
    [mapView_ animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:50.0f]];
}

-(NSMutableArray *)decodePolyLine: (NSMutableString *)encoded {
    [encoded replaceOccurrencesOfString:@"\\\\" withString:@"\\"
                                options:NSLiteralSearch
                                  range:NSMakeRange(0, [encoded length])];
    NSInteger len = [encoded length];
    NSInteger index = 0;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSInteger lat=0;
    NSInteger lng=0;
    while (index < len){
        NSInteger b;
        NSInteger shift = 0;
        NSInteger result = 0;
        do {
            b = [encoded characterAtIndex:index++] - 63;
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        NSInteger dlat = ((result & 1) ? ~(result >> 1) : (result >> 1));
        lat += dlat;
        shift = 0;
        result = 0;
        do {
            b = [encoded characterAtIndex:index++] - 63;
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        NSInteger dlng = ((result & 1) ? ~(result >> 1) : (result >> 1));
        lng += dlng;
        NSNumber *latitudeNum = [[NSNumber alloc] initWithFloat:lat * 1e-5];
        NSNumber *longitudeNum = [[NSNumber alloc] initWithFloat:lng * 1e-5];
        printf("[%f,", [latitudeNum doubleValue]);
        printf("%f]", [longitudeNum doubleValue]);
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:[latitudeNum floatValue] longitude:[longitudeNum floatValue]];
        [array addObject:loc];
    }
    return array;
}

@end
