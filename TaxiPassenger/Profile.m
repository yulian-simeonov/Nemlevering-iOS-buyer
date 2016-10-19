//
//  Profile.m
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 3/10/15.
//  Copyright (c) 2015 Technostacks Infotech Pvt. Ltd. All rights reserved.
//



//Image Edit Bug in This Screen.

#import "Profile.h"

@interface Profile ()

@end

@implementation Profile

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *letterTapRecognizer = [[UITapGestureRecognizer alloc]init];
    letterTapRecognizer.numberOfTapsRequired=1;
    letterTapRecognizer.delegate=self;
    [self.view addGestureRecognizer:letterTapRecognizer];
    [self.view setUserInteractionEnabled:YES];
    
    isEditProfile=YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"" style: UIBarButtonItemStylePlain target:self action:nil];
    [self.navigationItem setTitle:NSLocalizedString(@"title_pr", @"")];
    
    UIBarButtonItem *btnEdit = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"btn_save", @"") style:UIBarButtonItemStylePlain target:self action:@selector(actionEditProfile:)];
    [self.navigationItem setRightBarButtonItem:btnEdit];
    
    if (IPAD)
    {
        txtFirstName = [[UITextField alloc]initWithFrame:CGRectMake(65, 18, 150, 24)];
        txtFirstName.placeholder = NSLocalizedString(@"btn_first", @"");
        txtFirstName.delegate = self;
        
        txtLastName = [[UITextField alloc]initWithFrame:CGRectMake(65, 18, 150, 24)];
        txtLastName.placeholder = NSLocalizedString(@"btn_last", @"");
        txtLastName.delegate = self;
        
        txtEmail = [[UITextField alloc]initWithFrame:CGRectMake(125, 18,170, 24)];
        txtEmail.placeholder = NSLocalizedString(@"txt_email", @"");
        txtEmail.delegate = self;
        
        txtMobile = [[UITextField alloc]initWithFrame:CGRectMake(125, 18, 170, 24)];
        txtMobile.placeholder = NSLocalizedString(@"txt_Mobile", @"");
        txtMobile.delegate = self;
        
        txtPassword = [[UITextField alloc]initWithFrame:CGRectMake(125,18,170, 24)];
        txtPassword.placeholder = NSLocalizedString(@"txt_pwd", @"");
        txtPassword.delegate = self;
        txtPassword.secureTextEntry = YES;
    }
    else
    {
        txtFirstName = [[UITextField alloc]initWithFrame:CGRectMake(65, 11.5, 200, 21)];
        txtFirstName.placeholder = NSLocalizedString(@"btn_first", @"");
        txtFirstName.delegate = self;
        
        txtLastName = [[UITextField alloc]initWithFrame:CGRectMake(65, 11.5, 200, 21)];
        txtLastName.placeholder = NSLocalizedString(@"btn_last", @"");
        txtLastName.delegate = self;
        
        txtEmail = [[UITextField alloc]initWithFrame:CGRectMake(125, 11.5, 200, 21)];
        txtEmail.placeholder = NSLocalizedString(@"txt_email", @"");
        txtEmail.delegate = self;
        
        txtMobile = [[UITextField alloc]initWithFrame:CGRectMake(125, 11.5, 200, 21)];
        txtMobile.placeholder = NSLocalizedString(@"txt_Mobile", @"");
        txtMobile.delegate = self;
        
        txtPassword = [[UITextField alloc]initWithFrame:CGRectMake(125, 11.5, 200, 21)];
        txtPassword.placeholder = NSLocalizedString(@"txt_pwd", @"");
        txtPassword.delegate = self;
        txtPassword.secureTextEntry = YES;
    }

    imgViewProfile.layer.borderColor = [[UIColor whiteColor] CGColor];
    imgViewProfile.layer.borderWidth = 1.0f;
    imgViewProfile.layer.cornerRadius = 3.0f;
    imgViewProfile.layer.masksToBounds = YES;
    
    tblViewAccount.layer.borderColor = [[UIColor whiteColor] CGColor];
    tblViewAccount.layer.borderWidth = 1.0f;
    tblViewAccount.layer.cornerRadius = 3.0f;
    tblViewAccount.layer.masksToBounds = YES;
    
    tblViewName.layer.borderColor = [[UIColor whiteColor] CGColor];
    tblViewName.layer.borderWidth = 1.0f;
    tblViewName.layer.cornerRadius = 3.0f;
    tblViewName.layer.masksToBounds = YES;
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"FbTag"]isEqualToString:@"facebook"])
    {
        arrAccount = [[NSArray alloc]initWithObjects:NSLocalizedString(@"txt_email", @""), NSLocalizedString(@"txt_Mobile", @""), nil];
        //TableViewHight.constant=0.0;
    }
    else
    {
        arrAccount = [[NSArray alloc]initWithObjects:NSLocalizedString(@"txt_email", @""), NSLocalizedString(@"txt_Mobile", @""),NSLocalizedString(@"txt_pwd", @""), nil];
    }
    
    arrProfile = [[NSArray alloc]initWithObjects:NSLocalizedString(@"btn_first", @""),NSLocalizedString(@"btn_last", @""), nil];
    
    
    // Set Action Sheet on btnSelectCar
    objActionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"btn_cancel", @"") destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"txt_camera", @""), NSLocalizedString(@"txt_album", @""), nil];
    objActionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [self.view addSubview:objActionSheet];
    
    UITapGestureRecognizer *oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionProfileImage:)];
    [oneTap setDelegate:self];
    [oneTap setNumberOfTapsRequired:1];
    [imgViewProfile addGestureRecognizer:oneTap];
    
    NSString *strImageURL = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_ImageURL"];
    if ([strImageURL length]!=0)
    {
        [imgViewProfile setImageWithURL:[NSURL URLWithString:strImageURL] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    
}
#pragma mark UIGestureRecognizer Methods side menu
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    [appdelegate.deckController closeLeftViewAnimated:YES];
    return YES;
}
-(void)tapDetected
{
    objActionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"btn_cancel", @"") destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"txt_camera", @""), NSLocalizedString(@"txt_album", @""), nil];
    objActionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [self.view addSubview:objActionSheet];
}

