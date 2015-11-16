//
//  csMeta.m
//
//  Created by George Tsifrikas on 15/11/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "csMeta.h"


NSString *const kcsMetaRequestId = @"requestId";
NSString *const kcsMetaCode = @"code";


@interface csMeta ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation csMeta

@synthesize requestId = _requestId;
@synthesize code = _code;


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
            self.requestId = [self objectOrNilForKey:kcsMetaRequestId fromDictionary:dict];
            self.code = [[self objectOrNilForKey:kcsMetaCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.requestId forKey:kcsMetaRequestId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kcsMetaCode];

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

    self.requestId = [aDecoder decodeObjectForKey:kcsMetaRequestId];
    self.code = [aDecoder decodeDoubleForKey:kcsMetaCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_requestId forKey:kcsMetaRequestId];
    [aCoder encodeDouble:_code forKey:kcsMetaCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    csMeta *copy = [[csMeta alloc] init];
    
    if (copy) {

        copy.requestId = [self.requestId copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
