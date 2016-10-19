//
//  AddReservation.m
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 3/24/15.
//  Copyright (c) 2015 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import "AddReservation.h"

@interface AddReservation ()

@end

@implementation AddReservation

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Cancel button
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: NSLocalizedString(@"btn_cancel", @"") style: UIBarButtonItemStylePlain target:self action:@selector(actionCancel:)];
    [self.navigationItem setTitle:NSLocalizedString(@"title_rsdate", @"")];
    self.navigationController.navigationBar.translucent = NO;

    NSDate *todayDate = [NSDate date];
    [objDatePicker setMinimumDate:todayDate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)actionCancel:(id)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)actionNext:(id)sender {
    NSDate *chosen = [objDatePicker date];
    NSDateFormatter *objDateFormatter = [[NSDateFormatter alloc]init];
    [objDateFormatter setDateFormat:@"yyyy-MM-dd HH:MM"];
    
    NSString *strDate = [objDateFormatter stringFromDate:chosen];
    
    [[NSUserDefaults standardUserDefaults]setObject:strDate forKey:@"Key_ReservationDate"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    bookingViewController *objBookRide = [[bookingViewController alloc]initWithNibName:@"bookingViewController" bundle:nil];
    //objBookRide.isShowBookedRide = NO;
    
//    BookRide *objBookRide = [[BookRide alloc]initWithNibName:@"BookRide" bundle:nil];
//    objBookRide.isShowBookedRide = NO;
    [self.navigationController pushViewController:objBookRide animated:YES];
}
@end
