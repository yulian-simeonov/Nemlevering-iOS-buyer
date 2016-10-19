//
//  SideViewController.m
//  Taxi
//
//  Created by TechnoMac-2 on 9/15/14.
//  Copyright (c) 2014 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import "SideViewController.h"

@interface SideViewController ()

@end

@implementation SideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark -VIEWCONTROLLER'S DELEGATE METHODS
- (void)viewDidLoad
{
//    if (IPAD)
//    {
//       // imgProfileImage.layer.cornerRadius=imgProfileImage.frame.size.height/2;
//    }
//    else
//    {
//       // imgProfileImage.layer.cornerRadius=imgProfileImage.frame.size.height/2;
//    }
//    //imgProfileImage.layer.masksToBounds=YES;
    
//    _objDriver_rating.backgroundColor  = [UIColor clearColor];
//    _objDriver_rating.starImage = [[UIImage imageNamed:@"star-template"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//    _objDriver_rating.starHighlightedImage = [[UIImage imageNamed:@"star-highlighted-template"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//    _objDriver_rating.maxRating = 5.0;
//    
//    //_objDriver_rating.delegate = self;
//    _objDriver_rating.rating = 5.0;
//    _objDriver_rating.horizontalMargin = 10.0;
//    _objDriver_rating.editable=NO;
//
//[_objDriver_rating setNeedsDisplay];
//    
//    
//    _objDriver_rating.tintColor = [UIColor redColor];
//    
//    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"rating"]) {
//        NSString *strRating=[[NSUserDefaults standardUserDefaults]objectForKey:@"rating"];
//        float rating=[strRating intValue];
//        _objDriver_rating.rating=rating;
//    }
//    
    [super viewDidLoad];
   
    NSString *strMenu = [NSString stringWithFormat:NSLocalizedString(@"txt_sidegtr", @""),NSLocalizedString(@"txt_sidercnt", @""),NSLocalizedString(@"txt_sidersrvtn", @""),NSLocalizedString(@"txt_sidepmnt", @""),NSLocalizedString(@"txt_sidelogt", @"")];
    
    // Set Array of Menu
    arrMenu = [[strMenu componentsSeparatedByString:@","] mutableCopy];
    
    arrMenu = [[NSMutableArray alloc]initWithObjects:NSLocalizedString(@"txt_sidegtr", @""),NSLocalizedString(@"txt_sidercnt", @""),NSLocalizedString(@"txt_sidersrvtn", @""),NSLocalizedString(@"txt_sidepmnt", @""),NSLocalizedString(@"txt_sidelogt", @""), nil];
    
    // Write ImagesString for Images
    NSString *strImagesName = [NSString stringWithFormat:@"menu_cell_icon_1.png,menu_cell_icon_2.png,menu_cell_icon_3.png,menu_cell_icon_4.png,menu_cell_icon_5.png,menu_cell_icon_7.png"];
    //Logout.png
    
    // Set Array of Menu Images
    arrImages = [[strImagesName componentsSeparatedByString:@","] mutableCopy];
}
-(IBAction)clk_close:(id)sender
{
     [appdelegate.deckController closeLeftViewAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
       if (IPAD)
    {
        NSString *str=[NSString stringWithFormat:@"%@ %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"Key_FirstName"],[[NSUserDefaults standardUserDefaults] objectForKey:@"Key_LastName"]];
        lblProfileName.text=str;
       
        _objDriver_rating.backgroundColor  = [UIColor clearColor];
        _objDriver_rating.starImage = [[UIImage imageNamed:@"star-template"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _objDriver_rating.starHighlightedImage = [[UIImage imageNamed:@"star-highlighted-template"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        _objDriver_rating.maxRating = 5.0;
        
        //_objDriver_rating.delegate = self;
        _objDriver_rating.rating = 5.0;
        _objDriver_rating.horizontalMargin = 10.0;
        _objDriver_rating.editable=NO;
        
        [_objDriver_rating setNeedsDisplay];
        
        
        _objDriver_rating.tintColor = [UIColor redColor];
        
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"rating"]) {
            NSString *strRating=[[NSUserDefaults standardUserDefaults]objectForKey:@"rating"];
            float rating=[strRating intValue];
            _objDriver_rating.rating=rating;
            
        }
            imgProfileImage=[[UIImageView alloc]init];
            lblProfileName=[[UILabel alloc]init];
            [lblProfileName setTextAlignment:NSTextAlignmentCenter];
            lblProfileName.textColor=[UIColor darkGrayColor];
            
            lblProfileName.font=[UIFont fontWithName:@"Libertad-Bold" size:23.0f];
            
            
            imgProfileImage.frame=CGRectMake(self.view.frame.size.width/2-83, 70, 100, 100);
            imgProfileImage.image=[UIImage imageNamed:@"person-placeholder.jpg"];
            imgProfileImage.layer.cornerRadius=imgProfileImage.frame.size.width/2;
            imgProfileImage.layer.masksToBounds=YES;
            imgProfileImage.clipsToBounds=YES;
            
            
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTaped:)];
            singleTap.delegate = self;
            singleTap.numberOfTapsRequired = 1;
            singleTap.numberOfTouchesRequired = 1;
            [imgProfileImage addGestureRecognizer:singleTap];
            [imgProfileImage setUserInteractionEnabled:YES];
            

        
        NSString *strImageURL =[[NSUserDefaults standardUserDefaults]objectForKey:@"Key_ImageURL"];
        if ([strImageURL length]!=0)
        {
            [imgProfileImage setImageWithURL:[NSURL URLWithString:strImageURL] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
        }

        
    }else{
        imgProfileImage1=[[UIImageView alloc]init];
        imgProfileImage1.frame=CGRectMake(self.view.frame.size.width/2-83, 70, 100, 100);
        imgProfileImage1.image=[UIImage imageNamed:@"person-placeholder.jpg"];
        imgProfileImage1.layer.cornerRadius=imgProfileImage1.frame.size.width/2;
        imgProfileImage1.layer.masksToBounds=YES;
        imgProfileImage1.clipsToBounds=YES;

        if (lblProfileName1 == nil)
        {
            
            lblProfileName1=[[UILabel alloc]init];
            [lblProfileName1 setTextAlignment:NSTextAlignmentCenter];
            lblProfileName1.textColor=[UIColor darkGrayColor];
            lblProfileName1.font=[UIFont fontWithName:@"Libertad-Bold" size:23.0f];
        }

        NSString *str=[NSString stringWithFormat:@"%@ %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"Key_FirstName"],[[NSUserDefaults standardUserDefaults] objectForKey:@"Key_LastName"]];
        lblProfileName1.text=str;
    
        _objDriver_rating1=[[EDStarRating alloc]init];
        _objDriver_rating1.backgroundColor  = [UIColor clearColor];
        _objDriver_rating1.starImage = [[UIImage imageNamed:@"star-template"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _objDriver_rating1.starHighlightedImage = [[UIImage imageNamed:@"star-highlighted-template"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        _objDriver_rating1.maxRating = 5.0;
        
        //_objDriver_rating.delegate = self;
        _objDriver_rating1.rating = 5.0;
        _objDriver_rating1.horizontalMargin = 10.0;
        _objDriver_rating1.editable=NO;
        
        [_objDriver_rating1 setNeedsDisplay];
        
        
        _objDriver_rating1.tintColor = [UIColor redColor];
        
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"rating"]) {
            NSString *strRating=[[NSUserDefaults standardUserDefaults]objectForKey:@"rating"];
            float rating=[strRating intValue];
            _objDriver_rating1.rating=rating;
        }
        CGRect screenbounds = [[UIScreen mainScreen]bounds];
        self.view.frame=CGRectMake(0, 0,screenbounds.size.width,screenbounds.size.height);
        
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTaped:)];
        singleTap.delegate = self;
        singleTap.numberOfTapsRequired = 1;
        singleTap.numberOfTouchesRequired = 1;
        [imgProfileImage1 addGestureRecognizer:singleTap];
        [imgProfileImage1 setUserInteractionEnabled:YES];
        
              
        imgProfileImage1.frame=CGRectMake(self.view.frame.size.width/2-83, 70, 97, 100);
        btnProfile1.frame=CGRectMake(self.view.frame.size.width/2-101,72, 133, 90);
        
         lblProfileName1.frame=CGRectMake(5, imgProfileImage1.frame.origin.y+imgProfileImage1.frame.size.height+10, self.view.frame.size.width-80, 21);
        
        
        _objDriver_rating1.frame=CGRectMake(self.view.frame.size.width/2-91, lblProfileName1.frame.origin.y+lblProfileName1.frame.size.height+10, 113, 15);
        tblSideView.frame=CGRectMake(0, _objDriver_rating1.frame.origin.y+_objDriver_rating1.frame.size.height+20,self.view.frame.size.width,self.view.frame.size.height-318);
     
    
        NSString *strImageURL =[[NSUserDefaults standardUserDefaults]objectForKey:@"Key_ImageURL"];
        if ([strImageURL length]!=0)
       {
           [imgProfileImage1 setImageWithURL:[NSURL URLWithString:strImageURL] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
       }
        
        [self.view addSubview:lblProfileName1];
        [self.view addSubview:imgProfileImage1];
        [self.view addSubview:_objDriver_rating1];
    }
    
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -TABLEVIEW'S DELEGATE & DATASOURCE METHODS
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrMenu count]-1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    cell.separatorInset = UIEdgeInsetsZero;
    
    // Set Selected BackgroundView
    viewForCellSelected = [[UIView alloc]init];
    viewForCellSelected.backgroundColor = [UIColor colorWithRed:2/255.f green:124/255.f blue:225/255.f alpha:1.0f];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    
    if (IPAD)
    {
        UILabel *lblMenuName = [[UILabel alloc]
                                initWithFrame:CGRectMake(70, 7, 230, 40)];
        lblMenuName.font = [UIFont fontWithName:@"Libertad-Bold" size:30.0f];
        lblMenuName.textColor=[UIColor whiteColor];
        lblMenuName.text = [arrMenu objectAtIndex:indexPath.row];
        [cell.contentView addSubview:lblMenuName];
        
        lblMenuName.textAlignment = NSTextAlignmentLeft;
    }
    else
    {
        UILabel *lblMenuName = [[UILabel alloc]
                                initWithFrame:CGRectMake(70, 7, 150, 30)];
        lblMenuName.font = [UIFont fontWithName:@"Libertad-Bold" size:20.0f];
        lblMenuName.textColor=[UIColor whiteColor];
        lblMenuName.text = [arrMenu objectAtIndex:indexPath.row];
        [cell.contentView addSubview:lblMenuName];
        
        lblMenuName.textAlignment = NSTextAlignmentLeft;
    }

//    // Add ImageView in Cell for MenuImage
//    UIImageView *imgMenuImage = [[UIImageView alloc]initWithFrame:CGRectMake(33, 7, 30, 30)];
//    imgMenuImage.image = [UIImage imageNamed:[arrImages objectAtIndex:indexPath.row]];
//    imgMenuImage.contentMode = UIViewContentModeCenter;
//    [cell.contentView addSubview:imgMenuImage];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tblSideView reloadData];
    
    switch (indexPath.row) {
            // Get a Taxi
        case 0:{
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
            [appdelegate.deckController closeLeftViewAnimated:YES];
            break;
        }
            // Recents
        case 1:{
            Recents *objRecents = [[Recents alloc]initWithNibName:@"Recents" bundle:nil];
            [appdelegate.deckNavigationController pushViewController:objRecents animated:NO];
            [appdelegate.deckController closeLeftViewAnimated:YES];
            break;
        }
            
            // Reservation
        case 2:{
            Reservation *objReservation = [[Reservation alloc]initWithNibName:@"Reservation" bundle:nil];
            [appdelegate.deckNavigationController pushViewController:objReservation animated:NO];
            [appdelegate.deckController closeLeftViewAnimated:YES];
            break;
        }
            
            // Payment
        case 3:{
            CreditCardDetails *objCreditCardDetails = [[CreditCardDetails alloc]initWithNibName:@"CreditCardDetails" bundle:nil];
            [appdelegate.deckNavigationController pushViewController:objCreditCardDetails animated:NO];
            [appdelegate.deckController closeLeftViewAnimated:YES];
            break;
        }
            
            // Lost & Found
        case 4:{
            LostAndFound *objLostAndFound = [[LostAndFound alloc]initWithNibName:@"LostAndFound" bundle:nil];
//            [gAppDelegate.deckNavigationController pushViewController:objLostAndFound animated:YES];
//            [gAppDelegate.deckController closeLeftViewAnimated:YES];
            
            UINavigationController *objTempNavigationController = [[UINavigationController alloc]initWithRootViewController:objLostAndFound];
            objTempNavigationController.navigationBar.translucent = NO;
            [appdelegate.deckNavigationController presentViewController:objTempNavigationController animated:YES completion:nil];
//            [gAppDelegate.deckController closeLeftViewAnimated:YES];
            
            break;
        }
        case 5:{
            ShareSocially *objShareSocially = [[ShareSocially alloc]initWithNibName:@"ShareSocially" bundle:nil];
            [appdelegate.deckNavigationController pushViewController:objShareSocially animated:NO];
            [appdelegate.deckController closeLeftViewAnimated:YES];
            
            break;
        }
            // Log Out
//        case 6:{
//            SplashView *objSplashView = [[SplashView alloc]initWithNibName:@"SplashView" bundle:nil];
//            [appdelegate.deckNavigationController pushViewController:objSplashView animated:NO];
//            [appdelegate.deckController closeLeftViewAnimated:YES];
//            
//            break;
//        }

        default:
            break;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (IPAD)
    {
        UIView *footer=[[UIView alloc]initWithFrame:CGRectMake(5, 20, 200, 40)];
        UIButton *btnlogout=[[UIButton alloc]initWithFrame:CGRectMake(60, 30, 120, 47)];
        [btnlogout setTitle:NSLocalizedString(@"txt_sidelogt",@"") forState:UIControlStateNormal];
        
        btnlogout.titleLabel.font=[UIFont fontWithName:@"Libertad-Bold" size:15];
        [btnlogout setBackgroundImage:[UIImage imageNamed:@"SignIn_btn"] forState:UIControlStateNormal];
        [btnlogout addTarget:self action:@selector(btnLogoutPressed:) forControlEvents:UIControlEventTouchUpInside];
        [footer addSubview:btnlogout];
    
        return footer;
    }
    else
    {
        UIView *footer=[[UIView alloc]initWithFrame:CGRectMake(5, 20, 200, 40)];
        UIButton *btnlogout=[[UIButton alloc]initWithFrame:CGRectMake(60, 30, 120, 47)];
        [btnlogout setTitle:NSLocalizedString(@"txt_sidelogt",@"") forState:UIControlStateNormal];
        
        btnlogout.titleLabel.font=[UIFont fontWithName:@"Libertad-Bold" size:15];
        [btnlogout setBackgroundImage:[UIImage imageNamed:@"SignIn_btn"] forState:UIControlStateNormal];
        [btnlogout addTarget:self action:@selector(btnLogoutPressed:) forControlEvents:UIControlEventTouchUpInside];
        [footer addSubview:btnlogout];
    
        return footer;
    }
    //    tableView.frame = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, self.view.frame.size.width,tableView.frame.size.height);
//    UIImage *btnimage = [UIImage imageNamed:@"SignIn_btn"];
//    UIView *footerview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width,btnimage.size.height+60)];
//    
//    footerview.backgroundColor = [UIColor clearColor];
//    
//    UIButton *btnlogout = [[UIButton alloc]initWithFrame:CGRectMake(footerview.frame.size.width/2-(btnimage.size.width/2)-20,footerview.frame.size.height/2-(btnimage.size.height/2), btnimage.size.width, btnimage.size.height)];
//    [btnlogout setBackgroundImage:btnimage forState:UIControlStateNormal];
//    [btnlogout setTitle:NSLocalizedString(@"txt_sidelogt",@"") forState:UIControlStateNormal];
//    
//    btnlogout.titleLabel.font=[UIFont fontWithName:@"Libertad-Bold" size:12.0f];
//    [btnlogout setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 90;

}

- (void)imageTaped:(UIGestureRecognizer *)gestureRecognizer
{
    if (IPAD)
    {
        Profile *objProfile = [[Profile alloc]initWithNibName:@"profileView_Ipad" bundle:nil];
        [appdelegate.deckNavigationController pushViewController:objProfile animated:NO];
        [appdelegate.deckController closeLeftViewAnimated:YES];
    }
    else
    {
        
        Profile *objProfile = [[Profile alloc]initWithNibName:@"Profile" bundle:nil];
        [appdelegate.deckNavigationController pushViewController:objProfile animated:NO];
        [appdelegate.deckController closeLeftViewAnimated:YES];
    }
}
- (IBAction)actionChangeProfile:(id)sender
{
    if (IPAD)
    {
        Profile *objProfile = [[Profile alloc]initWithNibName:@"profileView_Ipad" bundle:nil];
        [appdelegate.deckNavigationController pushViewController:objProfile animated:NO];
        [appdelegate.deckController closeLeftViewAnimated:YES];
    }
    else
    {
        Profile *objProfile = [[Profile alloc]initWithNibName:@"Profile" bundle:nil];
        [appdelegate.deckNavigationController pushViewController:objProfile animated:NO];
        [appdelegate.deckController closeLeftViewAnimated:YES];
    }
}
- (IBAction)btnLogoutPressed:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"key_rememberme"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    if (IPAD)
    {
        appdelegate.Tag=3;
        SplashView *objSplashView = [[SplashView alloc]initWithNibName:@"splashView_Ipad" bundle:nil];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"FbTag"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_Email"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_Mobile"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_Password"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_ReservationDate"];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"VehicalSelect"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"passenger_id"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Device_Token"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_Passenger_Id"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_Driver_Id"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_Driver_Lat"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_Driver_Long"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_DriverArray_Index"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_TripDuration"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_TripFare"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_TripId"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_FirstName"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_LastName"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_Image"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_CreditCardNo"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_ExpirationDate"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"driver_list"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_PromoCode"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"btntag"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_Driver_Name"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_Driver_Image"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_Lost"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_ImageURL"];

        [[NSUserDefaults standardUserDefaults]synchronize];
        [appdelegate.deckNavigationController pushViewController:objSplashView animated:NO];
        [appdelegate.deckController closeLeftViewAnimated:YES];
    }
    else
    {
        appdelegate.Tag=3;
        SplashView *objSplashView = [[SplashView alloc]initWithNibName:@"SplashView" bundle:nil];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"FbTag"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_Email"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_Mobile"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_Password"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_ReservationDate"];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"VehicalSelect"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"passenger_id"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Device_Token"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_Passenger_Id"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_Driver_Id"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_Driver_Lat"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_Driver_Long"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_DriverArray_Index"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_TripDuration"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_TripFare"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_TripId"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_FirstName"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_LastName"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_Image"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_CreditCardNo"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_ExpirationDate"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"driver_list"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_PromoCode"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"btntag"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_Driver_Name"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_Driver_Image"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_Lost"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Key_ImageURL"];
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        [appdelegate.deckNavigationController pushViewController:objSplashView animated:NO];
        [appdelegate.deckController closeLeftViewAnimated:YES];
    }
}
- (IBAction)btnProfile:(id)sender
{
}
@end
