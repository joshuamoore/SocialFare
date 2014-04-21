//
//  BYFunctions.h
//  BorderingYou
//
//  Created by JMO on 2/9/14.
//  Copyright (c) 2014 JMO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFFunctions : NSObject {}

+ (void)clearUserDefaults;

//+ (User *)retrieveUserData;
//+ (NSNumber *)userID;
//+ (NSString *)userAuthToken;
//+ (NSString *)userName;

+ (void)getFriends;
+ (NSArray *)userFriends;

+ (NSMutableDictionary *)recurseDictionaryForNull:(NSMutableDictionary *)dictionary;
+ (void)alertView:(NSString *)title withMessage:(NSString *)message;

+ (NSString *)errorCodeToAlertMessage:(NSInteger)errorCode;
+ (NSString *)parseDatetimeWithFormat:(NSString *)datetime initialFormat:(NSString *)initialFormat desiredFormat:(NSString *)desiredFormat;

+ (BOOL)isIOS7OrGreater;
+ (BOOL)isIOS6OrLess;

@end
