//
//  LostAndFound.h
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 3/26/15.
//  Copyright (c) 2015 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TripForLostAndFound.h"

@interface LostAndFound : UIViewController{
    
    IBOutlet UIButton *btnLost;
    IBOutlet UIButton *btnFound;
    
    TripForLostAndFound *objTripForLostAndFound;
}
- (IBAction)actionLost:(id)sender;
- (IBAction)actionFound:(id)sender;

@end
