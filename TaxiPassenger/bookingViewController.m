//
//  bookingViewController.m
//  Taxi App
//
//  Created by TechnoMac-12 on 27/06/16.
//  Copyright © 2016 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import "bookingViewController.h"

@interface bookingViewController ()

@end

@implementation bookingViewController
@synthesize objMapView,objLocationManager,dicRideInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    btnObjBook.layer.cornerRadius=btnObjBook.frame.size.height/2;
    
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:40.712784 longitude:-74.005941 zoom:20.0f];
    [objMapView setCamera:camera];
    [objMapView setMyLocationEnabled:YES];
    [objMapView animateToZoom:12.0f];
    [objMapView.settings setMyLocationButton:YES];
    [objMapView.settings setRotateGestures:NO];
    [objMapView setDelegate:self];
    objMapView.settings.myLocationButton =NO;
    
    
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
    if ([objLocationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [objLocationManager requestWhenInUseAuthorization];
    }else if ([objLocationManager respondsToSelector:@selector(requestAlwaysAuthorization)]){
        [objLocationManager requestAlwaysAuthorization];
    }
    // For Fetching Current Location
    [objMapView addObserver:self forKeyPath:@"myLocation" options:NSKeyValueObservingOptionNew context:nil];

        
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    [self.objMapView removeObserver:self forKeyPath:@"myLocation"];
}
-(void)viewWillAppear:(BOOL)animated
{
    
    isStopUpdate = NO;
    
    
    NSString *strCarId=[[NSUserDefaults standardUserDefaults]objectForKey:@"Key_CarId"];
    [[NSUserDefaults standardUserDefaults]setObject:strCarId forKey:@"btntag"];
    
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"btntag"]isEqualToString:@"1"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"VehicalSelect"];
        
        [btnBike setImage:[UIImage imageNamed:@"bike_red"] forState:UIControlStateNormal];
        [lblChange setText:NSLocalizedString(@"lbl_BIKE_MESSANGER",@" ")];
        [btnBarlingo setImage:[UIImage imageNamed:@"Berlingo"] forState:UIControlStateNormal];
        [btnBokTruk setImage:[UIImage imageNamed:@"boxtruck_gray"] forState:UIControlStateNormal];
        [btnVan setImage:[UIImage imageNamed:@"Van"] forState:UIControlStateNormal];
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"btntag"]isEqualToString:@"2"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:@"VehicalSelect"];
        [lblChange setText:NSLocalizedString(@"lbl_BIKE_MESSANGER",@" ")];
        
        [btnBarlingo setImage:[UIImage imageNamed:@"Berlingo_red"] forState:UIControlStateNormal];
        [btnBike setImage:[UIImage imageNamed:@"bike"] forState:UIControlStateNormal];
        [btnBokTruk setImage:[UIImage imageNamed:@"boxtruck_gray"] forState:UIControlStateNormal];
        [btnVan setImage:[UIImage imageNamed:@"Van"] forState:UIControlStateNormal];
        
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"btntag"]isEqualToString:@"3"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"3" forKey:@"VehicalSelect"];
        [lblChange setText:NSLocalizedString(@"lbl_BIKE_MESSANGER",@" ")];
        
        [btnBokTruk setImage:[UIImage imageNamed:@"boxtruck_gray"] forState:UIControlStateNormal];
        
        [btnBike setImage:[UIImage imageNamed:@"bike"] forState:UIControlStateNormal];
        [btnBarlingo setImage:[UIImage imageNamed:@"Berlingo"] forState:UIControlStateNormal];
        
        [btnVan setImage:[UIImage imageNamed:@"van_red"] forState:UIControlStateNormal];
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"btntag"]isEqualToString:@"4"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"4" forKey:@"VehicalSelect"];
        [lblChange setText:NSLocalizedString(@"lbl_BIKE_MESSANGER",@" ")];
        
        [btnVan setImage:[UIImage imageNamed:@"Van"] forState:UIControlStateNormal];
        
        [btnBike setImage:[UIImage imageNamed:@"bike"] forState:UIControlStateNormal];
        [btnBarlingo setImage:[UIImage imageNamed:@"Berlingo"] forState:UIControlStateNormal];
        [btnBokTruk setImage:[UIImage imageNamed:@"boxtruck_red"] forState:UIControlStateNormal];
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"btntag"]isEqualToString:@"5"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"5" forKey:@"VehicalSelect"];
        
        [lblChange setText:NSLocalizedString(@"lbl_TRUCK",@" ")];
        [btnBike setImage:[UIImage imageNamed:@"truck_red"] forState:UIControlStateNormal];
        btnBike.userInteractionEnabled=NO;
        [btnBarlingo setImage:[UIImage imageNamed:@"Berlingo"] forState:UIControlStateNormal];
        [btnBokTruk setImage:[UIImage imageNamed:@"boxtruck_gray"] forState:UIControlStateNormal];
        [btnVan setImage:[UIImage imageNamed:@"Van"] forState:UIControlStateNormal];
    }

    
}
#pragma mark GetAddressOfCameraPosition Methods..
-(void)GetAddressOfCameraPosition{
    if (isStopMoving == NO)
    {
        if (isPickupSelected == YES) {
            
            GMSGeocoder *geoCoder_ = [[GMSGeocoder alloc] init];
            
            [geoCoder_ reverseGeocodeCoordinate:coorCameraPosition completionHandler:^(GMSReverseGeocodeResponse *respones, NSError *error) {
                
                if([respones firstResult]){
                    //[btnPickupAddress setTitle:@"" forState:UIControlStateNormal];
                   // GMSAddress* address = [respones firstResult];
                   // NSString *fullAddress = [address.lines componentsJoinedByString:@", "];
                    
                   // lblPIckUp.text=fullAddress;
                   // NSString *strpicadd=[NSString stringWithFormat:@"%@",lblPIckUp.text];
                    //[[NSUserDefaults standardUserDefaults]setObject:strpicadd forKey:@"Key_PicupAdress"];
                    
                    
                    
                    
                    //CLLocationCoordinate2D coord = address.coordinate;
                    
                   // CoordPickup = [[NSString alloc] initWithFormat:@"%f,%f", coord.latitude,coord.longitude];
                    //[objActivityIndicator startAnimating];
                } else {
                    [btnPickupAddress setTitle:@"" forState:UIControlStateNormal];
                } if (error) {
                }
            }];
            
        }else if (isPickupSelected == NO){
            
            GMSGeocoder *geoCoder_ = [[GMSGeocoder alloc] init];
            
            [geoCoder_ reverseGeocodeCoordinate:coorCameraPosition completionHandler:^(GMSReverseGeocodeResponse *respones, NSError *error) {
                if([respones firstResult]){
                    if (isbooked==YES)
                    {
                       // [btnDestinationAddress setTitle:@"" forState:UIControlStateNormal];
                        //GMSAddress* address = [respones firstResult];
                       // NSString *fullAddress = [address.lines componentsJoinedByString:@", "];
                        
                       // lblDestination.text=fullAddress;
                       // NSString *strdesadd=[NSString stringWithFormat:@"%@",lblDestination.text];
                        //[[NSUserDefaults standardUserDefaults]setObject:strdesadd forKey:@"Key_DestinationAdress"];
                        
                        //CLLocationCoordinate2D coord = address.coordinate;
                       // CoordDestination = [[NSString alloc] initWithFormat:@"%f,%f", coord.latitude,coord.longitude];
                    }
                    
                } else {
                    [btnDestinationAddress setTitle:@"" forState:UIControlStateNormal];
                } if (error) {
                    
                }
            }];
        }
    }
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
      //  [btnPickupAddress setTitle:NSLocalizedString(@"btn_titpin", @"") forState:UIControlStateNormal];
        
        coorPickup = coor;
    }else if (isPickupSelected == NO){
        //[btnDestinationAddress setTitle:NSLocalizedString(@"btn_titpin", @"") forState:UIControlStateNormal];
        
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
#pragma mark- autocompleat delegate method
- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place
{
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
    // Do something with the selected place.
    NSLog(@"Place name %@", place.name);
    NSLog(@"Place address %@", place.formattedAddress);
    NSLog(@"Place attributions %@", place.attributions.string);
    NSLog(@"%f",place.coordinate.latitude);
    NSLog(@"%f",place.coordinate.longitude);
    if (tagAuto==1)
    {
        lblPIckUp.text=strAddress;
        //lblPIckUp.text=place.formattedAddress;
        //NSString *strpicadd=[NSString stringWithFormat:@"%@",lblPIckUp.text];
        coorPickup =place.coordinate;
        
        CLLocationCoordinate2D coord = place.coordinate;
        CoordPickup = [[NSString alloc] initWithFormat:@"%f,%f", coord.latitude,coord.longitude];
        
    }
    else
    {
        lblDestination.text=strAddress;
        //lblDestination.text=place.formattedAddress;
        // NSString *strdesadd=[NSString stringWithFormat:@"%@",lblDestination.text];
        
        coorDestination = place.coordinate;
        CLLocationCoordinate2D coord = place.coordinate;
        CoordDestination = [[NSString alloc] initWithFormat:@"%f,%f", coord.latitude,coord.longitude];
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
#pragma mark ButtonAction Methods..
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


- (IBAction)btnSelectVehicles:(UIButton *)sender
{
    //----
    
    if (sender.tag==1)
    {
        btntag=1;
        //[self apiCallforUpadetCarid];
        btnBike.userInteractionEnabled=YES;
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"btntag"];
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"VehicalSelect"];
        
        [btnBike setImage:[UIImage imageNamed:@"bike_red"] forState:UIControlStateNormal];
        [btnBarlingo setImage:[UIImage imageNamed:@"Berlingo"] forState:UIControlStateNormal];
        [btnBokTruk setImage:[UIImage imageNamed:@"boxtruck_gray"] forState:UIControlStateNormal];
        [btnVan setImage:[UIImage imageNamed:@"Van"] forState:UIControlStateNormal];
    }
    else if (sender.tag==2)
    {
        btnBike.userInteractionEnabled=YES;
        btntag=2;
        
        [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:@"VehicalSelect"];
        [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:@"btntag"];
        
       // [self apiCallforUpadetCarid];
        [lblChange setText:NSLocalizedString(@"lbl_BIKE_MESSANGER",@" ")];
        [btnBike setImage:[UIImage imageNamed:@"bike"] forState:UIControlStateNormal];
        [btnBarlingo setImage:[UIImage imageNamed:@"Berlingo_red"] forState:UIControlStateNormal];
        [btnBokTruk setImage:[UIImage imageNamed:@"boxtruck_gray"] forState:UIControlStateNormal];
        [btnVan setImage:[UIImage imageNamed:@"Van"] forState:UIControlStateNormal];
    }
    else if (sender.tag==3)
    {
        btnBike.userInteractionEnabled=YES;
        btntag=3;
        //[self apiCallforUpadetCarid];
        [[NSUserDefaults standardUserDefaults]setObject:@"3" forKey:@"VehicalSelect"];
        [[NSUserDefaults standardUserDefaults]setObject:@"3" forKey:@"btntag"];
        [lblChange setText:NSLocalizedString(@"lbl_BIKE_MESSANGER",@" ")];
        [btnBike setImage:[UIImage imageNamed:@"bike"] forState:UIControlStateNormal];
        [btnBarlingo setImage:[UIImage imageNamed:@"Berlingo"] forState:UIControlStateNormal];
        [btnBokTruk setImage:[UIImage imageNamed:@"boxtruck_gray"] forState:UIControlStateNormal];
        [btnVan setImage:[UIImage imageNamed:@"van_red"] forState:UIControlStateNormal];
    }
    else if (sender.tag==4)
    {
        btnBike.userInteractionEnabled=YES;
        btntag=4;
       // [self apiCallforUpadetCarid];
        [[NSUserDefaults standardUserDefaults]setObject:@"4" forKey:@"VehicalSelect"];
        [[NSUserDefaults standardUserDefaults]setObject:@"4" forKey:@"btntag"];
        
        [lblChange setText:NSLocalizedString(@"lbl_BIKE_MESSANGER",@" ")];
        [btnBike setImage:[UIImage imageNamed:@"bike"] forState:UIControlStateNormal];
        [btnBarlingo setImage:[UIImage imageNamed:@"Berlingo"] forState:UIControlStateNormal];
        [btnBokTruk setImage:[UIImage imageNamed:@"boxtruck_red"] forState:UIControlStateNormal];
        [btnVan setImage:[UIImage imageNamed:@"Van"] forState:UIControlStateNormal];
    }
    else if (sender.tag==5)
    {
        
        btnBike.userInteractionEnabled=YES;
        
        if (IPAD)
        {
            SelectVehicalViewController *objVc = [[SelectVehicalViewController alloc]initWithNibName:@"selectVehicalView_Ipad" bundle:nil];
            
            //////[timerUpdateAllDriver invalidate];
            
            [btnBike setImage:[UIImage imageNamed:@"bike"] forState:UIControlStateNormal];
            [btnBarlingo setImage:[UIImage imageNamed:@"Berlingo"] forState:UIControlStateNormal];
            [btnBokTruk setImage:[UIImage imageNamed:@"boxtruck_gray"] forState:UIControlStateNormal];
            [btnVan setImage:[UIImage imageNamed:@"Van"] forState:UIControlStateNormal];
            [self.navigationController pushViewController:objVc animated:NO];
        }
        else
        {
            SelectVehicalViewController *objVc = [[SelectVehicalViewController alloc]initWithNibName:@"SelectVehicalViewController" bundle:nil];
            
            //[timerUpdateAllDriver invalidate];
            
            [btnBike setImage:[UIImage imageNamed:@"bike"] forState:UIControlStateNormal];
            [btnBarlingo setImage:[UIImage imageNamed:@"Berlingo"] forState:UIControlStateNormal];
            [btnBokTruk setImage:[UIImage imageNamed:@"boxtruck_gray"] forState:UIControlStateNormal];
            [btnVan setImage:[UIImage imageNamed:@"Van"] forState:UIControlStateNormal];
            [self.navigationController pushViewController:objVc animated:NO];
        }
    }

    
    //----
    

}
#pragma ma CallApiFor Booking....

- (IBAction)btnClickBook:(id)sender {
    
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
    else{

    
        markerPickup = [GMSMarker markerWithPosition:coorPickup];
        markerPickup.icon = [UIImage imageNamed:@"pickup_pin.png"];
        markerPickup.map = objMapView;
        
        
        markerDestination = [GMSMarker markerWithPosition:coorDestination];
        markerDestination.icon = [UIImage imageNamed:@"destination_pin.png"];
        markerDestination.map = objMapView;
        
    [self setOriginLatitude:coorPickup.latitude OriginLongitude:coorPickup.longitude DestinationLatitude:coorDestination.latitude DestinationLongitude:coorDestination.longitude];
    
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

    }
    
}
@end