-(void)actionEditProfile:(id)sender
{
    UIBarButtonItem *button = (UIBarButtonItem *)sender;
//    
//    if ([button.title isEqualToString:NSLocalizedString(@"btn_edit", @"")])
//    {
//        [button setTitle:NSLocalizedString(@"btn_save", @"")];
//        isEditProfile = YES;
//        
//    }
//    else
        if ([button.title isEqualToString:NSLocalizedString(@"btn_save", @"")])
    {
        //[button setTitle:NSLocalizedString(@"btn_edit", @"")];
        //isEditProfile = NO;
        
        [txtFirstName resignFirstResponder];
        [txtLastName resignFirstResponder];
        [txtEmail resignFirstResponder];
        [txtMobile resignFirstResponder];
        [txtPassword resignFirstResponder];
        
        [self saveProfile];
    }
}

-(void)saveProfile
{
    
    NSString *strNewFirstName = txtFirstName.text;
    NSString *strNewLastName = txtLastName.text;
    NSString *strNewPassword = txtPassword.text;
    
    if ([strNewFirstName length]!=0)
    {
        [[NSUserDefaults standardUserDefaults]setObject:strNewFirstName forKey:@"Key_FirstName"];
    }
    if ([strNewLastName length]!=0)
    {
        
        [[NSUserDefaults standardUserDefaults]setObject:strNewLastName forKey:@"Key_LastName"];
    }
    if ([strNewPassword length]!=0)
    {
        [[NSUserDefaults standardUserDefaults]setObject:strNewPassword forKey:@"Key_Password"];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    NSString *strFirstName = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_FirstName"];
    NSString *strLastName = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_LastName"];
    NSString *strEmail = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_Email"];
    NSString *strMobile = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_Mobile"];
   // NSString *strPassword = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_Password"];
    if ([strFirstName length]==0) {
        [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"alrt_fname", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles:nil]show];
        
    }else if ([strLastName length]==0){
        [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"alrt_lname", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles:nil]show];
        
    }else if ([strEmail length]==0){
        [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"reg_alrtemail", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles:nil]show];
        
    }else if ([strMobile length]==0){
        [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"reg_alrtmono", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles:nil]show];
        
    }
