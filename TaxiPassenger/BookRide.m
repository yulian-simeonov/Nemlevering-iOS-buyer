//
//  BookRide.m
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 3/24/15.
//  Copyright (c) 2015 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import "BookRide.h"

@interface BookRide ()

@end

@implementation BookRide
@synthesize objMapView;
@synthesize isShowBookedRide;
@synthesize dicRideInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
     [self.navigationItem setTitle:NSLocalizedString(@"txt_bookde", @"")];
    
    if (isShowBookedRide == YES) {
        //[self.navigationItem setTitle:NSLocalizedString(@"title_setpk", @"")];
        [btnSetPickupLocation setHidden:YES];
        [viewBottom setHidden:YES];
        [imgViewCenterPin setHidden:YES];
        [btnPickupAddress setHidden:YES];
        [btnDestinationAddress setHidden:YES];
        [appdelegate.leftBarButtonForMenu setHidden:YES];
        
        if ([dicRideInfo count]!=0) {
            NSString *strPickupLat = [dicRideInfo objectForKey:@"pickup_lat"];
            NSString *strPickupLong = [dicRideInfo objectForKey:@"pickup_long"];
            NSString *strDestLat = [dicRideInfo objectForKey:@"destination_lat"];
            NSString *strDestLong = [dicRideInfo objectForKey:@"destination_long"];
            objMapView.frame = self.view.frame;
            
            if ([strDestLat isEqualToString:@"0.f"] || [strDestLong isEqualToString:@"0.f"] || [strDestLat length]==0 || [strDestLong length] == 0) {
                // Set Default Camera Position on Map
                GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[strPickupLat floatValue] longitude:[strPickupLong floatValue] zoom:20.0f];
                [objMapView setCamera:camera];
                [objMapView animateToZoom:12.0f];
                [objMapView.settings setRotateGestures:NO];
                
                coorPickup = CLLocationCoordinate2DMake([strPickupLat floatValue], [strPickupLong floatValue]);
                markerPickup = [GMSMarker markerWithPosition:coorPickup];
                markerPickup.icon = [UIImage imageNamed:@"pickup_pin.png"];
                markerPickup.map = objMapView;

            }else{
                // Set Default Camera Position on Map
                GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[strPickupLat floatValue] longitude:[strPickupLong floatValue] zoom:20.0f];
                [objMapView setCamera:camera];
                [objMapView animateToZoom:12.0f];
                [objMapView.settings setRotateGestures:NO];

                coorPickup = CLLocationCoordinate2DMake([strPickupLat floatValue], [strPickupLong floatValue]);
                markerPickup = [GMSMarker markerWithPosition:coorPickup];
                markerPickup.icon = [UIImage imageNamed:@"pickup_pin.png"];
                markerPickup.map = objMapView;
                
                coorDestination = CLLocationCoordinate2DMake([strDestLat floatValue], [strDestLong floatValue]);
                markerDestination = [GMSMarker markerWithPosition:coorDestination];
                markerDestination.icon = [UIImage imageNamed:@"destination_pin.png"];
                markerDestination.map = objMapView;
                
                // Fetch Location Path
                [self setOriginLatitude:coorPickup.latitude OriginLongitude:coorPickup.longitude DestinationLatitude:coorDestination.latitude DestinationLongitude:coorDestination.longitude];

            }
            
        }

    }else{
        // Set Action Sheet on btnSelectCar
       objActionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"txt_carsedan", @""), NSLocalizedString(@"txt_carsuv", @""), NSLocalizedString(@"txt_carLux", @""), NSLocalizedString(@"txt_carlimo", @""), nil];
        objActionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        [self.view addSubview:objActionSheet];
        
       

        // Set Default Camera Position on Map
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:40.712784 longitude:-74.005941 zoom:20.0f];
        [objMapView setCamera:camera];
        [objMapView setMyLocationEnabled:YES];
        [objMapView animateToZoom:12.0f];
        [objMapView.settings setMyLocationButton:YES];
        [objMapView.settings setRotateGestures:NO];
        [objMapView setDelegate:self];
        
        btnSetPickupLocation.layer.cornerRadius = 15.0;
        btnSetPickupLocation.layer.masksToBounds = YES;
        btnSetPickupLocation.layer.borderColor = [[UIColor whiteColor] CGColor];
        btnSetPickupLocation.layer.borderWidth = 1.0;
        
        if (IS_IPHONE_4S) {
            imgViewCenterPin.center = CGPointMake(objMapView.center.x, objMapView.center.y-37);
            
        }else if (IS_IPHONE_5){
            imgViewCenterPin.center = CGPointMake(objMapView.center.x, objMapView.center.y-25);
            
        }else if (IS_IPHONE_6){
            imgViewCenterPin.center = CGPointMake(objMapView.center.x, objMapView.center.y-18);
            
        }else if (IS_IPHONE_6P){
            imgViewCenterPin.center = CGPointMake(objMapView.center.x, objMapView.center.y-10);
            
        }
        
        // For Fetching Current Location
        
        isPickupSelected=YES;
        isStopMoving = NO;
    }
}
// Add This Code.
- (void)viewWillAppear:(BOOL)animated
{
    isStopUpdate = NO;
    [objMapView addObserver:self forKeyPath:@"myLocation" options:NSKeyValueObservingOptionNew context:nil];
}
// Change This Code.

