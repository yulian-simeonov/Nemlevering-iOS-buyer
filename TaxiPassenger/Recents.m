//
//  Recents.m
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 3/11/15.
//  Copyright (c) 2015 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import "Recents.h"

@interface Recents ()<UIGestureRecognizerDelegate>

@end

@implementation Recents

- (void)viewDidLoad
{
    UIGestureRecognizer *letterTapRecognizer1 = [[UIGestureRecognizer alloc]init];
    letterTapRecognizer1.delegate=self;
    [self.view addGestureRecognizer:letterTapRecognizer1];


    [super viewDidLoad];
    // Cancel button
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"" style: UIBarButtonItemStylePlain target:self action:nil];
    [self.navigationItem setTitle:NSLocalizedString(@"title_rcnttr", @"")];
    
    
    [self getRecentTrips];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated
{
    [appdelegate.leftBarButtonForMenu setHidden:NO];
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
-(void)getRecentTrips
{
    NSString *strPassengerId = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_Passenger_Id"];
#pragma mark - URL Change

    // Direction API of Google Maps
   // NSString *str = [NSString stringWithFormat:@"http://54.153.20.98/api/android/Passenger_profile/view_recent_trips.php?passenger_id=%@",strPassengerId];
    
    NSString *strURL = [NSString stringWithFormat:@"%@Passenger_profile/view_recent_trips.php?passenger_id=%@",strBaseANURL,strPassengerId];
    
    // Encode String by NSUTF8String
    NSURL *url = [[NSURL alloc]initWithString:[strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    // Create URL Reqest
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    // Get Response in Data Format
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        // Get Response Dictionary
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&connectionError];
        
        NSLog(@"%@",json);
        
        NSArray *arrTripInfo = [json objectForKey:@"trip_info"];
        arrRecentTrips = [[NSMutableArray alloc]init];
        
        for (NSDictionary *tempDict in arrTripInfo)
        {
            [arrRecentTrips addObject:tempDict];
        }
        [tblRecentTrips reloadData];
    }];
}

#pragma mark -TABLEVIEW'S DELEGATE & DATASOURCE METHODS
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrRecentTrips count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Create Cell for TableView
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    cell.separatorInset = UIEdgeInsetsZero;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    UIImageView *imgDriverPic = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 60, 60)];
    [imgDriverPic setImage:[UIImage imageNamed:@"person-placeholder.jpg"]];
    [imgDriverPic setContentMode:UIViewContentModeScaleAspectFit];
    [imgDriverPic.layer setCornerRadius:30.0f];
    [imgDriverPic.layer setMasksToBounds:YES];
    [cell.contentView addSubview:imgDriverPic];
    
    NSString *strFare = [[arrRecentTrips objectAtIndex:indexPath.row]objectForKey:@"trip_fare"];
    
    if ([strFare length]!=0) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",strFare];
        [cell.detailTextLabel setFont:[UIFont fontWithName:@"Helvetica" size:15.0f]];
    }
    
    UILabel *lblDetails = [[UILabel alloc]initWithFrame:CGRectMake(70, 2, 200, 20)];
    [lblDetails setFont:[UIFont fontWithName:@"Helvetica" size:15.0f]];
    [cell.contentView addSubview:lblDetails];
    
    NSString *strDriverName = [NSString stringWithFormat:@"%@ %@",[[arrRecentTrips objectAtIndex:indexPath.row]objectForKey:@"first_name"],[[arrRecentTrips objectAtIndex:indexPath.row]objectForKey:@"last_name"]];
    if ([strDriverName length] != 0) {
        lblDetails.text = strDriverName;
    }
    
    lblSource = [[UILabel alloc]initWithFrame:CGRectMake(70, 20, 150, 20)];
    [lblSource setFont:[UIFont fontWithName:@"Helvetica" size:12.0f]];
    [lblSource setTextColor:[UIColor darkGrayColor]];
    [cell.contentView addSubview:lblSource];
    lblSource.tag = indexPath.row + 1;
    
    lblDest = [[UILabel alloc]initWithFrame:CGRectMake(70, 35, 150, 20)];
    [lblDest setFont:[UIFont fontWithName:@"Helvetica" size:12.0f]];
    [lblDest setTextColor:[UIColor darkGrayColor]];
    [cell.contentView addSubview:lblDest];
    lblDest.tag = indexPath.row + 2;
    
    UILabel *lblDateTime = [[UILabel alloc]initWithFrame:CGRectMake(70, 50, 180, 20)];
    [lblDateTime setFont:[UIFont fontWithName:@"Helvetica" size:12.0f]];
    [lblDateTime setTextColor:[UIColor lightGrayColor]];
    [cell.contentView addSubview:lblDateTime];
    NSString *strDate = [[arrRecentTrips objectAtIndex:indexPath.row]objectForKey:@"trip_date"];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate *date = [dateFormat dateFromString:strDate];
    
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd hh:mm"];
    lblDateTime.text = [DateFormatter stringFromDate:date];
    
