//
//  SFAppDelegate.m
//  SocialFare
//
//  Created by Josh Moore on 4/20/14.
//  Copyright (c) 2014 SocialFare. All rights reserved.
//

#import "SFAppDelegate.h"

#import "SFLandingVC.h"

@implementation SFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initializeFacebook];
    
    self.navigationController = [[UINavigationController alloc] initWithNavigationBarClass:[UINavigationBar class]
                                                                              toolbarClass:[UIToolbar class]];
    
    
    UIStoryboard *storyboard = [self getStoryboard];
    
    SFLandingVC *landingVC = (SFLandingVC *)[storyboard instantiateViewControllerWithIdentifier:kLandingIdentifier];
    [self.navigationController pushViewController:landingVC animated:YES];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)initializeFacebook {
    [FBLoginView class];
    
    // Whenever a person opens the app, check for a cached session
    if (self.session.state == FBSessionStateCreatedTokenLoaded) {
        
        // If there's one, just open the session silently, without showing the user the login UI
        [FBSession openActiveSessionWithReadPermissions:@[@"basic_info"]
                                           allowLoginUI:NO
                                      completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                          // Handler for session state changes
                                          // This method will be called EACH time the session state changes,
                                          // also for intermediate states and NOT just when the session open
                                          [self sessionStateChanged:session state:state error:error];
                                      }];
    }
    
    if (self.session.isOpen) {
        [SFFunctions getFriends];
    }
}

- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState)state error:(NSError *)error
{
    // If the session was opened successfully
    if (!error && state == FBSessionStateOpen){
        NSLog(@"Session opened");
        // Show the user the logged-in UI
        [self userLoggedIn];
        return;
    }
    if (state == FBSessionStateClosed || state == FBSessionStateClosedLoginFailed){
        // If the session is closed
        NSLog(@"Session closed: %d", state);
        // Show the user the logged-out UI
        [self userLoggedOut];
    }
    
    // Handle errors
    if (error){
        NSLog(@"Error");
        NSString *alertText;
        NSString *alertTitle;
        // If the error requires people using an app to make an action outside of the app in order to recover
        if ([FBErrorUtility shouldNotifyUserForError:error] == YES){
            alertTitle = @"Something went wrong";
            alertText = [FBErrorUtility userMessageForError:error];
            [SFFunctions alertView:alertTitle withMessage:alertText];
        } else {
            
            // If the user cancelled login, do nothing
            if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
                NSLog(@"User cancelled login");
                
                // Handle session closures that happen outside of the app
            } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession){
                alertTitle = @"Session Error";
                alertText = @"Your current session is no longer valid. Please log in again.";
                [SFFunctions alertView:alertTitle withMessage:alertText];
                
                // Here we will handle all other errors with a generic error message.
                // We recommend you check our Handling Errors guide for more information
                // https://developers.facebook.com/docs/ios/errors/
            } else {
                //Get more error information from the error
                NSDictionary *errorInformation = [[[error.userInfo objectForKey:@"com.facebook.sdk:ParsedJSONResponseKey"] objectForKey:@"body"] objectForKey:@"error"];
                
                // Show the user an error message
                alertTitle = @"Something went wrong";
                alertText = [NSString stringWithFormat:@"Please retry. \n\n If the problem persists contact us and mention this error code: %@", [errorInformation objectForKey:@"message"]];
                [SFFunctions alertView:alertTitle withMessage:alertText];
            }
        }
        // Clear this token
        [self.session closeAndClearTokenInformation];
        // Show the user the logged-out UI
        [self userLoggedOut];
    }
}

- (void)userLoggedIn {
    SFAppDelegate *appDelegate = (SFAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIStoryboard *storyboard = [self getStoryboard];
//    OUTMapVC *mapVC = (OUTMapVC *)[storyboard instantiateViewControllerWithIdentifier:kMapIdentifier];
//    [appDelegate.navigationController pushViewController:mapVC animated:NO];
}

- (void)userLoggedOut {
    [SFFunctions clearUserDefaults];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (UIStoryboard *)getStoryboard {
    if ([[UIDevice currentDevice].model hasPrefix:@"iPhone"]) {
        return [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    } else {
        return [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
    }
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    // Call FBAppCall's handleOpenURL:sourceApplication to handle Facebook app responses
    BOOL wasHandled = [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
    
    // You can add your app-specific url handling code here if needed
    
    return wasHandled;
}

@end
