// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Checkin.m instead.

#import "_Checkin.h"

const struct CheckinAttributes CheckinAttributes = {
	.city = @"city",
	.country = @"country",
	.created_time = @"created_time",
	.facebook_friend_id = @"facebook_friend_id",
	.facebook_id = @"facebook_id",
	.id = @"id",
	.latitude = @"latitude",
	.longitude = @"longitude",
	.name = @"name",
	.state = @"state",
	.user_id = @"user_id",
	.zip = @"zip",
};

const struct CheckinRelationships CheckinRelationships = {
	.friend = @"friend",
	.user = @"user",
};

const struct CheckinFetchedProperties CheckinFetchedProperties = {
};

@implementation CheckinID
@end

@implementation _Checkin

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Checkin" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Checkin";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Checkin" inManagedObjectContext:moc_];
}

- (CheckinID*)objectID {
	return (CheckinID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"user_idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"user_id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic city;






@dynamic country;






@dynamic created_time;






@dynamic facebook_friend_id;






@dynamic facebook_id;






@dynamic id;



- (int64_t)idValue {
	NSNumber *result = [self id];
	return [result longLongValue];
}

- (void)setIdValue:(int64_t)value_ {
	[self setId:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveIdValue {
	NSNumber *result = [self primitiveId];
	return [result longLongValue];
}

- (void)setPrimitiveIdValue:(int64_t)value_ {
	[self setPrimitiveId:[NSNumber numberWithLongLong:value_]];
}





@dynamic latitude;






@dynamic longitude;






@dynamic name;






@dynamic state;






@dynamic user_id;



- (int64_t)user_idValue {
	NSNumber *result = [self user_id];
	return [result longLongValue];
}

- (void)setUser_idValue:(int64_t)value_ {
	[self setUser_id:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveUser_idValue {
	NSNumber *result = [self primitiveUser_id];
	return [result longLongValue];
}

- (void)setPrimitiveUser_idValue:(int64_t)value_ {
	[self setPrimitiveUser_id:[NSNumber numberWithLongLong:value_]];
}





@dynamic zip;






@dynamic friend;

	

@dynamic user;

	






@end
