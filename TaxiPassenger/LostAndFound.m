//
//  LostAndFound.m
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 3/26/15.
//  Copyright (c) 2015 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import "LostAndFound.h"

@interface LostAndFound ()

@end

@implementation LostAndFound

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: NSLocalizedString(@"btn_cancel", @"") style: UIBarButtonItemStylePlain target:self action:@selector(actionCancelReport:)];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationItem setTitle:NSLocalizedString(@"txt_lf", @"")];
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationItem setTitle:NSLocalizedString(@"btn_back", @"")];
}
- (void)actionCancelReport:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [appdelegate.deckController closeLeftViewAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionLost:(id)sender {
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"Key_Lost"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    objTripForLostAndFound = [[TripForLostAndFound alloc]initWithNibName:@"TripForLostAndFound" bundle:nil];
    [self.navigationController pushViewController:objTripForLostAndFound animated:YES];
    
}

- (IBAction)actionFound:(id)sender {
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"Key_Lost"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    objTripForLostAndFound = [[TripForLostAndFound alloc]initWithNibName:@"TripForLostAndFound" bundle:nil];
    [self.navigationController pushViewController:objTripForLostAndFound animated:YES];
    
}
@end
