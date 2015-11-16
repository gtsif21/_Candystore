//
//  NetworkHelper.m
//  Nearby Locations
//
//  Created by George Tsifrikas on 15/11/15.
//  Copyright © 2015 George Tsifrikas. All rights reserved.
//

#import "NetworkHelper.h"

@implementation NetworkHelper
+(NetworkHelper *)sharedInstance
{
    static NetworkHelper *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[NetworkHelper alloc] init];
    });
    return _sharedClient;
}
@end
