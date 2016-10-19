//
//  DriverListViewController.h
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 9/25/14.
//  Copyright (c) 2014 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "DriverLocationViewController.h"
#import "DriverProfileViewController.h"

@interface DriverListViewController : UIViewController{
    
    // TableView for Driver List
    IBOutlet UITableView *tblDriverList;
    
    // Array for Driver Name
    NSMutableArray *arrDriverList;
    
    // BackgroundView for Cell
    UIView *viewForCellSelected;
    
    // Object of DriverProfileViewController
    DriverProfileViewController *objDriverProfileViewController;
}
- (IBAction)actionCancel:(id)sender;

@end
