//
//  SFMenuVC.m
//  SocialFare
//
//  Created by Josh Moore on 4/21/14.
//  Copyright (c) 2014 SocialFare. All rights reserved.
//

#import "SFMenuVC.h"
#import "SFFriendsVC.h"
#import "SFCheckinsVC.h"

@interface SFMenuVC ()

@end

@implementation SFMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SFFunctions getFriends];
    [SFFunctions getFriendCheckins];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)viewFriendsTouched:(id)sender {
    SFFriendsVC *friendsVC = [self.storyboard instantiateViewControllerWithIdentifier:kFriendsIdentifier];
    [self.navigationController pushViewController:friendsVC animated:YES];
}

- (IBAction)viewCheckinsTouched:(id)sender {
    SFCheckinsVC *checkinsVC = [self.storyboard instantiateViewControllerWithIdentifier:kCheckinsIdentifier];
    [self.navigationController pushViewController:checkinsVC animated:YES];
}

@end
