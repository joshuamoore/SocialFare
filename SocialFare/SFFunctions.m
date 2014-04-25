//
//  OUTFunctions.h
//  BorderingYou
//
//  Created OUT JMO on 2/9/14.
//  Copyright (c) 2014 JMO. All rights reserved.
//

#import "SFFunctions.h"
#import "SFLandingVC.h"
#import "SFAppDelegate.h"
#import "SFCoreDataFunctions.h"

@implementation SFFunctions

+ (void)clearUserDefaults {
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    SFAppDelegate *appDelegate = (SFAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.session closeAndClearTokenInformation];
}

+ (User *)retrieveUserData {
    User *user = [User MR_findFirstByAttribute:@"facebook_id"
                                     withValue:[self userFacebookID]];
    
    return user;
}

+ (NSString *)userFacebookID {
    return [[NSUserDefaults standardUserDefaults] secretStringForKey:kUserFacebookID];
}

//+ (NSString *)userAuthToken {
//    return [[NSUserDefaults standardUserDefaults] secretObjectForKey:kAuthToken];
//}
//
//+ (NSString *)userName {
//    User *user = [self retrieveUserData];
//    
//    return [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
//}
//
//+ (void)setupNavBar:(UIViewController *)controller {
//    [self setNavMenuImage:controller];
//    
//    if (![controller isKindOfClass:[OUTLandingVC class]] && ![controller isKindOfClass:[OUTSignUpVC class]]) {
//        UIButton *menuButton =  [UIButton buttonWithType:UIButtonTypeCustom];
//        [menuButton setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
//        [menuButton addTarget:[[UIApplication sharedApplication] delegate]
//                       action:@selector(showMenu)
//             forControlEvents:UIControlEventTouchUpInside];
//        [menuButton setFrame:CGRectMake(0, 0, 20, 20)];
//        controller.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
//    }
//}

+ (void)getFriends {
    [[FBRequest requestForGraphPath:@"/me/friends?fields=name,first_name,last_name,picture,id,address,birthday&limit=100&format=json"] startWithCompletionHandler:
     ^(FBRequestConnection *connection,
       NSDictionary<FBGraphObject> *friends,
       NSError *error) {
         if (!error) {
             NSArray *data = [friends objectForKey:@"data"];
             
             for (int i = 0; i < [data count]; i++) {
                 [SFCoreDataFunctions createOrUpdateFriend:data[i]];
             }
         } else {
             [SFFunctions alertView:kApplicationName
                        withMessage:error.localizedDescription];
             NSLog(@"ERROR: %@", error);
         }
     }];
}

+ (NSArray *)userFriends {
    return [[NSUserDefaults standardUserDefaults] secretObjectForKey:kFriends];
}

+ (void)getFriendCheckins {
    [[FBRequest requestForGraphPath:@"me/friends?fields=checkins.fields(coordinates,created_time,id,place,message,tags.fields(pic),from)&limit=300&format=json"] startWithCompletionHandler:
     ^(FBRequestConnection *connection,
       NSDictionary<FBGraphObject> *checkins,
       NSError *error) {
         if (!error) {
             NSArray *data = [checkins objectForKey:@"data"];
//             NSLog(@"checkin: %@", [data firstObject]);
             
             for (int i = 0; i < [data count]; i++) {
                 [SFCoreDataFunctions createOrUpdateCheckin:data[i]];
             }
         } else {
             [SFFunctions alertView:kApplicationName
                        withMessage:error.localizedDescription];
             NSLog(@"ERROR: %@", error);
         }
     }];
}

+(NSMutableDictionary *)recurseDictionaryForNull:(NSMutableDictionary *)dictionary {
    if (dictionary && [dictionary isKindOfClass:[NSMutableDictionary class]]) {
        for(NSString *k in [dictionary allKeys]) {
            id obj = [dictionary objectForKey:k];
            
            if([obj isKindOfClass:[NSDictionary class]]) {
                NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:obj];
                
                [dictionary setValue:[self recurseDictionaryForNull:mutableDictionary] forKey:k];
            } else if([obj isKindOfClass:[NSArray class]]) {
                NSMutableArray *a = [NSMutableArray arrayWithArray:obj];
                
                for(int i = 0; i < [a count]; i++) {
                    NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:a[i]];
                    if([mutableDictionary isKindOfClass:[NSMutableDictionary class]]) {
                        a[i] = [self recurseDictionaryForNull:mutableDictionary];
                    }
                }
                
                [dictionary setValue:a forKey:k];
            } else if([obj isKindOfClass:[NSString class]]) {
                obj = [obj stringByReplacingOccurrencesOfString:@"null" withString:@"\"\""];
                
                [dictionary setValue:obj forKey:k];
            } else if([obj isKindOfClass:[NSNull class]]) {
                [dictionary setValue:@"" forKey:k];
            }
        }
        
        return dictionary;
    } else {
        return [[NSMutableDictionary alloc] init];
    }
}

+ (void)alertView:(NSString *)title withMessage:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
    
    [alertView show];
}

+ (NSString *)errorCodeToAlertMessage:(NSInteger)errorCode {
    NSString *message;
    NSLog(@"errorCode: %ld", (long)errorCode);

    switch (errorCode) {
        case -1002:
            message = @"The URL that you used is unsupported. Please try again.";
            break;
            
        case -1003:
            message = @"Cannot connect to the web serivce at this time. Please check your connection and try again.";
            break;
            
        case -1004:
            message = @"Could not connect to web server. Please check your connection and try again.";
            break;
            
        case -1009:
            message = @"You currently do not have an internet connect. Please reconnect and try again.";
            break;
            
        case -1011:
            message = @"The page that you are looking for doesn't exist. (401)";
            break;
            
        default:
            message = @"There was an error processing your request. Please try again.";
            break;
    }
    
    return message;
}

+ (NSString *)parseDatetimeWithFormat:(NSString *)datetime initialFormat:(NSString *)initialFormat desiredFormat:(NSString *)desiredFormat {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:initialFormat];
    
    NSDate *date = [dateFormat dateFromString:datetime];
    [dateFormat setDateFormat:desiredFormat];
    
    return [dateFormat stringFromDate:date];
}

+ (BOOL)isIOS7OrGreater {
    return [[[UIDevice currentDevice] systemVersion] intValue] >= 7;
}

+ (BOOL)isIOS6OrLess {
    return [[[UIDevice currentDevice] systemVersion] intValue] <= 6;
}

@end
