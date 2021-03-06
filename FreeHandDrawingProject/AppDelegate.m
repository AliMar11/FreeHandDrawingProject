//
//  AppDelegate.m
//  FreeHandDrawingProject
//
//  Created by Alicia Marisal on 3/25/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//

#import "AppDelegate.h"
#import "lineInterpolation.h"
#import "ViewController.h"

@interface AppDelegate ()
@property (strong, nonatomic) UINavigationController* navigationController;
@property (strong, nonatomic) UIViewController* vc;
@property (strong, nonatomic) UIButton* oneBarButton;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
ViewController *vc = [sb instantiateViewControllerWithIdentifier: @"lineVC"];
[self.window makeKeyAndVisible];


[self.vc.navigationItem setRightBarButtonItem:self.oneBarButton];
// [self.vc setToolbarItems:oneBarButton animated:YES];
return YES;
}



- (void)applicationWillTerminate:(UIApplication *)application {

[self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
// The directory the application uses to store the Core Data store file. This code uses a directory named "aliApps.FreeHandDrawingProject" in the application's documents directory.
return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {

if (_managedObjectModel != nil) {
    return _managedObjectModel;
}
NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"FreeHandDrawingProject" withExtension:@"momd"];
_managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {

if (_persistentStoreCoordinator != nil) {
    return _persistentStoreCoordinator;
}

// Create the coordinator and store

_persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"FreeHandDrawingProject.sqlite"];
NSError *error = nil;
NSString *failureReason = @"There was an error creating or loading the application's saved data.";
if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
    // Report any error we got.
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
    dict[NSLocalizedFailureReasonErrorKey] = failureReason;
    dict[NSUnderlyingErrorKey] = error;
    error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
  
    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    abort();
}

return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {

if (_managedObjectContext != nil) {
    return _managedObjectContext;
}

NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
if (!coordinator) {
    return nil;
}
_managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
[_managedObjectContext setPersistentStoreCoordinator:coordinator];
return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
if (managedObjectContext != nil) {
    NSError *error = nil;
    if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
  
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}
}

@end
