//
//  bookingViewController.h
//  Taxi App
//
//  Created by TechnoMac-12 on 27/06/16.
//  Copyright © 2016 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface bookingViewController : UIViewController<GMSMapViewDelegate, EDStarRatingProtocol, UIActionSheetDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate,GMSAutocompleteTableDataSourceDelegate,UIGestureRecognizerDelegate,GMSAutocompleteViewControllerDelegate>
{
    IBOutlet UIButton *btnObjBook;
    
    IBOutlet UIImageView *imgViewCenterPin;
    IBOutlet GMSMapView *objMapView;
    
     int btntag;
    
    IBOutlet UIButton *btnBike;
    IBOutlet UIButton *btnBarlingo;
    IBOutlet UIButton *btnBokTruk;
    IBOutlet UIButton *btnVan;
    IBOutlet UIButton *btnMoreVehicles;
    
    IBOutlet UILabel *lblChange;
    
    
    // Store Current Location
    CLLocation *currentLocation;
    
    NSString *CoordPickup;
    
    NSString *CoordDestination;
    
    
    // Button for Select Pickup Address
    IBOutlet UIButton *btnPickupAddress;
    
    // Button for Select Destination Address
    IBOutlet UIButton *btnDestinationAddress;
    

     int tagAuto;
    
    // Boolean for Select Pickup or Destination
    BOOL isPickupSelected;
    BOOL isbooked;
    BOOL isSetPickupLocation;
    BOOL isStopMoving;
    
    IBOutlet UILabel *lblPIckUp;
    IBOutlet UILabel *lblDestination;
    
    // Updated Camera Position
    CLLocationCoordinate2D coorCameraPosition;
    
    // Pickup Location
    CLLocationCoordinate2D coorPickup;
    
    // Destination Location
    CLLocationCoordinate2D coorDestination;
    
    GMSMarker *markerPickup;
    GMSMarker *markerDestination;
    
    // Timer for Get Driver Address and Get Remaining Time
    NSTimer *timerMapViewScroll;
    
    BOOL isStopUpdate;

    
}
@property (strong, nonatomic) NSDictionary *dicRideInfo;
@property (strong, nonatomic) IBOutlet GMSMapView *objMapView;
@property (nonatomic, retain) CLLocationManager *objLocationManager;
- (IBAction)btnSelectVehicles:(id)sender;

- (IBAction)btnClickBook:(id)sender;
-(IBAction)actionPickupAddress:(id)sender;
-(IBAction)actionDestinationAddress:(id)sender;

@end
