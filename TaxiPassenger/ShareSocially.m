//
//  ShareSocially.m
//  TaxiPassenger
//
//  Created by TechnoMac-2 on 4/1/15.
//  Copyright (c) 2015 Technostacks Infotech Pvt. Ltd. All rights reserved.
//

#import "ShareSocially.h"

@interface ShareSocially ()

@end

@implementation ShareSocially

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Cancel button
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"" style: UIBarButtonItemStylePlain target:self action:nil];
    [self.navigationItem setTitle:NSLocalizedString(@"title_rcnttr", @"")];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionFacebookShare:(id)sender {
    
    SLComposeViewController *socialController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    NSString *strSetText = [NSString stringWithFormat:NSLocalizedString(@"msg_social", @"")];
    
    [socialController setInitialText:strSetText];
    
    [self presentViewController:socialController animated:YES completion:nil];
    
}

- (IBAction)actionTwitterShare:(id)sender {
    
    SLComposeViewController *socialController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    NSString *strSetText = [NSString stringWithFormat:NSLocalizedString(@"msg_social", @"")];
    
    [socialController setInitialText:strSetText];
    
    [self presentViewController:socialController animated:YES completion:nil];
    
}
@end