//    else if ([strPassword length]==0){
//        [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"reg_alrtpwd", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles:nil]show];
//        
//    }
    else
    {
#pragma mark - URL Change

        // URL Request String
       // NSString *requestURL = [NSString stringWithFormat:@"http://54.153.20.98/api/android/Passenger_profile/update_passenger_profile_detail.php"];
        
        NSString *strURL = [NSString stringWithFormat:@"%@Passenger_profile/update_passenger_profile_detail.php",strBaseANURL];
        
        // Show Progressbar in Main View
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        // AFNetworking Request Manager
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSString *strPassengerId = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_Passenger_Id"];
        
        if ([base64Encoded length]==0)
        {
            UIImage *imgPlaceholder = [UIImage imageNamed:@"person-placeholder.jpg"];
            
            NSData *imageData = [NSData dataWithData:UIImageJPEGRepresentation(imgPlaceholder, 0)];
            
            // Get NSString from NSData object in Base64
            base64Encoded = [imageData base64EncodedStringWithOptions:0];
        }
        
       // NSString *stremail=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"Key_Email"]];
       // NSString *strPhoneNo=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"Key_Mobile"]];
        
         //[[NSUserDefaults standardUserDefaults]setObject:[[dicResponse objectForKey:@"passenger_info"]objectForKey:@"image_url"] forKey:@"Key_ImageURL"];
        
        
        NSDictionary *params = @{@"first_name":txtFirstName.text,@"last_name":txtLastName.text,@"password":txtPassword.text,@"passenger_id":strPassengerId,@"image_url":base64Encoded,@"mobile_no":txtMobile.text,@"email":txtEmail.text};
        
        // Set Acceptable Contenttype of Response
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        [manager POST:strURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
            // Set Progressbar hide from View
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            NSDictionary *dicResponse = responseObject;
            NSLog(@"Response %@",dicResponse);
             NSLog(@"Response %@",[dicResponse objectForKey:@"status"]);
             
//             email = "hinal1@gmail.com";
//             "first_name" = Nisha1;
//             "image_url" = "http://cargo.technostacks.com/images/bf6fa387c8f2f1acadd68410d8d5db7d.jpeg";
//             "last_name" = Gandhi1;
//             "mobile_no" = 1231231111;
//             "passenger_id" = 1;
//             password = 123456;
//             status = 1;
             
             if ([[dicResponse objectForKey:@"status"]isEqualToString:@"2"])
             {
                [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"crt_alrtmsg", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles:nil, nil]show];
                 NSString *strImageURL = [dicResponse objectForKey:@"image_url"];
                 [[NSUserDefaults standardUserDefaults]setObject:strImageURL forKey:@"Key_ImageURL"];
                 [[NSUserDefaults standardUserDefaults]synchronize];
             }
             else
             {
                 [[NSUserDefaults standardUserDefaults]setObject:[dicResponse objectForKey:@"passenger_id"] forKey:@"Key_Passenger_Id"];
                 [[NSUserDefaults standardUserDefaults]setObject:[dicResponse objectForKey:@"first_name"] forKey:@"Key_FirstName"];
                 [[NSUserDefaults standardUserDefaults]setObject:[dicResponse objectForKey:@"last_name"] forKey:@"Key_LastName"];
                 [[NSUserDefaults standardUserDefaults]setObject:[dicResponse objectForKey:@"mobile_no"] forKey:@"Key_Mobile"];
                 [[NSUserDefaults standardUserDefaults]setObject:[dicResponse objectForKey:@"email"] forKey:@"Key_Email"];
                 [[NSUserDefaults standardUserDefaults]setObject:[dicResponse objectForKey:@"password"] forKey:@"Key_Password"];
                 NSString *strImageURL = [dicResponse objectForKey:@"image_url"];
                 [[NSUserDefaults standardUserDefaults]setObject:strImageURL forKey:@"Key_ImageURL"];
                 [[NSUserDefaults standardUserDefaults]synchronize];
                 
                 [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"alert_profedit", @"") delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil]show];
             }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            NSLog(@"%@",[error description]);
            
            [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"alert_srvrerr", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles:nil, nil]show];
        }];
        
