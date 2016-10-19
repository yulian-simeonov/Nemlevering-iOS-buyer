//
//  Reservation.m
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 3/24/15.
//  Copyright (c) 2015 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import "Reservation.h"

@interface Reservation ()<UIGestureRecognizerDelegate>

@end

@implementation Reservation

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIGestureRecognizer *letterTapRecognizer1 = [[UIGestureRecognizer alloc]init];
    letterTapRecognizer1.delegate=self;
    [self.view addGestureRecognizer:letterTapRecognizer1];

    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"" style: UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(actionAddReservation:)];
    
    [self.navigationItem setTitle:NSLocalizedString(@"txt_sidersrvtn", @"")];
}

-(void)viewWillAppear:(BOOL)animated
{
    [appdelegate.leftBarButtonForMenu setHidden:NO];
    
    [self getReservationInfo];
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)getReservationInfo
{
    @try
    {
        NSString *strPassengerId = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_Passenger_Id"];
#pragma mark - URL Change

        // URL String
      //  NSString *stringPost = [NSString stringWithFormat:@"http://54.153.20.98/api/android/Passenger_profile/get_reservation.php?passenger_id=%@", strPassengerId];
        
        NSString *strURL = [NSString stringWithFormat:@"%@Passenger_profile/get_reservation.php?passenger_id=%@",strBaseANURL,strPassengerId];
        
        // URL Request
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:strURL]];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        // Conncection Block
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler: ^(NSURLResponse *res, NSData *data, NSError *err) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            // Get Encoding Data in Dictionary
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
            
            NSLog(@"Error >>> %@",[err description]);
            
            NSLog(@"ReservationDic >>> %@",responseDictionary);
            
            NSArray *arrTemp = [responseDictionary objectForKey:@"reservation_info"];
            arrReservation = [[NSMutableArray alloc]init];
            for (NSDictionary *tempDic in arrTemp) {
                [arrReservation addObject:tempDic];
            }
            [tblReservation reloadData];
        }];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

-(void)actionAddReservation:(id)sender{
    AddReservation *objAddReservation = [[AddReservation alloc]initWithNibName:@"AddReservation" bundle:nil];
    UINavigationController *objNavigationController = [[UINavigationController alloc]initWithRootViewController:objAddReservation];
    [self.navigationController presentViewController:objNavigationController animated:YES completion:nil];
}

#pragma mark -TABLEVIEW'S DELEGATE & DATASOURCE METHODS
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrReservation count];
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

    NSString *strDate = [NSString stringWithFormat:@"%@",[[arrReservation objectAtIndex:indexPath.row] objectForKey:@"date"]];
    
    cell.textLabel.text = strDate;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    
//    bookingViewController *objBookRide = [[bookingViewController alloc]initWithNibName:@"bookingViewController" bundle:nil];
//    objBookRide.isShowBookedRide = YES;
//    objBookRide.dicRideInfo = [arrReservation objectAtIndex:indexPath.row];
//    [self.navigationController pushViewController:objBookRide animated:YES];
    
    BookRide *objBookRide = [[BookRide alloc]initWithNibName:@"BookRide" bundle:nil];
    objBookRide.isShowBookedRide = YES;
    objBookRide.dicRideInfo = [arrReservation objectAtIndex:indexPath.row];
    [appdelegate.deckNavigationController pushViewController:objBookRide animated:YES];
}
@end
