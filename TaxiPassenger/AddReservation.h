//
//  AddReservation.h
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 3/24/15.
//  Copyright (c) 2015 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookRide.h"
#import "bookingViewController.h"

@interface AddReservation : UIViewController{
    
    IBOutlet UIDatePicker *objDatePicker;
}
- (IBAction)actionNext:(id)sender;

@end
