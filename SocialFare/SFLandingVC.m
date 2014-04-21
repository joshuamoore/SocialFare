//
//  SFViewController.m
//  SocialFare
//
//  Created by Josh Moore on 4/20/14.
//  Copyright (c) 2014 SocialFare. All rights reserved.
//

#import "SFLandingVC.h"
#import "SFAppDelegate.h"
#import "SFMenuVC.h"

@interface SFLandingVC ()

@end

@implementation SFLandingVC

@synthesize loginView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    loginView.delegate = self;
    loginView.readPermissions = @[
                                @"user_checkins",
                                @"user_friends"
                                ];
    [loginView sizeToFit];
    
    [self updateView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)updateView {
    SFAppDelegate *appDelegate = (SFAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSLog(@"isOpen: %d", appDelegate.session.isOpen);
    if (appDelegate.session.isOpen) {
        [self transitionToMainViewController];
    } else {
        NSLog(@"FB session not open");
    }
}

- (void)transitionToMainViewController {
//    [OUTFunctions getFriends];
    
    SFMenuVC *menuVC = (SFMenuVC *)[self.storyboard instantiateViewControllerWithIdentifier:kMenuIdentifier];
    [self.navigationController pushViewController:menuVC animated:NO];
}

// You need to override loginView:handleError in order to handle possible errors that can occur during login
- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;
    
    // If the user should perform an action outside of you app to recover,
    // the SDK will provide a message for the user, you just need to surface it.
    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
        // This code will handle session closures since that happen outside of the app.
        // You can take a look at our error handling guide to know more about it
        // https://developers.facebook.com/docs/ios/errors
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
        // You can also choose to show the user a message if cancelling login will result in
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
        // You can checkout our error handling guide for more detailed information
        // https://developers.facebook.com/docs/ios/errors
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
    NSLog(@"user: %@", user);
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    NSLog(@"showing logged in user");
    
    [self transitionToMainViewController];
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    NSLog(@"showing logged OUT user");
    
    [SFFunctions clearUserDefaults];
    [self logOut];
}

- (void)logOut {
    // on log out we reset the main view controller
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
