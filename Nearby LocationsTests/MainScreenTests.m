//
//  MainScreenTests.m
//  Nearby Locations
//
//  Created by George Tsifrikas on 16/11/15.
//  Copyright © 2015 George Tsifrikas. All rights reserved.
//

#import "MainScreenTests.h"
#import "MainScreenViewController.h"

@interface MainScreenViewController(test)
-(void)loadVenuesWithLocation:(CLLocationCoordinate2D) location;
@property (nonatomic) CLLocationCoordinate2D lastFetchedLocation;
@property (nonatomic, strong)NSArray *venues;
@property (nonatomic)BOOL loadingLocation;
@property (strong, nonatomic) IBOutlet GMSMapView *mapView;
-(void)centerMapToUser;
@end


@implementation MainScreenTests

-(void)testGetVenues
{
    MainScreenViewController *vc = [[MainScreenViewController alloc] init];
    vc.loadingLocation = YES;
    vc.lastFetchedLocation = CLLocationCoordinate2DMake(51.50998000, -0.13370000);
    
    NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:20.0];
    __block BOOL responseHasArrived = NO;
    [vc centerMapToUser];//(x = 207, y = 368)
//    vc.mapView.center = CGPointMake(207, 368);
    [vc loadVenuesWithLocation:CLLocationCoordinate2DMake(51.50998000, -0.13370000)];
    
    while (responseHasArrived == NO && ([timeoutDate timeIntervalSinceNow] > 0)) {
        if ([vc.venues count] > 0) {
            responseHasArrived = YES;
        }
        CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0.01, YES);
    }
    
    if (responseHasArrived == NO) {
        XCTFail(@"Test timed out");
    }
}

@end
