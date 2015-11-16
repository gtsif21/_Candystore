//
//  NSString+Stuff.m
//  Rest
//
//  Created by George Tsifrikas on 10/12/14.
//  Copyright (c) 2014 George Tsifrikas. All rights reserved.
//

#import "NSString+Stuff.h"

@implementation NSString(Stuff)

-(NSString *)capitilizeFirstLetter
{
    return [self stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[self substringToIndex:1] uppercaseString]];
}

@end
