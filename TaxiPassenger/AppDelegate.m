//
//  AppDelegate.m
//  Taxi
//
//  Created by TechnoMac-2 on 9/15/14.
//  Copyright (c) 2014 Technostacks Infotech Pvt. Ltd. All rights reserved.
//latest code**************************

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

//com.${PRODUCT_NAME:rfc1034identifier}

@implementation AppDelegate

@synthesize deckNavigationController;
@synthesize deckController;
//@synthesize lblTitleLabel;
@synthesize window;
@synthesize kGoogleAPIKey;
@synthesize strAPI;
@synthesize leftBarButtonForMenu;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    //Reachability Implementetion
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"alert_connectionlost", nil) delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [self getToken:application];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [self getToken:application];
                break;
            default:
                break;
        }
    }];
    
    

    
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
        
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:15.0]}];
    
    [[UINavigationBar appearance]setTintColor:[UIColor blackColor]];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:13.0f]} forState:UIControlStateNormal];

    // Google Map Key
   // kGoogleAPIKey = @"AIzaSyA8okpxQUv61-oPrx84DlDQoUuYaHDl6w8";
      kGoogleAPIKey = @"AIzaSyAu_NhSsx9nuWZmcfA2uGp0eIfmw0uYCBM";
    
    // GOOGLE MAPS API KEY
    [GMSServices provideAPIKey:kGoogleAPIKey];
    
    if (launchOptions != nil)
    {
        NSDictionary* dictionary = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (dictionary != nil)
        {
            NSLog(@"Launched from push notification: %@", dictionary);
            
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
            [[UIApplication sharedApplication] cancelAllLocalNotifications];
        }
    }

    //Fcaebook
    
    BOOL islunch = [[NSUserDefaults standardUserDefaults]boolForKey:@"isFtimeLaunch"];
    
    if (!islunch)
    {
        
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isFtimeLaunch"];
        [[NSUserDefaults standardUserDefaults]synchronize];
         [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"VehicalSelect"];
    }
    
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    //fabric-crashlytics
    //[Crashlytics startWithAPIKey:@"5217900cfb03d2b58d434e4b544db04cb66cb68c"];
    [Fabric with:@[[Crashlytics class]]];
    
#pragma mark - URL Change

    // Set String for Standard API
    strAPI = [NSString stringWithFormat:@"http://54.153.20.98/api/ios"];
    //@"192.168.0.127/taxi_app2/api/ios"
    
    // Allocate deckController
    self.deckController = [self generateControllerStack];
    self.window.rootViewController = self.deckController;
    
    [self.window makeKeyAndVisible];
    [self setUpLayouts];
    
    return YES;
}
-(void)setUpLayouts
{
    if (IS_IPHONE_4S) {
        lblTitleLabel.frame = CGRectMake(60, 6, 200, 30);
        leftBarButtonForMenu.frame = CGRectMake(15, 5, 35, 35);
        
    }else if (IS_IPHONE_5){
        lblTitleLabel.frame = CGRectMake(60, 6, 200, 30);
        leftBarButtonForMenu.frame = CGRectMake(15, 5, 35, 35);
        
    }else if (IS_IPHONE_6){
        lblTitleLabel.frame = CGRectMake(85, 6, 200, 30);
        leftBarButtonForMenu.frame = CGRectMake(12.8, 5, 35, 35);
        
    }else if (IS_IPHONE_6P){
        lblTitleLabel.frame = CGRectMake(108, 6, 200, 30);
        leftBarButtonForMenu.frame = CGRectMake(11.59, 5, 35, 35);
    }
}

#pragma mark - CUSTOM METHODS
-(void)getToken:(UIApplication *) application{
    
    // Let the device know we want to receive push notifications
//    if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
//    {
//        // iOS 8 Notifications
//        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
//        
//        [application registerForRemoteNotifications];
//    }else{
//        // iOS < 8 Notifications
//        [application registerForRemoteNotificationTypes:
//         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
//    }
}

