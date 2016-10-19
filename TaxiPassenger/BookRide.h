//
//  BookRide.h
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 3/24/15.
//  Copyright (c) 2015 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookRide : UIViewController<UIActionSheetDelegate,UINavigationControllerDelegate,GMSMapViewDelegate>{
    UIActionSheet *objActionSheet;
    IBOutlet UIButton *btnSelectCar;
    IBOutlet UIImageView *imgViewCenterPin;
    
    // Button for Select Set PickupLocation
    IBOutlet UIButton *btnSetPickupLocation;
    

    // Timer for Get Driver Address and Get Remaining Time
    NSTimer *timerMapViewScroll;
    
    // Store Current Location
    CLLocation *currentLocation;
    
    // Boolean for Select Pickup or Destination
    BOOL isPickupSelected;
    
    // Updated Camera Position
    CLLocationCoordinate2D coorCameraPosition;
    
    // Pickup Location
    CLLocationCoordinate2D coorPickup;
    
    // Destination Location
    CLLocationCoordinate2D coorDestination;
    
    // Marker for Pickup Ride
    GMSMarker *markerPickup;
    
    // Marker for Destination
    GMSMarker *markerDestination;
    
    // Button for Select Pickup Address
    IBOutlet UIButton *btnPickupAddress;
    
    // Button for Select Destination Address
    IBOutlet UIButton *btnDestinationAddress;
    
    IBOutlet UIButton *btnRequestPickup;
    
    // Boolean for Set PickupLocation
    BOOL isSetPickupLocation;
    
    BOOL isStopMoving;

    IBOutlet UIView *viewBottom;
    
    BOOL isStopUpdate;
}
@property (nonatomic) BOOL isShowBookedRide;
@property (strong, nonatomic) NSDictionary *dicRideInfo;
@property (strong, nonatomic) IBOutlet GMSMapView *objMapView;
- (IBAction)actionSelectCar:(id)sender;
- (IBAction)actionSetPickDestPoint:(id)sender;
- (IBAction)actionSetPickupLocation:(id)sender;
@end
