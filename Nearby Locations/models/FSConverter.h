//
//  FSConverter.h
//  Foursquare2-iOS
//
//  Created by Constantine Fry on 2/7/13.
//
//

#import <Foundation/Foundation.h>
#import "NSString+Stuff.h"
#import "FSVenue.h"


@interface FSConverter : NSObject
- (NSArray *)convertToObjects:(NSArray *)venues;
-(FSVenue *)conevertToVenueObject:(NSDictionary *)dict;
@end
