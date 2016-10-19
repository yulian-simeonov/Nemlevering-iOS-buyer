//
//  EnterPromoCode.h
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 4/7/15.
//  Copyright (c) 2015 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EnterPromoCode : UIViewController
{
    
    IBOutlet UITextField *txtPromoCode;
}
- (IBAction)actionCancel:(id)sender;
- (IBAction)actionDone:(id)sender;
@end
