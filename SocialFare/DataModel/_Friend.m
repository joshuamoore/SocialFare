// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Friend.m instead.

#import "_Friend.h"

const struct FriendAttributes FriendAttributes = {
	.address = @"address",
	.birthday = @"birthday",
	.facebook_id = @"facebook_id",
	.first_name = @"first_name",
	.id = @"id",
	.last_name = @"last_name",
	.name = @"name",
	.picture = @"picture",
	.user_id = @"user_id",
};

const struct FriendRelationships FriendRelationships = {
	.user = @"user",
};

const struct FriendFetchedProperties FriendFetchedProperties = {
};

@implementation FriendID
@end

@implementation _Friend

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Friend" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Friend";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Friend" inManagedObjectContext:moc_];
}

- (FriendID*)objectID {
	return (FriendID*)[super objectID];
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




@dynamic address;






@dynamic birthday;






@dynamic facebook_id;






@dynamic first_name;






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





@dynamic last_name;






@dynamic name;






@dynamic picture;






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





@dynamic user;

	






@end
