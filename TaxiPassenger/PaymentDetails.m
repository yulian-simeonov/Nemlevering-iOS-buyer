//
//  PaymentDetails.m
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 1/7/15.
//  Copyright (c) 2015 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import "PaymentDetails.h"
#import "FBEncryptorAES.h"
#define CardIOAppToken @"7d8580d2cc9f4e38a7cf3b6a1c142351"

@interface PaymentDetails ()

@end

@implementation PaymentDetails

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: NSLocalizedString(@"btn_cancel", @"") style: UIBarButtonItemStylePlain target:self action:@selector(actionBack)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: NSLocalizedString(@"btn_next", @"") style: UIBarButtonItemStylePlain target:self action:@selector(actionNext)];
    
    //    objBraintree = [Braintree braintreeWithClientToken:kToken];
    
//    [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"user can enter dummy data", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles:nil]show];
}


#pragma mark ButtonAction Methods
-(void)actionBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)actionNext
{
    // URL Request String
    NSString *requestURL = [NSString stringWithFormat:@"%@register_ios_user_device_token.php",strBaseURL];
    
    // AFNetworking Request Manager
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // Set Acceptable Contenttype of Response
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *strEmail = [[NSUserDefaults standardUserDefaults] objectForKey:@"Key_Email"];
    NSString *strMobile = [[NSUserDefaults standardUserDefaults] objectForKey:@"Key_Mobile"];
    NSString *strPassword = [[NSUserDefaults standardUserDefaults] objectForKey:@"Key_Password"];
    NSString *strFirstName = [[NSUserDefaults standardUserDefaults] objectForKey:@"Key_FirstName"];
    NSString *strLastName = [[NSUserDefaults standardUserDefaults] objectForKey:@"Key_LastName"];
    NSString *strDeviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"Device_Token"];
    NSString *strCreditCardNo = [[NSUserDefaults standardUserDefaults] objectForKey:@"Key_CreditCardNo"];
    NSString *strImage = [[NSUserDefaults standardUserDefaults] objectForKey:@"Key_Image"];
    
    if ([strDeviceToken length]==0) {
        strDeviceToken = [NSString stringWithFormat:@"123456789010"];
    }
    if ([strCreditCardNo length]==0) {
        strCreditCardNo = [NSString stringWithFormat:@"4111111111111111"];
    }
    if ([strImage length] == 0) {
        strImage = [NSString stringWithFormat:@"NA"];
    }
    
    if ([self.nonce length]!=0) {
        NSDictionary *params = @{@"email":strEmail,
                                 @"mobile_no":strMobile,
                                 @"password":strPassword,
                                 @"first_name":strFirstName,
                                 @"last_name":strLastName,
                                 @"device_token":strDeviceToken,
                                 @"creadit_card_number":strCreditCardNo,
                                 @"adyen_key":self.AdyanKey,@"image_url":strImage,@"flag":@"0"};
        
        // Show Progressbar in Main View
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [manager POST:requestURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             // Set Progressbar hide from View
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             
             // Response Dictionary Received from API
             NSDictionary *dicResponse = responseObject;
             
             NSLog(@"%@",dicResponse);
             
             if ([[dicResponse objectForKey:@"status"]isEqualToString:@"1"])
             {
                 if (IPAD)
                 {
                     GetTaxi * objGetTaxi = [[GetTaxi alloc]initWithNibName:@"getTextView_Ipad" bundle:nil];
                     [appdelegate.deckNavigationController pushViewController:objGetTaxi animated:YES];
                 }
                 else
                 {
                     GetTaxi * objGetTaxi = [[GetTaxi alloc]initWithNibName:@"GetTaxi" bundle:nil];
                     
                     [appdelegate.deckNavigationController pushViewController:objGetTaxi animated:YES];
                 }
                 
                 [[NSUserDefaults standardUserDefaults]setObject:[[dicResponse objectForKey:@"passenger_info"]objectForKey:@"passenger_id"] forKey:@"Key_Passenger_Id"];
                 [[NSUserDefaults standardUserDefaults]setObject:[[dicResponse objectForKey:@"passenger_info"]objectForKey:@"image_url"] forKey:@"Key_ImageURL"];
                 [[NSUserDefaults standardUserDefaults]synchronize];
             }
             else
             {
                 [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"alert_regalrdy", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles:nil]show];
             }
         } failure:^(AFHTTPRequestOperation *operation, NSError *error)
        {
             // Set Progressbar hide from View
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             
             // Show Alert if Request Session Failed
             [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"alert_srvrerr", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles:nil]show];
             //             GetTaxi *objGetTaxi = [[GetTaxi alloc]initWithNibName:@"GetTaxi" bundle:nil];
             //            [appdelegate.deckNavigationController pushViewController:objGetTaxi animated:YES];
         }];
        //        [manager GET:requestURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //            // Set Progressbar hide from View
        //            [MBProgressHUD hideHUDForView:self.view animated:YES];
        //
        //            // Response Dictionary Received from API
        //            NSDictionary *dicResponse = responseObject;
        //
        //            NSLog(@"%@",dicResponse);
        //
        //            if ([[dicResponse objectForKey:@"status"]isEqualToString:@"1"]) {
        //                HomeViewController *objHomeViewController = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
        //                [gAppDelegate.deckNavigationController pushViewController:objHomeViewController animated:YES];
        //                [[NSUserDefaults standardUserDefaults]setObject:[[dicResponse objectForKey:@"passenger_info"]objectForKey:@"passenger_id"] forKey:@"Key_Passenger_Id"];
        //                [[NSUserDefaults standardUserDefaults]synchronize];
        //
        //            }else{
        //                [[[UIAlertView alloc]initWithTitle:@"HopOnRide" message:@"You are already registered, please signin." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
        //            }
        //
        //        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //            // Set Progressbar hide from View
        //            [MBProgressHUD hideHUDForView:self.view animated:YES];
        //
        //            // Show Alert if Request Session Failed
        ////            [[[UIAlertView alloc]initWithTitle:@"Taxi" message:@"you must enter dummy credit card details\n Card No. 4111 1111 1111 1111." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
        //        }];
    }
    else
    {
        [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"alert_card", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles:nil]show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma scan Card Btn
- (IBAction)actionScanCard:(id)sender
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // Set Acceptable Contenttype of Response
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
#pragma mark - URL Change
    
//    NSString *strURL = [NSString stringWithFormat:@"%@get_client_token.php",strBrainBaseURL];
//    
//    [manager GET:strURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
//     {
//         CardIOPaymentViewController *scanViewController = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
CardIOPaymentViewController *scanViewController = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self scanningEnabled:NO];
         
         //    scanViewController.modalPresentationStyle = UIModalPresentationFormSheet;
         //scanViewController.navigationBar.backgroundColor =[UIColor redColor];
         
         scanViewController.navigationBarTintColor=[UIColor redColor];
                 scanViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: NSLocalizedString(@"btn_back", @"") style: UIBarButtonItemStylePlain target:self action:@selector(userDidCancelPayment)];
         //    [gAppDelegate.deckNavigationController pushViewController:scanViewController animated:YES];
         [self presentViewController:scanViewController animated:YES completion:nil];
         
         // NSDictionary *dicResponse = responseObject;
         
