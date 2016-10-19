//
//  TripForLostAndFound.m
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 3/26/15.
//  Copyright (c) 2015 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import "TripForLostAndFound.h"

@interface TripForLostAndFound ()

@end

@implementation TripForLostAndFound

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Cancel button
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"CANCEL" style: UIBarButtonItemStylePlain target:self action:@selector(actionCancelReport:)];
    
    [self getRecentTrips];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationItem setTitle:NSLocalizedString(@"title_rcnttr", @"")];
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationItem setTitle:NSLocalizedString(@"btn_back", @"")];
}

- (void)actionCancelReport:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getRecentTrips{
    
    NSString *strPassengerId = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_Passenger_Id"];
#pragma mark - URL Change

    // Direction API of Google Maps
   // NSString *strPostRequest = [NSString stringWithFormat:@"http://54.153.20.98/api/android/Passenger_profile/view_recent_trips.php"];
    
    NSString *strURL = [NSString stringWithFormat:@"%@Passenger_profile/view_recent_trips.php",strBaseANURL];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *params = @{@"passenger_id":strPassengerId};
    
    [manager GET:strURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dicResponse = responseObject;
        
        NSLog(@"%@",dicResponse);
        
        NSArray *arrTripInfo = [dicResponse objectForKey:@"trip_info"];
        arrRecentTrips = [[NSMutableArray alloc]init];
        
        for (NSDictionary *tempDict in arrTripInfo) {
            [arrRecentTrips addObject:tempDict];
        }
        [tblRecentTrips reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"alrt_rcnttrph", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles: nil]show];
    }];

//    // Encode String by NSUTF8String
//    NSURL *url = [[NSURL alloc]initWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    
//    // Create URL Reqest
//    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
//    
//    // Get Response in Data Format
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        
//        // Get Response Dictionary
//        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&connectionError];
//        
//        NSLog(@"%@",json);
//        
//        NSArray *arrTripInfo = [json objectForKey:@"trip_info"];
//        arrRecentTrips = [[NSMutableArray alloc]init];
//        
//        for (NSDictionary *tempDict in arrTripInfo) {
//            [arrRecentTrips addObject:tempDict];
//        }
//        [tblRecentTrips reloadData];
//    }];
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
    
    UIImageView *imgDriverPic = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 40, 40)];
    [imgDriverPic setImage:[UIImage imageNamed:@"person-placeholder.jpg"]];
    [imgDriverPic setContentMode:UIViewContentModeScaleAspectFit];
    [imgDriverPic.layer setCornerRadius:20.0f];
    [imgDriverPic.layer setMasksToBounds:YES];
    [cell.contentView addSubview:imgDriverPic];
    
//    NSString *strFare = [[arrRecentTrips objectAtIndex:indexPath.row]objectForKey:@"trip_fare"];
//    
//    if ([strFare length]!=0) {
//        cell.detailTextLabel.text = [NSString stringWithFormat:@"$%@",strFare];
//    }
    
    UILabel *lblDetails = [[UILabel alloc]initWithFrame:CGRectMake(60, 5, 200, 20)];
    [lblDetails setFont:[UIFont fontWithName:@"Helvetica" size:15.0f]];
    [cell.contentView addSubview:lblDetails];
    
    NSString *strDriverName = [NSString stringWithFormat:@"%@ %@",[[arrRecentTrips objectAtIndex:indexPath.row]objectForKey:@"first_name"],[[arrRecentTrips objectAtIndex:indexPath.row]objectForKey:@"last_name"]];
    if ([strDriverName length] != 0) {
        lblDetails.text = strDriverName;
    }
    
