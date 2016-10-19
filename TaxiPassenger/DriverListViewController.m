//
//  DriverListViewController.m
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 9/25/14.
//  Copyright (c) 2014 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import "DriverListViewController.h"

@interface DriverListViewController ()

@end

@implementation DriverListViewController

#pragma mark -VIEWCONTROLLER'S DELEGATE METHOD

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Cancel button
    UIBarButtonItem *btnCancel = [[UIBarButtonItem alloc] initWithTitle: NSLocalizedString(@"btn_cancel", @"") style: UIBarButtonItemStylePlain target: self action:@selector(methodCancel:)];
    
    self.navigationItem.leftBarButtonItem = btnCancel;
    
    // Array of Driver List Allocation
    arrDriverList = [[NSMutableArray alloc]init];
    
    // Set Tableview Hidden, If Driver List found TableView Show
    tblDriverList.alpha = 0;
}

-(void)viewWillAppear:(BOOL)animated {
    // Get Driver List
    [self GetDriverList];
    [self.navigationItem setTitle:@"Driver List"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)methodCancel:(id) sender{
    [self dismissViewControllerAnimated:YES completion:nil];
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
        
        // If Driver Information Found TableView Show
        tblDriverList.alpha = 1;
        
        // Response Dictionary Received from API
        NSDictionary *dicResponse = responseObject;
        
        // Temperory Array of Response
        NSArray *arrResponse = [dicResponse objectForKey:@"driver_list"];
        
        // Add Object in Main Array from Received Response Dictionary
        for (NSDictionary *dicDriver in arrResponse) {
            
            // add object in Main Array
            [arrDriverList addObject:dicDriver];
        }
        
        [[NSUserDefaults standardUserDefaults]setObject:arrDriverList forKey:@"driver_list"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        // Reload Tableview when all Information Found
        [tblDriverList reloadData];
        
    }   // Block if Failure Occure
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // Set Progressbar hide from View
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        // If Driver Information not Found TableView Show
        tblDriverList.alpha = 0;
        
        // Show Alert if Request Session Failed
        [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"alrt_un", @"") delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
    }];
}

#pragma mark -TABLEVIEW'S DELEGATE & DATASOURCE METHODS
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrDriverList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Create Cell for TableView
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    cell.separatorInset = UIEdgeInsetsZero;
    
    // Set Selected BackgroundView
    viewForCellSelected = [[UIView alloc]init];
    viewForCellSelected.backgroundColor = [UIColor colorWithRed:2/255.f green:124/255.f blue:225/255.f alpha:1.0f];
    cell.selectedBackgroundView = viewForCellSelected;
    cell.backgroundColor = [UIColor clearColor];
    
    // Add Label in Cell for Menu Name
    UILabel *lblDriverName = [[UILabel alloc]initWithFrame:CGRectMake(83, 7, 150, 30)];
    lblDriverName.font = [UIFont fontWithName:@"Helvetica Neue Light" size:17.0f];
//    NSString *strDriverName = [NSString stringWithFormat:@"%@ %@",[[arrDriverList objectAtIndex:indexPath.row] objectForKey:@"first_name"],[[arrDriverList objectAtIndex:indexPath.row] objectForKey:@"last_name"]];
    
    NSString *strDriverName = [NSString stringWithFormat:@"%@ %@",[[arrDriverList objectAtIndex:indexPath.row] objectForKey:@"first_name"],[[arrDriverList objectAtIndex:indexPath.row] objectForKey:@"last_name"]];
    
    lblDriverName.text = [NSString stringWithFormat:@"%@",strDriverName];
    [cell.contentView addSubview:lblDriverName];
    
    // Add ImageView in Cell for MenuImage
    UIImageView *imgMenuImage = [[UIImageView alloc]initWithFrame:CGRectMake(33, 7, 30, 30)];
//    imgMenuImage.image = [UIImage imageNamed:[arrImages objectAtIndex:indexPath.row]];
    imgMenuImage.contentMode = UIViewContentModeCenter;
    [cell.contentView addSubview:imgMenuImage];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tblDriverList reloadData];
    
//    DriverLocationViewController *objDriverLocationViewController = [[DriverLocationViewController alloc] init];
//    NSString *strLatitude = [arrDriverList[indexPath.row]objectForKey:@"latitude"];
//    objDriverLocationViewController.latitude = [strLatitude floatValue];
    
//    NSString *strLongitude = [arrDriverList[indexPath.row]objectForKey:@"longitude"];
//    objDriverLocationViewController.longitude = [strLongitude floatValue];
//    [gAppDelegate.navigationController pushViewController:objDriverLocationViewController animated:YES];
    
    NSLog(@"%@",[[arrDriverList objectAtIndex:indexPath.row] objectForKey:@"driver_id"]);
    NSString *driverID= [[arrDriverList objectAtIndex:indexPath.row] objectForKey:@"driver_id"];
    
    objDriverProfileViewController = [[DriverProfileViewController alloc]initWithNibName:@"DriverProfileViewController" bundle:nil];
    objDriverProfileViewController.strDriverId = driverID;
    objDriverProfileViewController.strDriverName = [[arrDriverList objectAtIndex:indexPath.row]objectForKey:@"first_name"];
    [self.navigationController pushViewController:objDriverProfileViewController animated:YES];
    
//    NSString *pessengerID = [[NSUserDefaults standardUserDefaults]objectForKey:@"passenger_id"];
//    
//    NSData *responseData = [[NSData alloc]initWithContentsOfURL:[[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://54.215.230.79/api/ios/ride_booking.php?passenger_id=%@&driver_id=%@",pessengerID,driverID]]];
//    
//    NSString *strResponse = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
//    
//    NSDictionary *dictResponse = [[NSDictionary alloc]initWithDictionary:[strResponse JSONValue]];
//    NSLog(@"%@",dictResponse);
//    
//    NSString *status = [NSString stringWithFormat:@"%@",[dictResponse objectForKey:@"success"]];
//    if ([status isEqualToString:@"1"]) {
//        [[[UIAlertView alloc]initWithTitle:@"TaxiPassenger" message:@"Request sent successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
//    }else {
//        [[[UIAlertView alloc]initWithTitle:@"TaxiPassenger" message:@"Request not sent successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
//    }
//    NSLog(@"%@",dictResponse);
}

- (IBAction)actionCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
