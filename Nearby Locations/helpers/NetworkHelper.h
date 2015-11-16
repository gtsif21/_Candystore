//
//  NetworkHelper.h
//  Nearby Locations
//
//  Created by George Tsifrikas on 15/11/15.
//  Copyright © 2015 George Tsifrikas. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface NetworkHelper : AFHTTPRequestOperationManager
+(NetworkHelper *)sharedInstance;
@end
