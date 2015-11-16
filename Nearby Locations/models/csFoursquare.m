//
//  csFoursquare.m
//
//  Created by George Tsifrikas on 15/11/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "csFoursquare.h"
#import "csMeta.h"
#import "csNotifications.h"
#import "csResponse.h"


NSString *const kcsFoursquareMeta = @"meta";
NSString *const kcsFoursquareNotifications = @"notifications";
NSString *const kcsFoursquareResponse = @"response";


@interface csFoursquare ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation csFoursquare

@synthesize meta = _meta;
@synthesize notifications = _notifications;
@synthesize response = _response;


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
            self.meta = [csMeta modelObjectWithDictionary:[dict objectForKey:kcsFoursquareMeta]];
    NSObject *receivedcsNotifications = [dict objectForKey:kcsFoursquareNotifications];
    NSMutableArray *parsedcsNotifications = [NSMutableArray array];
    if ([receivedcsNotifications isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedcsNotifications) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedcsNotifications addObject:[csNotifications modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedcsNotifications isKindOfClass:[NSDictionary class]]) {
       [parsedcsNotifications addObject:[csNotifications modelObjectWithDictionary:(NSDictionary *)receivedcsNotifications]];
    }

    self.notifications = [NSArray arrayWithArray:parsedcsNotifications];
            self.response = [csResponse modelObjectWithDictionary:[dict objectForKey:kcsFoursquareResponse]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.meta dictionaryRepresentation] forKey:kcsFoursquareMeta];
    NSMutableArray *tempArrayForNotifications = [NSMutableArray array];
    for (NSObject *subArrayObject in self.notifications) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForNotifications addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForNotifications addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForNotifications] forKey:kcsFoursquareNotifications];
    [mutableDict setValue:[self.response dictionaryRepresentation] forKey:kcsFoursquareResponse];

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

    self.meta = [aDecoder decodeObjectForKey:kcsFoursquareMeta];
    self.notifications = [aDecoder decodeObjectForKey:kcsFoursquareNotifications];
    self.response = [aDecoder decodeObjectForKey:kcsFoursquareResponse];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_meta forKey:kcsFoursquareMeta];
    [aCoder encodeObject:_notifications forKey:kcsFoursquareNotifications];
    [aCoder encodeObject:_response forKey:kcsFoursquareResponse];
}

- (id)copyWithZone:(NSZone *)zone
{
    csFoursquare *copy = [[csFoursquare alloc] init];
    
    if (copy) {

        copy.meta = [self.meta copyWithZone:zone];
        copy.notifications = [self.notifications copyWithZone:zone];
        copy.response = [self.response copyWithZone:zone];
    }
    
    return copy;
}


@end