-(void)sendTokenToServer:(NSString *) deviceTokenString
{
    // URL String
    
#pragma mark - URL Change
   // NSString *stringPost = [NSString stringWithFormat:@"http://54.153.20.98/api/ios/register_ios_user_device_token.php?device_token=%@&flag=0",deviceTokenString];
    
    NSString *strpostURL = [NSString stringWithFormat:@"%@register_ios_user_device_token.php?device_token=%@&flag=0",strBaseURL,deviceTokenString];
    
    // URL Request
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:strpostURL]];
    [MBProgressHUD showHUDAddedTo:self.window animated:YES];
    
    // Conncection Block
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler: ^(NSURLResponse *res, NSData *data, NSError *err)
    {
        [MBProgressHUD hideHUDForView:self.window animated:YES];
        
        // Encoding Data
        NSString *responseString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        
        responseString = [responseString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [responseString stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        // Get Encoding Data in Dictionary
        NSDictionary *responseDictionary = [[NSDictionary alloc]initWithDictionary:[responseString JSONValue]];
        
        NSString *status = [NSString stringWithFormat:@"%@",[responseDictionary objectForKey:@"status"]];
        if ([status isEqualToString:@"1"]) {
            NSString *strID = [NSString stringWithFormat:@"%@",[responseDictionary objectForKey:@"passenger_id"]];
            [[NSUserDefaults standardUserDefaults]setObject:strID forKey:@"passenger_id"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }else if ([status isEqualToString:@"0"]){
            NSString *strID = [responseDictionary objectForKey:@"passanger_id"];
            [[NSUserDefaults standardUserDefaults]setObject:strID forKey:@"passenger_id"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }
        NSLog(@"%@",responseDictionary);
    }];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:sourceApplication
                                                               annotation:annotation
                    ];
    // Add any custom logic here.
    return handled;
}
#pragma mark - Push Notification Methods
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
    const unsigned* tokenBytes = [deviceToken bytes];
    NSString* deviceTokenString = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                                   ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                                   ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                                   ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    
    [[NSUserDefaults standardUserDefaults]setObject:deviceTokenString forKey:@"Device_Token"];
    
    NSLog(@"%@",deviceTokenString);
    
//    UIAlertView *objalert=[[UIAlertView alloc]initWithTitle:appName message:deviceTokenString delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
//    [objalert show];
    
    NSString *requestURL = [NSString stringWithFormat:@"%@update_device_token.php",strBaseANURL];
    
    
    // AFNetworking Request Manager
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // Set Acceptable Contenttype of Response
    
    NSString *strDriver_id=[[NSUserDefaults standardUserDefaults]objectForKey:@"Key_Passenger_Id"];
    
    NSLog(@"%@",strDriver_id);
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *params = @{@"device_token":deviceTokenString, @"passenger_id":strDriver_id,@"status":@"0"};
    
    [manager GET:requestURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *dicResponse = responseObject;
         
         NSLog(@"%@",dicResponse);
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         // Set Progressbar hide from View
         
         NSLog(@"%@",[error description]);
         
         // Show Alert if Request Session Failed
         [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"alert_srvrerr", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles:nil]show];
     }];
    
    
   // Reachability Implementetion
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"alrt_Netc", @"") delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                //[self sendTokenToServer:deviceTokenString];
                
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
               // [self sendTokenToServer:deviceTokenString];
                
                break;
            default:
              //  [self sendTokenToServer:deviceTokenString];
                break;
        }
    }];
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    
    NSLog(@"Device Token:--->> %@", deviceTokenString);
}

//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
//{
    
