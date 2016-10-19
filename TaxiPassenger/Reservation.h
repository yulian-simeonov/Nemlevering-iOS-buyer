//
//  Reservation.h
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 3/24/15.
//  Copyright (c) 2015 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddReservation.h"
#import "BookRide.h"

@interface Reservation : UIViewController<UIGestureRecognizerDelegate>
{
    IBOutlet UITableView *tblReservation;
    NSMutableArray *arrReservation;
}
@end
