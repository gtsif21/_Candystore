//
//  csGroups.m
//
//  Created by George Tsifrikas on 15/11/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "csGroups.h"


NSString *const kcsGroupsCount = @"count";
NSString *const kcsGroupsType = @"type";
NSString *const kcsGroupsName = @"name";
NSString *const kcsGroupsItems = @"items";


@interface csGroups ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation csGroups

@synthesize count = _count;
@synthesize type = _type;
@synthesize name = _name;
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
            self.count = [[self objectOrNilForKey:kcsGroupsCount fromDictionary:dict] doubleValue];
            self.type = [self objectOrNilForKey:kcsGroupsType fromDictionary:dict];
            self.name = [self objectOrNilForKey:kcsGroupsName fromDictionary:dict];
            self.items = [self objectOrNilForKey:kcsGroupsItems fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.count] forKey:kcsGroupsCount];
    [mutableDict setValue:self.type forKey:kcsGroupsType];
    [mutableDict setValue:self.name forKey:kcsGroupsName];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForItems] forKey:kcsGroupsItems];

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

    self.count = [aDecoder decodeDoubleForKey:kcsGroupsCount];
    self.type = [aDecoder decodeObjectForKey:kcsGroupsType];
    self.name = [aDecoder decodeObjectForKey:kcsGroupsName];
    self.items = [aDecoder decodeObjectForKey:kcsGroupsItems];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_count forKey:kcsGroupsCount];
    [aCoder encodeObject:_type forKey:kcsGroupsType];
    [aCoder encodeObject:_name forKey:kcsGroupsName];
    [aCoder encodeObject:_items forKey:kcsGroupsItems];
}

- (id)copyWithZone:(NSZone *)zone
{
    csGroups *copy = [[csGroups alloc] init];
    
    if (copy) {

        copy.count = self.count;
        copy.type = [self.type copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.items = [self.items copyWithZone:zone];
    }
    
    return copy;
}


@end