//    NSLog(@"%@",userInfo);
////    UIApplicationState state = [application applicationState];
////    
//   [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
//    [[UIApplication sharedApplication] cancelAllLocalNotifications];
//    NSLog(@"Notification Received");
//    
//    if ([[[userInfo objectForKey:@"aps"]objectForKey:@"msg"]isEqualToString:@"accepted"])
//    {
//       
//        
//        NSString *message =NSLocalizedString(@"alrt_Accept", @"");
//        
//        NSString *strDriverLat = [[userInfo objectForKey:@"aps"] objectForKey:@"driver_lat"];
//        NSString *strDriverLong = [[userInfo objectForKey:@"aps"] objectForKey:@"driver_long"];
//        NSString *strDriver_id = [[userInfo objectForKey:@"aps"]objectForKey:@"driver_id"];
//        
//        [[NSUserDefaults standardUserDefaults]setObject:strDriver_id forKey:@"Key_Driver_Id"];
//        [[NSUserDefaults standardUserDefaults]setObject:strDriverLat forKey:@"Key_Driver_Lat"];
//        [[NSUserDefaults standardUserDefaults]setObject:strDriverLong forKey:@"Key_Driver_Long"];
//        [[NSUserDefaults standardUserDefaults]synchronize];
//        
//        NSString *strStatus = [NSString stringWithFormat:@"%@",[[userInfo objectForKey:@"aps"] objectForKey:@"status"]];
//        
//        if ([strStatus isEqualToString:@"1"])
//        {
//            [[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@", message] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
//            
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowRoute" object:nil];
//            
//        }
//        else if ([strStatus isEqualToString:@"0"])
//        {
//            NSInteger index = [[NSUserDefaults standardUserDefaults]integerForKey:@"Key_DriverArray_Index"];
//            index ++;
//            
//            [[NSUserDefaults standardUserDefaults]setInteger:index forKey:@"Key_DriverArray_Index"];
//            [[NSUserDefaults standardUserDefaults]synchronize];
//            
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"DriverRequest" object:nil];
//        }
//    
//    }
//    else if ([[[userInfo objectForKey:@"aps"]objectForKey:@"msg"]isEqualToString:@"decline"])
//    {
//        NSInteger index = [[NSUserDefaults standardUserDefaults]integerForKey:@"Key_DriverArray_Index"];
//        index ++;
//        
//        [[NSUserDefaults standardUserDefaults]setInteger:index forKey:@"Key_DriverArray_Index"];
//        [[NSUserDefaults standardUserDefaults]synchronize];
//        
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"DriverRequest" object:nil];
//    }
//    else if ([[[userInfo objectForKey:@"aps"]objectForKey:@"msg"]isEqualToString:@"arrived"])
//    {
//       // NSString *message = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
//        
//        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"alrt_Arrived", @"")  message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
//        
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"DriverArrived" object:nil];
//    }
//    else if ([[[userInfo objectForKey:@"aps"]objectForKey:@"msg"]isEqualToString:@"endtrip"])
//    {
////        NSString *message = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
////        [[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@", message] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
//        
//        NSString *strTripDuration = [[userInfo objectForKey:@"aps"]objectForKey:@"trip_duration"];
//        NSString *strTripFare = [[userInfo objectForKey:@"aps"]objectForKey:@"trip_fare"];
//        NSString *strTripId = [[userInfo objectForKey:@"aps"]objectForKey:@"trip_id"];
//        
//        [[NSUserDefaults standardUserDefaults]setObject:strTripDuration forKey:@"Key_TripDuration"];
//        [[NSUserDefaults standardUserDefaults]setObject:strTripFare forKey:@"Key_TripFare"];
//        [[NSUserDefaults standardUserDefaults]setObject:strTripId forKey:@"Key_TripId"];
//        [[NSUserDefaults standardUserDefaults]synchronize];
//        
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"EndTrip" object:nil];
//    }
    