//        [manager GET:requestURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            
//            // Set Progressbar hide from View
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//            
//            // Response Dictionary Received from API
//            NSDictionary *dicResponse = responseObject;
//            
//            NSLog(@"Response : >>> %@",dicResponse);
//            
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            // Set Progressbar hide from View
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//            NSLog(@"%@",[error description]);
//            
//            // Show Alert if Request Session Failed
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"HopOnRide" message:@"Please try later, server is not responding." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
//            
//        }];
    }
}

//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    if (isEditProfile == YES) {
//        if (textField == txtEmail || textField == txtMobile) {
//            return NO;
//        }
//        
//        return YES;
//        
//    }else if (isEditProfile == NO)
//    {
//        return NO;
//        
//    }
//    return NO;
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark -TABLEVIEW'S DELEGATE & DATASOURCE METHODS
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == tblViewName)
    {
        return [arrProfile count];
    }
    else if (tableView == tblViewAccount)
    {
        return [arrAccount count];
    }
    else
    {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    cell.separatorInset = UIEdgeInsetsZero;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
   // [[NSUserDefaults standardUserDefaults]setObject:@"facebook" forKey:@"FbTag"];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"FbTag"]isEqualToString:@"facebook"])
    {
        if (tableView == tblViewName)
        {
            cell.textLabel.text = [arrProfile objectAtIndex:indexPath.row];
            
            if (indexPath.row == 0)
            {
                [cell.contentView addSubview:txtFirstName];
                txtFirstName.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_FirstName"];
            }
            else if (indexPath.row == 1)
            {
                [cell.contentView addSubview:txtLastName];
                
                NSString *strLastName = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_LastName"];
                if ([strLastName length]!=0)
                {
                    txtLastName.text = strLastName;
                }
            }
            
        }
        else if (tableView == tblViewAccount)
        {
            cell.textLabel.text = [arrAccount objectAtIndex:indexPath.row];
            
            if (indexPath.row == 0)
            {
                [cell.contentView addSubview:txtEmail];
                txtEmail.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_Email"];
            }
            else if (indexPath.row == 1)
            {
                [cell.contentView addSubview:txtMobile];
                txtMobile.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_Mobile"];
            }
        }
    }
    else
    {
        if (tableView == tblViewName)
        {
            cell.textLabel.text = [arrProfile objectAtIndex:indexPath.row];
            
            if (indexPath.row == 0)
            {
                [cell.contentView addSubview:txtFirstName];
                txtFirstName.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_FirstName"];
            }
            else if (indexPath.row == 1)
            {
                [cell.contentView addSubview:txtLastName];
                
                NSString *strLastName = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_LastName"];
                if ([strLastName length]!=0)
                {
                    txtLastName.text = strLastName;
                }
            }
        }
        else if (tableView == tblViewAccount)
        {
            cell.textLabel.text = [arrAccount objectAtIndex:indexPath.row];
            
            if (indexPath.row == 0)
            {
                [cell.contentView addSubview:txtEmail];
                txtEmail.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_Email"];
            }
            else if (indexPath.row == 1)
            {
                [cell.contentView addSubview:txtMobile];
                txtMobile.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_Mobile"];
            }
            else if (indexPath.row == 2)
            {
                [cell.contentView addSubview:txtPassword];
                txtPassword.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_Password"];
            }
        }
    }
        return cell;
}

