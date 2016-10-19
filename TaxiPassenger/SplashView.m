//
//  SplashView.m
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 1/6/15.
//  Copyright (c) 2015 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import "SplashView.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface SplashView ()

@end

@implementation SplashView

#pragma mark - ViewController Method
- (void)viewDidLoad
{
    [super viewDidLoad];
    btnselection=YES;
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    appdelegate.leftBarButtonForMenu.hidden = YES;
//    
//     txtRegEmail.text=@"123@gmail.com";
//     txtRegPasseord.text=@"12123132";
//     txtMobileNo.text=@"45454545";
    
    
    if (IPAD)
    {
        [txtCoutyCode.layer setBorderWidth:2];
        [txtCoutyCode.layer setBorderColor:[UIColor whiteColor].CGColor];
        [txtCoutyCode.layer setCornerRadius:25.0];
        [txtCoutyCode.layer setMasksToBounds:YES];
    }
    else{
        [txtCoutyCode.layer setBorderWidth:1.0];
        [txtCoutyCode.layer setBorderColor:[UIColor whiteColor].CGColor];
        [txtCoutyCode.layer setCornerRadius:15.0];
        [txtCoutyCode.layer setMasksToBounds:YES];
    }
    [self textFieldPedding:txtCoutyCode];

    
    
    
   // [txtCoutyCode.layer setBorderColor:[UIColor colorWithRed:186/255.0f green:134/255.0f blue:130/255.0f alpha:1.0].CGColor];
    
    btnRegister.layer.cornerRadius = 2.0;
    btnRegister.layer.masksToBounds = YES;
    btnSignIn.layer.cornerRadius = 2.0;
    btnSignIn.layer.masksToBounds = YES;
    
    tblCreateProfile.layer.cornerRadius = 3.0;
    tblCreateProfile.layer.masksToBounds = YES;
    [tblCreateProfile setSeparatorInset:UIEdgeInsetsZero];
    
    tblSignIn.layer.cornerRadius = 3.0;
    tblSignIn.layer.masksToBounds = YES;
    [tblSignIn setSeparatorInset:UIEdgeInsetsZero];
    
    UIToolbar *bonusToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    bonusToolbar.barStyle = UIBarStyleDefault;
    bonusToolbar.items = [NSArray arrayWithObjects:
                          [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"btn_cancel", nil) style:UIBarButtonItemStylePlain target:self action:@selector(cancelNumberPad)],
                          [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                          [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"btn_save", nil) style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)], nil];
    [bonusToolbar sizeToFit];
    txtMobile.inputAccessoryView = bonusToolbar;
    
    isrememberTmp = NO;
    
}
#pragma mark SetTextfiledPedding Methods
#pragma mark-----------------------------
-(void)textFieldPedding:(UITextField*)textField
{
    if (IPAD)
    {
        UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(0,0,28,0)];
        leftView.backgroundColor = [UIColor clearColor];
        textField.leftView = leftView;
        textField.leftViewMode = UITextFieldViewModeAlways;
    }
    else{
        
        UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(0,0,13,0)];
        leftView.backgroundColor = [UIColor clearColor];
        textField.leftView = leftView;
        textField.leftViewMode = UITextFieldViewModeAlways;
    }
}
-(void)viewWillAppear:(BOOL)animated
{
//    UITextField *plusLabel = [[UITextField alloc] init];
//    plusLabel.text = @"+45";
//    [plusLabel sizeToFit];
//    plusLabel.textColor=[UIColor whiteColor];
//    plusLabel.font = [UIFont fontWithName:@"Libertad" size:13.0f];
//    
//    txtMobileNo.leftView = plusLabel;
//    txtMobileNo.leftViewMode = UITextFieldViewModeAlways;
    
    
//    [UIView animateWithDuration:1.0 animations:^{
//        viewRegister.alpha = 0.0f;
//        viewSplash.alpha = 0.0f;
//        viewSignIn.alpha = 1.0f;
//        [btnRegitration setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent: 0.3f] forState:UIControlStateNormal];
//        [lblRegistration setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent: 0.3f]];
//        [btnSign setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
//        [lblSIgnIN setBackgroundColor:[UIColor redColor]];
//        [viewSignIn layoutIfNeeded];
//        [viewSplash layoutIfNeeded];
//        [viewRegister layoutIfNeeded];
//    }];
    
    self.navigationItem.title = appName;
    
    if (appdelegate.Tag==1)
    {
        [UIView animateWithDuration:1.0 animations:^{
            viewRegister.alpha = 1.0f;
            viewSplash.alpha = 0.0f;
            viewSignIn.alpha = 0.0f;
            [btnSign setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent: 0.3f] forState:UIControlStateNormal];
            [lblSIgnIN setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent: 0.3f]];
            
            [btnRegitration setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [lblRegistration setBackgroundColor:[UIColor redColor]];
            [viewSignIn layoutIfNeeded];
            [viewSplash layoutIfNeeded];
            [viewRegister layoutIfNeeded];
        }];
    }
    else if (appdelegate.Tag==2)
    {
        //sign in
        
        [UIView animateWithDuration:1.0 animations:^{
            viewRegister.alpha = 0.0f;
            viewSplash.alpha = 0.0f;
            viewSignIn.alpha = 1.0f;
            [btnRegitration setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent: 0.3f] forState:UIControlStateNormal];
            [lblRegistration setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent: 0.3f]];
            [btnSign setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
            [lblSIgnIN setBackgroundColor:[UIColor redColor]];
            [viewSignIn layoutIfNeeded];
            [viewSplash layoutIfNeeded];
            [viewRegister layoutIfNeeded];
        }];
    }
    else
    {
        [UIView animateWithDuration:1.0 animations:^{
            viewRegister.alpha = 0.0f;
            viewSplash.alpha = 1.0f;
            viewSignIn.alpha = 0.0f;
        }];
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark- custom method
-(void)cancelNumberPad
{
    [txtMobile resignFirstResponder];
}
-(void)doneWithNumberPad
{
    [txtMobile resignFirstResponder];
}
#pragma mark- facebook delegate method
- (void)_loadData
{
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:@"/me"
                                  parameters:@{ @"fields" : @"id,name,picture.width(100).height(100),emailid"}
                                  HTTPMethod:@"GET"];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,id result,NSError *error)
     {
         if(result)
         {
             NSLog(@"%@",connection);
             NSLog(@"%@",result);
             NSLog(@"====%@",request);
             //            NSString *facebookID = userData[@"id"];
             //            name = userData[@"name"];
             //            //                    NSString *location = userData[@"location"][@"name"];
             //
             //            email = userData[@"email"];
             //            imgurl = userData[@"picture"][@"data"][@"url"];
             //            NSLog(@"this is email=%@facebookid==%@name==%@picture url%@",email,facebookID,name,imgurl);
             //            NSData *Data=[NSData dataWithContentsOfURL:[NSURL URLWithString:imgurl]];
             //            UIImage *image=[UIImage imageWithData:Data];
             //            datas.imgProfilePhoto=image;
             //            one=@"1";
             //            [self multiform];
         }
     }];
}
#pragma mark - TEXTFIELD DELEGATE METHODS
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //    if (textField==txtMobileNo)
    //    {
    //        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARECTERS] invertedSet];
    //
    //        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    //
    //        NSString *updatedText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    //
    //        if (updatedText.length > 10)
    //        {
    //            if (string.length > 1)
    //            {
    //            }
    //            return NO;
    //        }
    //        return [string isEqualToString:filtered];
    //    }
    if (textField==txtRegPasseord)
    {
        if([string isEqualToString:@" "])
        {
            // Returning no here to restrict whitespace
            return NO;
        }
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - TABLEVIEW DELEGATE METHODS

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == tblCreateProfile)
    {
        return [arrCreateProfile count];
    }
    else if (tableView == tblSignIn)
    {
        return [arrSignIn count];
    }
    else
    {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create Cell for TableView
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //    cell.separatorInset = UIEdgeInsetsZero;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (tableView == tblCreateProfile) {
        cell.textLabel.text = [arrCreateProfile objectAtIndex:indexPath.row];
        
        if (indexPath.row == 0) {
            // [cell.contentView addSubview:txtEmail];
        }else if (indexPath.row == 1){
            // [cell.contentView addSubview:txtMobile];
        }else if (indexPath.row == 2){
            //[cell.contentView addSubview:txtPassword];
        }
        
    }else if (tableView == tblSignIn){
        cell.textLabel.text = [arrSignIn objectAtIndex:indexPath.row];
        
        if (indexPath.row == 0) {
            //[cell.contentView addSubview:txtEmail];
        }else if (indexPath.row == 1){
            //[cell.contentView addSubview:txtPassword];
        }
    }
    return cell;
}

