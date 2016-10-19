//
//  ForgotPassword.m
//  TaxiDriver
//
//  Created by TechnoMac-2 on 3/27/15.
//  Copyright (c) 2015 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import "ForgotPassword.h"

@interface ForgotPassword ()

@end

@implementation ForgotPassword
#pragma mark- view life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
      [[self navigationController] setNavigationBarHidden:NO animated:YES];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleDefault];
    [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:210/255.f green:62/255.f blue:63/255.f alpha:1.0f]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:16.0],NSFontAttributeName:[UIFont boldSystemFontOfSize:13.0f]}];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:13.0f]} forState:UIControlStateNormal];
    
    NSString *urlAddress = @"http://dashboard.findacargo.com/forgot-pass";
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [objwebview loadRequest:requestObj];
     [activityIndicator startAnimating];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark- btn action
- (IBAction)actionCancel:(id)sender
{
    [appdelegate.deckNavigationController dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)actionReset:(id)sender
{
    [appdelegate.deckNavigationController dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark- webview delegate method
- (BOOL)webView:(UIWebView *)wv shouldStartLoadWithRequest:(NSURLRequest *)rq
{
    [activityIndicator startAnimating];
    return YES;
}
- (void)webViewDidFinishLoading:(UIWebView *)wv
{
    [activityIndicator stopAnimating];
}
- (void)webView:(UIWebView *)wv didFailLoadWithError:(NSError *)error
{
    [activityIndicator stopAnimating];
}
@end
