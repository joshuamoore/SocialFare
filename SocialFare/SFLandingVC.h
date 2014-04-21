//
//  SFViewController.h
//  SocialFare
//
//  Created by Josh Moore on 4/20/14.
//  Copyright (c) 2014 SocialFare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFLandingVC : UIViewController <FBLoginViewDelegate>

@property (weak, nonatomic) IBOutlet FBLoginView *loginView;

@end
