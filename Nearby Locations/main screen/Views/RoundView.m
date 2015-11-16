//
//  RoundView.m
//  Nearby Locations
//
//  Created by George Tsifrikas on 14/11/15.
//  Copyright © 2015 George Tsifrikas. All rights reserved.
//

#import "RoundView.h"

IB_DESIGNABLE
@implementation RoundView

-(void)awakeFromNib
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.frame.size.height/2;
}

@end
