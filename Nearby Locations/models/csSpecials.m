//
//  csSpecials.m
//
//  Created by George Tsifrikas on 15/11/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "csSpecials.h"


NSString *const kcsSpecialsCount = @"count";
NSString *const kcsSpecialsItems = @"items";


@interface csSpecials ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation csSpecials

@synthesize count = _count;
@synthesize items = _items;


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
            self.count = [[self objectOrNilForKey:kcsSpecialsCount fromDictionary:dict] doubleValue];
            self.items = [self objectOrNilForKey:kcsSpecialsItems fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.count] forKey:kcsSpecialsCount];
    NSMutableArray *tempArrayForItems = [NSMutableArray array];
    for (NSObject *subArrayObject in self.items) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForItems addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForItems addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForItems] forKey:kcsSpecialsItems];

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

    self.count = [aDecoder decodeDoubleForKey:kcsSpecialsCount];
    self.items = [aDecoder decodeObjectForKey:kcsSpecialsItems];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_count forKey:kcsSpecialsCount];
    [aCoder encodeObject:_items forKey:kcsSpecialsItems];
}

- (id)copyWithZone:(NSZone *)zone
{
    csSpecials *copy = [[csSpecials alloc] init];
    
    if (copy) {

        copy.count = self.count;
        copy.items = [self.items copyWithZone:zone];
    }
    
    return copy;
}


@end
