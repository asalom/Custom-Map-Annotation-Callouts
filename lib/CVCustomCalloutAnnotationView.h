//
// Reworked by Nicolas VERINAUD
// 05/12/2012
//
// Original by Asynchrony Solution.
// Hosted on GitHub by Alex Salom (asalom) https://github.com/asalom/Custom-Map-Annotation-Callouts
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface CVCustomCalloutAnnotationView : MKAnnotationView

@property (nonatomic, retain) MKAnnotationView *parentAnnotationView;
@property (nonatomic, retain) MKMapView *mapView;
@property (nonatomic, readonly, strong) UIView *contentView;
@property (nonatomic) CGPoint offsetFromParent;
@property (nonatomic) CGFloat contentHeight;

@end
