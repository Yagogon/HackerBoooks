//
//  AppDelegate.m
//  HackerBooks
//
//  Created by Yago de la Fuente on 21/3/15.
//  Copyright (c) 2015 com.cininika. All rights reserved.
//

#import "AppDelegate.h"
#import "AGTJSONUtils.h"
#import "AGTLocalFile.h"
#import "AGTLibrary.h"
#import "AGTBooksTableViewController.h"
#import "AGTBookViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    AGTLocalFile *localFile = [[AGTLocalFile alloc] init];
    [localFile saveData:[NSURL URLWithString:@"https://t.co/K9ziV0z3SJ"]];
    //NSArray *data = [AGTJSONUtils JSONBooks];
    NSArray *data;
    
   [AGTJSONUtils JSONBooksWithCompletionBlock:^(NSArray *array) {
       <#code#>
   }];
   // AGTLibrary *model = [[AGTLibrary alloc] initWithArray:data];
    
     //self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
      //  [self configureForPadWithModel:model];
    //} else {
      //  [self configureForPhoneWithModel:model];
   // }
    
   
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
}

-(void)configureForPhoneWithModel:(AGTLibrary *)library{
    
    // Creamos el controlador
    AGTBooksTableViewController *tableVC = [[AGTBooksTableViewController alloc] initWithLibrary:library
                                                                                          style:UITableViewStylePlain];
    
    // Creamos el combinador
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:tableVC];
    
    // Asignamos delegados
    tableVC.delegate = tableVC;
    
    // Lo hacemos root
    self.window.rootViewController = navVC;
    
}

-(void)configureForPadWithModel:(AGTLibrary *)library{
    
    AGTBooksTableViewController *tabVC = [[AGTBooksTableViewController alloc] initWithLibrary:library style:UITableViewStylePlain];
    UINavigationController *navTab = [[UINavigationController alloc] initWithRootViewController:tabVC];
    
    AGTBookViewController *bookVC = [[AGTBookViewController alloc] initWithBook:[library booksForTag:[[library tags] objectAtIndex:1] atIndex:0]];
    UINavigationController *navBook = [[UINavigationController alloc] initWithRootViewController:bookVC];
    
    tabVC.delegate = bookVC;
    
    UISplitViewController *splitVC = [[UISplitViewController alloc] init];
    splitVC.viewControllers = @[navTab, navBook];
    
    bookVC.navigationItem.leftBarButtonItem = splitVC.displayModeButtonItem;
    
    self.window.rootViewController = splitVC;
    
}


@end
