//
//  SelectVehicalViewController.m
//  Taxi App
//
//  Created by TechnoMac-11 on 21/05/16.
//  Copyright © 2016 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import "SelectVehicalViewController.h"

@interface SelectVehicalViewController ()

@end

@implementation SelectVehicalViewController

#pragma mark- view life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *letterTapRecognizer = [[UITapGestureRecognizer alloc]init];
    letterTapRecognizer.numberOfTapsRequired=1;
    letterTapRecognizer.delegate=self;
    [self.view addGestureRecognizer:letterTapRecognizer];
    [self.view setUserInteractionEnabled:YES];
    
    self.navigationItem.title=NSLocalizedString(@"txt_title", @"");
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"btn_select", @"")style:UIBarButtonItemStylePlain target:self action:@selector(BtnPressed)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    objarry=[[NSMutableArray alloc]initWithObjects:NSLocalizedString(@"lbl_BIKE", @""),NSLocalizedString(@"lbl_BERLINGO", @""),NSLocalizedString(@"lbl_VAN", @""),NSLocalizedString(@"lbl_BOK_TRUCK", @""),NSLocalizedString(@"lbl_TRUCK", @""), nil];
    
   
     arrPrice=[[NSMutableArray alloc]initWithObjects:NSLocalizedString(@"lbl_60KR",@""),NSLocalizedString(@"lbl_60KR",@""),NSLocalizedString(@"lbl_90KR",@""),NSLocalizedString(@"lbl_150KR",@""),NSLocalizedString(@"lbl_250KR",@""), nil];
    
        self.navigationItem.hidesBackButton = YES;

        //objImagArry=[[NSMutableArray alloc]initWithObjects:@"Berlingo_morivehicals",@"BIke_red_moreVehical",@"box_truckred_MoreVehical",@"dump_truck_red_MoreVehical",@"refrigerated_red_MoreVehical",@"truck_Morevehical",@"van_red_MoreVehical", nil];
    
    objImagArry=[[NSMutableArray alloc]initWithObjects:@"BIke_red_moreVehical",@"Berlingo_morivehicals",@"van_red_MoreVehical",@"box_truckred_MoreVehical",@"truck_Morevehical",nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)viewDidAppear:(BOOL)animated
{
    NSString *strindex=[[NSUserDefaults standardUserDefaults]objectForKey:@"Key_CarId"];
    
    NSString *strlastindex=[NSString stringWithFormat:@"%d",[strindex intValue]-1];
    if ([strlastindex isEqualToString:@"1"])
    {
        strlastindex=@"1";
    }
    if ([strlastindex isEqualToString:@"0"])
    {
        strlastindex=@"0";
    }
    if ([strlastindex length]==0)
    {
        strlastindex=@"0";
        
    }
    [objPIckerView selectRow:[strlastindex intValue] inComponent:0 animated:YES];

}
#pragma mark- gester SideMenu method
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    [appdelegate.deckController closeLeftViewAnimated:YES];
    return YES;
}
#pragma mark- btn Pressed
-(void)BtnPressed
{
    [self apiCallforUpadetCarid];
    
}
#pragma mark- picker view delegate method
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return objarry.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return objarry[row];
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    if (IPAD)
    {
        return 130;
    }
    else
    {
        return 100;
    }
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UIImage *img = [UIImage imageNamed:[objImagArry objectAtIndex:row]];
    UIImageView *icon = [[UIImageView alloc] initWithImage:img];
    
    if (IPAD)
    {
        UIView *tmpView = [[UIView alloc] initWithFrame:CGRectMake(objPIckerView.frame.origin.x+30, 0, objPIckerView.frame.size.width-30, 150)];
        UILabel *firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(icon.frame.origin.x+icon.frame.size.width+15, 0,170, 32)];
        firstLabel.text = [objarry objectAtIndex:row];
        [firstLabel setFont:[UIFont fontWithName:@"Libertad-Bold" size:25.0f]];
        firstLabel.textAlignment = kCTJustifiedTextAlignment;
        firstLabel.backgroundColor = [UIColor clearColor];
        
        UILabel *secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(tmpView.frame.size.width-100, 0, 100, 32)];
        secondLabel.text=[arrPrice objectAtIndex:row];
        secondLabel.textColor=[UIColor redColor];
        secondLabel.textAlignment = NSTextAlignmentRight;
        secondLabel.backgroundColor = [UIColor clearColor];
        
        UILabel *lblKm = [[UILabel alloc] initWithFrame:CGRectMake(firstLabel.frame.origin.x, firstLabel.frame.origin.y+30, 150, 32)];
        lblKm.text = NSLocalizedString(@"lbl_km", @"");
        [lblKm setFont:[UIFont fontWithName:@"Libertad-Book" size:22.0f]];
        lblKm.textColor=[UIColor blackColor];
        lblKm.textAlignment = NSTextAlignmentLeft;
        lblKm.backgroundColor = [UIColor clearColor];
        
        UILabel *lblreng = [[UILabel alloc] initWithFrame:CGRectMake(tmpView.frame.size.width-150, secondLabel.frame.origin.y+30, 150, 30)];
        lblreng.text = NSLocalizedString(@"lbl_reng", @"");
        [lblreng setFont:[UIFont fontWithName:@"Libertad-Book" size:20.0f]];
        lblreng.textColor=[UIColor blackColor];
        lblreng.textAlignment = NSTextAlignmentRight;
        lblreng.backgroundColor = [UIColor clearColor];
        
        [tmpView addSubview:icon];
        [tmpView addSubview:firstLabel];
        [tmpView addSubview:secondLabel];
        [tmpView addSubview:lblKm];
        [tmpView addSubview:lblreng];
        [tmpView setTag:row];
        [tmpView setUserInteractionEnabled:NO];
        return tmpView;
    }
    else
    {
        UIView *tmpView = [[UIView alloc] initWithFrame:CGRectMake(objPIckerView.frame.origin.x+30, 0, objPIckerView.frame.size.width-60, 60)] ;
        UILabel *firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(icon.frame.origin.x+icon.frame.size.width+15, 0, 120, 32)];
        firstLabel.text = [objarry objectAtIndex:row];
        [firstLabel setFont:[UIFont fontWithName:@"Libertad-Bold" size:17.0f]];
        firstLabel.textAlignment = kCTJustifiedTextAlignment;
        firstLabel.backgroundColor = [UIColor clearColor];
        
        UILabel *secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(tmpView.frame.size.width-100, 0, 100, 32)];
        secondLabel.text=[arrPrice objectAtIndex:row];
        secondLabel.textColor=[UIColor redColor];
        secondLabel.textAlignment = NSTextAlignmentRight;
        secondLabel.backgroundColor = [UIColor clearColor];
        
        UILabel *lblKm = [[UILabel alloc] initWithFrame:CGRectMake(firstLabel.frame.origin.x, firstLabel.frame.origin.y+30, 150, 32)];
        lblKm.text = NSLocalizedString(@"lbl_km", @"");
        [lblKm setFont:[UIFont fontWithName:@"Libertad-Book" size:15.0f]];
        lblKm.textColor=[UIColor blackColor];
        lblKm.textAlignment = NSTextAlignmentLeft;
        lblKm.backgroundColor = [UIColor clearColor];
        
        UILabel *lblreng = [[UILabel alloc] initWithFrame:CGRectMake(tmpView.frame.size.width-150, secondLabel.frame.origin.y+30, 150, 30)];
        lblreng.text = NSLocalizedString(@"lbl_reng", @"");
        [lblreng setFont:[UIFont fontWithName:@"Libertad-Book" size:12.0f]];
        lblreng.textColor=[UIColor blackColor];
        lblreng.textAlignment = NSTextAlignmentRight;
        lblreng.backgroundColor = [UIColor clearColor];
        
        [tmpView addSubview:icon];
        [tmpView addSubview:firstLabel];
        [tmpView addSubview:secondLabel];
        [tmpView addSubview:lblKm];
        [tmpView addSubview:lblreng];
        [tmpView setTag:row];
        [tmpView setUserInteractionEnabled:NO];
        return tmpView;
    }
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    if (row==0)
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"btntag"];
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"VehicalSelect"];
    }
    else if (row==1)
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:@"btntag"];
        [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:@"VehicalSelect"];
    }
    else if (row==2)
    {
     
        [[NSUserDefaults standardUserDefaults]setObject:@"3" forKey:@"btntag"];
        [[NSUserDefaults standardUserDefaults]setObject:@"3" forKey:@"VehicalSelect"];
    }
    else if (row==3)
    {
       
        [[NSUserDefaults standardUserDefaults]setObject:@"4" forKey:@"btntag"];
        [[NSUserDefaults standardUserDefaults]setObject:@"4" forKey:@"VehicalSelect"];
    }
    else if (row==4)
    {
        
        [[NSUserDefaults standardUserDefaults]setObject:@"5" forKey:@"btntag"];
        [[NSUserDefaults standardUserDefaults]setObject:@"5" forKey:@"VehicalSelect"];
    }

}
#pragma mark- URL Change
-(void)getCarlist
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *strURL = [NSString stringWithFormat:@"%@car_type.php",strBaseANURL];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:strURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"%@",responseObject);
         // arrCarlist = [responseObject objectForKey:@"car_list"];
         // Update the UI on the main thread.
         //[tblCarlist reloadData];
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
     }];
}
-(void)apiCallforUpadetCarid
{
    NSString *requestURL = [NSString stringWithFormat:@"%@update_car.php",strBaseANURL];
    NSString *strCarId= [[NSUserDefaults standardUserDefaults]objectForKey:@"VehicalSelect"];
    
    if ([strCarId length]==0)
    {
        strCarId=@"1";
    }
    
    // Show Progressbar in Main View
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *strPassengerId = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_Passenger_Id"];
    // AFNetworking Request Manager
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // Set Acceptable Contenttype of Response
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *params = @{@"passenger_id":strPassengerId,@"car_id":strCarId,@"user_update":@"1"};
    
    [manager GET:requestURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        // arrCarlist = [responseObject objectForKey:@"car_list"];
        
        [[NSUserDefaults standardUserDefaults]setObject:[responseObject objectForKey:@"car_id"] forKey:@"Key_CarId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.navigationController popViewControllerAnimated:YES];
        // Update the UI on the main thread.
        //[tblCarlist reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }];
}


@end
