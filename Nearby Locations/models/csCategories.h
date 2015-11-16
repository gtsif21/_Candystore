//
//  csCategories.h
//
//  Created by George Tsifrikas on 15/11/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class csIcon;

@interface csCategories : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *categoriesIdentifier;
@property (nonatomic, strong) NSString *pluralName;
@property (nonatomic, strong) csIcon *icon;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *shortName;
@property (nonatomic, assign) BOOL primary;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
