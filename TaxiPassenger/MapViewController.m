//
//  MapViewController.m
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 10/8/14.
//  Copyright (c) 2014 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import "MapViewController.h"
#define CardIOAppToken @"7d8580d2cc9f4e38a7cf3b6a1c142351"

@interface MapViewController ()

@end

@implementation MapViewController

#pragma mark -VIEWCONTROLLER'S DELEGATE METHODS
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //objBraintree = [Braintree braintreeWithClientToken:kToken];
    
    // Cancel button
    UIBarButtonItem *btnCancel = [[UIBarButtonItem alloc] initWithTitle: @"" style: UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem = btnCancel;
    
    // Set Initial MapView
    if (IS_IPHONE_4S) {
        [self setMapViewValueX:0 Y:0 Width:320 Height:366];
    }else if (IS_IPHONE_5){
        [self setMapViewValueX:0 Y:0 Width:320 Height:454];
    }else if (IS_IPHONE_6){
        [self setMapViewValueX:0 Y:0 Width:375 Height:553];
    }else if (IS_IPHONE_6P){
        [self setMapViewValueX:0 Y:0 Width:414 Height:622];
    }
    
    // set center PinView
    imgCenterPin = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/2, 14, 37)];
    imgCenterPin.image = [UIImage imageNamed:@"home_map_pin.png"];
    imgCenterPin.center = mapView_.center;
    [self.view addSubview:imgCenterPin];
    [imgCenterPin bringSubviewToFront:mapView_];
    
    // Label for Address above Center Pin
    lblAddress = [[UILabel alloc]initWithFrame:CGRectMake(50, 350, 220, 20)];
    lblAddress.font = [UIFont systemFontOfSize:12.0f];
    lblAddress.textColor = [UIColor blackColor];
    lblAddress.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lblAddress];
    [lblAddress bringSubviewToFront:mapView_];
    
    // Button for Selection
    btnSelectLocation = [[UIButton alloc]initWithFrame:CGRectMake(120, 400, 80, 21)];
    btnSelectLocation.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [btnSelectLocation setTitle:@"Pickup" forState:UIControlStateNormal];
    [btnSelectLocation.titleLabel setTextColor:[UIColor whiteColor]];
    [btnSelectLocation setBackgroundColor:[UIColor darkGrayColor]];
    [btnSelectLocation addTarget:self action:@selector(isLocationSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSelectLocation];
    [btnSelectLocation bringSubviewToFront:mapView_];
    
    // For Fetching Current Location
    [mapView_ addObserver:self forKeyPath:@"myLocation" options:NSKeyValueObservingOptionNew context:nil];
    
#pragma mark -SET TABBAR VIEW
    // Set Tabbar Image
    viewTabbar = [[UIView alloc]initWithFrame:CGRectMake(0, 518, 320, 50)];
    //    [viewTabbar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Bottom-Menu.png"]]];
    [viewTabbar setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewTabbar];
    
    imgLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 5)];
    [imgLine setImage:[UIImage imageNamed:@"Line.png"]];
    [viewTabbar addSubview:imgLine];
    
    // Set Tabbar Search Button
    btnTabbarSearch = [[UIButton alloc]initWithFrame:CGRectMake(20, 15, 24, 24)];
    [btnTabbarSearch setBackgroundImage:[UIImage imageNamed:@"home_tabbar_search.png"] forState:UIControlStateNormal];
    [btnTabbarSearch addTarget:self action:@selector(isTabbarSearchButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [viewTabbar addSubview:btnTabbarSearch];
    
    // Set Tabbar Phone Button
    btnTabbarPhone = [[UIButton alloc]initWithFrame:CGRectMake(279, 15, 24, 24)];
    [btnTabbarPhone setBackgroundImage:[UIImage imageNamed:@"home_tabbar_phone.png"] forState:UIControlStateNormal];
    [viewTabbar addSubview:btnTabbarPhone];
    
    // Set Tabbar Select Car Popup Button
    btnSelectCar = [[UIButton alloc]initWithFrame:CGRectMake(122, -36, 76, 76)];
    [btnSelectCar setBackgroundImage:[UIImage imageNamed:@"Bottom icon.png"] forState:UIControlStateNormal];
    [btnSelectCar addTarget:self action:@selector(isTabbarSelectCarButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [viewTabbar addSubview:btnSelectCar];
    
    // Set Action Sheet on btnSelectCar
    objActionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"CANCEL" destructiveButtonTitle:nil otherButtonTitles:@"LUXURY", @"SEDAN", @"LIMO", @"SUV", nil];
    objActionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [self.view addSubview:objActionSheet];
    [objActionSheet bringSubviewToFront:mapView_];
    
#pragma mark -SET SEARCH VIEW
    
    // Set Search View
    viewSearch = [[UIView alloc]initWithFrame:CGRectMake(0, 64, 320, 334)];
    [viewSearch setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"search_bg.png"]]];
    [self.view addSubview:viewSearch];
    [viewTabbar bringSubviewToFront:viewSearch];
    
    // Set Cancel Button
    btnSearchViewCancel = [[UIButton alloc]initWithFrame:CGRectMake(7, 10, 70, 40)];
    [btnSearchViewCancel setTitle:@"Cancel" forState:UIControlStateNormal];
    [btnSearchViewCancel setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btnSearchViewCancel addTarget:self action:@selector(isSearchViewCancel:) forControlEvents:UIControlEventTouchUpInside];
    [btnSearchViewCancel.titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue"  size:18.0]];
    [viewSearch addSubview:btnSearchViewCancel];
    
    // Set Search Label
    lblSearchLabel = [[UILabel alloc]initWithFrame:CGRectMake(86, 20, 160, 21)];
    [lblSearchLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:17.0]];
    [lblSearchLabel setText:@"Search"];
    [lblSearchLabel setTextAlignment:NSTextAlignmentCenter];
    [viewSearch addSubview:lblSearchLabel];
    
    // Set From Label
    lblFromLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 78, 38, 21)];
    [lblFromLabel setFont:[UIFont fontWithName:@"Helvetica Neue"  size:15.0]];
    [lblFromLabel setText:@"From"];
    [viewSearch addSubview:lblFromLabel];
    
    // Set From TextField
    txtPickupLocation = [[UITextField alloc]initWithFrame:CGRectMake(64, 76, 204, 21)];
    txtPickupLocation.placeholder = @"From";
    txtPickupLocation.delegate = self;
    [txtPickupLocation addTarget:self action:@selector(GetAddressbyAPI:) forControlEvents:UIControlEventEditingChanged];
    [viewSearch addSubview:txtPickupLocation];
    
    // Set Current Location Button
    btnCurrentLocation = [[UIButton alloc]initWithFrame:CGRectMake(275, 65, 45, 45)];
    [btnCurrentLocation setImage:[UIImage imageNamed:@"search_location_service.png"] forState:UIControlStateNormal];
    [btnCurrentLocation setBackgroundColor:[UIColor clearColor]];
    [viewSearch addSubview:btnCurrentLocation];
    
    // Set To Label
    lblToLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 120, 18, 21)];
    [lblToLabel setFont:[UIFont fontWithName:@"Helvetica Neue"  size:15.0]];
    [lblToLabel setText:@"To"];
    [viewSearch addSubview:lblToLabel];
    
    // Set To TextField
    txtDestinationLocation = [[UITextField alloc]initWithFrame:CGRectMake(64, 118, 204, 21)];
    txtDestinationLocation.placeholder = @"To";
    txtDestinationLocation.delegate = self;
    [txtDestinationLocation addTarget:self action:@selector(GetAddressbyAPI:) forControlEvents:UIControlEventEditingChanged];
    [viewSearch addSubview:txtDestinationLocation];
    
    // Set Scan Card Button
    btnScanCard = [[UIButton alloc]initWithFrame:CGRectMake(0, 224, 320, 54)];
    [btnScanCard.titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue"  size:20.0]];
    [btnScanCard setTitle:@"Scan your card" forState:UIControlStateNormal];
    [btnScanCard setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnScanCard setBackgroundImage:[UIImage imageNamed:@"payment_btn_cancel.png"] forState:UIControlStateNormal];
    [btnScanCard addTarget:self action:@selector(isScanCardButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [viewSearch addSubview:btnScanCard];
    
    // Set Reserve Button
    btnReserve = [[UIButton alloc]initWithFrame:CGRectMake(0, 280, 320, 54)];
    [btnReserve.titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue"  size:20.0]];
    [btnReserve setTitle:@"Reserve" forState:UIControlStateNormal];
    [btnReserve setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnReserve setBackgroundImage:[UIImage imageNamed:@"payment_btn_cancel.png"] forState:UIControlStateNormal];
    [btnReserve addTarget:self action:@selector(isReserveSelected:) forControlEvents:UIControlEventTouchUpInside];
    [viewSearch addSubview:btnReserve];
    
    // Set TableView for SearchData
    tblSearchView = [[UITableView alloc]init];
    tblSearchView.dataSource = self;
    tblSearchView.delegate = self;
    tblSearchView.alpha = 0;
    tblSearchView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tblSearchView.backgroundColor = [UIColor colorWithRed:2/255.f green:124/255.f blue:225/255.f alpha:1.0f];
    [viewSearch addSubview:tblSearchView];
    
    // Set View Search Alpha 0 for Initial Level
    viewSearch.alpha = 0;
    
}

-(void)viewWillAppear:(BOOL)animated{
    //    gAppDelegate.lblTitleLabel.text = @"Taxi";
}

-(void)viewDidAppear:(BOOL)animated {
    [self setUpLayouts];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -UITEXTFIELD DELEGATE METHOD
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    tblSearchView.alpha = 0;
    return YES;
}

#pragma mark -MAP DELEGATE & CUSTOM METHOD
-(void)setUpLayouts{
    
    if (IS_IPHONE_4S) {
        btnSelectCar.frame = CGRectMake(122, -36, 76, 76);
        viewTabbar.frame = CGRectMake(0, 366, 320, 50);
        imgLine.frame = CGRectMake(0, 0, 320, 5);
        btnTabbarPhone.frame = CGRectMake(279, 15, 24, 24);
        viewSearch.frame = CGRectMake(0, 64, 320, 334);
        btnReserve.frame = CGRectMake(0, 280, 320, 54);
        btnScanCard.frame = CGRectMake(0, 224, 320, 54);
        lblSearchLabel.frame = CGRectMake(86, 20, 160, 21);
        
    }else if (IS_IPHONE_5){
        btnSelectCar.frame = CGRectMake(122, -36, 76, 76);
        imgLine.frame = CGRectMake(0, 0, 320, 5);
        viewTabbar.frame = CGRectMake(0, 454, 320, 50);
        btnTabbarPhone.frame = CGRectMake(279, 15, 24, 24);
        viewSearch.frame = CGRectMake(0, 64, 320, 334);
        btnReserve.frame = CGRectMake(0, 280, 320, 54);
        btnScanCard.frame = CGRectMake(0, 224, 320, 54);
        lblSearchLabel.frame = CGRectMake(86, 20, 160, 21);
        
    }else if (IS_IPHONE_6){
        btnSelectCar.frame = CGRectMake(142, -36, 76, 76);
        imgLine.frame = CGRectMake(0, 0, 375, 5);
        viewTabbar.frame = CGRectMake(0, 553, 375, 50);
        btnTabbarPhone.frame = CGRectMake(326, 15, 24, 24);
        viewSearch.frame = CGRectMake(0, 64, 375, 334);
        btnReserve.frame = CGRectMake(0, 280, 375, 54);
        btnScanCard.frame = CGRectMake(0, 224, 375, 54);
        lblSearchLabel.frame = CGRectMake(100, 20, 160, 21);
        
    }else if (IS_IPHONE_6P){
        btnSelectCar.frame = CGRectMake(157, -36, 76, 76);
        imgLine.frame = CGRectMake(0, 0, 414, 5);
        viewTabbar.frame = CGRectMake(0, 622, 414, 50);
        btnTabbarPhone.frame = CGRectMake(360, 15, 24, 24);
        viewSearch.frame = CGRectMake(0, 64, 414, 334);
        btnReserve.frame = CGRectMake(0, 280, 414, 54);
        btnScanCard.frame = CGRectMake(0, 224, 414, 54);
        lblSearchLabel.frame = CGRectMake(111, 20, 160, 21);
        
    }
}

-(void)setMapViewValueX:(float)x Y:(float)y Width:(float)width Height:(float)height{
    @try {
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:40.712784 longitude:-74.005941 zoom:20.0f];   
        mapView_ = [GMSMapView mapWithFrame:CGRectMake(x, y, width, height) camera:camera];
        mapView_.myLocationEnabled = YES;
        [mapView_ animateToZoom:15.0f];
        //            mapView_.mapType = kGMSTypeHybrid;
        mapView_.settings.compassButton = YES;
        mapView_.delegate=self;
        [self.view addSubview:mapView_];
//        [self GetDriverList];
    }
    @catch (NSException *exception) {
        [[[UIAlertView alloc]initWithTitle:appName message:[exception description] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
    }
}

// For Fetching Current Location
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"myLocation"]) {
        CLLocation *location = [object myLocation];
        NSLog(@"Location, %@,", location);
        
        CLLocationCoordinate2D target = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
        [mapView_ animateToLocation:target];
        [mapView_ animateToZoom:5.0f];
    }
    [mapView_ removeObserver:self forKeyPath:@"myLocation"];
}

// Calling When Camera Position Changed
- (void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position{

    CGPoint point = mapView.center;
    CLLocationCoordinate2D coor = [mapView.projection coordinateForPoint:point];
    
    geoCoder_ = [[GMSGeocoder alloc] init];
    
    [geoCoder_ reverseGeocodeCoordinate:coor completionHandler:^(GMSReverseGeocodeResponse *respones, NSError *error) {
        if([respones firstResult]){
            if ([btnSelectLocation.titleLabel.text isEqualToString:@"Pickup"]) {
                coorPickup = coor;
            } else {
                coorDestination = coor;
            }
            
            GMSAddress* address = [respones firstResult];
            NSString* fullAddress = [address.lines componentsJoinedByString:@", "];
            //            NSString *strAddress = [NSString stringWithFormat:@"%@, %@",address.thoroughfare, address.subLocality];
            lblAddress.text = fullAddress;
        } else {
            lblAddress.text = @"";
        }
        
//        if (error) {
//            [[[UIAlertView alloc]initWithTitle:@"Taxi" message:@"Please check your internet connection." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
//        }
    }];
}

-(void)isLocationSelected:(id)sender {
    if (viewTabbar.hidden==YES) {
        viewTabbar.frame = CGRectMake(0, 618, 320, 50);
        viewTabbar.hidden = NO;
        if (IS_IPHONE_5) {
            [mapView_ setFrame:CGRectMake(0, 70, 320, 498)];
        }else{
            [mapView_ setFrame:CGRectMake(0, 70, 320, 410)];
        }
        
        [UIView animateWithDuration:0.5 animations:^{
            if ([viewTabbar isKindOfClass:[UIView class]]) {
                [viewTabbar setFrame:CGRectMake(viewTabbar.frame.origin.x, viewTabbar.frame.origin.y-100.f, viewTabbar.frame.size.width, viewTabbar.frame.size.height)];
                [mapView_ setFrame:CGRectMake(mapView_.frame.origin.x, mapView_.frame.origin.y, mapView_.frame.size.width, mapView_.frame.size.height-50)];
            }
            else {
                [viewTabbar setFrame:CGRectMake(viewTabbar.frame.origin.x, viewTabbar.frame.origin.y, viewTabbar.frame.size.width, viewTabbar.frame.size.height-100.f)];
                [mapView_ setFrame:CGRectMake(mapView_.frame.origin.x, mapView_.frame.origin.y, mapView_.frame.size.width, mapView_.frame.size.height-50)];
            }
        } completion:nil];
    }
    
    UIButton *button = (UIButton *)sender;
    if ([button.titleLabel.text isEqualToString:@"Pickup"]) {
        markerPickup = [GMSMarker markerWithPosition:coorPickup];
        markerPickup.title = lblAddress.text;
        markerPickup.icon = [UIImage imageNamed:@"home_map_pin.png"];
        markerPickup.map = mapView_;
        [button setTitle:@"Destination" forState:UIControlStateNormal];
    } else {
        markerDestination = [GMSMarker markerWithPosition:coorDestination];
        markerDestination.title = lblAddress.text;
        markerDestination.icon = [UIImage imageNamed:@"home_map_pin.png"];
        markerDestination.map = mapView_;
        button.hidden = YES;
        imgCenterPin.hidden=YES;
        lblAddress.hidden = YES;
        
        // Fetch Location Path
        [self setOriginLatitude:coorPickup.latitude OriginLongitude:coorPickup.longitude DestinationLatitude:coorDestination.latitude DestinationLongitude:coorDestination.longitude];
    }
}

- (void)isTabbarSearchButtonSelected:(id)sender {
    viewSearch.alpha = 1;
}

// Called When Select btnSelect Car from TabBar
- (void)isTabbarSelectCarButtonSelected:(id)sender{
    [objActionSheet showInView:self.view];
}

- (void)isSearchViewCancel:(id)sender {
    viewSearch.alpha = 0;
}

// Draw Polyline to Route
-(void)setOriginLatitude:(float)OriginLat OriginLongitude:(float)OriginLong DestinationLatitude:(float)DestLat DestinationLongitude:(float)DestLong{
#pragma mark - URL Change

    // Direction API of Google Maps
    NSString *str = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&radius=1000&sensor=true", OriginLat, OriginLong, DestLat, DestLong];
    
    // Encode String by NSUTF8String
    NSURL *url=[[NSURL alloc]initWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    // Create URL Reqest
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    // Get Response in Data Format
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    // If any Error Occure store in Error
    NSError* error;
    // Get Response Dictionary
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    // Found routes from Array
    NSArray* latestRoutes = [json objectForKey:@"routes"];
    NSString *points;
    
    if ([latestRoutes count]!=0) {
        points=[[[latestRoutes objectAtIndex:0] objectForKey:@"overview_polyline"] objectForKey:@"points"];
    }
    
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
            rectangle.strokeColor = [UIColor blackColor];
            //            rectangle.strokeColor = [UIColor colorWithRed:50/255.f green:150/255.f blue:225/255.f alpha:1.0f];
            rectangle.strokeWidth= 5.0;
            rectangle.map = mapView_;
            
            // Manage Bounds Area
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
    for (GMSMarker *marker in markerArray){
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

-(void)GetAddressbyAPI:(id)sender{
    if (sender == txtPickupLocation) {
        [self searchAddress:txtPickupLocation.text];
        [tblSearchView setFrame:CGRectMake(64, 97, 204, 220)];
        tblSearchView.alpha = 1;
    }else if (sender == txtDestinationLocation){
        [self searchAddress:txtDestinationLocation.text];
        [tblSearchView setFrame:CGRectMake(64, 139, 204, 220)];
        tblSearchView.alpha = 1;
    }
}

-(void)searchAddress:(NSString *) address {
    
//    NSString *str = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&radius=100&types=geocode&sensor=false&key=AIzaSyCtNLk2xQPdxzw_nGYm92MOcfHuznC2dEI", address];
    NSString *str = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&radius=1000&types=geocode&sensor=true&key=AIzaSyCtNLk2xQPdxzw_nGYm92MOcfHuznC2dEI", address];
    
    NSURL *url=[[NSURL alloc]initWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSLog(@"%@",error);
    if ([[json objectForKey:@"status"]isEqualToString:@"OK"]) {
        NSArray * latestRoutes = [json objectForKey:@"predictions"];
        arrSearchAddress = [[NSMutableArray alloc]init];
        for (int i=0; i<[latestRoutes count]; i++) {
            [arrSearchAddress addObject:[[latestRoutes objectAtIndex:i] objectForKey:@"description"]];
        }
        [tblSearchView reloadData];
    } else {
        arrSearchAddress = [[NSMutableArray alloc]init];
        [tblSearchView reloadData];
    }
}

#pragma mark -TABLEVIEW'S DELEGATE & DATASOURCE METHODS

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrSearchAddress count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Create Cell for TableView
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    cell.backgroundColor = [UIColor colorWithRed:2/255.f green:124/255.f blue:225/255.f alpha:1.0f];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    cell.separatorInset = UIEdgeInsetsZero;
    cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
    cell.textLabel.text = [arrSearchAddress objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tblSearchView.frame.origin.y==97) {
        txtPickupLocation.text = [arrSearchAddress objectAtIndex:indexPath.row];
    }else if (tblSearchView.frame.origin.y==139) {
        txtDestinationLocation.text = [arrSearchAddress objectAtIndex:indexPath.row];
    }
    tblSearchView.alpha = 0;
}

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker{
    return YES;
}

#pragma mark -ACTIONSHEET DELEGATE
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}

#pragma mark -GET DRIVER LIST FROM WEB SERVICES
-(void)GetDriverList {
    
    // URL Request String
    NSString *requestURL = [NSString stringWithFormat:@"%@driver_list.php",strBaseURL];
    
    // Allocation of Array of Driver list
    arrDriverList = [[NSMutableArray alloc]init];
    
    // Show Progressbar in Main View
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // AFNetworking Request Manager
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // Set Acceptable Contenttype of Response
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    // Request Block if Success
    [manager POST:requestURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // Set Progressbar hide from View
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        // Response Dictionary Received from API
        NSDictionary *dicResponse = responseObject;
        
        // Temperory Array of Response
        NSArray *arrResponse = [dicResponse objectForKey:@"driver_list"];
        
        // Add Object in Main Array from Received Response Dictionary
        for (NSDictionary *dicDriver in arrResponse) {
            
            // add object in Main Array
            [arrDriverList addObject:dicDriver];
        }
        
        for (int j = 0; j<[arrDriverList count]; j++) {
            NSString *strLatitude = [NSString stringWithFormat:@"%@",[arrDriverList[j] objectForKey:@"latitude"]];
            NSString *strLongitude = [NSString stringWithFormat:@"%@",[arrDriverList[j] objectForKey:@"longitude"]];
            markerPickup = [GMSMarker markerWithPosition:CLLocationCoordinate2DMake([strLatitude floatValue], [strLongitude floatValue])];
            markerPickup.title = lblAddress.text;
            markerPickup.icon = [UIImage imageNamed:@"top-map.png"];
            markerPickup.map = mapView_;
            
        }
    }   // Block if Failure Occure
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              // Set Progressbar hide from View
              [MBProgressHUD hideHUDForView:self.view animated:YES];
              
              // Show Alert if Request Session Failed
              [[[UIAlertView alloc]initWithTitle:appName message:@"We are unable to fetch details, please try after sometime." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
          }];
}

@end
