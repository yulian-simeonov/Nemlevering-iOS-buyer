//
//  CreateProfile.m
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 1/7/15.
//  Copyright (c) 2015 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import "CreateProfile.h"

@interface CreateProfile ()

@end

@implementation CreateProfile

#pragma mark - ViewController's Method
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    imgViewProfile.layer.cornerRadius=imgViewProfile.frame.size.height/2;
    imgViewProfile.layer.borderColor = [[UIColor whiteColor] CGColor];
    imgViewProfile.layer.borderWidth = 1.0f;
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: NSLocalizedString(@"btn_back", @"") style: UIBarButtonItemStylePlain target:self action:@selector(actionBack)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: NSLocalizedString(@"btn_next", @"") style: UIBarButtonItemStylePlain target:self action:@selector(actionNext)];
    
    arrProfile = [[NSArray alloc]initWithObjects:NSLocalizedString(@"btn_first", @""),NSLocalizedString(@"btn_last", @""), nil];
    
    
    tblProfile.layer.borderColor = [[UIColor whiteColor] CGColor];
    tblProfile.layer.borderWidth = 1.0f;
    tblProfile.layer.cornerRadius = 3.0f;
    tblProfile.layer.masksToBounds = YES;
    
    // Set Action Sheet on btnSelectCar
    objActionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"btn_cancel", @"") destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"txt_camera", @""), NSLocalizedString(@"txt_album", @""), nil];
    objActionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [self.view addSubview:objActionSheet];
    
    UITapGestureRecognizer *oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionProfileImage:)];
    [oneTap setDelegate:self];
    [oneTap setNumberOfTapsRequired:1];
    [imgViewProfile addGestureRecognizer:oneTap];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.title = NSLocalizedString(@"profile_txt", @"");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark- custom method
-(void)actionBack
{
    appdelegate.Tag=1;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)actionNext
{
    //    [txtFirstName resignFirstResponder];
    //    [txtLastName resignFirstResponder];
    //
    //    if ([txtFirstName.text length] == 0){
    //        [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"alrt_fname", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles:nil]show];
    //    }else if ([txtLastName.text length] == 0){
    //        [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"alrt_lname", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles:nil]show];
    //    }else{
    //        [[NSUserDefaults standardUserDefaults]setObject:txtFirstName.text forKey:@"Key_FirstName"];
    //        [[NSUserDefaults standardUserDefaults]setObject:txtLastName.text forKey:@"Key_LastName"];
    //        [[NSUserDefaults standardUserDefaults]synchronize];
    //
    //        objPaymentDetails = [[PaymentDetails alloc]initWithNibName:@"PaymentDetails" bundle:nil];
    //        [appdelegate.deckNavigationController pushViewController:objPaymentDetails animated:YES];
    //    }
}

#pragma mark -TABLEVIEW'S DELEGATE & DATASOURCE METHODS
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrProfile count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Create Cell for TableView
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    cell.separatorInset = UIEdgeInsetsZero;
    cell.textLabel.text = [arrProfile objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        // [cell.contentView addSubview:txtFirstName];
    }else if (indexPath.row == 1){
        // [cell.contentView addSubview:txtLastName];
    }
    
    return cell;
}

#pragma mark - TEXTFIELD DELEGATE METHODS
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==txtFirstname)
    {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHA] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        NSString *updatedText = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (updatedText.length > 30)
        {
            if (string.length > 1)
            {
            }
            return NO;
        }
//        if([string isEqualToString:@" "])
//        {
//            // Returning no here to restrict whitespace
//            return NO;
//        }
        return [string isEqualToString:filtered];
        
    }
    else if (textField==txtLastname)
    {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHA] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        NSString *updatedText = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (updatedText.length > 30)
        {
            if (string.length > 1)
            {
            }
            return NO;
        }
//        if([string isEqualToString:@" "])
//        {
//            // Returning no here to restrict whitespace
//            return NO;
//        }
        return [string isEqualToString:filtered];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark ButtonAction Methods

- (IBAction)btnBackPresssed:(id)sender
{
    appdelegate.Tag=1;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)actionProfileImage:(UITapGestureRecognizer *)sender
{
    //[objActionSheet showInView:self.view];
    if (IPAD)
    {
        // [objActionSheet showFromRect:imgViewProfile.frame inView:self.view animated:YES];
        
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:appName message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *actionCamera = [UIAlertAction actionWithTitle:@"txt_camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                
                [[[UIAlertView alloc] initWithTitle:appName message:@"Device has no camera" delegate:nil cancelButtonTitle:@"btn_ok" otherButtonTitles: nil] show];
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
- (IBAction)btnNextPressed:(id)sender
{
    [txtFirstname resignFirstResponder];
    [txtLastname resignFirstResponder];
    
    if ([txtFirstname.text length] == 0)
    {
        [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"alrt_fname", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles:nil]show];
    }
    else if ([txtLastname.text length] == 0)
    {
        [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"alrt_lname", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles:nil]show];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setObject:txtFirstname.text forKey:@"Key_FirstName"];
        [[NSUserDefaults standardUserDefaults]setObject:txtLastname.text forKey:@"Key_LastName"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        if (IPAD)
        {
            objPaymentDetails = [[PaymentDetails alloc]initWithNibName:@"paymentDetailView_Ipad" bundle:nil];
            [appdelegate.deckNavigationController pushViewController:objPaymentDetails animated:YES];
        }
        else
        {
            objPaymentDetails = [[PaymentDetails alloc]initWithNibName:@"PaymentDetails" bundle:nil];
            [appdelegate.deckNavigationController pushViewController:objPaymentDetails animated:YES];
        }
    }
}
- (IBAction)btnSignInPressed:(id)sender
{
    appdelegate.Tag=2;
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnRegistrationPressed:(id)sender
{
    appdelegate.Tag=1;
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - action sheet method
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch(buttonIndex)
    {
        case 0:
        {
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                
                [[[UIAlertView alloc] initWithTitle:appName message:@"Device has no camera" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
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
#pragma mark- image picker delegat method
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
    NSString *base64Encoded = [imageData base64EncodedStringWithOptions:0];
    
    // Print the Base64 encoded string
    NSLog(@"Encoded: %@", base64Encoded);
    
    [[NSUserDefaults standardUserDefaults]setObject:base64Encoded forKey:@"Key_Image"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
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
