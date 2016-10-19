//
//  DriverProfileViewController.h
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 9/26/14.
//  Copyright (c) 2014 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RateView.h"

@interface DriverProfileViewController : UIViewController<RatingViewDelegate>{
    RateView *rateView;
    IBOutlet UIButton *btnTextDriver;
    IBOutlet UIButton *btnCallDriver;
    IBOutlet UIView *viewDriver;
    IBOutlet UIImageView *imgDriverProfile;
    IBOutlet UILabel *lblDriverName;
    IBOutlet UIImageView *imgCarImage;
    IBOutlet UILabel *lblCarName;
    IBOutlet UIButton *btnSendRequest;
}
@property (strong, nonatomic) NSString *strDriverId;
@property (strong, nonatomic) NSString *strDriverName;

- (IBAction)isTextDriverButtonClicked:(id)sender;
- (IBAction)actionSendRequest:(id)sender;

@end
