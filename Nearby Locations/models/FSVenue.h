//
//  VenueAnnotation.h
//  Foursquare2-iOS
//
//
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface FSLocation : NSObject {
    CLLocationCoordinate2D _coordinate;
}

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic,strong)NSNumber *distance;
@property (nonatomic,strong)NSString *address;

@end


@interface FSVenue : NSObject<MKAnnotation>

@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *venueId;
@property (nonatomic,strong)FSLocation *location;
@property (nonatomic, strong)NSDictionary *photos;

-(NSString *)getThePhotoWithWidth:(CGFloat)width completion:(void(^)(UIImage *image, NSString *error, NSString *verification))callback;
-(NSArray *)getPhotosUrlsWithDimension:(CGFloat)dimension;

@end
