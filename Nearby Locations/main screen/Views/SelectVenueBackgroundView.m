//
//  SelectVenueBackgroundView.m
//  Nearby Locations
//
//  Created by George Tsifrikas on 14/11/15.
//  Copyright © 2015 George Tsifrikas. All rights reserved.
//

#import "SelectVenueBackgroundView.h"

@implementation SelectVenueBackgroundView

-(void)awakeFromNib
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 10;
}

@end
