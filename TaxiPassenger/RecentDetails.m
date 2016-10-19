//
//  RecentDetails.m
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 3/13/15.
//  Copyright (c) 2015 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import "RecentDetails.h"

@interface RecentDetails ()<UIGestureRecognizerDelegate>

@end

@implementation RecentDetails
@synthesize objMapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Cancel button
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"" style: UIBarButtonItemStylePlain target:self action:nil];
    UIGestureRecognizer *letterTapRecognizer1 = [[UIGestureRecognizer alloc]init];
    letterTapRecognizer1.delegate=self;
    [self.view addGestureRecognizer:letterTapRecognizer1];


    self.navigationController.navigationBarHidden=NO;
    tblRecentDetail.tableHeaderView = viewMapView;
    
    
    NSString *strDate = [self.dicRecentDetails objectForKey:@"trip_date"];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate *date = [dateFormat dateFromString:strDate];
    
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd hh:mm"];
    
    [self.navigationItem setTitle:[DateFormatter stringFromDate:date]];
    
    NSString *strSourceLat = [self.dicRecentDetails objectForKey:@"source_lat"];
    NSString *strSourceLong = [self.dicRecentDetails objectForKey:@"source_long"];
    CLLocationCoordinate2D coorPickup = CLLocationCoordinate2DMake([strSourceLat floatValue], [strSourceLong floatValue]);
    
    markerPickup = [GMSMarker markerWithPosition:coorPickup];
    markerPickup.icon = [UIImage imageNamed:@"pickup_pin.png"];
    markerPickup.map = objMapView;
    
    NSString *strDestLat = [self.dicRecentDetails objectForKey:@"destination_lat"];
    NSString *strDestLong = [self.dicRecentDetails objectForKey:@"destination_long"];
    CLLocationCoordinate2D coorDestination = CLLocationCoordinate2DMake([strDestLat floatValue], [strDestLong floatValue]);
    markerDestination = [GMSMarker markerWithPosition:coorDestination];
    markerDestination.icon = [UIImage imageNamed:@"destination_pin.png"];
    markerDestination.map = objMapView;
    
    [self setOriginLatitude:[strSourceLat floatValue] OriginLongitude:[strSourceLong floatValue] DestinationLatitude:[strDestLat floatValue] DestinationLongitude:[strDestLong floatValue]];
    
}
#pragma mark UIGestureRecognizer Methods side menu
#pragma mark -----------------
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:self.view])
    {
        [appdelegate.deckController closeLeftViewAnimated:YES];
        return NO;
    }
    
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -TABLEVIEW'S DELEGATE & DATASOURCE METHODS
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Create Cell for TableView
    TripDetails *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TripDetails" owner:self options:nil];
    cell = [nib objectAtIndex:0];
    
    if (cell == nil)
    {
        cell = [[TripDetails alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    cell.separatorInset = UIEdgeInsetsZero;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.lblName.text = [NSString stringWithFormat:@"%@ %@",[self.dicRecentDetails objectForKey:@"first_name"],[self.dicRecentDetails objectForKey:@"last_name"]];
    
    NSString *strGetStatus = [self.dicRecentDetails objectForKey:@"trip_status"];
    NSString *strSetStatus = [[NSString alloc]init];
    if ([strGetStatus isEqualToString:@"1"]) {
        strSetStatus = [NSString stringWithFormat:NSLocalizedString(@"txt_compl", @"")];
    }else{
        strSetStatus = [NSString stringWithFormat:NSLocalizedString(@"txt_cancel", @"")];
    }
    cell.lblStatusDetails.text = strSetStatus;
    NSString *strTripFare = [NSString stringWithFormat:@"%@",[self.dicRecentDetails objectForKey:@"trip_fare"]];
    
    cell.lblTotalFareDetails.text = strTripFare;
    cell.lblCardNo.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_CreditCardNo"];
    cell.lblFareCharged.text = strTripFare;
    
    return cell;
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
            //        rectangle.strokeColor = [UIColor colorWithRed:255/255.f green:255/255.f blue:0/255.f alpha:1.0f];
            rectangle.strokeColor = [UIColor blackColor];
            //            rectangle.strokeColor = [UIColor colorWithRed:50/255.f green:150/255.f blue:225/255.f alpha:1.0f];
            rectangle.strokeWidth= 5.0;
            rectangle.map = objMapView;
            
            // Manage Bounds Area
            [self focusMapToShowAllMarkers];
            
        }@catch (NSException *exception) {
            //            [[[UIAlertView alloc]initWithTitle:@"Taxi" message:@"We are unable to draw route, please try after sometime." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
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


@end
