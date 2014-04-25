// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Checkin.h instead.

#import <CoreData/CoreData.h>


extern const struct CheckinAttributes {
	__unsafe_unretained NSString *city;
	__unsafe_unretained NSString *country;
	__unsafe_unretained NSString *created_time;
	__unsafe_unretained NSString *facebook_friend_id;
	__unsafe_unretained NSString *facebook_id;
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *latitude;
	__unsafe_unretained NSString *longitude;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *state;
	__unsafe_unretained NSString *user_id;
	__unsafe_unretained NSString *zip;
} CheckinAttributes;

extern const struct CheckinRelationships {
	__unsafe_unretained NSString *friend;
	__unsafe_unretained NSString *user;
} CheckinRelationships;

extern const struct CheckinFetchedProperties {
} CheckinFetchedProperties;

@class Friend;
@class User;














@interface CheckinID : NSManagedObjectID {}
@end

@interface _Checkin : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (CheckinID*)objectID;





@property (nonatomic, strong) NSString* city;



//- (BOOL)validateCity:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* country;



//- (BOOL)validateCountry:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* created_time;



//- (BOOL)validateCreated_time:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* facebook_friend_id;



//- (BOOL)validateFacebook_friend_id:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* facebook_id;



//- (BOOL)validateFacebook_id:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* id;



@property int64_t idValue;
- (int64_t)idValue;
- (void)setIdValue:(int64_t)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* latitude;



//- (BOOL)validateLatitude:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* longitude;



//- (BOOL)validateLongitude:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* state;



//- (BOOL)validateState:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* user_id;



@property int64_t user_idValue;
- (int64_t)user_idValue;
- (void)setUser_idValue:(int64_t)value_;

//- (BOOL)validateUser_id:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* zip;



//- (BOOL)validateZip:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Friend *friend;

//- (BOOL)validateFriend:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) User *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;





@end

@interface _Checkin (CoreDataGeneratedAccessors)

@end

@interface _Checkin (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCity;
- (void)setPrimitiveCity:(NSString*)value;




- (NSString*)primitiveCountry;
- (void)setPrimitiveCountry:(NSString*)value;




- (NSDate*)primitiveCreated_time;
- (void)setPrimitiveCreated_time:(NSDate*)value;




- (NSString*)primitiveFacebook_friend_id;
- (void)setPrimitiveFacebook_friend_id:(NSString*)value;




- (NSString*)primitiveFacebook_id;
- (void)setPrimitiveFacebook_id:(NSString*)value;




- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (int64_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int64_t)value_;




- (NSString*)primitiveLatitude;
- (void)setPrimitiveLatitude:(NSString*)value;




- (NSString*)primitiveLongitude;
- (void)setPrimitiveLongitude:(NSString*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitiveState;
- (void)setPrimitiveState:(NSString*)value;




- (NSNumber*)primitiveUser_id;
- (void)setPrimitiveUser_id:(NSNumber*)value;

- (int64_t)primitiveUser_idValue;
- (void)setPrimitiveUser_idValue:(int64_t)value_;




- (NSString*)primitiveZip;
- (void)setPrimitiveZip:(NSString*)value;





- (Friend*)primitiveFriend;
- (void)setPrimitiveFriend:(Friend*)value;



- (User*)primitiveUser;
- (void)setPrimitiveUser:(User*)value;


@end