- (void)dealloc
{
    [self.objMapView removeObserver:self forKeyPath:@"myLocation"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)actionBookRide:(id)sender{
    
#pragma mark - URL Change
    
    NSString *strPassengerId = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_Passenger_Id"];
    NSString *strDate = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_ReservationDate"];
    NSString *strPickLat = [NSString stringWithFormat:@"%f",coorPickup.latitude];
    NSString *strPickLong = [NSString stringWithFormat:@"%f",coorPickup.longitude];
    NSString *strDestLat = [NSString stringWithFormat:@"%f",coorDestination.latitude];
    NSString *strDestLong = [NSString stringWithFormat:@"%f",coorDestination.longitude];
    
    //NSString *strRequestURL = [NSString stringWithFormat:@"http://54.153.20.98/api/"];
    NSString *strURL = [NSString stringWithFormat:@"%@Passenger_profile/set_reservation.php",strBaseANURL];
    
    NSDictionary *params = @{@"passenger_id":strPassengerId,@"date":strDate,@"pickup_lat":strPickLat,@"pickup_long":strPickLong,@"destination_lat":strDestLat,@"destination_long":strDestLong};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // Set Acceptable Contenttype of Response
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];

    [manager GET:strURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        // Get Encoding Data in Dictionary
        NSDictionary *responseDictionary = responseObject;
        
        NSLog(@"ReservationDic >>> %@",responseDictionary);
        
        if ([[responseDictionary objectForKey:@"status"]isEqualToString:@"1"]) {
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            UIAlertView *altBooked = [[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"alrt_bkd", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles:nil];
            altBooked.tag = 1000;
            [altBooked show];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"alrt_bkderr", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles:nil]show];
    }];
    

//    @try {
//        NSString *strPassengerId = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_Passenger_Id"];
//        NSString *strDate = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_ReservationDate"];
//        NSString *strPickLat = [NSString stringWithFormat:@"%f",coorPickup.latitude];
//        NSString *strPickLong = [NSString stringWithFormat:@"%f",coorPickup.longitude];
//        NSString *strDestLat = [NSString stringWithFormat:@"%f",coorDestination.latitude];
//        NSString *strDestLong = [NSString stringWithFormat:@"%f",coorDestination.longitude];
//        
//        
//        // URL String
//        NSString *stringPost = [NSString stringWithFormat:@"http://54.153.20.98/api/android/Passenger_profile/set_reservation.php?passenger_id=%@&date=%@&pickup_lat=%@&pickup_long=%@&destination_lat=%@&destination_long=%@", strPassengerId, strDate,strPickLat,strPickLong,strDestLat,strDestLong];
//        
//        // URL Request
//        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:stringPost]];
//        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        
//        // Conncection Block
//        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler: ^(NSURLResponse *res, NSData *data, NSError *err) {
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//            
//            // Get Encoding Data in Dictionary
//            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//            
//            NSLog(@"Error >>> %@",[err description]);
//            
//            NSLog(@"ReservationDic >>> %@",responseDictionary);
//            
//            if ([[responseDictionary objectForKey:@"status"]isEqualToString:@"1"]) {
//                UIAlertView *altBooked = [[UIAlertView alloc]initWithTitle:@"HopOnRide" message:@"Your Ride reservation was booked successfully. \nHopOn would contact you soon." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                altBooked.tag = 1000;
//                [altBooked show];
//            }
//        }];
//    }
//    @catch (NSException *exception) {
//        
//    }
//    @finally {
//        
//    }
}

- (IBAction)actionSelectCar:(id)sender {
    [objActionSheet showInView:self.view];
}

