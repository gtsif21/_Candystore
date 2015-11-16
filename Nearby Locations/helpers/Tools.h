//
//  Tools.h
//  Nearby Locations
//
//  Created by George Tsifrikas on 15/11/15.
//  Copyright © 2015 George Tsifrikas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NetworkHelper.h"
#import "DataModels.h"
@import SDWebImage;

@interface Tools : NSObject
+ (void)getImageForVenue:(csVenues *)venue andImageNamed:(NSString *)imageName imageReady:(void (^)(UIImage *image))completion;
+ (void)cacheAllCategoriesIcons;
+(NSString *)getCategoryIconPath:(NSDictionary *)categoryInfo;
+ (UIImage*)imageByCombiningImage:(UIImage*)firstImage withImage:(UIImage*)secondImage withSize:(CGSize)ISize andSecondImageScale:(CGFloat)scale; 
@end
