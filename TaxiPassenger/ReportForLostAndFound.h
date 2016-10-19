//
//  ReportForLostAndFound.h
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 3/26/15.
//  Copyright (c) 2015 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportForLostAndFound : UIViewController<UITextFieldDelegate, UITextViewDelegate>
{
    
    IBOutlet UIButton *btnReport;
    
    NSArray *arrReportFields;
    
    UITextField *txtLostItem;
    
    UITextView *txtDescription;
}

@property (strong, nonatomic) NSDictionary *dicRecentDetails;
@end
