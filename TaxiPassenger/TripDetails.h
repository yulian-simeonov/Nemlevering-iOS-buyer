//
//  TripDetails.h
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 3/13/15.
//  Copyright (c) 2015 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TripDetails : UITableViewCell
{
    
}

@property (strong, nonatomic) IBOutlet UIImageView *imgViewProfile;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblStatusDetails;
@property (strong, nonatomic) IBOutlet UILabel *lblTotalFareDetails;
@property (strong, nonatomic) IBOutlet UILabel *lblCardNo;
@property (strong, nonatomic) IBOutlet UILabel *lblFareCharged;

@end
