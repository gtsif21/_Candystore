//
//  csHereNow.m
//
//  Created by George Tsifrikas on 15/11/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "csHereNow.h"
#import "csGroups.h"


NSString *const kcsHereNowCount = @"count";
NSString *const kcsHereNowSummary = @"summary";
NSString *const kcsHereNowGroups = @"groups";


@interface csHereNow ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation csHereNow

@synthesize count = _count;
@synthesize summary = _summary;
@synthesize groups = _groups;


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
            self.count = [[self objectOrNilForKey:kcsHereNowCount fromDictionary:dict] doubleValue];
            self.summary = [self objectOrNilForKey:kcsHereNowSummary fromDictionary:dict];
    NSObject *receivedcsGroups = [dict objectForKey:kcsHereNowGroups];
    NSMutableArray *parsedcsGroups = [NSMutableArray array];
    if ([receivedcsGroups isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedcsGroups) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedcsGroups addObject:[csGroups modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedcsGroups isKindOfClass:[NSDictionary class]]) {
       [parsedcsGroups addObject:[csGroups modelObjectWithDictionary:(NSDictionary *)receivedcsGroups]];
    }

    self.groups = [NSArray arrayWithArray:parsedcsGroups];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.count] forKey:kcsHereNowCount];
    [mutableDict setValue:self.summary forKey:kcsHereNowSummary];
    NSMutableArray *tempArrayForGroups = [NSMutableArray array];
    for (NSObject *subArrayObject in self.groups) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForGroups addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForGroups addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForGroups] forKey:kcsHereNowGroups];

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

    self.count = [aDecoder decodeDoubleForKey:kcsHereNowCount];
    self.summary = [aDecoder decodeObjectForKey:kcsHereNowSummary];
    self.groups = [aDecoder decodeObjectForKey:kcsHereNowGroups];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_count forKey:kcsHereNowCount];
    [aCoder encodeObject:_summary forKey:kcsHereNowSummary];
    [aCoder encodeObject:_groups forKey:kcsHereNowGroups];
}

- (id)copyWithZone:(NSZone *)zone
{
    csHereNow *copy = [[csHereNow alloc] init];
    
    if (copy) {

        copy.count = self.count;
        copy.summary = [self.summary copyWithZone:zone];
        copy.groups = [self.groups copyWithZone:zone];
    }
    
    return copy;
}


@end
