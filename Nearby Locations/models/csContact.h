//
//  csContact.h
//
//  Created by George Tsifrikas on 15/11/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface csContact : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *twitter;
@property (nonatomic, strong) NSString *facebook;
@property (nonatomic, strong) NSString *formattedPhone;
@property (nonatomic, strong) NSString *facebookUsername;
@property (nonatomic, strong) NSString *facebookName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
