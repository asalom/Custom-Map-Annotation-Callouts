#import "CustomMapAnnotationExampleViewController.h"
#import "BasicMapAnnotation.h"
#import "CalloutMapAnnotation.h"
#import "CalloutMapAnnotationView.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface CustomMapAnnotationExampleViewController()

@property (nonatomic, retain) CalloutMapAnnotation *calloutAnnotation;
@property (nonatomic, retain) BasicMapAnnotation *customAnnotation;
@property (nonatomic, retain) BasicMapAnnotation *normalAnnotation;

@end


@implementation CustomMapAnnotationExampleViewController

@synthesize calloutAnnotation = _calloutAnnotation;
@synthesize mapView = _mapView;
@synthesize selectedAnnotationView = _selectedAnnotationView;
@synthesize customAnnotation = _customAnnotation;
@synthesize normalAnnotation = _normalAnnotation;

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
	if (view.annotation == self.customAnnotation) {
		if (self.calloutAnnotation == nil) {
			self.calloutAnnotation = [[CalloutMapAnnotation alloc] initWithLatitude:view.annotation.coordinate.latitude
																	   andLongitude:view.annotation.coordinate.longitude];
		} else {
			self.calloutAnnotation.latitude = view.annotation.coordinate.latitude;
			self.calloutAnnotation.longitude = view.annotation.coordinate.longitude;
		}
		[self.mapView addAnnotation:self.calloutAnnotation];
		self.selectedAnnotationView = view;
	}
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
	if (self.calloutAnnotation && view.annotation == self.customAnnotation) {
		[self.mapView removeAnnotation: self.calloutAnnotation];
	}
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	if (annotation == self.calloutAnnotation) {
		CalloutMapAnnotationView *calloutMapAnnotationView = (CalloutMapAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"CalloutAnnotation"];
		if (!calloutMapAnnotationView) {
			calloutMapAnnotationView = [[[CalloutMapAnnotationView alloc] initWithAnnotation:annotation 
																			 reuseIdentifier:@"CalloutAnnotation"] autorelease];
			calloutMapAnnotationView.contentHeight = 78.0f;
			UIImage *asynchronyLogo = [UIImage imageNamed:@"asynchrony-logo-small.png"];
			UIImageView *asynchronyLogoView = [[[UIImageView alloc] initWithImage:asynchronyLogo] autorelease];
			asynchronyLogoView.frame = CGRectMake(5, 2, asynchronyLogoView.frame.size.width, asynchronyLogoView.frame.size.height);
			[calloutMapAnnotationView.contentView addSubview:asynchronyLogoView];
		}
		calloutMapAnnotationView.parentAnnotationView = self.selectedAnnotationView;
		calloutMapAnnotationView.mapView = self.mapView;
		return calloutMapAnnotationView;
	} else if (annotation == self.customAnnotation) {
		MKPinAnnotationView *annotationView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation 
																			   reuseIdentifier:@"CustomAnnotation"] autorelease];
		annotationView.canShowCallout = NO;
		annotationView.pinColor = MKPinAnnotationColorGreen;
		return annotationView;
	} else if (annotation == self.normalAnnotation) {
		MKPinAnnotationView *annotationView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation 
																			   reuseIdentifier:@"NormalAnnotation"] autorelease];
		annotationView.canShowCallout = YES;
		annotationView.pinColor = MKPinAnnotationColorPurple;
		return annotationView;
	}
	
	
	return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.mapView.delegate = self;
	
	self.customAnnotation = [[[BasicMapAnnotation alloc] initWithLatitude:38.6335 andLongitude:-90.2045] autorelease];
	[self.mapView addAnnotation:self.customAnnotation];
	
	self.normalAnnotation = [[[BasicMapAnnotation alloc] initWithLatitude:38 andLongitude:-90.2045] autorelease];
	self.normalAnnotation.title = @"                                                         ";
	[self.mapView addAnnotation:self.normalAnnotation];
	
	CLLocationCoordinate2D coordinate = {38.315, -90.2045};
	[self.mapView setRegion:MKCoordinateRegionMake(coordinate, 
												   MKCoordinateSpanMake(1, 1))];
}

- (void)viewDidUnload {
	self.mapView = nil;
	self.customAnnotation = nil;
	self.normalAnnotation = nil;
}

- (void)dealloc {
    [super dealloc];
}

@end
