//
//  TripForLostAndFound.h
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 3/26/15.
//  Copyright (c) 2015 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReportForLostAndFound.h"

@interface TripForLostAndFound : UIViewController
{
    IBOutlet UITableView *tblRecentTrips;
    
    NSMutableArray *arrRecentTrips;
    
    UILabel *lblSource;
    
    UILabel *lblDest;

}
@end
