//
//  Tools.m
//  Nearby Locations
//
//  Created by George Tsifrikas on 15/11/15.
//  Copyright © 2015 George Tsifrikas. All rights reserved.
//

#import "Tools.h"

@implementation Tools

+ (void)getImageForVenue:(csVenues *)venue andImageNamed:(NSString *)imageName imageReady:(void (^)(UIImage *image))completion;
{
    __block UIImage* imageToReturn = nil;
    __block NSString *key = [((csCategories *)venue.categories[0]).categoriesIdentifier stringByAppendingString:imageName];
    __block SDImageCache *ic = [SDImageCache sharedImageCache];
    imageToReturn = [ic imageFromDiskCacheForKey:key];
    if(imageToReturn == nil) {
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:[Tools getCategoryIconPath:[((csCategories *)venue.categories[0]) dictionaryRepresentation]]] options:SDWebImageHighPriority progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            imageToReturn = [Tools imageByCombiningImage:[UIImage imageNamed:imageName] withImage:image withSize:CGSizeMake(30, 37) andSecondImageScale:1];
            dispatch_queue_t qb = dispatch_queue_create("com.gtsifrikas.saving.icon", NULL);
            dispatch_async(qb, ^{
                [ic storeImage:imageToReturn forKey:key];
            });
            completion(imageToReturn);
        }];
    } else {
        imageToReturn = [UIImage imageWithCGImage:imageToReturn.CGImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationDown];
        completion(imageToReturn);
    }
}

+ (UIImage*)imageByCombiningImage:(UIImage*)firstImage withImage:(UIImage*)secondImage withSize:(CGSize)ISize andSecondImageScale:(CGFloat)scale {
    UIImage *image = nil;

    UIGraphicsBeginImageContextWithOptions(ISize, NO, 0.0);
    
    [firstImage drawAtPoint:CGPointMake(roundf((ISize.width-firstImage.size.width)/2),
                                        roundf((ISize.height-firstImage.size.height)/2))];
    
    CGSize secondImageSize = CGSizeMake(ISize.width * scale, ISize.width*scale);
    [secondImage drawInRect:CGRectMake(roundf((ISize.width-secondImageSize.width)/2),
                                       roundf((ISize.height-secondImageSize.height)/2-4), secondImageSize.width, secondImageSize.height)];
    
   
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//+ (UIImage*)mergeImage:(UIImage*)first withImage:(UIImage*)second atSize:(CGSize)size
//{
//    // get size of the first image
//    CGImageRef firstImageRef = first.CGImage;
//    CGFloat firstWidth = CGImageGetWidth(firstImageRef);
//    CGFloat firstHeight = CGImageGetHeight(firstImageRef);
//
//    // get size of the second image
//    CGImageRef secondImageRef = second.CGImage;
//    CGFloat secondWidth = CGImageGetWidth(secondImageRef);
//    CGFloat secondHeight = CGImageGetHeight(secondImageRef);
//
//    // build merged size
////    CGSize mergedSize = CGSizeMake(MAX(firstWidth, secondWidth), MAX(firstHeight, secondHeight));
//    CGSize mergedSize = size;
//    // capture image context ref
//   UIGraphicsBeginImageContextWithOptions(mergedSize, NO, [[UIScreen mainScreen] scale]);
//
//    //Draw images onto the context
//    [firstImage drawAtPoint:CGPointMake(roundf((newImageSize.width-firstImage.size.width)/2),
//                                        roundf((newImageSize.height-firstImage.size.height)/2))];
//    [secondImage drawAtPoint:CGPointMake(roundf((newImageSize.width-secondImage.size.width)/2),
//                                         roundf((newImageSize.height-secondImage.size.height)/2))];
//
//
//    // assign context to new UIImage
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//
//    // end context
//    UIGraphicsEndImageContext();
//
//    return newImage;
//}

+(NSString *)getCategoryIconPath:(NSDictionary *)categoryInfo
{
    return [NSString stringWithFormat:@"%@64%@", categoryInfo[@"icon"][@"prefix"],categoryInfo[@"icon"][@"suffix"]];
}

+ (void)cacheAllCategoriesIcons
{
    //    __weak typeof(self) weakSelf = self;
    
    [[NetworkHelper sharedInstance] GET:@"https://api.foursquare.com/v2/venues/categories?oauth_token=4NPLHLFHN4XMEZVXSTEUCCHWUNDB51T0UASR01QKQMLSJFTM&v=20151115" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        for (NSDictionary *category in ((NSDictionary *)responseObject)[@"response"][@"categories"]) {
            NSString *imagePath = [Tools getCategoryIconPath:category];
            [manager downloadImageWithURL:[NSURL URLWithString:imagePath] options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                
            }];
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}
@end
