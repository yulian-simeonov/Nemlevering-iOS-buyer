//
//  SplashView.h
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 1/6/15.
//  Copyright (c) 2015 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"

#import "CreateProfile.h"
#import "GetTaxi.h"
#import "ForgotPassword.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#define ACCEPTABLE_CHARECTERS @"0123456789."
#define ALPHA                   @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "
#define NUMERIC                 @"1234567890"
#define ALPHA_NUMERIC ALPHA NUMERIC

@interface SplashView : UIViewController<GMSMapViewDelegate, UITextFieldDelegate>
{
    // Object of Signin Button
    IBOutlet UIButton *btnSignIn;
    
    // Object of Register Button
    IBOutlet UIButton *btnRegister;
    
    // Object of Forgot Password Button
    IBOutlet UIButton *btnForgotPassword;
    
    // View for Register
    IBOutlet UIView *viewRegister;
    
    // View for Signin
    IBOutlet UIView *viewSignIn;
    
    // View for Splash
    IBOutlet UIView *viewSplash;
    
    // Flag for Registration or SignIn
    BOOL isRegister;
    
    // Object of MapViewController
    MapViewController *objMapViewController;
    
    //HomeViewController *objHomeViewController;
    
    CreateProfile *objCreateProfile;
    
    GetTaxi *objGetTaxi;
    
    IBOutlet UITableView *tblCreateProfile;
    NSArray *arrCreateProfile;
    
    IBOutlet UITableView *tblSignIn;
    NSArray *arrSignIn;
    
    IBOutlet UITextField *txtLoginEmail;
    IBOutlet UITextField *txtloginPassword;
    IBOutlet UITextField *txtRegEmail;
    IBOutlet UITextField *txtRegPasseord;
     UITextField *txtMobile;
    IBOutlet UITextField *txtMobileNo;
    IBOutlet UIButton *objbtnRemember;
    BOOL btnselection;
    
     IBOutlet FBSDKLoginButton *fbLogin;
    
    int ffbTag;
    
    BOOL isrememberTmp;
    
    /// view display
     IBOutlet UIView *objViewDisplay;
    
     IBOutlet UIButton *btnSign;
    
     IBOutlet UILabel *lblSIgnIN;
    
     IBOutlet UIButton *btnRegitration;
    
     IBOutlet UILabel *lblRegistration;
    
    IBOutlet UITextField *txtCoutyCode;
    int EffectTag;
    
}
@property(strong,nonatomic)NSString *strImageBase64;
- (IBAction)btnSignInPressed:(id)sender;
- (IBAction)btnRemeberPressed:(id)sender;
// Registration back btn
- (IBAction)btnReg_backPressed:(id)sender;
- (IBAction)btnReg_nextPressed:(id)sender;

// Action of Register Button
- (IBAction)actionRegister:(id)sender;

// Action of SignIn Button
- (IBAction)actionSignIn:(id)sender;
- (IBAction)fbLoginbtnPressed:(id)sender;

// Action of ForgotPassword
- (IBAction)actionForgotPassword:(id)sender;

///view Display
- (IBAction)btnBackAction:(id)sender;
- (IBAction)btnSIgnAction:(id)sender;
- (IBAction)btnRegistrationPressed:(id)sender;





@end
