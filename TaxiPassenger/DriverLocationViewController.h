//
//  DriverLocationViewController.h
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 9/29/14.
//  Copyright (c) 2014 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DriverLocationViewController : UIViewController<GMSMapViewDelegate>
{
    // View for Driver Information
    UIView *viewDriverInfo;
    
    // Object of Google Map View
    GMSMapView *mapView_;
    
    // Object of Marker
    GMSMarker *markerPickup;
    GMSMarker *markerDestination;
    
    // Object of GeoCoder
    GMSGeocoder *geoCoder_;
    
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
}

@property (nonatomic, assign) float latitude;
@property (nonatomic, assign) float longitude;

@end
