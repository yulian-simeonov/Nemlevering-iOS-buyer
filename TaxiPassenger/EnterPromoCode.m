//
//  EnterPromoCode.m
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 4/7/15.
//  Copyright (c) 2015 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import "EnterPromoCode.h"

@interface EnterPromoCode ()

@end

@implementation EnterPromoCode

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [txtPromoCode becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionCancel:(id)sender {
    [appdelegate.deckNavigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)actionDone:(id)sender {
    
    NSString *strPromoCode = txtPromoCode.text;
    
    if ([strPromoCode length]==0) {
        [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"alert_entpm", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles:nil]show];
    }
    else
    {
        
        NSString *strDriverId = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_Driver_Id"];
        
        // URL String
        NSString *stringPost = [NSString stringWithFormat:@"http://54.153.20.98/api/android/send_promocode.php"];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        // Set Acceptable Contenttype of Response
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        
        NSDictionary *params = @{@"driver_id":strDriverId,@"promo_code":strPromoCode};
        
        [manager GET:stringPost parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            // Get Encoding Data in Dictionary
            NSDictionary *responseDictionary = responseObject;
            [appdelegate.deckNavigationController dismissViewControllerAnimated:YES completion:nil];

            NSLog(@"send_promocode.php >>> %@",responseDictionary);
            if ([[responseDictionary objectForKey:@"success"]isEqualToString:@"1"]) {
                [[NSUserDefaults standardUserDefaults]setObject:strPromoCode forKey:@"Key_PromoCode"];
                [[NSUserDefaults standardUserDefaults]synchronize];
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"alert_srvr", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles:nil]show];
        }];   
    }
}
@end
