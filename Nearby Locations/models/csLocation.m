//
//  csLocation.m
//
//  Created by George Tsifrikas on 15/11/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "csLocation.h"


NSString *const kcsLocationAddress = @"address";
NSString *const kcsLocationCity = @"city";
NSString *const kcsLocationCountry = @"country";
NSString *const kcsLocationPostalCode = @"postalCode";
NSString *const kcsLocationCrossStreet = @"crossStreet";
NSString *const kcsLocationFormattedAddress = @"formattedAddress";
NSString *const kcsLocationDistance = @"distance";
NSString *const kcsLocationLat = @"lat";
NSString *const kcsLocationLng = @"lng";
NSString *const kcsLocationCc = @"cc";
NSString *const kcsLocationState = @"state";


@interface csLocation ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation csLocation

@synthesize address = _address;
@synthesize city = _city;
@synthesize country = _country;
@synthesize postalCode = _postalCode;
@synthesize crossStreet = _crossStreet;
@synthesize formattedAddress = _formattedAddress;
@synthesize distance = _distance;
@synthesize lat = _lat;
@synthesize lng = _lng;
@synthesize cc = _cc;
@synthesize state = _state;


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
            self.address = [self objectOrNilForKey:kcsLocationAddress fromDictionary:dict];
            self.city = [self objectOrNilForKey:kcsLocationCity fromDictionary:dict];
            self.country = [self objectOrNilForKey:kcsLocationCountry fromDictionary:dict];
            self.postalCode = [self objectOrNilForKey:kcsLocationPostalCode fromDictionary:dict];
            self.crossStreet = [self objectOrNilForKey:kcsLocationCrossStreet fromDictionary:dict];
            self.formattedAddress = [self objectOrNilForKey:kcsLocationFormattedAddress fromDictionary:dict];
            self.distance = [[self objectOrNilForKey:kcsLocationDistance fromDictionary:dict] doubleValue];
            self.lat = [[self objectOrNilForKey:kcsLocationLat fromDictionary:dict] doubleValue];
            self.lng = [[self objectOrNilForKey:kcsLocationLng fromDictionary:dict] doubleValue];
            self.cc = [self objectOrNilForKey:kcsLocationCc fromDictionary:dict];
            self.state = [self objectOrNilForKey:kcsLocationState fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.address forKey:kcsLocationAddress];
    [mutableDict setValue:self.city forKey:kcsLocationCity];
    [mutableDict setValue:self.country forKey:kcsLocationCountry];
    [mutableDict setValue:self.postalCode forKey:kcsLocationPostalCode];
    [mutableDict setValue:self.crossStreet forKey:kcsLocationCrossStreet];
    NSMutableArray *tempArrayForFormattedAddress = [NSMutableArray array];
    for (NSObject *subArrayObject in self.formattedAddress) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForFormattedAddress addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForFormattedAddress addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForFormattedAddress] forKey:kcsLocationFormattedAddress];
    [mutableDict setValue:[NSNumber numberWithDouble:self.distance] forKey:kcsLocationDistance];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lat] forKey:kcsLocationLat];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lng] forKey:kcsLocationLng];
    [mutableDict setValue:self.cc forKey:kcsLocationCc];
    [mutableDict setValue:self.state forKey:kcsLocationState];

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

    self.address = [aDecoder decodeObjectForKey:kcsLocationAddress];
    self.city = [aDecoder decodeObjectForKey:kcsLocationCity];
    self.country = [aDecoder decodeObjectForKey:kcsLocationCountry];
    self.postalCode = [aDecoder decodeObjectForKey:kcsLocationPostalCode];
    self.crossStreet = [aDecoder decodeObjectForKey:kcsLocationCrossStreet];
    self.formattedAddress = [aDecoder decodeObjectForKey:kcsLocationFormattedAddress];
    self.distance = [aDecoder decodeDoubleForKey:kcsLocationDistance];
    self.lat = [aDecoder decodeDoubleForKey:kcsLocationLat];
    self.lng = [aDecoder decodeDoubleForKey:kcsLocationLng];
    self.cc = [aDecoder decodeObjectForKey:kcsLocationCc];
    self.state = [aDecoder decodeObjectForKey:kcsLocationState];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_address forKey:kcsLocationAddress];
    [aCoder encodeObject:_city forKey:kcsLocationCity];
    [aCoder encodeObject:_country forKey:kcsLocationCountry];
    [aCoder encodeObject:_postalCode forKey:kcsLocationPostalCode];
    [aCoder encodeObject:_crossStreet forKey:kcsLocationCrossStreet];
    [aCoder encodeObject:_formattedAddress forKey:kcsLocationFormattedAddress];
    [aCoder encodeDouble:_distance forKey:kcsLocationDistance];
    [aCoder encodeDouble:_lat forKey:kcsLocationLat];
    [aCoder encodeDouble:_lng forKey:kcsLocationLng];
    [aCoder encodeObject:_cc forKey:kcsLocationCc];
    [aCoder encodeObject:_state forKey:kcsLocationState];
}

- (id)copyWithZone:(NSZone *)zone
{
    csLocation *copy = [[csLocation alloc] init];
    
    if (copy) {

        copy.address = [self.address copyWithZone:zone];
        copy.city = [self.city copyWithZone:zone];
        copy.country = [self.country copyWithZone:zone];
        copy.postalCode = [self.postalCode copyWithZone:zone];
        copy.crossStreet = [self.crossStreet copyWithZone:zone];
        copy.formattedAddress = [self.formattedAddress copyWithZone:zone];
        copy.distance = self.distance;
        copy.lat = self.lat;
        copy.lng = self.lng;
        copy.cc = [self.cc copyWithZone:zone];
        copy.state = [self.state copyWithZone:zone];
    }
    
    return copy;
}


@end
