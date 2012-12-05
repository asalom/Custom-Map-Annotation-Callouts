
#import "CustomMapAnnotationExampleViewController.h"
#import "BasicMapAnnotation.h"
#import "CalloutMapAnnotation.h"
#import "CVCustomCalloutAnnotationView.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface CustomMapAnnotationExampleViewController () <MKMapViewDelegate>

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) MKAnnotationView *selectedAnnotationView;
@property (nonatomic, retain) CalloutMapAnnotation *calloutAnnotation;
@property (nonatomic, retain) BasicMapAnnotation *customAnnotation;
@property (nonatomic, retain) BasicMapAnnotation *normalAnnotation;

@end


@implementation CustomMapAnnotationExampleViewController

#pragma mark - Memory Management

- (void)dealloc
{
	_mapView.delegate = nil;
	[_mapView release];
	[_customAnnotation release];
	[_normalAnnotation release];
	
    [super dealloc];
}


- (void)viewDidUnload
{
	[super viewDidUnload];
	
	self.mapView.delegate = nil;
	self.mapView = nil;
	self.customAnnotation = nil;
	self.normalAnnotation = nil;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.mapView.delegate = self;
	
	self.customAnnotation = [[[BasicMapAnnotation alloc] initWithLatitude:38.6335 andLongitude:-90.2045] autorelease];
	[self.mapView addAnnotation:self.customAnnotation];
	
	self.normalAnnotation = [[[BasicMapAnnotation alloc] initWithLatitude:38 andLongitude:-90.2045] autorelease];
	self.normalAnnotation.title = @"Hello Annotation !";
	[self.mapView addAnnotation:self.normalAnnotation];
	
	CLLocationCoordinate2D coordinate = {38.315, -90.2045};
	[self.mapView setRegion:MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(1, 1))];
}


#pragma mark - MKMapView delegate

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
	if (view.annotation == self.customAnnotation)
	{
		if (self.calloutAnnotation == nil)
		{
			self.calloutAnnotation = [[CalloutMapAnnotation alloc] initWithLatitude:view.annotation.coordinate.latitude andLongitude:view.annotation.coordinate.longitude];
		}
		else
		{
			self.calloutAnnotation.latitude = view.annotation.coordinate.latitude;
			self.calloutAnnotation.longitude = view.annotation.coordinate.longitude;
		}
		
		self.selectedAnnotationView = view;
		// On iOS 6 when an annotation is added, if the user see the region of the added annotation
		// the method mapView:viewForAnnotation: is immediately called on the delegate.
		// So be sure to set the selectedAnnotationView before adding the new annotation
		// Because the custome callout annotation view use the selected annotation view as its parent to
		// compute its frame, offseting from the parent annotation view frame !
		[self.mapView addAnnotation:self.calloutAnnotation];
	}
}


- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
	// Remove the fake bubble annotation view on deselection.
	if (self.calloutAnnotation && view.annotation == self.customAnnotation)
		[self.mapView removeAnnotation: self.calloutAnnotation];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	MKAnnotationView *annotationView = nil;
	
	if (annotation == self.calloutAnnotation)
	{
		CVCustomCalloutAnnotationView *calloutMapAnnotationView = (CVCustomCalloutAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"CalloutAnnotation"];
		
		if (!calloutMapAnnotationView)
		{
			calloutMapAnnotationView = [[[CVCustomCalloutAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CalloutAnnotation"] autorelease];
			
			/**  
			 Custom view in the bubble is set here !
			 */
			calloutMapAnnotationView.contentHeight = 78.0f;
			UIImage *asynchronyLogo = [UIImage imageNamed:@"asynchrony-logo-small.png"];
			UIImageView *asynchronyLogoView = [[[UIImageView alloc] initWithImage:asynchronyLogo] autorelease];
			asynchronyLogoView.frame = CGRectMake(5, 2, asynchronyLogoView.frame.size.width, asynchronyLogoView.frame.size.height);
			[calloutMapAnnotationView.contentView addSubview:asynchronyLogoView];
		}
		
		calloutMapAnnotationView.parentAnnotationView = self.selectedAnnotationView;
		calloutMapAnnotationView.mapView = self.mapView;
		
		annotationView = calloutMapAnnotationView;
	}
	else if (annotation == self.customAnnotation)
	{
		MKPinAnnotationView *pinAV = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomAnnotation"] autorelease];
		pinAV.canShowCallout = NO;
		pinAV.pinColor = MKPinAnnotationColorGreen;
		annotationView = pinAV;
	}
	else if (annotation == self.normalAnnotation)
	{
		MKPinAnnotationView *pinAV = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"NormalAnnotation"] autorelease];
		pinAV.canShowCallout = YES;
		pinAV.pinColor = MKPinAnnotationColorPurple;
		annotationView = pinAV;
	}
	
	return annotationView;
}

@end
