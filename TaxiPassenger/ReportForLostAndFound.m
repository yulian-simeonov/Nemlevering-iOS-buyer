//
//  ReportForLostAndFound.m
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 3/26/15.
//  Copyright (c) 2015 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import "ReportForLostAndFound.h"

@interface ReportForLostAndFound ()

@end

@implementation ReportForLostAndFound
@synthesize dicRecentDetails;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"title_trip", @"") style: UIBarButtonItemStylePlain target:self action:@selector(actionReport:)];
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"Key_Lost"]==YES) {
        arrReportFields = [[NSArray alloc]initWithObjects:NSLocalizedString(@"text_trpd", @""),NSLocalizedString(@"txt_drname", @""),NSLocalizedString(@"txt_lostitm", @""),NSLocalizedString(@"txt_desc", @""), nil];
        [self.navigationItem setTitle:NSLocalizedString(@"title_lostreport", @"")];
    }else if ([[NSUserDefaults standardUserDefaults]boolForKey:@"Key_Lost"]==NO){
        arrReportFields = [[NSArray alloc]initWithObjects:NSLocalizedString(@"text_trpd", @""),NSLocalizedString(@"txt_drname", @""),NSLocalizedString(@"txt_founditem", @""),NSLocalizedString(@"txt_desc", @""), nil];
        [self.navigationItem setTitle:NSLocalizedString(@"title_foundrp", @"")];
    }
    
    txtLostItem = [[UITextField alloc]initWithFrame:CGRectMake(120, 5, 190, 30)];
    [txtLostItem setFont:[UIFont fontWithName:@"HelveticaNeue" size:13.0f]];
    txtLostItem.placeholder = [arrReportFields objectAtIndex:2];
    [txtLostItem setTintColor:[UIColor darkGrayColor]];
    txtLostItem.delegate = self;
    txtLostItem.borderStyle = UITextBorderStyleRoundedRect;
    txtLostItem.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    txtDescription = [[UITextView alloc]initWithFrame:CGRectMake(10, 35, 300, 88)];
    txtDescription.text = NSLocalizedString(@"txt_desc", @"");
    [txtDescription setFont:[UIFont fontWithName:@"HelveticaNeue" size:13.0f]];
    [txtDescription setTextColor:[UIColor lightGrayColor]];
    [txtDescription setTintColor:[UIColor darkGrayColor]];
    txtDescription.backgroundColor = [UIColor groupTableViewBackgroundColor];
    txtDescription.layer.borderWidth = 0.30f;
    txtDescription.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    txtDescription.layer.cornerRadius = 5.0f;
    txtDescription.layer.masksToBounds = YES;
    txtDescription.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -TABLEVIEW'S DELEGATE & DATASOURCE METHODS
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrReportFields count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        return 132.0f;
    }
    return 40.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Create Cell for TableView
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    cell.separatorInset = UIEdgeInsetsZero;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.textLabel.text = [arrReportFields objectAtIndex:indexPath.row];
    
    UILabel *lblFieldName = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 120, 30)];
    lblFieldName.text = [arrReportFields objectAtIndex:indexPath.row];
    lblFieldName.textColor = [UIColor darkGrayColor];
    lblFieldName.font = [UIFont fontWithName:@"Hevetica" size:15.0f];
    [cell.contentView addSubview:lblFieldName];
    
    switch (indexPath.row) {
        case 0:{
            cell.detailTextLabel.text = [dicRecentDetails objectForKey:@"trip_date"];
            
            break;
        }
        case 1:{
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@",[dicRecentDetails objectForKey:@"first_name"],[dicRecentDetails objectForKey:@"last_name"]];
            
            break;
        }
        case 2:{
            [cell.contentView addSubview:txtLostItem];
            
            break;
        }
        case 3:{
            [cell.contentView addSubview:txtDescription];
            
            break;
        }
        default:{
            
            break;
        }
    }
    return cell;
}

- (void)actionReport:(id)sender {
    
    NSLog(@"%@",dicRecentDetails);
    
    NSString *strItem = txtLostItem.text;
    NSString *strDescription = txtDescription.text;
    NSString *strLostorFound;
    NSString *strTripDate = [dicRecentDetails objectForKey:@"trip_date"];
    NSString *strDriverId = [dicRecentDetails objectForKey:@"driver_id"];
    NSString *strTripId = [dicRecentDetails objectForKey:@"trip_id"];
    NSString *strLostFound;
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"Key_Lost"]==YES) {
        strLostorFound = [NSString stringWithFormat:@"Lost"];
        strLostFound = [NSString stringWithFormat:@"0"];
        
    }else if ([[NSUserDefaults standardUserDefaults]boolForKey:@"Key_Lost"]==NO){
        strLostorFound = [NSString stringWithFormat:@"Found"];
        strLostFound = [NSString stringWithFormat:@"1"];
    }
    
    if ([strItem length]==0) {
        [[[UIAlertView alloc]initWithTitle:appName message:[NSString stringWithFormat:@"Please enter the name of item which is %@ during trip.",strLostorFound]  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
        
    }else if ([strDescription length]==0){
        [[[UIAlertView alloc]initWithTitle:appName message:[NSString stringWithFormat:@"Please enter the description of item which is %@ during trip.",strLostorFound]  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
        
    }else{
#pragma mark - URL Change

       // NSString *strPostRequest = [NSString stringWithFormat:@"http://54.153.20.98/api/android/lost_found.php"];
        
        NSString *strURL = [NSString stringWithFormat:@"%@lost_found.php",strBaseANURL];
        
        NSString *strPassengerId = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_Passenger_Id"];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        
        NSDictionary *params = @{@"trip_id":strTripId,@"trip_date":strTripDate,@"driver_id":strDriverId,@"passenger_id":strPassengerId,@"description":strDescription,@"lost_item":strItem,@"lost_found":strLostFound,@"req_from":@"1"};
        
        [manager GET:strURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dicResponse = responseObject;
            
            if ([[dicResponse objectForKey:@"status"]isEqualToString:@"1"]) {
                [appdelegate.deckController closeLeftViewAnimated:YES];
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                
            }else{
                [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"alrt_rpsave", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles: nil]show];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [[[UIAlertView alloc]initWithTitle:appName message:NSLocalizedString(@"alrt_rpsave", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", @"") otherButtonTitles: nil]show];
        }];
    }
}

#pragma mark - TEXTFIELD DELEGATES
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [txtLostItem resignFirstResponder];
    if(txtDescription.text.length == 0){
        txtDescription.textColor = [UIColor lightGrayColor];
        txtDescription.text = NSLocalizedString(@"txt_desc", @"");
        [txtDescription resignFirstResponder];
    }
    return YES;
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (textView.textColor == [UIColor lightGrayColor]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(textView.text.length == 0){
        textView.textColor = [UIColor lightGrayColor];
        textView.text = NSLocalizedString(@"txt_desc", @"");
        [textView resignFirstResponder];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if(textView.text.length == 0){
            textView.textColor = [UIColor lightGrayColor];
            textView.text = NSLocalizedString(@"txt_desc", @"");
            [textView resignFirstResponder];
        }
        return NO;
    }
    
    return YES;
}

@end