//    NSString *strSourceAddress = [self GetSourceAddressFromLat:[[arrRecentTrips objectAtIndex:indexPath.row] objectForKey:@"source_lat"] Long:[[arrRecentTrips objectAtIndex:indexPath.row] objectForKey:@"source_long"]];
//    if ([strSourceAddress length]!=0) {
//        lblSource.text = strSourceAddress;
//    }
//    
//    NSString *strDestAddress = [self GetDestinationAddressFromLat:[[arrRecentTrips objectAtIndex:indexPath.row] objectForKey:@"destination_lat"] Long:[[arrRecentTrips objectAtIndex:indexPath.row] objectForKey:@"destination_long"]];
//    if ([strDestAddress length]!=0) {
//        lblDest.text = strDestAddress;
//    }
    
    // Get Source Address
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
#pragma mark - URL Change

        // Direction API of Google Maps
        NSString *str = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%@,%@&sensor=true",[[arrRecentTrips objectAtIndex:indexPath.row] objectForKey:@"source_lat"],[[arrRecentTrips objectAtIndex:indexPath.row] objectForKey:@"source_long"]];
        
        // Encode String by NSUTF8String
        NSURL *url = [[NSURL alloc]initWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        NSData *data;
        
        data = [NSData dataWithContentsOfURL:url];
        
        // Get Response Dictionary
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        //        NSLog(@"%@",json);
        NSString *strSourceAddress;
        if ([[json objectForKey:@"status"]isEqualToString:@"OK"]) {
            strSourceAddress = [NSString stringWithFormat:@"%@",[[[json objectForKey:@"results"] objectAtIndex:0] objectForKey:@"formatted_address"]];
            NSLog(@"%@",strSourceAddress);
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            UILabel *source = (UILabel *)[cell viewWithTag:indexPath.row+1];
            source.text = strSourceAddress;
        });
    });
    
    
    // Get Destination Address
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
#pragma mark - URL Change

        // Direction API of Google Maps
        NSString *str = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%@,%@&sensor=true",[[arrRecentTrips objectAtIndex:indexPath.row] objectForKey:@"destination_lat"],[[arrRecentTrips objectAtIndex:indexPath.row] objectForKey:@"destination_long"]];
        
        // Encode String by NSUTF8String
        NSURL *url = [[NSURL alloc]initWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        NSData *data;
        
        data = [NSData dataWithContentsOfURL:url];
        
        // Get Response Dictionary
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        NSString *strSourceAddress;
        if ([[json objectForKey:@"status"]isEqualToString:@"OK"]) {
            strSourceAddress = [NSString stringWithFormat:@"%@",[[[json objectForKey:@"results"] objectAtIndex:0] objectForKey:@"formatted_address"]];
            NSLog(@"%@",strSourceAddress);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            UILabel *source = (UILabel *)[cell viewWithTag:indexPath.row+2];
            source.text = strSourceAddress;
        });
    });


    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RecentDetails *objRecentDetails = [[RecentDetails alloc]initWithNibName:@"RecentDetails" bundle:nil];
    objRecentDetails.dicRecentDetails = [arrRecentTrips objectAtIndex:indexPath.row];
    [appdelegate.deckNavigationController pushViewController:objRecentDetails animated:YES];
}

