//
//  Profile.h
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 3/10/15.
//  Copyright (c) 2015 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface Profile : UIViewController<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate>{
    
    IBOutlet UIImageView *imgViewProfile;
    IBOutlet UITableView *tblViewName;
    IBOutlet UITableView *tblViewAccount;
    
    NSArray *arrProfile;
    NSArray *arrAccount;
    
    // TextField First Name and Last Name
    UITextField *txtFirstName;
    UITextField *txtLastName;
    UITextField *txtEmail;
    UITextField *txtMobile;
    UITextField *txtPassword;
    
    IBOutlet NSLayoutConstraint *TableViewHight;
    BOOL isEditProfile;
    
    UIActionSheet *objActionSheet;
    
    UIImagePickerController *imgPickerController;

    NSString *base64Encoded;
}

@end
