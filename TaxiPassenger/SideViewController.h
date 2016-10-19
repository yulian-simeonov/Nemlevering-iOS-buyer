//
//  SideViewController.h
//  Taxi
//
//  Created by TechnoMac-2 on 9/15/14.
//  Copyright (c) 2014 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DriverListViewController.h"
#import "DriverProfileViewController.h"
#import "SplashView.h"
#import "Profile.h"
#import "Recents.h"
#import "Reservation.h"
#import "CreditCardDetails.h"
#import "LostAndFound.h"
#import "ShareSocially.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface SideViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
{
    
    // Object for Tableview
    IBOutlet UITableView *tblSideView;
    
    // Object for ImageView
    IBOutlet UIImageView *imgProfileImage;

    
    // Object for Profile Name
    IBOutlet UILabel *lblProfileName;
    
    IBOutlet UIButton *btnProfile;
    
    UIImageView *imgProfileImage1;
    UILabel *lblProfileName1;
    UIButton *btnProfile1;
    
    // Array for Menu
    NSMutableArray *arrMenu;
    
    // Array of Image
    NSMutableArray *arrImages;
    
    // BackgroundView for Cell
    UIView *viewForCellSelected;
}

@property (strong, nonatomic) IBOutlet EDStarRating *objDriver_rating;
@property(strong ,nonatomic) EDStarRating *objDriver_rating1;

- (IBAction)actionChangeProfile:(id)sender;
- (IBAction)btnLogoutPressed:(id)sender;

@end
