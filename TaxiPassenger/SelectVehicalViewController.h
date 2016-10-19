//
//  SelectVehicalViewController.h
//  Taxi App
//
//  Created by TechnoMac-11 on 21/05/16.
//  Copyright © 2016 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetTaxi.h"

@interface SelectVehicalViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UIGestureRecognizerDelegate>
{
    NSMutableArray *objarry;
    NSMutableArray *objImagArry;
    
    NSMutableArray *arrPrice;
    IBOutlet UIPickerView *objPIckerView;
}

@end
