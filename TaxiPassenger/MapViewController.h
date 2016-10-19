//
//  MapViewController.h
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 10/8/14.
//  Copyright (c) 2014 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>
#import "JSON.h"
#import <AFNetworking/AFNetworking.h>
#import <Braintree/Braintree.h>
#import "CardIOPaymentViewControllerDelegate.h"
#import "CardIO.h"


#define kToken @"eyJ2ZXJzaW9uIjoxLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiIzZTgwZDM0OTAwYWNmNTZlNGMyNDUwZjFjMzhjYTA3MWM1YzRkZTIyZTM5ZjFkZjU1Y2JlMGZkMjQ2ZDMxMTI0fGNyZWF0ZWRfYXQ9MjAxNC0wOS0yM1QxMzoyMjozNC4xMzAwMDk1OTIrMDAwMFx1MDAyNm1lcmNoYW50X2lkPWRjcHNweTJicndkanIzcW5cdTAwMjZwdWJsaWNfa2V5PTl3d3J6cWszdnIzdDRuYzgiLCJjb25maWdVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvZGNwc3B5MmJyd2RqcjNxbi9jbGllbnRfYXBpL3YxL2NvbmZpZ3VyYXRpb24iLCJjaGFsbGVuZ2VzIjpbXSwicGF5bWVudEFwcHMiOltdLCJjbGllbnRBcGlVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvZGNwc3B5MmJyd2RqcjNxbi9jbGllbnRfYXBpIiwiYXNzZXRzVXJsIjoiaHR0cHM6Ly9hc3NldHMuYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhdXRoVXJsIjoiaHR0cHM6Ly9hdXRoLnZlbm1vLnNhbmRib3guYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhbmFseXRpY3MiOnsidXJsIjoiaHR0cHM6Ly9jbGllbnQtYW5hbHl0aWNzLnNhbmRib3guYnJhaW50cmVlZ2F0ZXdheS5jb20ifSwidGhyZWVEU2VjdXJlRW5hYmxlZCI6ZmFsc2UsInBheXBhbEVuYWJsZWQiOnRydWUsInBheXBhbCI6eyJkaXNwbGF5TmFtZSI6IkFjbWUgV2lkZ2V0cywgTHRkLiAoU2FuZGJveCkiLCJjbGllbnRJZCI6bnVsbCwicHJpdmFjeVVybCI6Imh0dHA6Ly9leGFtcGxlLmNvbS9wcCIsInVzZXJBZ3JlZW1lbnRVcmwiOiJodHRwOi8vZXhhbXBsZS5jb20vdG9zIiwiYmFzZVVybCI6Imh0dHBzOi8vYXNzZXRzLmJyYWludHJlZWdhdGV3YXkuY29tIiwiYXNzZXRzVXJsIjoiaHR0cHM6Ly9jaGVja291dC5wYXlwYWwuY29tIiwiZGlyZWN0QmFzZVVybCI6bnVsbCwiYWxsb3dIdHRwIjp0cnVlLCJlbnZpcm9ubWVudE5vTmV0d29yayI6dHJ1ZSwiZW52aXJvbm1lbnQiOiJvZmZsaW5lIiwibWVyY2hhbnRBY2NvdW50SWQiOiJzdGNoMm5mZGZ3c3p5dHc1IiwiY3VycmVuY3lJc29Db2RlIjoiVVNEIn19"

@interface MapViewController : UIViewController<GMSMapViewDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource,BTDropInViewControllerDelegate, UIActionSheetDelegate, CardIOPaymentViewControllerDelegate>{
    
    // Object of Search Bar
    UISearchBar *srchPickup;
    UISearchBar *srchDestination;
    
    // View for Driver Information
    UIView *viewDriverInfo;
    
    // Object of Google Map View
    GMSMapView *mapView_;
    
    // Object of Marker
    GMSMarker *markerPickup;
    GMSMarker *markerDestination;
    
    // Object of GeoCoder
    GMSGeocoder *geoCoder_;
    
    // Coordinate of Pickup & Destination
    CLLocationCoordinate2D coorPickup;
    CLLocationCoordinate2D coorDestination;
    
    // Pin Image in Center
    UIImageView *imgCenterPin;
    
    // Object for Address
    UILabel *lblAddress;
    UIButton *btnSelectLocation;
    
    // Objects for Tabbar View
    UIView *viewTabbar;
    UIButton *btnTabbarSearch;
    UIButton *btnSelectCar;
    UIButton *btnTabbarPhone;
    UIActionSheet *objActionSheet;
    
    // Objects for SearchView
    UIView *viewSearch;
    UIButton *btnSearchViewCancel;
    UILabel *lblSearchLabel;
    UILabel *lblFromLabel;
    UILabel *lblToLabel;
    UITextField *txtPickupLocation;
    UITextField *txtDestinationLocation;
    UIButton *btnCurrentLocation;
    UIButton *btnReserve;
    UIButton *btnScanCard;
    UIImageView *imgLine;
    
    // Array for Search Address
    NSMutableArray *arrSearchAddress;
    // TableView for Search Address
    UITableView *tblSearchView;
    
    // Braintree's Object
    Braintree *objBraintree;
    
    // Near by Driver
    NSMutableArray *arrDriverList;
    
}

// Braintree's nonce object
@property (strong, nonatomic) NSString *nonce;

// Called When Select btnSelectLocation
-(void)isLocationSelected:(id)sender;

// Called When Select btnTabbarSearch
- (void)isTabbarSearchButtonSelected:(id)sender;

// Called When Select btnSelect Car from TabBar
- (void)isTabbarSelectCarButtonSelected:(id)sender;

// Called When Select Cancel Button from Search View
- (void)isSearchViewCancel:(id)sender;

// Called When Select Reserve Button
-(void)isReserveSelected:(id)sender;

// Called When Select Scancard Button
-(void)isScanCardButtonSelected:(id)sender;

@end