-(NSString *)GetSourceAddressFromLat:(NSString *) sourceLat Long:(NSString *) sourceLong{
    
    __block NSString *strSourceAddress = nil;
//
//    CLLocationCoordinate2D coor = CLLocationCoordinate2DMake([sourceLat floatValue], [sourceLong floatValue]);
//    
//    GMSGeocoder *geoCoder_ = [[GMSGeocoder alloc] init];
//    
//    [geoCoder_ reverseGeocodeCoordinate:coor completionHandler:^(GMSReverseGeocodeResponse *respones, NSError *error) {
//        if([respones firstResult]){
//            GMSAddress* address = [respones firstResult];
//            NSString* fullAddress = [NSString stringWithFormat:@"%@",address.lines];
//            strSourceAddress = fullAddress;
//            
//        } else {
//            
//        }
//    }];
#pragma mark - URL Change

    // Direction API of Google Maps
    NSString *str = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%@,%@&sensor=true",sourceLat,sourceLong];
    
    // Encode String by NSUTF8String
    NSURL *url = [[NSURL alloc]initWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    __block NSData *data;
    
    data = [NSData dataWithContentsOfURL:url];
    
//    // Create URL Reqest
//    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
//    
//    // Get Response in Data Format
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        
        // Get Response Dictionary
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
//        NSLog(@"%@",json);
    
        if ([[json objectForKey:@"status"]isEqualToString:@"OK"]) {
            strSourceAddress = [NSString stringWithFormat:@"%@",[[[json objectForKey:@"results"] objectAtIndex:0] objectForKey:@"formatted_address"]];
            NSLog(@"%@",strSourceAddress);
        }
//    }];
    
    return strSourceAddress;
    
}

-(NSString *)GetDestinationAddressFromLat:(NSString *) destLat Long:(NSString *) destLong{
    
    __block NSString *strDestAddress = nil;
    
//    CLLocationCoordinate2D coor = CLLocationCoordinate2DMake([destLat floatValue], [destLat floatValue]);
//    
//    GMSGeocoder *geoCoder_ = [[GMSGeocoder alloc] init];
//    
//    [geoCoder_ reverseGeocodeCoordinate:coor completionHandler:^(GMSReverseGeocodeResponse *respones, NSError *error) {
//        if([respones firstResult]){
//            GMSAddress* address = [respones firstResult];
//            NSString* fullAddress = [NSString stringWithFormat:@"%@",address.thoroughfare];
//            strDestAddress = fullAddress;
//            
//        } else {
//            
//        }
//    }];
#pragma mark - URL Change

    // Direction API of Google Maps
    NSString *str = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%@,%@&sensor=true",destLat,destLong];
    
    // Encode String by NSUTF8String
    NSURL *url = [[NSURL alloc]initWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    __block NSData *data;
    
    data = [NSData dataWithContentsOfURL:url];
    
    //    // Create URL Reqest
    //    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    //    // Get Response in Data Format
    //    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    
    // Get Response Dictionary
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    //        NSLog(@"%@",json);
    
    if ([[json objectForKey:@"status"]isEqualToString:@"OK"]) {
        strDestAddress = [NSString stringWithFormat:@"%@",[[[json objectForKey:@"results"] objectAtIndex:0] objectForKey:@"formatted_address"]];
        NSLog(@"%@",strDestAddress);
    }
    //    }];
    
    return strDestAddress;
}

@end
