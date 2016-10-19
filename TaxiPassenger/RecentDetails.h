//
//  RecentDetails.h
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 3/13/15.
//  Copyright (c) 2015 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TripDetails.h"

@interface RecentDetails : UIViewController{
    
    IBOutlet UITableView *tblRecentDetail;
    
    IBOutlet UIView *viewMapView;
    // Object of Pickup Marker
    GMSMarker *markerPickup;
    // Object of Destination Marker
    GMSMarker *markerDestination;

}
@property (strong, nonatomic) IBOutlet GMSMapView *objMapView;
@property (strong, nonatomic) NSDictionary *dicRecentDetails;
@end
