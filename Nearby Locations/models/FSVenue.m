//
//  VenueAnnotation.m
//  Foursquare2-iOS
//
//

#import "FSVenue.h"
#import <SDWebImage/SDWebImageManager.h>


@implementation FSLocation


@end

@implementation FSVenue
- (id)init {
    self = [super init];
    if (self) {
        self.location = [[FSLocation alloc]init];
    }
    return self;
}

- (CLLocationCoordinate2D)coordinate {
    return self.location.coordinate;
}

- (NSString *)title {
    return self.name;
}

-(NSArray *)getPhotosUrlsWithDimension:(CGFloat)dimension
{
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:[self.photos[@"count"] integerValue]];
    if ([self.photos count] && [self.photos[@"groups"] count] && [self.photos[@"groups"][0] count]){
        for (NSDictionary *photo in self.photos[@"groups"][0][@"items"]) {
            NSString *prefix = photo[@"prefix"];
            NSString *suffix = photo[@"suffix"];
            NSString *photoUrl = [NSString stringWithFormat:@"%@width%i%@", prefix, (int)dimension, suffix];
            [photos addObject:photoUrl];
        }
    }
    return [photos copy];
}

-(NSString *)getThePhotoWithWidth:(CGFloat)width completion:(void(^)(UIImage *image, NSString *error, NSString *verification))callback
{
    //let's check if a photo  exists //[@"groups"][0][@"items"][0][@"suffix"]
    if ([self.photos[@"count"] integerValue] > 0) {
        NSDictionary *photo = self.photos[@"groups"][0][@"items"][0];
        NSString *prefix = photo[@"prefix"];
        NSString *suffix = photo[@"suffix"];
        
        NSString *photoUrl = [NSString stringWithFormat:@"%@width%i%@", prefix, (int)width, suffix];
        
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        
        [manager downloadImageWithURL:[NSURL URLWithString:photoUrl] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (finished) {
                callback(image, [error localizedDescription], photoUrl);
            }
        }];
        return photoUrl;
    } else {
        callback(nil, @"Photo for this venue did not found", @"");
    }
    return nil;
}

@end
