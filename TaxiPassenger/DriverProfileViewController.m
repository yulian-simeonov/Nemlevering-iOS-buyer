//
//  DriverProfileViewController.m
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 9/26/14.
//  Copyright (c) 2014 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import "DriverProfileViewController.h"
#import "RateView.h"

@interface DriverProfileViewController ()

@end

@implementation DriverProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Cancel button
//    UIBarButtonItem *btnCancel = [[UIBarButtonItem alloc] initWithTitle: @"" style: UIBarButtonItemStylePlain target: self action:nil];
//    self.navigationItem.leftBarButtonItem = btnCancel;
    
    rateView = [[RateView alloc]initWithFrame:CGRectMake(75, 150, 170, 28) andStarColor:[UIColor yellowColor]];
    rateView.delegate = self;
    [self.view addSubview:rateView];
    
    if (IS_IPHONE_4S) {
        rateView.frame = CGRectMake(75, 150, 170, 28);
        viewDriver.frame = CGRectMake(0, 0, 320, 480);
        
    }else if (IS_IPHONE_5){
        rateView.frame = CGRectMake(75, 150, 170, 28);
        viewDriver.frame = CGRectMake(0, 0, 320, 568);
        
    }else if (IS_IPHONE_6){
        rateView.frame = CGRectMake(95, 150, 170, 28);
        btnCallDriver.frame = CGRectMake(5, 363, 150, 60);
        btnTextDriver.frame = CGRectMake(210, 363, 150, 60);
        viewDriver.frame = CGRectMake(0, 0, 375, 667);
        
    }else if (IS_IPHONE_6P){
        rateView.frame = CGRectMake(120, 150, 170, 28);
        btnCallDriver.frame = CGRectMake(6, 363, 150, 60);
        btnTextDriver.frame = CGRectMake(213, 363, 150, 60);
        viewDriver.frame = CGRectMake(0, 0, 414, 736);
        
    }
    
    btnSendRequest.layer.borderColor = [[UIColor whiteColor]CGColor];
    btnSendRequest.layer.borderWidth = 2.0f;
    btnSendRequest.layer.cornerRadius = 5.0f;
    btnSendRequest.layer.masksToBounds = YES;
    
    btnCallDriver.layer.borderColor = [[UIColor whiteColor]CGColor];
    btnCallDriver.layer.borderWidth = 2.0f;
    btnCallDriver.layer.cornerRadius = 5.0f;
    btnCallDriver.layer.masksToBounds = YES;
    
    btnTextDriver.layer.borderColor = [[UIColor whiteColor]CGColor];
    btnTextDriver.layer.borderWidth = 2.0f;
    btnTextDriver.layer.cornerRadius = 5.0f;
    btnTextDriver.layer.masksToBounds = YES;
    
    [self.navigationItem setTitle:self.strDriverName];
    lblDriverName.text = self.strDriverName;
}

- (void)getRatingCount:(float)rateCount {
    NSLog(@"%f",rateCount);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)isTextDriverButtonClicked:(id)sender {
    
//    NSData *responseData = [[NSData alloc]initWithContentsOfURL:[[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://54.215.230.79/api/ios/send_message_driver.php?device_id=1"]]];
//    
//    NSString *strResponse = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
    
//    NSDictionary *dictResponse = [[NSDictionary alloc]initWithDictionary:[strResponse JSONValue]];
//    NSLog(@"RESPONSE:--->> %@", dictResponse);
    
}

- (IBAction)actionSendRequest:(id)sender {
    
#pragma mark - URL Change
    
    NSString *pessengerID = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_Passenger_Id"];
    
    NSString *strURL = [NSString stringWithFormat:@"%@ride_booking.php?passenger_id=%@&driver_id=%@",strBaseURL,pessengerID,self.strDriverId];
    
    NSData *responseData = [[NSData alloc]initWithContentsOfURL:[[NSURL alloc] initWithString:strURL]];
  
    // [NSString stringWithFormat:@"http://54.153.20.98/api/ios/ride_booking.php?passenger_id=%@&driver_id=%@",pessengerID,self.strDriverId]
    
    NSString *strResponse = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSDictionary *dictResponse = [[NSDictionary alloc]initWithDictionary:[strResponse JSONValue]];
    NSLog(@"%@",dictResponse);
    
    NSString *status = [NSString stringWithFormat:@"%@",[dictResponse objectForKey:@"success"]];
    if ([status isEqualToString:@"1"]) {
        [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"alrt_reqsent", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles:nil]show];
    }else {
        [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"alrt_reqnotsent", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles:nil]show];
    }
    NSLog(@"%@",dictResponse);
}


@end
