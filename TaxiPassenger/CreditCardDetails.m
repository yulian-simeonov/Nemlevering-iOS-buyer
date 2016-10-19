//
//  CreditCardDetails.m
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 2/26/15.
//  Copyright (c) 2015 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import "CreditCardDetails.h"

@interface CreditCardDetails ()

@end

@implementation CreditCardDetails

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *letterTapRecognizer = [[UITapGestureRecognizer alloc]init];
    letterTapRecognizer.numberOfTapsRequired=1;
    letterTapRecognizer.delegate=self;
    [self.view addGestureRecognizer:letterTapRecognizer];
    [self.view setUserInteractionEnabled:YES];

    // Cancel button
    UIBarButtonItem *btnCancel = [[UIBarButtonItem alloc] initWithTitle: @"" style: UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem = btnCancel;
    
    tblCreditCardDetails.layer.borderColor = [[UIColor whiteColor] CGColor];
    tblCreditCardDetails.layer.borderWidth = 1.0f;
    tblCreditCardDetails.layer.cornerRadius = 3.0f;
    tblCreditCardDetails.layer.masksToBounds = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark UIGestureRecognizer Methods side menu
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    [appdelegate.deckController closeLeftViewAnimated:YES];
    return YES;
}
#pragma mark -TABLEVIEW'S DELEGATE & DATASOURCE METHODS
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    cell.separatorInset = UIEdgeInsetsZero;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *strCardNo = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_CreditCardNo"];
    NSString *strCardDate = [[NSUserDefaults standardUserDefaults]objectForKey:@"Key_ExpirationDate"];
    
    cell.textLabel.text = NSLocalizedString(@"txt_card", @"");
    cell.detailTextLabel.text = NSLocalizedString(@"txt_dd", @"");
    cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13.0f];
    
    cell.textLabel.textColor = [UIColor darkTextColor];
    cell.detailTextLabel.textColor = [UIColor darkGrayColor];
    
    UILabel *lblCardNumber = [[UILabel alloc]initWithFrame:CGRectMake(115, 7, 220, 21)];
    lblCardNumber.text = strCardNo;
    lblCardNumber.font = [UIFont systemFontOfSize:15.0f];
    lblCardNumber.textColor = [UIColor darkTextColor];
    [cell.contentView addSubview:lblCardNumber];
    
    UILabel *lblCardDate = [[UILabel alloc]initWithFrame:CGRectMake(65, 23, 220, 21)];
    lblCardDate.text = strCardDate;
    lblCardDate.font = [UIFont systemFontOfSize:13.0f];
    lblCardDate.textColor = [UIColor darkGrayColor];
    [cell.contentView addSubview:lblCardDate];
    
    return cell;
}

@end
