//
//  SFCoreDataFunctions.m
//  SocialFare
//
//  Created by Josh Moore on 4/23/14.
//  Copyright (c) 2014 SocialFare. All rights reserved.
//

#import "SFCoreDataFunctions.h"

@implementation SFCoreDataFunctions

+ (Friend *)createOrUpdateFriend:(NSDictionary *)friendInput {
    Friend *friend = [Friend MR_findFirstByAttribute:@"facebook_id" withValue:friendInput[kFriendFacebookID]];
    
    if (!friend) {
        friend = [Friend MR_createEntity];
    }
    
    NSManagedObjectContext *context = friend.managedObjectContext;
    
    User *user = [SFFunctions retrieveUserData];
    if (user) {
        friend.user_id = [NSNumber numberWithInt:[user.facebook_id intValue]];
        friend.user = user;
    }
    
    friend.first_name = friendInput[kFriendFirstName];
    friend.facebook_id = friendInput[kFriendFacebookID];
    friend.last_name = friendInput[kFriendLastName];
    friend.name = friendInput[kFriendName];
    friend.picture = friendInput[@"picture"][@"data"][@"url"];
    
    [context MR_saveToPersistentStoreAndWait];
    
    return friend;
}

+ (void)createOrUpdateCheckin:(NSDictionary *)checkinsForFriend {
    NSArray *checkinsData = checkinsForFriend[kCheckins][@"data"];
    
    for (int i = 0; i < [checkinsData count]; i++) {
        NSDictionary *checkinInput = checkinsData[i];
        
        Checkin *checkin = [Checkin MR_findFirstByAttribute:@"facebook_id" withValue:checkinInput[kCheckinID]];
        
        if (!checkin) {
            checkin = [Checkin MR_createEntity];
        }
        
        NSManagedObjectContext *context = checkin.managedObjectContext;
        
        User *user = [SFFunctions retrieveUserData];
        if (user) {
            checkin.user_id = [NSNumber numberWithInt:[user.facebook_id intValue]];
            checkin.user = user;
        }
        
        NSPredicate *friendFilter = [NSPredicate predicateWithFormat:@"user_id = %@", [SFFunctions userFacebookID]];
        Friend *friend = [Friend MR_findFirstWithPredicate:friendFilter];
        if (friend) {
            checkin.friend = friend;
            checkin.facebook_friend_id = checkinInput[@"from"][@"id"];
        }
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:kServerDateTimeFormat];

        checkin.created_time = [dateFormatter dateFromString:checkinInput[kCheckinCreatedTime]];
        
        checkin.city = checkinInput[@"place"][@"location"][kCheckinCity];
        checkin.country = checkinInput[@"place"][@"location"][kCheckinCountry];
        checkin.facebook_id = checkinInput[kCheckinID];
        checkin.latitude = [NSString stringWithFormat:@"%@", checkinInput[kCheckinCoordinates][kCheckinLatitude]];
        checkin.longitude = [NSString stringWithFormat:@"%@", checkinInput[kCheckinCoordinates][kCheckinLongitude]];
        checkin.state = checkinInput[@"place"][@"location"][kCheckinState];
        checkin.zip = checkinInput[@"place"][@"location"][kCheckinZip];
        checkin.name = checkinInput[@"place"][@"name"];
        
        [context MR_saveToPersistentStoreAndWait];
    }
}

+ (User *)createOrUpdateUser:(NSDictionary *)userInput {
    User *user = [User MR_findFirstByAttribute:@"facebook_id" withValue:userInput[kUserFacebookID]];
    
    if (!user) {
        user = [User MR_createEntity];

        user.facebook_id = userInput[kUserFacebookID];
    }
    
    NSManagedObjectContext *context = user.managedObjectContext;
    
    user.first_name = userInput[kUserFirstName];
    user.gender = userInput[kUserGender];
    user.last_name = userInput[kUserLastName];
    user.link = userInput[kUserLink];
    user.name = userInput[kUserName];
    
    [context MR_saveToPersistentStoreAndWait];
    
    return user;
}

@end
