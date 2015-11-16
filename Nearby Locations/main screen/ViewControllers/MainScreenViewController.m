//
//  MainScreenViewController.m
//  Nearby Locations
//
//  Created by George Tsifrikas on 14/11/15.
//  Copyright © 2015 George Tsifrikas. All rights reserved.
//

#import "MainScreenViewController.h"

@interface MainScreenViewController () <GMSMapViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *addressContentView;
@property (strong, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userLocationIcon;
@property (weak, nonatomic) IBOutlet UILabel *currentUserAddressLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *usersAddressBottomConstraint;
@property (weak, nonatomic) IBOutlet UIView *venueHolderView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIImageView *venueImage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *imageActivityIndicator;
@property (weak, nonatomic) IBOutlet UIView *ratingView;

@property (weak, nonatomic) IBOutlet UILabel *venueTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *venueAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *venueTypeLabel;

@property (nonatomic)BOOL loadingLocation;

@property (nonatomic) CLLocationCoordinate2D lastFetchedLocation;
@property (nonatomic, strong)NSArray *venues;

@property (nonatomic, strong)NSArray *markers;
@end

@implementation MainScreenViewController {
    
    BOOL _doNotUpdateMap;
    CGFloat _movedMapToShowVenue;
}

-(void)setVenues:(NSArray *)venues
{
    if (_venues != venues) {
        _venues = venues;
        [self putVenusOnMap];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _loadingLocation = NO;
    _doNotUpdateMap = NO;
    self.userLocationIcon.hidden = YES;
    self.mapView.delegate = self;
    self.venueHolderView.hidden = YES;
    [self determineUsersLocation];
    [Tools cacheAllCategoriesIcons];
    
    //let's hide user's address
    self.usersAddressBottomConstraint.constant = -102;
    [self.contentView layoutIfNeeded];
    //    [self.contentView updateConstraintsIfNeeded];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (![self fetchedLocation]) {
        [SwiftSpinner show:@"Determining your location" animated:YES];
    }
}

- (void)determineUsersLocation
{
    if (!_loadingLocation) {
        _loadingLocation = YES;
        __weak typeof(self) weakSelf = self;
        [[INTULocationManager sharedInstance] requestLocationWithDesiredAccuracy:INTULocationAccuracyHouse timeout:10 delayUntilAuthorized:YES block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
            weakSelf.lastFetchedLocation = currentLocation.coordinate;
            
            [weakSelf centerMapToUser];
            weakSelf.userLocationIcon.hidden = NO;
            _loadingLocation = NO;
            [SwiftSpinner hide:nil];
        }];
    }
}

- (BOOL)fetchedLocation
{
    return !(self.lastFetchedLocation.latitude == 0 && self.lastFetchedLocation.longitude == 0);
}

-(void)getUsersAddress
{
    __weak typeof(self) weakSelf = self;
    self.currentUserAddressLabel.text = @"Loading..";
    GMSGeocoder *geocoder = [GMSGeocoder geocoder];
    
    [geocoder reverseGeocodeCoordinate:[self getUsersPinLocation] completionHandler:^(GMSReverseGeocodeResponse *response, NSError *error) {
        weakSelf.currentUserAddressLabel.text = response.firstResult.thoroughfare;
    }];
}

-(CLLocationCoordinate2D)getUsersPinLocation
{
    CGPoint centerPoint = self.mapView.center;
    return [self.mapView.projection coordinateForPoint:centerPoint];
}

-(void)loadVenuesWithLocation:(CLLocationCoordinate2D) location
{
    __weak typeof(self) weakSelf = self;
    if([self fetchedLocation]) {
        NSString *path = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?ll=%f,%f&oauth_token=4NPLHLFHN4XMEZVXSTEUCCHWUNDB51T0UASR01QKQMLSJFTM&v=20151115&limit=10", location.latitude, location.longitude];//&categoryId=4bf58dd8d48988d1d0941735,4bf58dd8d48988d117951735,52f2ab2ebcbc57f1066b8b31
        [[NetworkHelper sharedInstance] GET:path parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                csFoursquare *foursquareResponse = [csFoursquare modelObjectWithDictionary:(NSDictionary *)responseObject];
                weakSelf.venues = foursquareResponse.response.venues;
            }
            
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            
        }];
        
    }
}

-(void)putVenusOnMap
{
    [self.mapView clear];
    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:[self.venues count]];
    for (csVenues *venue in self.venues) {
        CLLocationCoordinate2D position = CLLocationCoordinate2DMake(venue.location.lat, venue.location.lng);
        __block GMSMarker *marker = [GMSMarker markerWithPosition:position];
        if ([venue.categories count]>0) {
            
            [Tools getImageForVenue:venue andImageNamed:@"icon-venue-dark" imageReady:^(UIImage *image) {
                marker.icon = image;
            }];
            
            marker.appearAnimation = kGMSMarkerAnimationPop;
            marker.map = self.mapView;
            [temp addObject:marker];
        }
    }
    self.markers = [temp copy];
}

- (void)mapView:(GMSMapView *)mapView
idleAtCameraPosition:(GMSCameraPosition *)position {
    if ([self fetchedLocation] && !_doNotUpdateMap) {
        [self showAddressView];
        [self loadVenuesWithLocation:[self getUsersPinLocation]];
    } else {
        _doNotUpdateMap = NO;
    }
}


- (void)mapView:(GMSMapView *)mapView willMove:(BOOL)gesture
{
    if (!self.venueHolderView.hidden) {
        [self hideVenueView];
    }
    [self hideAddressView];
}

