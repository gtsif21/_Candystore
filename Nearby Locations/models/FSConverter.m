//
//  FSConverter.m
//  Foursquare2-iOS
//
//
//

#import "FSConverter.h"
#import "FSVenue.h"

@implementation FSConverter

- (NSArray *)convertToObjects:(NSArray *)venues {
    NSMutableArray *objects = [NSMutableArray arrayWithCapacity:venues.count];
    for (NSDictionary *v_t_t  in venues) {
        for (NSDictionary *v_t  in v_t_t[@"items"]) {
            NSDictionary *v = v_t[@"venue"];
            [objects addObject:[self conevertToVenueObject:v]];
        }
    }
    return objects;
}

-(FSVenue *)conevertToVenueObject:(NSDictionary *)dict
{
    NSDictionary *v = dict;
    FSVenue *ann = [[FSVenue alloc]init];
    ann.name = [[v valueForKey:@"name"] capitilizeFirstLetter];;
    ann.venueId = [v valueForKey:@"id"];
    
    ann.location.address = [v valueForKeyPath:@"location.address"];
    ann.location.distance = [v valueForKeyPath:@"location.distance"];
    
    [ann.location setCoordinate:CLLocationCoordinate2DMake([[v valueForKeyPath:@"location.lat"] doubleValue],
                                                           [[v valueForKeyPath:@"location.lng"] doubleValue])];
    //            NSLog(@" %@",v [@"photos"]);//[@"groups"][0][@"items"][0][@"suffix"]
    ann.photos = v[@"photos"];
    return ann;
}

@end
