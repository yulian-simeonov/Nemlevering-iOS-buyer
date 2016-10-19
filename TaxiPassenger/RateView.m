//
//  RateView.m
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 10/4/14.
//  Copyright (c) 2014 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import "RateView.h"
#define kNumberOfStars 5
#define kdefaultFillColor [UIColor blueColor]

@interface RateView(Private)
- (void)rating;
@end


@implementation RateView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame andStarColor:(UIColor *)color{
    self = [super initWithFrame:frame];
    if (self) {
        //initilization code
        self.clipsToBounds = YES;
        
        ratingColor = color;
        if (!ratingColor) {
            ratingColor = kdefaultFillColor;
        }
        ratingImgVw=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        ratingImgVw.contentMode=UIViewContentModeScaleToFill;
        ratingImgVw.image=[UIImage imageNamed:@"starRatingImg.png"];
        ratingImgVw.clipsToBounds = YES;
        [self addSubview:ratingImgVw];
        
        ratingViewFrameWidth = self.frame.size.width;
    }
    return self;
}

#pragma mark - Touch Events Methods
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    startPoint = point;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    endPoint = point;
    [self rating];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    endPoint = point;
    singleStarRect = ratingViewFrameWidth/kNumberOfStars;//get each single star rect(width)
    currentStarRating = endPoint.x/singleStarRect;//get rating value
    
    /* handling exception */
    if (currentStarRating > 5.0) {
        currentStarRating = 5.0;
    }else if(currentStarRating < 0.0){
        currentStarRating = 0.0;
    }
    
    if (delegate) {
        if ([delegate respondsToSelector:@selector(getRatingCount:)]) {
            [delegate getRatingCount:currentStarRating];
        }
    }
    [self rating];
}

/* cancel in the sense on touch event if a call comes then this method ll trigger */
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    /* handle ur exception code */
    NSLog(@"Touches Cancelled");
}

#pragma mark - Rating Method
- (void)rating{
    [UIView animateWithDuration:0.50
                          delay:0.0
                        options: UIViewAnimationOptionAutoreverse
                     animations:^{
                         if (fillColorView) {
                             [fillColorView removeFromSuperview];
                             fillColorView = nil;
                         }
                         fillColorView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, endPoint.x, self.frame.size.height)];
                         fillColorView.backgroundColor = ratingColor;
                         [self addSubview:fillColorView];
                         [self sendSubviewToBack:fillColorView];
                     }
                     completion:^(BOOL finished){
    }];
}
@end
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