- (void)actionProfileImage:(UITapGestureRecognizer *)sender{
    if (isEditProfile == YES)
    {
        //[objActionSheet showInView:self.view];
        if (IPAD)
        {
            // [objActionSheet showFromRect:imgViewProfile.frame inView:self.view animated:YES];
            
            UIAlertController *controller = [UIAlertController alertControllerWithTitle:appName message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *actionCamera = [UIAlertAction actionWithTitle:NSLocalizedString(@"txt_camera",@"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                
                if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    
                    [[[UIAlertView alloc] initWithTitle:appName message:@"Device has no camera" delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles: nil] show];
                }
                else
                {
                    imgPickerController = [[UIImagePickerController alloc] init];
                    imgPickerController.delegate = self;
                    imgPickerController.allowsEditing = YES;
                    imgPickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                    
                    [self presentViewController:imgPickerController animated:YES completion:NULL];
                }
                
            }];
            
            UIAlertAction *actionLib = [UIAlertAction actionWithTitle:@"Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                imgPickerController = [[UIImagePickerController alloc] init];
                imgPickerController.delegate = self;
                imgPickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self.navigationController presentViewController:imgPickerController animated:YES completion:nil];
                
            }];
            
            [controller addAction:actionCamera];
            [controller addAction:actionLib];
            
            [controller setModalPresentationStyle:UIModalPresentationPopover];
            
            UIPopoverPresentationController *popPresenter = [controller popoverPresentationController];
            popPresenter.sourceView = imgViewProfile;
            popPresenter.sourceRect = imgViewProfile.bounds;
            [self presentViewController:controller animated:YES completion:nil];
        }
        else
        {
            [objActionSheet showInView:self.view];
        }
    }
}

#pragma mark -
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch(buttonIndex)
    {
        case 0:
        {
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                
                [[[UIAlertView alloc] initWithTitle:appName message:@"Device has no txt_camera" delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles: nil] show];
                break;
            }
            else
            {
                imgPickerController = [[UIImagePickerController alloc] init];
                imgPickerController.delegate = self;
                imgPickerController.allowsEditing = YES;
                imgPickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                
                [self presentViewController:imgPickerController animated:YES completion:NULL];
                break;
            }
        }
        case 1:
        {
            imgPickerController = [[UIImagePickerController alloc] init];
            imgPickerController.delegate = self;
            imgPickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self.navigationController presentViewController:imgPickerController animated:YES completion:nil];
            break;
        }
        default:
            // Do Nothing.........
            break;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSLog(@"Picker returned successfully.");
    
    UIImage *selectedImage;
    
    NSURL *mediaUrl;
    
    mediaUrl = (NSURL *)[info valueForKey:UIImagePickerControllerMediaURL];
    
    if (mediaUrl == nil)
    {
        selectedImage = (UIImage *) [info valueForKey:UIImagePickerControllerEditedImage];
        if (selectedImage == nil)
        {
            selectedImage= (UIImage *) [info valueForKey:UIImagePickerControllerOriginalImage];
            NSLog(@"Original image picked.");
        }
        else
        {
            NSLog(@"Edited image picked.");
        }
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    //    [btnProfilePic setImage:selectedImage forState:UIControlStateNormal];
    [imgViewProfile setImage:selectedImage];
    
    NSData *imageData = [NSData dataWithData:UIImageJPEGRepresentation(imgViewProfile.image, 0)];
    
    // Get NSString from NSData object in Base64
    base64Encoded = [imageData base64EncodedStringWithOptions:0];
    
//    // Print the Base64 encoded string
//    NSLog(@"Encoded: %@", base64Encoded);
//    
//    // Direction API of Google Maps
//    NSString *strPostString = [NSString stringWithFormat:@"http://192.168.0.109/taxi_app/image_upload.php"];
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    NSDictionary *params = @{@"image":base64Encoded};
//    
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    
//    [manager POST:strPostString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSLog(@"%@",responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [[[UIAlertView alloc]initWithTitle:@"Cayenne" message:@"There was a problem while updating your profile picture. Please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
//        NSLog(@"Image Failed : %@",[error description]);
//    }];
    
    
    //    NSLog(@"Decoded: %@", base64Decoded);
}

@end
