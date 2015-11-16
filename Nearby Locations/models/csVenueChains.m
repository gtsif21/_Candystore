//
//  csVenueChains.m
//
//  Created by George Tsifrikas on 15/11/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "csVenueChains.h"


NSString *const kcsVenueChainsId = @"id";


@interface csVenueChains ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation csVenueChains

@synthesize venueChainsIdentifier = _venueChainsIdentifier;


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
            self.venueChainsIdentifier = [self objectOrNilForKey:kcsVenueChainsId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.venueChainsIdentifier forKey:kcsVenueChainsId];

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

    self.venueChainsIdentifier = [aDecoder decodeObjectForKey:kcsVenueChainsId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_venueChainsIdentifier forKey:kcsVenueChainsId];
}

- (id)copyWithZone:(NSZone *)zone
{
    csVenueChains *copy = [[csVenueChains alloc] init];
    
    if (copy) {

        copy.venueChainsIdentifier = [self.venueChainsIdentifier copyWithZone:zone];
    }
    
    return copy;
}


@end
