//
//  csNotifications.m
//
//  Created by George Tsifrikas on 15/11/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "csNotifications.h"
#import "csItem.h"


NSString *const kcsNotificationsType = @"type";
NSString *const kcsNotificationsItem = @"item";


@interface csNotifications ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation csNotifications

@synthesize type = _type;
@synthesize item = _item;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.type = [self objectOrNilForKey:kcsNotificationsType fromDictionary:dict];
            self.item = [csItem modelObjectWithDictionary:[dict objectForKey:kcsNotificationsItem]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.type forKey:kcsNotificationsType];
    [mutableDict setValue:[self.item dictionaryRepresentation] forKey:kcsNotificationsItem];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.type = [aDecoder decodeObjectForKey:kcsNotificationsType];
    self.item = [aDecoder decodeObjectForKey:kcsNotificationsItem];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_type forKey:kcsNotificationsType];
    [aCoder encodeObject:_item forKey:kcsNotificationsItem];
}

- (id)copyWithZone:(NSZone *)zone
{
    csNotifications *copy = [[csNotifications alloc] init];
    
    if (copy) {

        copy.type = [self.type copyWithZone:zone];
        copy.item = [self.item copyWithZone:zone];
    }
    
    return copy;
}


@end
