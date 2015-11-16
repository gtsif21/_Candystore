//
//  csStats.m
//
//  Created by George Tsifrikas on 15/11/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "csStats.h"


NSString *const kcsStatsUsersCount = @"usersCount";
NSString *const kcsStatsCheckinsCount = @"checkinsCount";
NSString *const kcsStatsTipCount = @"tipCount";


@interface csStats ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation csStats

@synthesize usersCount = _usersCount;
@synthesize checkinsCount = _checkinsCount;
@synthesize tipCount = _tipCount;


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
            self.usersCount = [[self objectOrNilForKey:kcsStatsUsersCount fromDictionary:dict] doubleValue];
            self.checkinsCount = [[self objectOrNilForKey:kcsStatsCheckinsCount fromDictionary:dict] doubleValue];
            self.tipCount = [[self objectOrNilForKey:kcsStatsTipCount fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.usersCount] forKey:kcsStatsUsersCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.checkinsCount] forKey:kcsStatsCheckinsCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.tipCount] forKey:kcsStatsTipCount];

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

    self.usersCount = [aDecoder decodeDoubleForKey:kcsStatsUsersCount];
    self.checkinsCount = [aDecoder decodeDoubleForKey:kcsStatsCheckinsCount];
    self.tipCount = [aDecoder decodeDoubleForKey:kcsStatsTipCount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_usersCount forKey:kcsStatsUsersCount];
    [aCoder encodeDouble:_checkinsCount forKey:kcsStatsCheckinsCount];
    [aCoder encodeDouble:_tipCount forKey:kcsStatsTipCount];
}

- (id)copyWithZone:(NSZone *)zone
{
    csStats *copy = [[csStats alloc] init];
    
    if (copy) {

        copy.usersCount = self.usersCount;
        copy.checkinsCount = self.checkinsCount;
        copy.tipCount = self.tipCount;
    }
    
    return copy;
}


@end