//         self.clientToken = [responseObject objectForKey:@"client_token"];
//         
//         NSLog(@"%@",self.clientToken);
//         
//     }failure:^(AFHTTPRequestOperation *operation, NSError *error)
//    {
//         // Handle failure communicating with your server
//         NSLog(@"%@",[error description]);
//     }];
}
- (IBAction)btnSigninPressed:(id)sender
{
    NSMutableArray *allViewControllers = [NSMutableArray arrayWithArray:[self.navigationController viewControllers]];
    for (UIViewController *aViewController in allViewControllers)
    {
        if ([aViewController isKindOfClass:[SplashView class]])
        {
            appdelegate.Tag=2;
            [self.navigationController popToViewController:aViewController animated:NO];
        }
    }
}
- (IBAction)btnRegidterPressed:(id)sender
{
    NSMutableArray *allViewControllers = [NSMutableArray arrayWithArray:[self.navigationController viewControllers]];
    for (UIViewController *aViewController in allViewControllers)
    {
        if ([aViewController isKindOfClass:[SplashView class]])
        {
            appdelegate.Tag=1;
            [self.navigationController popToViewController:aViewController animated:NO];
        }
    }
}
- (IBAction)btnBackPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnDonePressed:(id)sender
{
    // URL Request String
    NSString *requestURL = [NSString stringWithFormat:@"%@register_ios_user_device_token.php",strBaseURL];
    
    // AFNetworking Request Manager
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // Set Acceptable Contenttype of Response
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *strEmail = [[NSUserDefaults standardUserDefaults] objectForKey:@"Key_Email"];
    NSString *strMobile = [[NSUserDefaults standardUserDefaults] objectForKey:@"Key_Mobile"];
    NSString *strPassword = [[NSUserDefaults standardUserDefaults] objectForKey:@"Key_Password"];
    NSString *strFirstName = [[NSUserDefaults standardUserDefaults] objectForKey:@"Key_FirstName"];
    NSString *strLastName = [[NSUserDefaults standardUserDefaults] objectForKey:@"Key_LastName"];
    NSString *strDeviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"Device_Token"];
    NSString *strCreditCardNo = [[NSUserDefaults standardUserDefaults] objectForKey:@"Key_CreditCardNo"];
    NSString *strImage = [[NSUserDefaults standardUserDefaults] objectForKey:@"Key_Image"];
    
    if ([strDeviceToken length]==0)
    {
        strDeviceToken = [NSString stringWithFormat:@"123456789010"];
    }
    if ([strCreditCardNo length]==0)
    {
        strCreditCardNo = [NSString stringWithFormat:@"4111111111111111"];
    }
    if ([strImage length] == 0)
    {
        strImage = [NSString stringWithFormat:@"NA"];
    }
    
  
    if ([self.AdyanKey length]!=0)
    {
        NSDictionary *params = @{@"email":strEmail,
                                 @"mobile_no":strMobile,
                                 @"password":strPassword,
                                 @"first_name":strFirstName,
                                 @"last_name":strLastName,
                                 @"device_token":strDeviceToken,
                                 @"creadit_card_number":strCreditCardNo,
                                 @"adyen_key":self.AdyanKey,@"image_url":strImage,@"flag":@"0",@"register":@"app"};
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [manager POST:requestURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             //{
//                 "passenger_info" =     {
//                     "adyen_key" = "adyenan0_1_1$bRGdbMsDOUzQgvONnLZAGvKEtiqpLZmXwW8FcBU8KLEw16AE4qbjDU3wYSXfEDHnAmRtaratz9MO6eHVbkQeYLH9qi1AnEVbckol7a/0O54kpKzKj70pHpcSlitBWXQD2+vzJ78xp04IrxR2Dtvup/NPRAB2MHhrNABWLY8MfBaSovEwts5NS6QWW9ysyLM4kvOAIghRVU5FEtVHIDFxqWQwM3Zou6d58GYqEFuQ7PsG5Ls0ukMVUHgoH1YbTLGjJ25vRxv1satktrVOVqXa9LuN6zFSdWulHJ36VsIli2BtSog++ZrspBXBQ6sd9nD6O+SnJgNwfa0iNl96Yx3iig==$0B5YmMu9q9n7TcWs5Qzt7TabGZgWWtLKxtydFFUAL9D2C4+qskhneIOXyxM/irgEvVCgWUwSz8zc3HFn+8x+WsxuC1TV8rFt6HXItHLjaxiX5zKsYlNGbRLpAWwxyWMCAaGAgPZBmIR3bUTXnRbqIv1npUKkEaLFePZs8WKTAW4/yoUGXsuFAPUSRBFc9R7hi5aD0S7yh/BKltESYh+Y";
//                     email = "eueruu@gmail.com";
//                     "first_name" = e;
//                     "image_url" = "http://cargo.technostacks.comimages/1128f80ecd23c44b50e8eaee48d26de7.octet-stream";
//                     "last_name" = we;
//                     mobile = jkljkl;
//                     "passenger_id" = 42;
//                 };
//                 status = 1;
//             }

             [MBProgressHUD hideHUDForView:self.view animated:YES];
             
             // Response Dictionary Received from API
             NSDictionary *dicResponse = responseObject;
             
             NSLog(@"%@",dicResponse);
             
             //[[NSUserDefaults standardUserDefaults]setObject:strImageURL forKey:@"Key_ImageURL"]
             
             if ([[dicResponse objectForKey:@"status"]isEqualToString:@"1"])
             {
                 if (IPAD)
                 {
                     GetTaxi * objGetTaxi = [[GetTaxi alloc]initWithNibName:@"getTextView_Ipad" bundle:nil];
                     [appdelegate.deckNavigationController pushViewController:objGetTaxi animated:YES];
                 }
                 else
                 {
                     GetTaxi * objGetTaxi = [[GetTaxi alloc]initWithNibName:@"GetTaxi" bundle:nil];
                     
                     [appdelegate.deckNavigationController pushViewController:objGetTaxi animated:YES];
                 }
                 
                 [[NSUserDefaults standardUserDefaults]setObject:[dicResponse objectForKey:@"image_url"] forKey:@"Key_ImageURL"];
                 
                 [[NSUserDefaults standardUserDefaults]setObject:[[dicResponse objectForKey:@"passenger_info"]objectForKey:@"passenger_id"] forKey:@"Key_Passenger_Id"];
                 
                 [[NSUserDefaults standardUserDefaults]setObject:[[dicResponse objectForKey:@"passenger_info"]objectForKey:@"first_name"] forKey:@"Key_FirstName"];
                 
                 [[NSUserDefaults standardUserDefaults]setObject:[[dicResponse objectForKey:@"passenger_info"]objectForKey:@"image_url"] forKey:@"Key_ImageURL"];
                 
                 [[NSUserDefaults standardUserDefaults]setObject:[[dicResponse objectForKey:@"passenger_info"]objectForKey:@"last_name"] forKey:@"Key_LastName"];
                 
                 
                 //isrememberTmp = YES;
                 [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"key_rememberme"];
                 
                 [[NSUserDefaults standardUserDefaults]synchronize];
             }
             else
             {
                 [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"alert_regalrdy", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles:nil]show];
             }
         } failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             // Set Progressbar hide from View
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             
             // Show Alert if Request Session Failed
             [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"alert_srvrerr", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles:nil]show];
         }];
    }
    else
    {
        [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"alert_card", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles:nil]show];
    }
}
-(void)getNonceFromClientToken:(NSString *) strClientToken CreditCardNo:(NSString *) cardNo expirationMonth:(NSString *) month expirationYear:(NSString *) year CVV:(NSString *) cvvNo
{
    
    self.objBraintree = [Braintree braintreeWithClientToken:strClientToken];
    
    BTClientCardRequest *request = [BTClientCardRequest new];
    request.number = cardNo;
    request.expirationMonth = month;
    request.expirationYear = year;
    //        request.expirationDate = @"11/23";
    request.cvv = cvvNo;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [self.objBraintree tokenizeCard:request completion:^(NSString *nonce, NSError *error){
        // Communicate the nonce to your server, or handle error
        NSLog(@"Nonce %@",nonce);
        NSLog(@"Error %@",[error description]);
        
        self.nonce = nonce;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        //        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        //
        //        // Set Acceptable Contenttype of Response
        //        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        //        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        //
        //        NSDictionary *params = @{@"firstname":@"Fourth",@"lastname":@"Passenger",@"nonce":nonce};
        //
        //        [manager POST:@"http://192.168.0.105/braintree/api/create_user.php" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //            // Handle success
        //            NSDictionary *dicResponse = responseObject;
        //            NSLog(@"%@",dicResponse);
        //        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //            // Handle failure communicating with your server
        //            NSLog(@"%@",[error description]);
        //        }];
    }];
}

