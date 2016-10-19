//
//  AppDelegate.h
//  Taxi
//
//  Created by TechnoMac-2 on 9/15/14.
//  Copyright (c) 2014 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IIViewDeckController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <Smooch/Smooch.h>
#import "SideViewController.h"
#import "MapViewController.h"
#import "SplashView.h"
//#import "HomeViewController.h"
#import "GetTaxi.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,IIViewDeckControllerDelegate>{
    
    // Object of Window
    UIWindow *window;
    
    // Object of viewDeckController
    IIViewDeckController* deckController;
    
    // Object of SideViewController
    SideViewController *objSideViewController;
    
    // Object of HomeViewController
    MapViewController *objMapViewController;
    
    // Object of SplashView
    SplashView *objSplashView;
    
    // Object of HomeViewController
   // HomeViewController *objHomeViewController;
    
    // Object of GetTaxi
    GetTaxi *objGetTaxi;
    
    // Object of TempNavigationController
    UINavigationController *tempNavigationController;
    
    // Object of NavigationController
    UINavigationController *navigationController;
    
    // Label for Header
    UILabel *lblTitleLabel;
    
    UIButton *leftBarButtonForMenu;
    
    // String for Standard Link
    NSString *strAPI;
}

@property (strong, nonatomic) UIWindow *window;

// Google API Key
@property (strong, nonatomic) NSString *kGoogleAPIKey;
@property ( nonatomic) int Tag;
@property (strong, nonatomic) UINavigationController *deckNavigationController;
@property (strong, nonatomic) IIViewDeckController* deckController;
//@property (strong, nonatomic) UILabel *lblTitleLabel;
@property (strong, nonatomic) UIButton *leftBarButtonForMenu;
// String for Standard Link
@property (strong, nonatomic) NSString *strAPI;

@end
