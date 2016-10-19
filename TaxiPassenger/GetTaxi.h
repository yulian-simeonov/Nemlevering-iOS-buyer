//
//  GetTaxi.h
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 3/17/15.
//  Copyright (c) 2015 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "EnterPromoCode.h"
#import "SelectVehicalViewController.h"
#import "EDStarRating.h"


@interface GetTaxi : UIViewController<GMSMapViewDelegate, EDStarRatingProtocol, UIActionSheetDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate,GMSAutocompleteTableDataSourceDelegate,UIGestureRecognizerDelegate,GMSAutocompleteViewControllerDelegate>
{
    // Tabbar View
    IBOutlet UIView *viewTabbar;
    
    // Button for Select Car for Ride
    IBOutlet UIButton *btnSelectCar;
    
    // Button for Set PickupLocation and Send Request to Nearest Driver
    IBOutlet UIButton *btnRequestPickup;
    
    // Button for Select Set PickupLocation
    IBOutlet UIButton *btnSetPickupLocation;
    
    // Label for Remaining Time
    IBOutlet UILabel *lblRemainingTime;
    
    // Imageview of Center Pin
    IBOutlet UIImageView *imgViewCenterPin;
    
    // Button for Select Pickup Address
    IBOutlet UIButton *btnPickupAddress;
    
    // Button for Select Destination Address
    IBOutlet UIButton *btnDestinationAddress;
    
    // view for Invoice
    IBOutlet UIView *viewInvoice;
    
    // Label of Ride Fare
    IBOutlet UILabel *lblRideFare;
    
    // Label for Discount Rate
    IBOutlet UILabel *lblDiscountRate;
    
    IBOutlet UILabel *lblTotalFare;
    IBOutlet UILabel *lblPromoCode;
    // Button to Submit Information
    IBOutlet UIButton *btnSubmit;
    
    // Label for TripDuration
    IBOutlet UILabel *lblTripDuration;
    
    // View for Search Address
    IBOutlet UIView *viewSearchAddress;
    
    // Searchbar for Search Address
    IBOutlet UISearchBar *searchBarAddress;
    
    // TableView for Display Searched Address
    IBOutlet UITableView *tblSearchAddress;
    
    // Action Sheet for Select Car
    UIActionSheet *objActionSheet;
    
    // ActivityIndicator for Search Remaining Time
    UIActivityIndicatorView *objActivityIndicator;
    
    // Timer for Update All Driver Location
    NSTimer *timerUpdateAllDriver;
    
    // Timer for Get Driver Address and Get Remaining Time
    NSTimer *timerMapViewScroll;
    
    UIAlertController *openpop;
    
    // Timer for Update SelectedDriverLocation
    NSTimer *timerUpdateRideLocation;
    
    // Store Current Location
    CLLocation *currentLocation;
    
    int tagAuto;
    
    // Array for Driver List
    NSMutableArray *arrDriverList;
    
    
    NSString *CoordPickup;
    
    NSString *CoordDestination;
    
    // Array for Nearest Driver
    NSMutableArray *arrNearestDriver;
    
    NSMutableArray *arrDriverMarkers;
    
    // Boolean for Select Pickup or Destination
    BOOL isPickupSelected;
    BOOL isbooked;
    
    // Boolean for Set PickupLocation
    BOOL isSetPickupLocation;
    
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
    
    // Marker for Ride Selected Driver
    GMSMarker *markerDriver;
    IBOutlet UIImageView *imgViewDriverProfile;
    IBOutlet UILabel *lblDriverName;
    
    
    IBOutlet UIButton *btnEnterPromoCode;
    
    IBOutlet UIButton *objbtnBook;
   
    BOOL isAlerShow;
    BOOL isTagDriver;
    
    IBOutlet UIButton *btnVan;
    IBOutlet UIButton *btnBozTuck;
    IBOutlet UIButton *btnBerlingo;
    IBOutlet UIButton *btnBike;
    IBOutlet UILabel *lblPIckUp;
    IBOutlet UILabel *lblDestination;
    
    NSString *strselectedCar;
    
    int btntag;
    
    IBOutlet UILabel *lblChange;
}

@property (strong, nonatomic) IBOutlet GMSMapView *objMapView;
@property (strong, nonatomic) IBOutlet EDStarRating *viewRatingToDriver;
@property (nonatomic, retain) CLLocationManager *objLocationManager;
@property (strong, nonatomic) NSString *strRatingValue;
//@property(assign)int selectedCar;

- (IBAction)actionSelectCar:(id)sender;
- (IBAction)actionRequestPickup:(id)sender;
- (IBAction)actionSetPickupLocation:(id)sender;
- (IBAction)actionPickupAddress:(id)sender;
- (IBAction)actionDestinationAddress:(id)sender;
- (IBAction)actionSubmit:(id)sender;
- (IBAction)actionEnterPromoCode:(id)sender;
- (IBAction)btnBookPressed:(id)sender;
- (IBAction)tabbtnPressed:(id)sender;
@end
