//
//  TripDetails.m
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 3/13/15.
//  Copyright (c) 2015 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import "TripDetails.h"

@implementation TripDetails

- (void)awakeFromNib {
    // Initialization code
    
    [self.imgViewProfile.layer setCornerRadius:40.0f];
    [self.imgViewProfile.layer setMasksToBounds:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
