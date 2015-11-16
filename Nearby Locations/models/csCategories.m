//
//  csCategories.m
//
//  Created by George Tsifrikas on 15/11/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "csCategories.h"
#import "csIcon.h"


NSString *const kcsCategoriesId = @"id";
NSString *const kcsCategoriesPluralName = @"pluralName";
NSString *const kcsCategoriesIcon = @"icon";
NSString *const kcsCategoriesName = @"name";
NSString *const kcsCategoriesShortName = @"shortName";
NSString *const kcsCategoriesPrimary = @"primary";


@interface csCategories ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation csCategories

@synthesize categoriesIdentifier = _categoriesIdentifier;
@synthesize pluralName = _pluralName;
@synthesize icon = _icon;
@synthesize name = _name;
@synthesize shortName = _shortName;
@synthesize primary = _primary;


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
            self.categoriesIdentifier = [self objectOrNilForKey:kcsCategoriesId fromDictionary:dict];
            self.pluralName = [self objectOrNilForKey:kcsCategoriesPluralName fromDictionary:dict];
            self.icon = [csIcon modelObjectWithDictionary:[dict objectForKey:kcsCategoriesIcon]];
            self.name = [self objectOrNilForKey:kcsCategoriesName fromDictionary:dict];
            self.shortName = [self objectOrNilForKey:kcsCategoriesShortName fromDictionary:dict];
            self.primary = [[self objectOrNilForKey:kcsCategoriesPrimary fromDictionary:dict] boolValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.categoriesIdentifier forKey:kcsCategoriesId];
    [mutableDict setValue:self.pluralName forKey:kcsCategoriesPluralName];
    [mutableDict setValue:[self.icon dictionaryRepresentation] forKey:kcsCategoriesIcon];
    [mutableDict setValue:self.name forKey:kcsCategoriesName];
    [mutableDict setValue:self.shortName forKey:kcsCategoriesShortName];
    [mutableDict setValue:[NSNumber numberWithBool:self.primary] forKey:kcsCategoriesPrimary];

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

    self.categoriesIdentifier = [aDecoder decodeObjectForKey:kcsCategoriesId];
    self.pluralName = [aDecoder decodeObjectForKey:kcsCategoriesPluralName];
    self.icon = [aDecoder decodeObjectForKey:kcsCategoriesIcon];
    self.name = [aDecoder decodeObjectForKey:kcsCategoriesName];
    self.shortName = [aDecoder decodeObjectForKey:kcsCategoriesShortName];
    self.primary = [aDecoder decodeBoolForKey:kcsCategoriesPrimary];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_categoriesIdentifier forKey:kcsCategoriesId];
    [aCoder encodeObject:_pluralName forKey:kcsCategoriesPluralName];
    [aCoder encodeObject:_icon forKey:kcsCategoriesIcon];
    [aCoder encodeObject:_name forKey:kcsCategoriesName];
    [aCoder encodeObject:_shortName forKey:kcsCategoriesShortName];
    [aCoder encodeBool:_primary forKey:kcsCategoriesPrimary];
}

- (id)copyWithZone:(NSZone *)zone
{
    csCategories *copy = [[csCategories alloc] init];
    
    if (copy) {

        copy.categoriesIdentifier = [self.categoriesIdentifier copyWithZone:zone];
        copy.pluralName = [self.pluralName copyWithZone:zone];
        copy.icon = [self.icon copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.shortName = [self.shortName copyWithZone:zone];
        copy.primary = self.primary;
    }
    
    return copy;
}


@end