//    if (state == UIApplicationStateActive)
//    {
////        [NSString stringWithFormat:@"%@", message];
//        [[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@", message] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
//    }
//    else
//    {
//        // Push Notification received in the background
//        [[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@", message] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
//    }
//}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSLog(@"%@",userInfo);
    
    //  UIApplicationState state = [application applicationState];
    
    NSLog(@"Notification Received");
    
    if ([[[userInfo objectForKey:@"aps"]objectForKey:@"msg"]isEqualToString:@"accepted"])
    {
        NSString *message =NSLocalizedString(@"alrt_Accept", @"");
        
        NSString *strDriverLat = [[userInfo objectForKey:@"aps"] objectForKey:@"driver_lat"];
        NSString *strDriverLong = [[userInfo objectForKey:@"aps"] objectForKey:@"driver_long"];
        NSString *strDriver_id = [[userInfo objectForKey:@"aps"]objectForKey:@"driver_id"];
        
        [[NSUserDefaults standardUserDefaults]setObject:strDriver_id forKey:@"Key_Driver_Id"];
        [[NSUserDefaults standardUserDefaults]setObject:strDriverLat forKey:@"Key_Driver_Lat"];
        [[NSUserDefaults standardUserDefaults]setObject:strDriverLong forKey:@"Key_Driver_Long"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSString *strStatus = [NSString stringWithFormat:@"%@",[[userInfo objectForKey:@"aps"] objectForKey:@"status"]];
        
        if ([strStatus isEqualToString:@"1"])
        {
            [[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@", message] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
            [[UIApplication sharedApplication] cancelAllLocalNotifications];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowRoute" object:nil];
            
        }
        else if ([strStatus isEqualToString:@"0"])
        {
           
            NSInteger index = [[NSUserDefaults standardUserDefaults]integerForKey:@"Key_DriverArray_Index"];
            index ++;
            
            [[NSUserDefaults standardUserDefaults]setInteger:index forKey:@"Key_DriverArray_Index"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"DriverRequest" object:nil];
          
        }
        
    }
    else if ([[[userInfo objectForKey:@"aps"]objectForKey:@"msg"]isEqualToString:@"decline"])
    {
       
        NSInteger index = [[NSUserDefaults standardUserDefaults]integerForKey:@"Key_DriverArray_Index"];
        index ++;
        
        [[NSUserDefaults standardUserDefaults]setInteger:index forKey:@"Key_DriverArray_Index"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"DriverRequest" object:nil];
    }
    else if ([[[userInfo objectForKey:@"aps"]objectForKey:@"msg"]isEqualToString:@"arrived"])
    {
        // NSString *message = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
        
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"alrt_Arrived", @"")  message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"DriverArrived" object:nil];
    }
    else if ([[[userInfo objectForKey:@"aps"]objectForKey:@"msg"]isEqualToString:@"endtrip"])
    {
        //        NSString *message = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
        //        [[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@", message] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        
        NSString *strTripDuration = [[userInfo objectForKey:@"aps"]objectForKey:@"trip_duration"];
        NSString *strTripFare = [[userInfo objectForKey:@"aps"]objectForKey:@"trip_fare"];
        NSString *strBasePrice=[[userInfo objectForKey:@"aps"]objectForKey:@"base_price"];
        NSString *strTripId = [[userInfo objectForKey:@"aps"]objectForKey:@"trip_id"];
        
        [[NSUserDefaults standardUserDefaults]setObject:strTripDuration forKey:@"Key_TripDuration"];
        [[NSUserDefaults standardUserDefaults]setObject:strTripFare forKey:@"Key_TripFare"];
        [[NSUserDefaults standardUserDefaults]setObject:strTripId forKey:@"Key_TripId"];
        [[NSUserDefaults standardUserDefaults]setObject:strBasePrice forKey:@"Key_BasePrice"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"EndTrip" object:nil];
    }
}

-(void)GetNotification:(NSDictionary *)userInfo
{
    
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
   // NSLog(@"Failed to get token, error: %@", error);
}


