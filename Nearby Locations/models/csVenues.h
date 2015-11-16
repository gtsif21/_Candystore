//
//  csVenues.h
//
//  Created by George Tsifrikas on 15/11/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class csStats, csHereNow, csContact, csLocation, csSpecials;

@interface csVenues : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *venuesIdentifier;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) csStats *stats;
@property (nonatomic, strong) NSArray *venueChains;
@property (nonatomic, strong) NSString *storeId;
@property (nonatomic, strong) csHereNow *hereNow;
@property (nonatomic, strong) csContact *contact;
@property (nonatomic, assign) BOOL verified;
@property (nonatomic, strong) NSString *referralId;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) csLocation *location;
@property (nonatomic, assign) BOOL allowMenuUrlEdit;
@property (nonatomic, strong) csSpecials *specials;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