#pragma mark - CUSTOM METHODS

#pragma mark- btn registtre pressed
- (IBAction)actionRegister:(id)sender
{
    isRegister = YES;
    self.navigationItem.title = NSLocalizedString(@"splash_regntitle", nil);
    
    arrCreateProfile = [[NSArray alloc]initWithObjects:NSLocalizedString(@"txt_email", @""),NSLocalizedString(@"txt_Mobile", @""),NSLocalizedString(@"txt_pwd", @""), nil];
    [tblCreateProfile reloadData];
    
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"isCreateAccountCancel"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [self.view endEditing:YES];
    [UIView animateWithDuration:1.0 animations:^{
        viewRegister.alpha = 1.0f;
        viewSplash.alpha = 0.0f;
        viewSignIn.alpha = 0.0f;
        objViewDisplay.alpha=1.0;
        txtLoginEmail.text = @"";
        txtMobileNo.text = @"";
        txtloginPassword.text = @"";
    }];
    
    [btnSign setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent: 0.3f] forState:UIControlStateNormal];
    [lblSIgnIN setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent: 0.3f]];
    
    [btnRegitration setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lblRegistration setBackgroundColor:[UIColor redColor]];
}
- (IBAction)actionSignIn:(id)sender
{
    isRegister = NO;
    self.navigationItem.title = NSLocalizedString(@"splash_signtitle", @"");
    arrSignIn = [[NSArray alloc]initWithObjects:NSLocalizedString(@"txt_email", @""),NSLocalizedString(@"txt_pwd", @""), nil];
    [tblSignIn reloadData];

    [self.view endEditing:YES];
    [UIView animateWithDuration:1.0 animations:^{
        viewRegister.alpha = 0.0f;
        viewSplash.alpha = 0.0f;
        viewSignIn.alpha = 1.0f;
        objViewDisplay.alpha=1.0;
        txtLoginEmail.text = @"";
        txtMobileNo.text = @"";
        txtloginPassword.text = @"";
    }];
    
    [btnRegitration setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent: 0.3f] forState:UIControlStateNormal];
    [lblRegistration setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent: 0.3f]];
    [btnSign setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    [lblSIgnIN setBackgroundColor:[UIColor redColor]];
    
}
#pragma mark- facebook Btn Pressed
- (IBAction)fbLoginbtnPressed:(id)sender
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"public_profile", @"email", @"user_friends"]
                 fromViewController:self
                            handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
     {
         if (error)
         {
             NSLog(@"Process error");
         }
         else if (result.isCancelled)
         {
             NSLog(@"Cancelled");
         }
         else
         {
             [self FacebookInformation];
         }
     }];
}
-(void)FacebookInformation
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me?fields=id,name,birthday,email,picture,first_name,last_name" parameters:nil]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error)
     {
         if (!error)
         {
             // NSLog(@"fetched user:%@  and Email : %@", result,result[@"email"]);
             
             //         user:{
             //             email = "developer.technostacks@gmail.com";
             //             id = 1738950769720130;
             //             name = "Ryan McBride";
             //             picture =     {
             //                 data =         {
             //                     "is_silhouette" = 0;
             //                     url = "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xaf1/v/t1.0-1/p50x50/11196341_1583089068639635_6238869975815225250_n.jpg?oh=9c1553679e6465ee1ac020d293a91fe4&oe=57DF07BF&__gda__=1474466098_c37db0642703d8fca88d5a9233e43792";
             //                 };
             
             //  NSDictionary *DicIMageUrl=[result valueForKeyPath:@"picture.data"];
             
             
             //             UIImage *img=[UIImage imageNamed:[DicIMageUrl objectForKey:@"url"]];
             //
             //             //             NSURL *urlString = [NSURL URLWithString:[DicIMageUrl objectForKey:@"url"]];
             //             //             [cell.massagerimg sd_setImageWithURL:urlString];
             //
             //
             //             NSData *imageData = [NSData dataWithData:UIImageJPEGRepresentation(img, 0)];
             //
             //
             //             NSString *base64Encoded = [imageData base64EncodedStringWithOptions:0];
             //
             //             NSLog(@"Encoded: %@", base64Encoded);
             
             NSString *requestURL = [NSString stringWithFormat:@"%@register_ios_user_device_token.php",strBaseURL];
             //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
             
             
             AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
             
             manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
             manager.requestSerializer = [AFJSONRequestSerializer serializer];
             
             NSString *strEmail =result[@"email"];
             NSString *strMobile = result[@"id"];
             NSString *strPassword = @"123123";
             NSString *strfname=[NSString stringWithFormat:@"%@",result[@"first_name"]];
             NSString *strlname=[NSString stringWithFormat:@"%@",result[@"last_name"]];
             
             NSString *strimag=[NSString stringWithFormat:@"%@",[[[result objectForKey:@"picture"] objectForKey:@"data"] objectForKey:@"url"]];
             
             UIImage *imgs = [self getImageFromURL:strimag];
             self.strImageBase64 = [self encodeToBase64String:imgs];
             //             if ([self.strImageBase64 length] == 0) {
             //
             //                 NSData *imageData = [NSData dataWithData:UIImageJPEGRepresentation(imgRegprofile.image, 0)];
             //
             //                 // Get NSString from NSData object in Base64
             //                 NSString *base64Encoded = [imageData base64EncodedStringWithOptions:0];
             //
             //                 self.strImageBase64 = base64Encoded;
             //             }
             
             NSDictionary *params = @{@"email":strEmail,
                                      @"mobile_no":strMobile,
                                      @"password":strPassword,
                                      @"first_name":strfname,
                                      @"last_name":strlname,@"flag":@"0",@"register":@"facebook",@"image_url":self.strImageBase64};
             
             //             NSDictionary *params = @{@"email":strEmail,
             //                                      @"mobile_no":strMobile,
             //                                      @"password":strPassword,
             //                                      @"first_name":strfname,
             //                        @"last_name":strlname,@"flag":@"0",@"register":@"facebook",@"image_url":self.strImageBase64.length>0?self.strImageBase64:@""};
             
             [manager POST:requestURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
              {
                  NSLog(@"%@",responseObject);
                  [MBProgressHUD hideHUDForView:self.view animated:YES];
                  
                  NSDictionary *dicResponse = responseObject;
                  
                  NSLog(@"%@",dicResponse);
                  
                  if ([[dicResponse objectForKey:@"status"]isEqualToString:@"1"]||[[dicResponse objectForKey:@"status"]isEqualToString:@"2"])
                  {
                      [[NSUserDefaults standardUserDefaults]setObject:@"facebook" forKey:@"FbTag"];
                      [[NSUserDefaults standardUserDefaults]setObject:[[dicResponse objectForKey:@"passenger_info"]objectForKey:@"passenger_id"] forKey:@"Key_Passenger_Id"];
                      [[NSUserDefaults standardUserDefaults]setObject:[[dicResponse objectForKey:@"passenger_info"]objectForKey:@"first_name"] forKey:@"Key_FirstName"];
                      [[NSUserDefaults standardUserDefaults]setObject:[[dicResponse objectForKey:@"passenger_info"]objectForKey:@"last_name"] forKey:@"Key_LastName"];
                      [[NSUserDefaults standardUserDefaults]setObject:[[dicResponse objectForKey:@"passenger_info"]objectForKey:@"mobile"] forKey:@"Key_Mobile"];
                      [[NSUserDefaults standardUserDefaults]setObject:[[dicResponse objectForKey:@"passenger_info"]objectForKey:@"email"] forKey:@"Key_Email"];
                      [[NSUserDefaults standardUserDefaults]setObject:[[dicResponse objectForKey:@"passenger_info"]objectForKey:@"image_url"] forKey:@"Key_ImageURL"];
                      [[NSUserDefaults standardUserDefaults]setObject:[[dicResponse objectForKey:@"passenger_info"]objectForKey:@"car_id"] forKey:@"Key_CarId"];
                      
                      // [[NSUserDefaults standardUserDefaults]setObject:txtloginPassword.text forKey:@"Key_Password"];
                      
                      [[NSUserDefaults standardUserDefaults]synchronize];
                      
                      if (IPAD)
                      {
                          GetTaxi * objGetTaxiView = [[GetTaxi alloc]initWithNibName:@"getTextView_Ipad" bundle:nil];
                          [appdelegate.deckNavigationController pushViewController:objGetTaxiView animated:YES];
                      }
                      else
                      {
                          GetTaxi * objGetTaxiView = [[GetTaxi alloc]initWithNibName:@"GetTaxi" bundle:nil];
                          
                          [appdelegate.deckNavigationController pushViewController:objGetTaxiView animated:YES];
                      }

                  }
              } failure:^(AFHTTPRequestOperation *operation, NSError *error)
              {
                  [MBProgressHUD hideHUDForView:self.view animated:YES];
                  [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"alert_try", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles:nil]show];
              }];
         }
     }];
}
-(UIImage *) getImageFromURL:(NSString *)fileURL
{
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
}
- (NSString *)encodeToBase64String:(UIImage *)image
{
    NSData *data = UIImagePNGRepresentation(image);
    
    return [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    //    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
#pragma mark- alertview delegate method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1000)
    {
        if (buttonIndex == 0)
        {
            //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"" style: UIBarButtonItemStylePlain target:self action:@selector(actionBack)];
            
           // self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"" style: UIBarButtonItemStylePlain target:self action:@selector(actionBack)];
            
            [UIView animateWithDuration:1.0 animations:^{
                viewRegister.alpha = 0.0f;
                viewSplash.alpha = 1.0f;
                viewSignIn.alpha = 0.0f;
            }];
        }
        else if (buttonIndex == 1)
        {
            
        }
    }
    else if (alertView.tag == 2000)
    {
        //            txtEmail.text = @"";
        //            txtMobile.text = @"";
        //            txtPassword.text = @"";
        isRegister = NO;
        self.navigationItem.title =NSLocalizedString(@"splash_signtitle", @"");
        arrSignIn = [[NSArray alloc]initWithObjects:NSLocalizedString(@"txt_email", @""),NSLocalizedString(@"txt_pwd", @""), nil];
        [tblSignIn reloadData];
        
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: NSLocalizedString(@"btn_cancel", @"") style: UIBarButtonItemStylePlain target:self action:@selector(actionBack)];
//        
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:  NSLocalizedString(@"", @"btn_next") style: UIBarButtonItemStylePlain target:self action:@selector(actionNext)];
        
        //            [UIView animateWithDuration:1.0 animations:^{
        //                viewRegister.alpha = 0.0f;
        //                viewSplash.alpha = 0.0f;
        //                viewSignIn.alpha = 1.0f;
        //            }];
    }
}

