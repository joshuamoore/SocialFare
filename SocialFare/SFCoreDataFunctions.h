//
//  SFCoreDataFunctions.h
//  SocialFare
//
//  Created by Josh Moore on 4/23/14.
//  Copyright (c) 2014 SocialFare. All rights reserved.
//

#import "DataModel/Friend.h"
#import "DataModel/Checkin.h"
#import "DataModel/User.h"

#import <Foundation/Foundation.h>

@interface SFCoreDataFunctions : NSObject

+ (Friend *)createOrUpdateFriend:(NSDictionary *)friendInput;
+ (void)createOrUpdateCheckin:(NSDictionary *)checkinsForFriend;
+ (User *)createOrUpdateUser:(NSDictionary *)userInput;

@end
