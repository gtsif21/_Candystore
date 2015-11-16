//
//  csFoursquare.h
//
//  Created by George Tsifrikas on 15/11/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class csMeta, csResponse;

@interface csFoursquare : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) csMeta *meta;
@property (nonatomic, strong) NSArray *notifications;
@property (nonatomic, strong) csResponse *response;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
