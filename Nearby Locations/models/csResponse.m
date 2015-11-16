//
//  csResponse.m
//
//  Created by George Tsifrikas on 15/11/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "csResponse.h"
#import "csVenues.h"


NSString *const kcsResponseConfident = @"confident";
NSString *const kcsResponseVenues = @"venues";


@interface csResponse ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation csResponse

@synthesize confident = _confident;
@synthesize venues = _venues;


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
            self.confident = [[self objectOrNilForKey:kcsResponseConfident fromDictionary:dict] boolValue];
    NSObject *receivedcsVenues = [dict objectForKey:kcsResponseVenues];
    NSMutableArray *parsedcsVenues = [NSMutableArray array];
    if ([receivedcsVenues isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedcsVenues) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedcsVenues addObject:[csVenues modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedcsVenues isKindOfClass:[NSDictionary class]]) {
       [parsedcsVenues addObject:[csVenues modelObjectWithDictionary:(NSDictionary *)receivedcsVenues]];
    }

    self.venues = [NSArray arrayWithArray:parsedcsVenues];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithBool:self.confident] forKey:kcsResponseConfident];
    NSMutableArray *tempArrayForVenues = [NSMutableArray array];
    for (NSObject *subArrayObject in self.venues) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForVenues addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForVenues addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForVenues] forKey:kcsResponseVenues];

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

    self.confident = [aDecoder decodeBoolForKey:kcsResponseConfident];
    self.venues = [aDecoder decodeObjectForKey:kcsResponseVenues];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeBool:_confident forKey:kcsResponseConfident];
    [aCoder encodeObject:_venues forKey:kcsResponseVenues];
}

- (id)copyWithZone:(NSZone *)zone
{
    csResponse *copy = [[csResponse alloc] init];
    
    if (copy) {

        copy.confident = self.confident;
        copy.venues = [self.venues copyWithZone:zone];
    }
    
    return copy;
}


@end