#pragma mark -CARDIO PAYMENT VIEWCONTROLLER DELEGATE
- (void)userDidProvideCreditCardInfo:(CardIOCreditCardInfo *)info inPaymentViewController:(CardIOPaymentViewController *)paymentViewController
{
    
    NSLog(@"Scan succeeded with info: %@", info);
    // Do whatever needs to be done to deliver the purchased items.
    [self dismissViewControllerAnimated:YES completion:nil];
    //    [self.navigationController popViewControllerAnimated:YES];
    
    //        self.infoLabel.text = [NSString stringWithFormat:@"Received card info. Number: %@, expiry: %02lu/%lu, cvv: %@.", info.redactedCardNumber, (unsigned long)info.expiryMonth, (unsigned long)info.expiryYear, info.cvv];
    
    NSLog(@"%@",[NSString stringWithFormat:@"Received card info. Number: %@, expiry: %02lu/%lu, cvv: %@.", info.cardNumber, (unsigned long)info.expiryMonth, (unsigned long)info.expiryYear, info.cvv]);
    
    Card* card = [[Card alloc] init];
    card.generationtime = [[NSDate alloc] init];
    card.number = info.cardNumber;
    card.cvc = info.cvv;
    card.holderName = @"abc";
    card.expiryMonth = [NSString stringWithFormat:@"%lu",(unsigned long)info.expiryMonth];
    card.expiryYear = [NSString stringWithFormat:@"%lu",(unsigned long)info.expiryYear];
    
    
    NSString *strAESKey = [NSString stringWithFormat:@"%@,%@,%@,%@,%@",card.number,card.cvc,card.holderName,card.expiryMonth,card.expiryYear];
    
    self.AdyanKey = [FBEncryptorAES encryptBase64String:strAESKey
                                              keyString:@"adyen_Key"
                                          separateLines:YES];
   // self.AdyanKey = [ADYEncrypter encrypt:[card encode] publicKeyInHex:@"10001|C533DC63AD1359A5FF41931F676CB4D7E44DA4F8451711CF6A681EE7A8DEE2451D7DE5EE4E87D7F25A2CFEEBEC094190C99A4AE8D79045E57C1693658DC117C3AAB56F1F824E2D8294F16A09A64FCB190BE2B4E4247F570C8F99F55744FBAD2202E0EDBBB09D4F3E7F9A7A6A3FEA63F7FE146B9E6F19F7574A5B8D8059063CF305E3A3996CBEEAA07EE082D2A0164B1FE0B138416F81329C33E78A6C309D909EF13964C9D083ABEB08494C002D7F5837C44EBF8DB1BA7A1A7C3B9101AD8E1420972320CE1DCC69F1DC2EFC46A7A4547269FA11910D6575A31ED275BCD67038A37DAF9B174DAB6ED24DB51EE810FF0ECDD80EA00E8B1767F75502345CEA518FDD"];
    
    
    // Number: 4111111111111111, expiry: 11/2020, cvv: 123.
    
    NSString *strMonth = [NSString stringWithFormat:@"%lu",(unsigned long)info.expiryMonth];
    NSString *strYear = [NSString stringWithFormat:@"%lu",(unsigned long)info.expiryYear];
    
    NSString *strTempYear = [strYear substringFromIndex: [strYear length] - 2];
    NSString *strDate = [NSString stringWithFormat:@"%@ / %@",strMonth,strTempYear];
    
    [[NSUserDefaults standardUserDefaults]setObject:info.cardNumber forKey:@"Key_CreditCardNo"];
    [[NSUserDefaults standardUserDefaults]setObject:strDate forKey:@"Key_ExpirationDate"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    tblPaymentDetails.hidden = NO;
    [tblPaymentDetails reloadData];
    
  //  [self getNonceFromClientToken:self.clientToken CreditCardNo:info.cardNumber expirationMonth:strMonth expirationYear:strYear CVV:info.cvv];
    
}

-(void)userDidCancelPayment{
    tblPaymentDetails.hidden = YES;
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)userDidCancelPaymentViewController:(CardIOPaymentViewController *)paymentViewController {
    NSLog(@"User cancelled scan");
    tblPaymentDetails.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
    //    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -TABLEVIEW'S DELEGATE & DATASOURCE METHODS
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create Cell for TableView
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    
    //    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //    cell.separatorInset = UIEdgeInsetsZero;
    //    cell.textLabel.textColor = [UIColor darkGrayColor];
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    
    NSString *strCardNo = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_CreditCardNo"];
    NSString *strCardDate = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_ExpirationDate"];
    
    if (IPAD)
    {
        if (indexPath.row==0)
        {
            cell.textLabel.text = NSLocalizedString(@"txt_card", @"");
            cell.textLabel.font = [UIFont fontWithName:@"Libertad-Bold" size:30.0f];
            cell.textLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent: 0.3f];
            UILabel *lblCardNumber = [[UILabel alloc]initWithFrame:CGRectMake(300, 10, 220, 40)];
            lblCardNumber.text = strCardNo;
            lblCardNumber.font = [UIFont fontWithName:@"Libertad-Bold" size:30.0f];
            lblCardNumber.textColor = [[UIColor whiteColor] colorWithAlphaComponent: 0.3f];
            [cell.contentView addSubview:lblCardNumber];
        }
        else if (indexPath.row==1)
        {
            cell.textLabel.text = NSLocalizedString(@"txt_dd", @"");
            cell.textLabel.font = [UIFont fontWithName:@"Libertad-Bold" size:30.0f];
            cell.textLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent: 0.3f];
            UILabel *lblCardDate = [[UILabel alloc]initWithFrame:CGRectMake(300,10, 220, 40)];
            lblCardDate.text = strCardDate;
            lblCardDate.font = [UIFont fontWithName:@"Libertad-Bold" size:30.0f];
            lblCardDate.textColor = [[UIColor whiteColor] colorWithAlphaComponent: 0.3f];
            [cell.contentView addSubview:lblCardDate];
        }
    }
    else
    {
        if (indexPath.row==0)
        {
            cell.textLabel.text = NSLocalizedString(@"txt_card", @"");
            cell.textLabel.font = [UIFont fontWithName:@"Libertad-Bold" size:13.0f];
            cell.textLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent: 0.3f];
            UILabel *lblCardNumber = [[UILabel alloc]initWithFrame:CGRectMake(120, 16, 220, 21)];
            lblCardNumber.text = strCardNo;
            lblCardNumber.font = [UIFont fontWithName:@"Libertad-Bold" size:13.0f];
            lblCardNumber.textColor = [[UIColor whiteColor] colorWithAlphaComponent: 0.3f];
            [cell.contentView addSubview:lblCardNumber];
        }
        else if (indexPath.row==1)
        {
            cell.textLabel.text = NSLocalizedString(@"txt_dd", @"");
            cell.textLabel.font = [UIFont fontWithName:@"Libertad-Bold" size:13.0f];
            cell.textLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent: 0.3f];
            UILabel *lblCardDate = [[UILabel alloc]initWithFrame:CGRectMake(120, 16, 220, 21)];
            lblCardDate.text = strCardDate;
            lblCardDate.font = [UIFont fontWithName:@"Libertad-Bold" size:13.0f];
            lblCardDate.textColor = [[UIColor whiteColor] colorWithAlphaComponent: 0.3f];
            [cell.contentView addSubview:lblCardDate];
            
        }
    }

    //    cell.imageView.frame=CGRectMake(0, 15, cell.contentView.frame.size.width, 2);
    //    cell.imageView.backgroundColor=[UIColor whiteColor];
    
    
    cell.contentView.backgroundColor=[UIColor clearColor];
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 150;
//}

#pragma mark -PAYPAL VIEWCONTROLLER DELEGATE
- (void)postNonceToServer:(NSString *)paymentMethodNonce {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // Set Acceptable Contenttype of Response
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSDictionary *params = @{@"amount":@"1",@"nonce":paymentMethodNonce,@"customer_id":@"14919106"};
    
    NSString *strURL = [NSString stringWithFormat:@"%@store_in_vault.php",strBrainBaseURL];
    //http://54.153.20.98/api/braintree/api/store_in_vault.php
    
    [manager POST:strURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // Handle success
        NSDictionary *dicResponse = responseObject;
        NSLog(@"%@",dicResponse);
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Handle failure communicating with your server
        NSLog(@"%@",[error description]);
    }];
}

@end
