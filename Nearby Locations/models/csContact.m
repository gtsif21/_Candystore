//
//  csContact.m
//
//  Created by George Tsifrikas on 15/11/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "csContact.h"


NSString *const kcsContactPhone = @"phone";
NSString *const kcsContactTwitter = @"twitter";
NSString *const kcsContactFacebook = @"facebook";
NSString *const kcsContactFormattedPhone = @"formattedPhone";
NSString *const kcsContactFacebookUsername = @"facebookUsername";
NSString *const kcsContactFacebookName = @"facebookName";


@interface csContact ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation csContact

@synthesize phone = _phone;
@synthesize twitter = _twitter;
@synthesize facebook = _facebook;
@synthesize formattedPhone = _formattedPhone;
@synthesize facebookUsername = _facebookUsername;
@synthesize facebookName = _facebookName;


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
            self.phone = [self objectOrNilForKey:kcsContactPhone fromDictionary:dict];
            self.twitter = [self objectOrNilForKey:kcsContactTwitter fromDictionary:dict];
            self.facebook = [self objectOrNilForKey:kcsContactFacebook fromDictionary:dict];
            self.formattedPhone = [self objectOrNilForKey:kcsContactFormattedPhone fromDictionary:dict];
            self.facebookUsername = [self objectOrNilForKey:kcsContactFacebookUsername fromDictionary:dict];
            self.facebookName = [self objectOrNilForKey:kcsContactFacebookName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.phone forKey:kcsContactPhone];
    [mutableDict setValue:self.twitter forKey:kcsContactTwitter];
    [mutableDict setValue:self.facebook forKey:kcsContactFacebook];
    [mutableDict setValue:self.formattedPhone forKey:kcsContactFormattedPhone];
    [mutableDict setValue:self.facebookUsername forKey:kcsContactFacebookUsername];
    [mutableDict setValue:self.facebookName forKey:kcsContactFacebookName];

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

    self.phone = [aDecoder decodeObjectForKey:kcsContactPhone];
    self.twitter = [aDecoder decodeObjectForKey:kcsContactTwitter];
    self.facebook = [aDecoder decodeObjectForKey:kcsContactFacebook];
    self.formattedPhone = [aDecoder decodeObjectForKey:kcsContactFormattedPhone];
    self.facebookUsername = [aDecoder decodeObjectForKey:kcsContactFacebookUsername];
    self.facebookName = [aDecoder decodeObjectForKey:kcsContactFacebookName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_phone forKey:kcsContactPhone];
    [aCoder encodeObject:_twitter forKey:kcsContactTwitter];
    [aCoder encodeObject:_facebook forKey:kcsContactFacebook];
    [aCoder encodeObject:_formattedPhone forKey:kcsContactFormattedPhone];
    [aCoder encodeObject:_facebookUsername forKey:kcsContactFacebookUsername];
    [aCoder encodeObject:_facebookName forKey:kcsContactFacebookName];
}

- (id)copyWithZone:(NSZone *)zone
{
    csContact *copy = [[csContact alloc] init];
    
    if (copy) {

        copy.phone = [self.phone copyWithZone:zone];
        copy.twitter = [self.twitter copyWithZone:zone];
        copy.facebook = [self.facebook copyWithZone:zone];
        copy.formattedPhone = [self.formattedPhone copyWithZone:zone];
        copy.facebookUsername = [self.facebookUsername copyWithZone:zone];
        copy.facebookName = [self.facebookName copyWithZone:zone];
    }
    
    return copy;
}


@end