#pragma mark - Custom Methods
- (IIViewDeckController*)generateControllerStack
{
    // SideViewController Allocaiton
    if (IPAD)
    {
        objSideViewController = [[SideViewController alloc]initWithNibName:@"sideView_Ipad" bundle:nil];
    }
    else
    {
        objSideViewController = [[SideViewController alloc]initWithNibName:@"SideViewController" bundle:nil];
    }
    //objSideViewController.view.frame=CGRectMake(0, 0,screenbounds.size.width-500,screenbounds.size.height);
    
    NSLog(@"%@",objSideViewController);
    
    NSString *strUserId = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_Passenger_Id"];
    
    BOOL isRememberme = [[NSUserDefaults standardUserDefaults]boolForKey:@"key_rememberme"];
    
    if (isRememberme)
    {
        if ([strUserId length]!=0)
        {
            if (IPAD)
            {
                objGetTaxi = [[GetTaxi alloc]initWithNibName:@"getTextView_Ipad" bundle:nil];
                
                self.deckNavigationController = [[UINavigationController alloc] initWithRootViewController:objGetTaxi];
            }
            else
            {
                objGetTaxi = [[GetTaxi alloc]initWithNibName:@"GetTaxi" bundle:nil];
                
                self.deckNavigationController = [[UINavigationController alloc] initWithRootViewController:objGetTaxi];
            }
        }
        else
        {
            if (IPAD)
            {
                objGetTaxi = [[GetTaxi alloc]initWithNibName:@"getTextView_Ipad" bundle:nil];
                
                self.deckNavigationController = [[UINavigationController alloc] initWithRootViewController:objGetTaxi];
            }
            else
            {
                objGetTaxi = [[GetTaxi alloc]initWithNibName:@"GetTaxi" bundle:nil];
                
                self.deckNavigationController = [[UINavigationController alloc] initWithRootViewController:objGetTaxi];
            }
        }
    }
    else
    {
        if (IPAD)
        {
            objSplashView = [[SplashView alloc]initWithNibName:@"splashView_Ipad" bundle:nil];
            
            self.deckNavigationController = [[UINavigationController alloc] initWithRootViewController:objSplashView];
        }
        else
        {
            objSplashView = [[SplashView alloc]initWithNibName:@"SplashView" bundle:nil];
            
            self.deckNavigationController = [[UINavigationController alloc] initWithRootViewController:objSplashView];
        }

    }
    
   
    
    self.deckNavigationController.navigationBar.translucent = NO;
    
    [[UINavigationBar appearance] setBarStyle:UIBarStyleDefault];
    [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:210/255.f green:62/255.f blue:63/255.f alpha:1.0f]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:16.0],NSFontAttributeName:[UIFont boldSystemFontOfSize:13.0f]}];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:13.0f]} forState:UIControlStateNormal];
    
    self.deckController =  [[IIViewDeckController alloc] initWithCenterViewController:self.deckNavigationController leftViewController:objSideViewController];
    self.deckController.view.backgroundColor = [UIColor redColor];
    self.deckController.panningMode = IIViewDeckNoPanning;
    self.deckController.leftSize = 70;
    self.deckController.delegate = self;
    
    // Add sideViewController button
    leftBarButtonForMenu = [[UIButton alloc]initWithFrame:CGRectMake(15, 5, 35, 35)];
    [leftBarButtonForMenu setImage:[UIImage imageNamed:@"Menu_sidebar"] forState:UIControlStateNormal];
    [leftBarButtonForMenu addTarget:self.deckController action:@selector(toggleLeftView) forControlEvents:UIControlEventTouchUpInside];
//    [self.deckNavigationController.navigationBar addSubview:leftBarButtonForMenu];
    
//    // Add sideViewController button
//    rightBarButtonForMenu = [[UIButton alloc]initWithFrame:CGRectMake(270, 12, 32, 25)];
//    [rightBarButtonForMenu setImage:[UIImage imageNamed:@"List View.png"] forState:UIControlStateNormal];
//    [rightBarButtonForMenu addTarget:self.deckController action:@selector(toggleRightView) forControlEvents:UIControlEventTouchUpInside];
//    [self.deckNavigationController.navigationBar addSubview:rightBarButtonForMenu];
    
    // Add Title label
//    self.lblTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 6, 200, 30)];
//    self.lblTitleLabel.backgroundColor = [UIColor clearColor];
//    self.lblTitleLabel.textColor = [UIColor blackColor];
//    self.lblTitleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
//    self.lblTitleLabel.textAlignment = NSTextAlignmentCenter;
//    self.lblTitleLabel.text = @"Hop On";
//    [self.deckNavigationController.navigationBar addSubview:self.lblTitleLabel];
    
    // Set navigation bar's text color
//    [self.deckNavigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    return self.deckController;
}

- (void)viewDeckController:(IIViewDeckController *)viewDeckController applyShadow:(CALayer *)shadowLayer withBounds:(CGRect)rect {
    shadowLayer.masksToBounds = NO;
    shadowLayer.shadowRadius = 0;
    shadowLayer.shadowOpacity = 0;
    shadowLayer.shadowColor = nil;
    shadowLayer.shadowOffset = CGSizeZero;
    shadowLayer.shadowPath = nil;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}
- (void)applicationWillEnterForeground:(UIApplication *)application
{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"apiCallforClearNotificationumber" object:nil];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    application.applicationIconBadgeNumber = 0;
    [FBSDKAppEvents activateApp];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}
- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
