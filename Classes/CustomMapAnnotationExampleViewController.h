#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CalloutMapAnnotation.h"
#import "BasicMapAnnotation.h"

@interface CustomMapAnnotationExampleViewController : UIViewController <MKMapViewDelegate> {
	MKMapView *_mapView;
	CalloutMapAnnotation *_calloutAnnotation;
	MKAnnotationView *_selectedAnnotationView;
	BasicMapAnnotation *_customAnnotation;
	BasicMapAnnotation *_normalAnnotation;
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) MKAnnotationView *selectedAnnotationView;

@end

