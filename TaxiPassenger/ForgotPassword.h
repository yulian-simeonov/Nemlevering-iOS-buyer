//
//  ForgotPassword.h
//  TaxiDriver
//
//  Created by TechnoMac-2 on 3/27/15.
//  Copyright (c) 2015 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPassword : UIViewController<UIWebViewDelegate>
{
    
    //Object of Register Button
    IBOutlet UITextField *txtEmailAddress;
    
    /*! Is false if download is already in progress */

    IBOutlet UIWebView *objwebview;
    
    IBOutlet UIActivityIndicatorView *activityIndicator;
}

/*!
 @brief
 
 @discussion sdfsdfd.
 
 @param checkString. hhfdjgvjkdg
 
 @return sdfsdfdsfdsf.
 */
-(BOOL) NSStringIsValidEmail:(NSString *)checkString;
- (IBAction)actionCancel:(id)sender;
- (IBAction)actionReset:(id)sender;

@end
