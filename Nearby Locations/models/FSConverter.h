//
//  FSConverter.h
//  Foursquare2-iOS
//
//
//

#import <Foundation/Foundation.h>
#import "NSString+Stuff.h"
#import "FSVenue.h"


@interface FSConverter : NSObject
- (NSArray *)convertToObjects:(NSArray *)venues;
-(FSVenue *)conevertToVenueObject:(NSDictionary *)dict;
@end