//    lblSource = [[UILabel alloc]initWithFrame:CGRectMake(70, 20, 160, 20)];
//    [lblSource setFont:[UIFont fontWithName:@"Helvetica" size:12.0f]];
//    [lblSource setTextColor:[UIColor darkGrayColor]];
//    [cell.contentView addSubview:lblSource];
//    lblSource.tag = indexPath.row + 1;
//    
//    lblDest = [[UILabel alloc]initWithFrame:CGRectMake(70, 35, 160, 20)];
//    [lblDest setFont:[UIFont fontWithName:@"Helvetica" size:12.0f]];
//    [lblDest setTextColor:[UIColor darkGrayColor]];
//    [cell.contentView addSubview:lblDest];
//    lblDest.tag = indexPath.row + 2;
    
    UILabel *lblDateTime = [[UILabel alloc]initWithFrame:CGRectMake(60, 25, 180, 20)];
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
    
//    // Get Source Address
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        // Direction API of Google Maps
//        NSString *str = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%@,%@&sensor=true",[[arrRecentTrips objectAtIndex:indexPath.row] objectForKey:@"source_lat"],[[arrRecentTrips objectAtIndex:indexPath.row] objectForKey:@"source_long"]];
//        
//        // Encode String by NSUTF8String
//        NSURL *url = [[NSURL alloc]initWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//        
//        NSData *data;
//        
//        data = [NSData dataWithContentsOfURL:url];
//        
//        // Get Response Dictionary
//        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//        
//        //        NSLog(@"%@",json);
//        NSString *strSourceAddress;
//        if ([[json objectForKey:@"status"]isEqualToString:@"OK"]) {
//            strSourceAddress = [NSString stringWithFormat:@"%@",[[[json objectForKey:@"results"] objectAtIndex:0] objectForKey:@"formatted_address"]];
//            NSLog(@"%@",strSourceAddress);
//        }
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//            UILabel *source = (UILabel *)[cell viewWithTag:indexPath.row+1];
//            source.text = strSourceAddress;
//        });
//    });
//    
//    
//    // Get Destination Address
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        // Direction API of Google Maps
//        NSString *str = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%@,%@&sensor=true",[[arrRecentTrips objectAtIndex:indexPath.row] objectForKey:@"destination_lat"],[[arrRecentTrips objectAtIndex:indexPath.row] objectForKey:@"destination_long"]];
//        
//        // Encode String by NSUTF8String
//        NSURL *url = [[NSURL alloc]initWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//        
//        NSData *data;
//        
//        data = [NSData dataWithContentsOfURL:url];
//        
//        // Get Response Dictionary
//        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//        
//        NSString *strSourceAddress;
//        if ([[json objectForKey:@"status"]isEqualToString:@"OK"]) {
//            strSourceAddress = [NSString stringWithFormat:@"%@",[[[json objectForKey:@"results"] objectAtIndex:0] objectForKey:@"formatted_address"]];
//            NSLog(@"%@",strSourceAddress);
//        }
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//            UILabel *source = (UILabel *)[cell viewWithTag:indexPath.row+2];
//            source.text = strSourceAddress;
//        });
//    });
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ReportForLostAndFound *objReportForLostAndFound = [[ReportForLostAndFound alloc]initWithNibName:@"ReportForLostAndFound" bundle:nil];
    objReportForLostAndFound.dicRecentDetails = [arrRecentTrips objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:objReportForLostAndFound animated:YES];
}

-(NSString *)GetSourceAddressFromLat:(NSString *) sourceLat Long:(NSString *) sourceLong{
    
    __block NSString *strSourceAddress = nil;
#pragma mark - URL Change

    // Direction API of Google Maps
    NSString *str = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%@,%@&sensor=true",sourceLat,sourceLong];
    
    // Encode String by NSUTF8String
    NSURL *url = [[NSURL alloc]initWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    __block NSData *data;
    
    data = [NSData dataWithContentsOfURL:url];
    
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
#pragma mark - URL Change

    // Direction API of Google Maps
    NSString *str = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%@,%@&sensor=true",destLat,destLong];
    
    // Encode String by NSUTF8String
    NSURL *url = [[NSURL alloc]initWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    __block NSData *data;
    
    data = [NSData dataWithContentsOfURL:url];
    
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