- (IBAction)actionSetPickDestPoint:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    if ([button.titleLabel.text isEqualToString:NSLocalizedString(@"btn_pickh", @"")]) {
        markerPickup = [GMSMarker markerWithPosition:coorPickup];
        markerPickup.icon = [UIImage imageNamed:@"pickup_pin.png"];
        markerPickup.map = objMapView;
        
        [button setTitle:NSLocalizedString(@"btn_reqdsh", @"") forState:UIControlStateNormal];
        isPickupSelected = NO;
        btnDestinationAddress.hidden = NO;
        //[self.navigationItem setTitle:NSLocalizedString(@"title_dest", @"")];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: NSLocalizedString(@"title_bk", @"") style: UIBarButtonItemStylePlain target:self action:@selector(actionBookRide:)];

    } else if ([button.titleLabel.text isEqualToString:NSLocalizedString(@"btn_reqdsh", @"")]){
        markerDestination = [GMSMarker markerWithPosition:coorDestination];
        markerDestination.icon = [UIImage imageNamed:@"destination_pin.png"];
        markerDestination.map = objMapView;
        imgViewCenterPin.hidden = YES;
        [button setTitle:NSLocalizedString(@"btn_reseth", @"") forState:UIControlStateNormal];
        isStopMoving = YES;
        //[self.navigationItem setTitle:@"BESTIL DIN RIDE"];
        
        // Fetch Location Path
        [self setOriginLatitude:coorPickup.latitude OriginLongitude:coorPickup.longitude DestinationLatitude:coorDestination.latitude DestinationLongitude:coorDestination.longitude];
        
    }else if ([button.titleLabel.text isEqualToString:NSLocalizedString(@"btn_reqdsh", @"")]){
        imgViewCenterPin.hidden = NO;
        isPickupSelected = YES;
        [button setTitle:NSLocalizedString(@"btn_pickh", @"") forState:UIControlStateNormal];
        [objMapView clear];
        //[self.navigationItem setTitle:NSLocalizedString(@"title_setpk", @"")];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style: UIBarButtonItemStylePlain target:self action:nil];

        [UIView animateWithDuration:0.20 animations:^{
            [objMapView animateToZoom:12.0f];
            [btnSetPickupLocation setTitle:NSLocalizedString(@"txt_pickloc", @"") forState:UIControlStateNormal];
            btnSetPickupLocation.hidden = NO;
            isSetPickupLocation = YES;
            isPickupSelected = YES;
            btnSelectCar.hidden = NO;
            button.hidden = YES;
            btnRequestPickup.hidden = YES;
            btnDestinationAddress.hidden = YES;
        }];
    }
}

- (IBAction)actionSetPickupLocation:(id)sender {
    UIButton *btnSender = (UIButton *)sender;
    [objMapView animateToZoom:16.0f];
    btnSelectCar.hidden = YES;
    btnRequestPickup.hidden = NO;
    btnSender.hidden = YES;
    isSetPickupLocation = NO;
}

// Draw Polyline to Route
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
    
    if ([latestRoutes count]!=0) {
        points=[[[latestRoutes objectAtIndex:0] objectForKey:@"overview_polyline"] objectForKey:@"points"];
    }
    
    if ([[json objectForKey:@"status"]isEqualToString:@"OK"]) {
        @try {
            
            NSArray *temp = [self decodePolyLine:[points mutableCopy]];
            
            GMSMutablePath *path = [GMSMutablePath path];
            
            for(int idx = 0; idx < [temp count]; idx++)
            {
                CLLocation *location=[temp objectAtIndex:idx];
                
                [path addCoordinate:location.coordinate];
                
            }
            
            // create the polyline based on the array of points.
            GMSPolyline *rectangle = [GMSPolyline polylineWithPath:path];
            rectangle.strokeColor = [UIColor blackColor];
            rectangle.strokeWidth= 5.0;     
            rectangle.map = objMapView;
            
            // Manage Bounds Area
            [self focusMapToShowAllMarkers];
            
        }@catch (NSException *exception) {
            
        }
    }
}

- (void)focusMapToShowAllMarkers {
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] init];
    NSArray *markerArray = @[markerPickup,markerDestination];
    for (GMSMarker *marker in markerArray){
        bounds = [bounds includingCoordinate:marker.position];
    }
    [objMapView animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:50.0f]];
}

