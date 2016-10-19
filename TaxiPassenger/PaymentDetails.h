//
//  PaymentDetails.h
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 1/7/15.
//  Copyright (c) 2015 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import <Braintree/Braintree.h>
#import "CardIOPaymentViewControllerDelegate.h"
#import "CardIO.h"
//#import "HomeViewController.h"
#import "SplashView.h"
#import "Card.h"
#import "ADYEncrypter.h"




#define kToken @"eyJ2ZXJzaW9uIjoxLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiIzZTgwZDM0OTAwYWNmNTZlNGMyNDUwZjFjMzhjYTA3MWM1YzRkZTIyZTM5ZjFkZjU1Y2JlMGZkMjQ2ZDMxMTI0fGNyZWF0ZWRfYXQ9MjAxNC0wOS0yM1QxMzoyMjozNC4xMzAwMDk1OTIrMDAwMFx1MDAyNm1lcmNoYW50X2lkPWRjcHNweTJicndkanIzcW5cdTAwMjZwdWJsaWNfa2V5PTl3d3J6cWszdnIzdDRuYzgiLCJjb25maWdVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvZGNwc3B5MmJyd2RqcjNxbi9jbGllbnRfYXBpL3YxL2NvbmZpZ3VyYXRpb24iLCJjaGFsbGVuZ2VzIjpbXSwicGF5bWVudEFwcHMiOltdLCJjbGllbnRBcGlVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvZGNwc3B5MmJyd2RqcjNxbi9jbGllbnRfYXBpIiwiYXNzZXRzVXJsIjoiaHR0cHM6Ly9hc3NldHMuYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhdXRoVXJsIjoiaHR0cHM6Ly9hdXRoLnZlbm1vLnNhbmRib3guYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhbmFseXRpY3MiOnsidXJsIjoiaHR0cHM6Ly9jbGllbnQtYW5hbHl0aWNzLnNhbmRib3guYnJhaW50cmVlZ2F0ZXdheS5jb20ifSwidGhyZWVEU2VjdXJlRW5hYmxlZCI6ZmFsc2UsInBheXBhbEVuYWJsZWQiOnRydWUsInBheXBhbCI6eyJkaXNwbGF5TmFtZSI6IkFjbWUgV2lkZ2V0cywgTHRkLiAoU2FuZGJveCkiLCJjbGllbnRJZCI6bnVsbCwicHJpdmFjeVVybCI6Imh0dHA6Ly9leGFtcGxlLmNvbS9wcCIsInVzZXJBZ3JlZW1lbnRVcmwiOiJodHRwOi8vZXhhbXBsZS5jb20vdG9zIiwiYmFzZVVybCI6Imh0dHBzOi8vYXNzZXRzLmJyYWludHJlZWdhdGV3YXkuY29tIiwiYXNzZXRzVXJsIjoiaHR0cHM6Ly9jaGVja291dC5wYXlwYWwuY29tIiwiZGlyZWN0QmFzZVVybCI6bnVsbCwiYWxsb3dIdHRwIjp0cnVlLCJlbnZpcm9ubWVudE5vTmV0d29yayI6dHJ1ZSwiZW52aXJvbm1lbnQiOiJvZmZsaW5lIiwibWVyY2hhbnRBY2NvdW50SWQiOiJzdGNoMm5mZGZ3c3p5dHc1IiwiY3VycmVuY3lJc29Db2RlIjoiVVNEIn19"

@interface PaymentDetails : UIViewController<CardIOPaymentViewControllerDelegate>{
    
    IBOutlet UIButton *btnScanCard;
    IBOutlet UITableView *tblPaymentDetails;
}

// Braintree's nonce object
@property (strong, nonatomic) NSString *nonce;
@property(strong,nonatomic)NSString *AdyanKey;
@property (strong, nonatomic) NSString *clientToken;
@property (strong, nonatomic) Braintree *objBraintree;

- (IBAction)actionScanCard:(id)sender;
- (IBAction)btnSigninPressed:(id)sender;
- (IBAction)btnRegidterPressed:(id)sender;
- (IBAction)btnBackPressed:(id)sender;
- (IBAction)btnDonePressed:(id)sender;

@end
