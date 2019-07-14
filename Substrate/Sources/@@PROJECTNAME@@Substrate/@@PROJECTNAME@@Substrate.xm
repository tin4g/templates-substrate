#import "@@PROJECTNAME@@Substrate.h"

static NSString *nsDomainString = @"@@PACKAGENAME@@";
static NSString *nsNotificationString = @"@@PACKAGENAME@@/ReloadPrefs";
static BOOL enabled;

static void notificationCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	NSNumber *n = (NSNumber *)[[HBPreferences preferencesForIdentifier:nsDomainString] objectForKey:@"enabled"];
	enabled = (n) ? [n boolValue] : YES;
}

@implementation @@PROJECTNAME@@Substrate {
	NSString *_text;
}

- (id)init
{
	self = [super init];

	if (self) {
		_text = @"Hello, World!";
	}

	return self;
}

@synthesize text = _text;

@end

%ctor {
	// Set variables on start up
	notificationCallback(NULL, NULL, NULL, NULL, NULL);

	// Register for 'PostNotification' notifications
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, notificationCallback, (CFStringRef)nsNotificationString, NULL, CFNotificationSuspensionBehaviorCoalesce);

	// Add any personal initializations
	Class @@PROJECTNAME@@ = NSClassFromString(@"@@PROJECTNAME@@.@@PROJECTNAME@@");
	HBLogInfo(@"@@PROJECTNAME@@: %@ @@PROJECTNAME@@Substrate: %@", [[[@@PROJECTNAME@@ alloc] init] text], [[[@@PROJECTNAME@@Substrate alloc] init] text]);
}

/* How to Hook with Logos
Hooks are written with syntax similar to that of an Objective-C @implementation.
You don't need to #include <substrate.h>, it will be done automatically, as will
the generation of a class list and an automatic constructor.

%hook ClassName

// Hooking a class method
+ (id)sharedInstance {
	return %orig;
}

// Hooking an instance method with an argument.
- (void)messageName:(id)arg {
	%log; // Write a message about this call, including its class, name and arguments, to the system log.

	%orig; // Call through to the original function with its original arguments.
	%orig(nil); // Call through to the original function with a custom argument.

	// If you use %orig(), you MUST supply all arguments (except for self and _cmd, the automatically generated ones.)
}

// Hooking an instance method with no arguments.
- (id)noArguments {
	%log;
	id awesome = %orig;
	[awesome doSomethingElse];

	return awesome;
}

// Always make sure you clean up after yourself; Not doing so could have grave consequences!
%end
*/
