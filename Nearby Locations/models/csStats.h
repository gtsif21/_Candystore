//
//  csStats.h
//
//  Created by George Tsifrikas on 15/11/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface csStats : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double usersCount;
@property (nonatomic, assign) double checkinsCount;
@property (nonatomic, assign) double tipCount;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
