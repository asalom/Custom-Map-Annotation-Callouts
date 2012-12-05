#import "CustomMapAnnotationExampleAppDelegate.h"
#import "CustomMapAnnotationExampleViewController.h"

@implementation CustomMapAnnotationExampleAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self.window addSubview:self.viewController.view];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)dealloc
{
    [_viewController release];
    [_window release];
    [super dealloc];
}


@end
