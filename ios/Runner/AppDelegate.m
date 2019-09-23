#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

@implementation AppDelegate

NSString *sharedText;

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //[self getUrl];
    
    FlutterViewController *controller = (FlutterViewController *) self.window.rootViewController;
    FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:@"app.channel.shared.data" binaryMessenger:controller];
    
    [channel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        //NSString *from = call.arguments[@"from"];
        if([@"getCode" isEqualToString:call.method]){
            //NSString *messageToFlutter = [self getUrl];
            //messageToFlutter = [NSString stringWithFormat:@"%@, Back to %@", messageToFlutter, from];
            result(sharedText);
            sharedText = NULL;
        }
    }];
    [GeneratedPluginRegistrant registerWithRegistry:self];
    // Override point for customization after application launch.
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    NSLog(@"url recieved: %@", url);
    sharedText=[url query];
    NSLog(@"query string: %@", [url query]);
    NSLog(@"host: %@", [url host]);
    NSLog(@"url path: %@", [url path]);
    NSDictionary *dict = [self parseQueryString:[url query]];
    NSLog(@"query dict: %@", dict);
    return YES;
}

- (NSDictionary *)parseQueryString:(NSString *)query {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:6] ;
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [dict setObject:val forKey:key];
    }
    return dict;
}

-(void) getUrl{
    sharedText=@"Ios";
}

@end

