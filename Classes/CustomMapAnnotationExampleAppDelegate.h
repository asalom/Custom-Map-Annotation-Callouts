#import <UIKit/UIKit.h>

@class CustomMapAnnotationExampleViewController;

@interface CustomMapAnnotationExampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UIViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UIViewController *viewController;

@end