-(NSMutableArray *)decodePolyLine: (NSMutableString *)encoded {
    [encoded replaceOccurrencesOfString:@"\\\\" withString:@"\\"
                                options:NSLiteralSearch
                                  range:NSMakeRange(0, [encoded length])];
    NSInteger len = [encoded length];
    NSInteger index = 0;
    NSMutableArray *array = [[NSMutableArray alloc] init] ;
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
        NSNumber *latitude = [[NSNumber alloc] initWithFloat:lat * 1e-5] ;
        NSNumber *longitude = [[NSNumber alloc] initWithFloat:lng * 1e-5] ;
        printf("[%f,", [latitude doubleValue]);
        printf("%f]", [longitude doubleValue]);
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:[latitude floatValue] longitude:[longitude floatValue]];
        [array addObject:loc];
    }
    return array;
}

-(void)GetAddressOfCameraPosition{
    if (isStopMoving == NO) {
        if (isPickupSelected == YES) {
            
            GMSGeocoder *geoCoder_ = [[GMSGeocoder alloc] init];
            
            [geoCoder_ reverseGeocodeCoordinate:coorCameraPosition completionHandler:^(GMSReverseGeocodeResponse *respones, NSError *error) {
                
                if([respones firstResult]){
                    GMSAddress* address = [respones firstResult];
                    NSString *fullAddress = [address.lines componentsJoinedByString:@", "];
                    [btnPickupAddress setTitle:fullAddress forState:UIControlStateNormal];
                    
                } else {
                    [btnPickupAddress setTitle:@"" forState:UIControlStateNormal];
                } if (error) {
                }
            }];
            
        }else if (isPickupSelected == NO){
            
            GMSGeocoder *geoCoder_ = [[GMSGeocoder alloc] init];
            
            [geoCoder_ reverseGeocodeCoordinate:coorCameraPosition completionHandler:^(GMSReverseGeocodeResponse *respones, NSError *error) {
                if([respones firstResult]){
                    GMSAddress* address = [respones firstResult];
                    NSString *fullAddress = [address.lines componentsJoinedByString:@", "];
                    [btnDestinationAddress setTitle:fullAddress forState:UIControlStateNormal];
                    
                } else {
                    [btnDestinationAddress setTitle:@"" forState:UIControlStateNormal];
                } if (error) {
                    
                }
            }];
        }
    }
}

#pragma mark - ACTION SHEET DELEGATE
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:{
            [btnSelectCar setImage:[UIImage imageNamed:@"Sedan.png"] forState:UIControlStateNormal];
            break;
        }case 1:{
            [btnSelectCar setImage:[UIImage imageNamed:@"SUV.png"] forState:UIControlStateNormal];
            break;
        }case 2:{
            [btnSelectCar setImage:[UIImage imageNamed:@"Luxury.png"] forState:UIControlStateNormal];
            break;
        }case 3:{
            [btnSelectCar setImage:[UIImage imageNamed:@"Limo.png"] forState:UIControlStateNormal];
            break;
        }default:{
            break;
        }
    }
}

#pragma mark - LOCATION SUPPORTING METHODS
// For Fetching Current Location
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if([keyPath isEqualToString:@"myLocation"]) {
        CLLocation *location = [object myLocation];
        NSLog(@"Location, %@,", location);
        
        CLLocationCoordinate2D target = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
        currentLocation = location;
        
        if (!isStopUpdate) {
         
            [objMapView animateToLocation:target];
            [objMapView animateToZoom:10.0f];
            isStopUpdate = YES;
        }
       
        
        // Change This Code.
        //[self.objMapView removeObserver:self forKeyPath:@"myLocation"];
    }
}

// Calling When Camera Position Changed
- (void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position
{
    
    CGPoint point = mapView.center;
    CLLocationCoordinate2D coor = [mapView.projection coordinateForPoint:point];
    
    coorCameraPosition = coor;
    
    if (isPickupSelected == YES) {
        [btnPickupAddress setTitle:NSLocalizedString(@"btn_titpin", @"") forState:UIControlStateNormal];
        
        coorPickup = coor;
    }else if (isPickupSelected == NO){
        [btnDestinationAddress setTitle:NSLocalizedString(@"btn_titpin", @"") forState:UIControlStateNormal];
        
        coorDestination = coor;
    }
    
    if (timerMapViewScroll) {
        [timerMapViewScroll invalidate];
    }
    
    timerMapViewScroll=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(GetAddressOfCameraPosition) userInfo:nil repeats:NO];
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1000) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}
@end
