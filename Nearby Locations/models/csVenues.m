//
//  csVenues.m
//
//  Created by George Tsifrikas on 15/11/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "csVenues.h"
#import "csCategories.h"
#import "csStats.h"
#import "csVenueChains.h"
#import "csHereNow.h"
#import "csContact.h"
#import "csLocation.h"
#import "csSpecials.h"


NSString *const kcsVenuesId = @"id";
NSString *const kcsVenuesCategories = @"categories";
NSString *const kcsVenuesStats = @"stats";
NSString *const kcsVenuesVenueChains = @"venueChains";
NSString *const kcsVenuesStoreId = @"storeId";
NSString *const kcsVenuesHereNow = @"hereNow";
NSString *const kcsVenuesContact = @"contact";
NSString *const kcsVenuesVerified = @"verified";
NSString *const kcsVenuesReferralId = @"referralId";
NSString *const kcsVenuesUrl = @"url";
NSString *const kcsVenuesLocation = @"location";
NSString *const kcsVenuesAllowMenuUrlEdit = @"allowMenuUrlEdit";
NSString *const kcsVenuesSpecials = @"specials";
NSString *const kcsVenuesName = @"name";


@interface csVenues ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation csVenues

@synthesize venuesIdentifier = _venuesIdentifier;
@synthesize categories = _categories;
@synthesize stats = _stats;
@synthesize venueChains = _venueChains;
@synthesize storeId = _storeId;
@synthesize hereNow = _hereNow;
@synthesize contact = _contact;
@synthesize verified = _verified;
@synthesize referralId = _referralId;
@synthesize url = _url;
@synthesize location = _location;
@synthesize allowMenuUrlEdit = _allowMenuUrlEdit;
@synthesize specials = _specials;
@synthesize name = _name;


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
            self.venuesIdentifier = [self objectOrNilForKey:kcsVenuesId fromDictionary:dict];
    NSObject *receivedcsCategories = [dict objectForKey:kcsVenuesCategories];
    NSMutableArray *parsedcsCategories = [NSMutableArray array];
    if ([receivedcsCategories isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedcsCategories) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedcsCategories addObject:[csCategories modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedcsCategories isKindOfClass:[NSDictionary class]]) {
       [parsedcsCategories addObject:[csCategories modelObjectWithDictionary:(NSDictionary *)receivedcsCategories]];
    }

    self.categories = [NSArray arrayWithArray:parsedcsCategories];
            self.stats = [csStats modelObjectWithDictionary:[dict objectForKey:kcsVenuesStats]];
    NSObject *receivedcsVenueChains = [dict objectForKey:kcsVenuesVenueChains];
    NSMutableArray *parsedcsVenueChains = [NSMutableArray array];
    if ([receivedcsVenueChains isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedcsVenueChains) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedcsVenueChains addObject:[csVenueChains modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedcsVenueChains isKindOfClass:[NSDictionary class]]) {
       [parsedcsVenueChains addObject:[csVenueChains modelObjectWithDictionary:(NSDictionary *)receivedcsVenueChains]];
    }

    self.venueChains = [NSArray arrayWithArray:parsedcsVenueChains];
            self.storeId = [self objectOrNilForKey:kcsVenuesStoreId fromDictionary:dict];
            self.hereNow = [csHereNow modelObjectWithDictionary:[dict objectForKey:kcsVenuesHereNow]];
            self.contact = [csContact modelObjectWithDictionary:[dict objectForKey:kcsVenuesContact]];
            self.verified = [[self objectOrNilForKey:kcsVenuesVerified fromDictionary:dict] boolValue];
            self.referralId = [self objectOrNilForKey:kcsVenuesReferralId fromDictionary:dict];
            self.url = [self objectOrNilForKey:kcsVenuesUrl fromDictionary:dict];
            self.location = [csLocation modelObjectWithDictionary:[dict objectForKey:kcsVenuesLocation]];
            self.allowMenuUrlEdit = [[self objectOrNilForKey:kcsVenuesAllowMenuUrlEdit fromDictionary:dict] boolValue];
            self.specials = [csSpecials modelObjectWithDictionary:[dict objectForKey:kcsVenuesSpecials]];
            self.name = [self objectOrNilForKey:kcsVenuesName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.venuesIdentifier forKey:kcsVenuesId];
    NSMutableArray *tempArrayForCategories = [NSMutableArray array];
    for (NSObject *subArrayObject in self.categories) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCategories addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCategories addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCategories] forKey:kcsVenuesCategories];
    [mutableDict setValue:[self.stats dictionaryRepresentation] forKey:kcsVenuesStats];
    NSMutableArray *tempArrayForVenueChains = [NSMutableArray array];
    for (NSObject *subArrayObject in self.venueChains) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForVenueChains addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForVenueChains addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForVenueChains] forKey:kcsVenuesVenueChains];
    [mutableDict setValue:self.storeId forKey:kcsVenuesStoreId];
    [mutableDict setValue:[self.hereNow dictionaryRepresentation] forKey:kcsVenuesHereNow];
    [mutableDict setValue:[self.contact dictionaryRepresentation] forKey:kcsVenuesContact];
    [mutableDict setValue:[NSNumber numberWithBool:self.verified] forKey:kcsVenuesVerified];
    [mutableDict setValue:self.referralId forKey:kcsVenuesReferralId];
    [mutableDict setValue:self.url forKey:kcsVenuesUrl];
    [mutableDict setValue:[self.location dictionaryRepresentation] forKey:kcsVenuesLocation];
    [mutableDict setValue:[NSNumber numberWithBool:self.allowMenuUrlEdit] forKey:kcsVenuesAllowMenuUrlEdit];
    [mutableDict setValue:[self.specials dictionaryRepresentation] forKey:kcsVenuesSpecials];
    [mutableDict setValue:self.name forKey:kcsVenuesName];

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

    self.venuesIdentifier = [aDecoder decodeObjectForKey:kcsVenuesId];
    self.categories = [aDecoder decodeObjectForKey:kcsVenuesCategories];
    self.stats = [aDecoder decodeObjectForKey:kcsVenuesStats];
    self.venueChains = [aDecoder decodeObjectForKey:kcsVenuesVenueChains];
    self.storeId = [aDecoder decodeObjectForKey:kcsVenuesStoreId];
    self.hereNow = [aDecoder decodeObjectForKey:kcsVenuesHereNow];
    self.contact = [aDecoder decodeObjectForKey:kcsVenuesContact];
    self.verified = [aDecoder decodeBoolForKey:kcsVenuesVerified];
    self.referralId = [aDecoder decodeObjectForKey:kcsVenuesReferralId];
    self.url = [aDecoder decodeObjectForKey:kcsVenuesUrl];
    self.location = [aDecoder decodeObjectForKey:kcsVenuesLocation];
    self.allowMenuUrlEdit = [aDecoder decodeBoolForKey:kcsVenuesAllowMenuUrlEdit];
    self.specials = [aDecoder decodeObjectForKey:kcsVenuesSpecials];
    self.name = [aDecoder decodeObjectForKey:kcsVenuesName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_venuesIdentifier forKey:kcsVenuesId];
    [aCoder encodeObject:_categories forKey:kcsVenuesCategories];
    [aCoder encodeObject:_stats forKey:kcsVenuesStats];
    [aCoder encodeObject:_venueChains forKey:kcsVenuesVenueChains];
    [aCoder encodeObject:_storeId forKey:kcsVenuesStoreId];
    [aCoder encodeObject:_hereNow forKey:kcsVenuesHereNow];
    [aCoder encodeObject:_contact forKey:kcsVenuesContact];
    [aCoder encodeBool:_verified forKey:kcsVenuesVerified];
    [aCoder encodeObject:_referralId forKey:kcsVenuesReferralId];
    [aCoder encodeObject:_url forKey:kcsVenuesUrl];
    [aCoder encodeObject:_location forKey:kcsVenuesLocation];
    [aCoder encodeBool:_allowMenuUrlEdit forKey:kcsVenuesAllowMenuUrlEdit];
    [aCoder encodeObject:_specials forKey:kcsVenuesSpecials];
    [aCoder encodeObject:_name forKey:kcsVenuesName];
}

- (id)copyWithZone:(NSZone *)zone
{
    csVenues *copy = [[csVenues alloc] init];
    
    if (copy) {

        copy.venuesIdentifier = [self.venuesIdentifier copyWithZone:zone];
        copy.categories = [self.categories copyWithZone:zone];
        copy.stats = [self.stats copyWithZone:zone];
        copy.venueChains = [self.venueChains copyWithZone:zone];
        copy.storeId = [self.storeId copyWithZone:zone];
        copy.hereNow = [self.hereNow copyWithZone:zone];
        copy.contact = [self.contact copyWithZone:zone];
        copy.verified = self.verified;
        copy.referralId = [self.referralId copyWithZone:zone];
        copy.url = [self.url copyWithZone:zone];
        copy.location = [self.location copyWithZone:zone];
        copy.allowMenuUrlEdit = self.allowMenuUrlEdit;
        copy.specials = [self.specials copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
