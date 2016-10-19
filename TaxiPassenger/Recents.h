//
//  Recents.h
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 3/11/15.
//  Copyright (c) 2015 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecentDetails.h"

@interface Recents : UIViewController<UIGestureRecognizerDelegate>
{
    IBOutlet UITableView *tblRecentTrips;
    
    NSMutableArray *arrRecentTrips;
    
    UILabel *lblSource;
    
    UILabel *lblDest;
    
}

@end
