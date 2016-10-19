//
//  RateView.h
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 10/4/14.
//  Copyright (c) 2014 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RatingViewDelegate <NSObject>
@optional

- (void)getRatingCount:(float)rateCount;

@end


@interface RateView : UIView
{
    UIImageView *ratingImgVw;
    CGPoint startPoint;
    CGPoint endPoint;
    UIView *fillColorView;
    CGFloat ratingViewFrameWidth;
    CGFloat singleStarRect;
    CGFloat currentStarRating;
    UIColor *ratingColor;
}
@property(nonatomic,retain) id<RatingViewDelegate> delegate;
- (id)initWithFrame:(CGRect)frame andStarColor:(UIColor *)color;
@end
