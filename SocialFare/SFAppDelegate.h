//
//  SFAppDelegate.h
//  SocialFare
//
//  Created by Josh Moore on 4/20/14.
//  Copyright (c) 2014 SocialFare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) FBSession *session;

@end