#pragma mark- login
#pragma mark forgot btn
- (IBAction)actionForgotPassword:(id)sender
{
    if (IPAD)
    {
        ForgotPassword *objForgotPassword = [[ForgotPassword alloc]initWithNibName:@"ForgotPasswordView_Ipad" bundle:nil];
        [appdelegate.deckNavigationController presentViewController:objForgotPassword animated:YES completion:nil];
    }
    else
    {
        ForgotPassword *objForgotPassword = [[ForgotPassword alloc]initWithNibName:@"ForgotPassword" bundle:nil];
        [appdelegate.deckNavigationController presentViewController:objForgotPassword animated:YES completion:nil];
    }
}
#pragma mark Remember btn
- (IBAction)btnRemeberPressed:(id)sender
{
    //    UIImage *select=[UIImage imageNamed:@"Check"];
    //    UIImage *Unselect=[UIImage imageNamed:@"Uncheck"];
    //
    //    if (btnselection==YES)
    //    {
    //        [objbtnRemember setImage:select forState:UIControlStateNormal];
    //        btnselection=NO;
    //        isrememberTmp = YES;
    //    }
    //    else
    //    {
    //        isrememberTmp = NO;
    //        [objbtnRemember setImage:Unselect forState:UIControlStateNormal];
    //        btnselection=YES;
    //    }
}
#pragma mark sign in btn
- (IBAction)btnSignInPressed:(id)sender
{
    if([txtLoginEmail.text length]==0)
    {
        [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"Enter register email address", @"") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
    }
    else if ([txtloginPassword.text length]==0)
    {
        [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"Enter valid password", @"") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
    }
    else
    {
        NSString *requestURL = [NSString stringWithFormat:@"%@Passenger_profile/login_passenger.php",strBaseURL];
    
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        // AFNetworking Request Manager
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        // Set Acceptable Contenttype of Response
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        
        NSString *strEmail = txtLoginEmail.text;
        NSString *strPassword = txtloginPassword.text;
        
        NSDictionary *params = @{@"email":strEmail, @"password":strPassword, @"flag":@"0"};
        
        [manager GET:requestURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             
             // Response Dictionary Received from API
             NSDictionary *dicResponse = responseObject;
             
             NSLog(@"%@",dicResponse);
             if ([[dicResponse objectForKey:@"status"]isEqualToString:@"1"])
             {
                 isrememberTmp = YES;
                 [[NSUserDefaults standardUserDefaults]setBool:isrememberTmp forKey:@"key_rememberme"];
                 [[NSUserDefaults standardUserDefaults]synchronize];
                 
                 if (IPAD)
                 {
                     GetTaxi * objGetTaxiView = [[GetTaxi alloc]initWithNibName:@"getTextView_Ipad" bundle:nil];
                     [appdelegate.deckNavigationController pushViewController:objGetTaxiView animated:YES];
                 }
                 else
                 {
                     GetTaxi * objGetTaxiView = [[GetTaxi alloc]initWithNibName:@"GetTaxi" bundle:nil];
                     
                     [appdelegate.deckNavigationController pushViewController:objGetTaxiView animated:YES];
                 }
                 
                 [[NSUserDefaults standardUserDefaults]setObject:[[dicResponse objectForKey:@"passenger_info"]objectForKey:@"passenger_id"] forKey:@"Key_Passenger_Id"];
                 [[NSUserDefaults standardUserDefaults]setObject:[[dicResponse objectForKey:@"passenger_info"]objectForKey:@"first_name"] forKey:@"Key_FirstName"];
                 [[NSUserDefaults standardUserDefaults]setObject:[[dicResponse objectForKey:@"passenger_info"]objectForKey:@"last_name"] forKey:@"Key_LastName"];
                 [[NSUserDefaults standardUserDefaults]setObject:[[dicResponse objectForKey:@"passenger_info"]objectForKey:@"mobile"] forKey:@"Key_Mobile"];
                 [[NSUserDefaults standardUserDefaults]setObject:[[dicResponse objectForKey:@"passenger_info"]objectForKey:@"email"] forKey:@"Key_Email"];
                 [[NSUserDefaults standardUserDefaults]setObject:[[dicResponse objectForKey:@"passenger_info"]objectForKey:@"image_url"] forKey:@"Key_ImageURL"];
                 [[NSUserDefaults standardUserDefaults]setObject:txtloginPassword.text forKey:@"Key_Password"];
                 [[NSUserDefaults standardUserDefaults]setObject:[[dicResponse objectForKey:@"passenger_info"]objectForKey:@"car_id"] forKey:@"Key_CarId"];
                 [[NSUserDefaults standardUserDefaults]synchronize];
             }
             else if ([[dicResponse objectForKey:@"status"]isEqualToString:@"0"])
             {
                 [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"alrt_loginerr", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles:nil]show];
             }
         } failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSLog(@"%@",[error description]);
             [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"alrt_srvererr", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", @"")  otherButtonTitles:nil]show];
         }];
    }
}
#pragma mark- Register
-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}
#pragma mark register back btn
- (IBAction)btnReg_backPressed:(id)sender
{
}
#pragma mark register next btn
- (IBAction)btnReg_nextPressed:(id)sender
{
    if([txtRegEmail.text length]==0)
    {
        [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"reg_alrtemail",@"") delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", nil) otherButtonTitles:nil]show];
    }
    else if (![self NSStringIsValidEmail:txtRegEmail.text])
    {
        [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"alet_validEmail",@"") delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", nil) otherButtonTitles:nil]show];
    }
    else if ([txtMobileNo.text length]==0)
    {
        [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"reg_alrtmono",@"") delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", nil) otherButtonTitles:nil]show];
    }
    else if ([txtRegPasseord.text length]==0)
    {
        [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"reg_alrtpwd", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", nil) otherButtonTitles:nil]show];
    }
    else if ([txtRegPasseord.text length]<5)
    {
        [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"pass_reng", @"")  delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles:nil]show];
    }
    else
    {
        NSString *requestURL = [NSString stringWithFormat:@"%@register_ios_user_device_token.php",strBaseURL];
    
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        // AFNetworking Request Manager
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        // Set Acceptable Contenttype of Response
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        
        NSString *strEmail = txtRegEmail.text;
        NSString *strMobile =[txtCoutyCode.text stringByAppendingString:txtMobileNo.text];
        //txtMobileNo.text;
        NSString *strPassword = txtRegPasseord.text;
        
        NSDictionary *params = @{@"email":strEmail, @"mobile_no":strMobile, @"password":strPassword, @"flag":@"0" ,@"adyen_key":@"",@"register":@"app"};
        
        [manager POST:requestURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSLog(@"%@",responseObject);
             [[NSUserDefaults standardUserDefaults]setObject:txtRegEmail.text forKey:@"Key_Email"];
             [[NSUserDefaults standardUserDefaults]setObject:strMobile forKey:@"Key_Mobile"];
             [[NSUserDefaults standardUserDefaults]setObject:txtRegPasseord.text forKey:@"Key_Password"];
             [[NSUserDefaults standardUserDefaults]synchronize];
             
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             
             // Response Dictionary Received from API
             NSDictionary *dicResponse = responseObject;
             
             NSLog(@"%@",dicResponse);
             
             if ([[dicResponse objectForKey:@"status"]isEqualToString:@"1"])
             {
                 if (IPAD)
                 {
                     objCreateProfile = [[CreateProfile alloc]initWithNibName:@"creatProfileView_Ipad" bundle:nil];
                     [appdelegate.deckNavigationController pushViewController:objCreateProfile animated:YES];
                 }
                 else
                 {
                     objCreateProfile = [[CreateProfile alloc]initWithNibName:@"CreateProfile" bundle:nil];
                     [appdelegate.deckNavigationController pushViewController:objCreateProfile animated:YES];
                 }
             }
             else if ([[dicResponse objectForKey:@"status"]isEqualToString:@"0"])
             {
                 UIAlertView *alrtAlreadyRegistered = [[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"crt_alrtmsg", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles:nil];
                 alrtAlreadyRegistered.tag = 2000;
                 [alrtAlreadyRegistered show];
             }
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"alert_try", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles:nil]show];
         }];
    }
    
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isCreateAccountCancel"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
#pragma mark- View Display
- (IBAction)btnBackAction:(id)sender
{
    [self.view endEditing:YES];
    [UIView animateWithDuration:1.0 animations:^{
        //viewRegister.alpha = 0.0f;
        viewSplash.alpha = 1.0f;
        //viewSignIn.alpha = 0.0f;
        objViewDisplay.alpha=0.0;
        txtLoginEmail.text = @"";
        txtMobileNo.text = @"";
        txtloginPassword.text = @"";
    }];
}
- (IBAction)btnSIgnAction:(id)sender
{
    [UIView animateWithDuration:1.0 animations:^{
        viewRegister.alpha = 0.0f;
        viewSplash.alpha = 0.0f;
        viewSignIn.alpha = 1.0f;
        [btnRegitration setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent: 0.3f] forState:UIControlStateNormal];
        [lblRegistration setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent: 0.3f]];
        [btnSign setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
        [lblSIgnIN setBackgroundColor:[UIColor redColor]];
        [viewSignIn layoutIfNeeded];
        [viewSplash layoutIfNeeded];
        [viewRegister layoutIfNeeded];
    }];
}
- (IBAction)btnRegistrationPressed:(id)sender
{
    [UIView animateWithDuration:1.0 animations:^{
        viewRegister.alpha = 1.0f;
        viewSplash.alpha = 0.0f;
        viewSignIn.alpha = 0.0f;
        [btnSign setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent: 0.3f] forState:UIControlStateNormal];
        [lblSIgnIN setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent: 0.3f]];
        
        [btnRegitration setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [lblRegistration setBackgroundColor:[UIColor redColor]];
        [viewSignIn layoutIfNeeded];
        [viewSplash layoutIfNeeded];
        [viewRegister layoutIfNeeded];
    }];
    
}
@end