-(void)showAddressView
{
    __weak typeof(self) weakSelf = self;
    //stupid google map fire delegate methods in different thread than main
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.addressContentView layoutIfNeeded];
        self.usersAddressBottomConstraint.constant = 0;
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [weakSelf.contentView layoutIfNeeded];
        } completion:nil];
    });
    [self getUsersAddress];
}

-(void)hideAddressView
{
    __weak typeof(self) weakSelf = self;
    //stupid google map fire delegate methods in different thread than main
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.usersAddressBottomConstraint.constant > -102) {
            [self.addressContentView layoutIfNeeded];
            self.usersAddressBottomConstraint.constant = -102;
            
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [weakSelf.contentView layoutIfNeeded];
            } completion:nil];
        }
    });
}

-(void)resetMarkersColor
{
    for (GMSMarker *marker in self.markers) {
        csVenues *venue = [self venueWithPosition:marker.position];
        [Tools getImageForVenue:venue andImageNamed:@"icon-venue-dark" imageReady:^(UIImage *image) {
            marker.icon = image;
        }];
    }
}



-(BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker
{
    [self resetMarkersColor];
    csVenues *venue = [self venueWithPosition:marker.position];
    
    [Tools getImageForVenue:venue andImageNamed:@"icon-venue" imageReady:^(UIImage *image) {
        marker.icon = image;
    }];
    
    CGPoint point = [self.mapView.projection pointForCoordinate:marker.position];
    
    if(point.y < [UIScreen mainScreen].bounds.size.height/2) {
        self.userLocationIcon.hidden = YES;
        _doNotUpdateMap = YES;
        _movedMapToShowVenue = [UIScreen mainScreen].bounds.size.height/2 - point.y;
        point.y = [UIScreen mainScreen].bounds.size.height/2 - 100;
        GMSCameraUpdate *camera =
        [GMSCameraUpdate setTarget:[self.mapView.projection coordinateForPoint:point]];
        [self.mapView animateWithCameraUpdate:camera];
    }
    
    //    NSLog(@"%@", [self venueWithPosition:marker.position]);
    [self showVenue:[self venueWithPosition:marker.position]];
    return YES;
}

-(void)hideVenueView
{
    self.userLocationIcon.hidden = NO;
    [self resetMarkersColor];
    __weak typeof(self) weakSelf = self;
    [UIView transitionWithView:self.venueHolderView duration:0.4 options:UIViewAnimationOptionTransitionFlipFromTop animations:^(void){
        [weakSelf.venueHolderView setHidden:YES];
    } completion:nil];
}

-(void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    if (!self.venueHolderView.hidden) {
        [self hideVenueView];
        [self showAddressView];
    }
}

-(csVenues *)venueWithPosition:(CLLocationCoordinate2D)position
{
    for (csVenues* venue in self.venues) {
        if (venue.location.lat == position.latitude && venue.location.lng == position.longitude) {
            return venue;
        }
    }
    return nil;
}

- (IBAction)currentLocationAction:(id)sender {
    [self centerMapToUser];
}

-(void)showVenue:(csVenues *)venue
{
    __weak typeof(self) weakSelf = self;
    [[NetworkHelper sharedInstance] GET:[NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/%@", venue.venuesIdentifier] parameters:@{@"oauth_token" : @"4NPLHLFHN4XMEZVXSTEUCCHWUNDB51T0UASR01QKQMLSJFTM", @"v":@"20151115"} success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"%@", ((NSDictionary *)responseObject)[@"response"][@"venue"]);
        
        NSString *ratingText = [NSString stringWithFormat:@"%@",((NSDictionary *)responseObject)[@"response"][@"venue"][@"rating"]];
        ratingText = [ratingText substringToIndex:ratingText.length>3?3:ratingText.length];
        if (ratingText.length > 0 && ![ratingText isEqualToString:@"(nu"]) {
            weakSelf.ratingView.hidden = NO;
            weakSelf.ratingLabel.text = ratingText;
        }
        
        if ([((NSArray *)((NSDictionary *)responseObject)[@"response"][@"venue"][@"photos"][@"groups"]) count]>0) {
            
            
            NSDictionary *photos = ((NSDictionary *)responseObject)[@"response"][@"venue"][@"photos"][@"groups"][0];
            
            weakSelf.venueImage.image = nil;
            weakSelf.imageActivityIndicator.hidden = NO;
            if ([(NSArray *)photos[@"items"] count] > 0) {
                NSString *photoPath = [NSString stringWithFormat:@"%@%ix%i%@", photos[@"items"][0][@"prefix"], (int)[UIScreen mainScreen].scale * 104, (int)[UIScreen mainScreen].scale * 104, photos[@"items"][0][@"suffix"]];
                [weakSelf.venueImage sd_setImageWithURL:[NSURL URLWithString:photoPath] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    weakSelf.imageActivityIndicator.hidden = YES;
                }];
            } else {
                weakSelf.imageActivityIndicator.hidden = YES;
            }
            
            weakSelf.venueTitleLabel.text = venue.name;
            weakSelf.venueAddressLabel.text = venue.location.address;
            weakSelf.venueTypeLabel.text = ((csCategories *)venue.categories[0]).name;
            
            [UIView transitionWithView:weakSelf.venueHolderView duration:0.4 options:UIViewAnimationOptionTransitionFlipFromTop animations:^(void){
                [weakSelf.venueHolderView setHidden:NO];
            } completion:nil];
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
}

-(void)centerMapToUser
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.lastFetchedLocation.latitude
                                                            longitude:self.lastFetchedLocation.longitude
                                                                 zoom:16];
    self.mapView.camera = camera;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
