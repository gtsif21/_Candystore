//
//  csIcon.m
//
//  Created by George Tsifrikas on 15/11/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "csIcon.h"


NSString *const kcsIconPrefix = @"prefix";
NSString *const kcsIconSuffix = @"suffix";


@interface csIcon ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation csIcon

@synthesize prefix = _prefix;
@synthesize suffix = _suffix;


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
            self.prefix = [self objectOrNilForKey:kcsIconPrefix fromDictionary:dict];
            self.suffix = [self objectOrNilForKey:kcsIconSuffix fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.prefix forKey:kcsIconPrefix];
    [mutableDict setValue:self.suffix forKey:kcsIconSuffix];

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

    self.prefix = [aDecoder decodeObjectForKey:kcsIconPrefix];
    self.suffix = [aDecoder decodeObjectForKey:kcsIconSuffix];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_prefix forKey:kcsIconPrefix];
    [aCoder encodeObject:_suffix forKey:kcsIconSuffix];
}

- (id)copyWithZone:(NSZone *)zone
{
    csIcon *copy = [[csIcon alloc] init];
    
    if (copy) {

        copy.prefix = [self.prefix copyWithZone:zone];
        copy.suffix = [self.suffix copyWithZone:zone];
    }
    
    return copy;
}


@end
