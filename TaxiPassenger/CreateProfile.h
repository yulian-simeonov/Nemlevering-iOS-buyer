//
//  CreateProfile.h
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 1/7/15.
//  Copyright (c) 2015 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentDetails.h"

@interface CreateProfile : UIViewController<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate>
{
    // TableView of Profile FirstName & LastName
    IBOutlet UITableView *tblProfile;
    
    // ProfilePic Button
    IBOutlet UIImageView *imgViewProfile;
    
    // TextField First Name and Last Name
   //  UITextField *txtFirstName;
    // UITextField *txtLastName;
    IBOutlet UITextField *txtFirstname;
    IBOutlet UITextField *txtLastname;
    
    // Profile Array
    NSArray *arrProfile;
    
    // PaymentDetails Viewcontroller
    PaymentDetails *objPaymentDetails;
    
    UIActionSheet *objActionSheet;
    
    UIImagePickerController *imgPickerController;
}
- (IBAction)btnBackPresssed:(id)sender;
- (void)actionProfileImage:(id)sender;
- (IBAction)btnNextPressed:(id)sender;
- (IBAction)btnSignInPressed:(id)sender;
- (IBAction)btnRegistrationPressed:(id)sender;

@end
