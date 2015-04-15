//
//  AppDelegate.m
//  HackerBooks
//
//  Created by Yago de la Fuente on 21/3/15.
//  Copyright (c) 2015 com.cininika. All rights reserved.
//

#import "AppDelegate.h"
#import "AGTLocalFile.h"
#import "AGTLibraryViewController.h"
#import "AGTBookViewController.h"
#import "AGTLoadingViewController.h"
#import "AGTTag.h"
#import "AGTBook.h"
#import "AGTCoreDataStack.h"

@interface AppDelegate ()

@property (nonatomic, strong) AGTCoreDataStack *stack;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Creamos una instancia del stack
    self.stack = [AGTCoreDataStack coreDataStackWithModelName:@"Model"];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:FIRST_EXECUTION] == nil) {
        
        AGTLocalFile *localFile = [[AGTLocalFile alloc] init];
        [localFile saveData:[NSURL URLWithString:@"https://t.co/K9ziV0z3SJ"] completionBlock:^(NSArray *array) {
            
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
                
                for (NSDictionary *dict in array) {
                    [AGTBook bookWithDict:dict context:self.stack.context];
                }
                
//                [self.stack saveWithErrorBlock:^(NSError *error) {
//                    NSLog(@"Error al guardar %@", error);
//                }];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    //if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                      //  [self configureForPadWithModel:model];
                   // } else {
                     //   [self configureForPhoneWithModel:model];
                   // }
                    
                    // Buscar
                    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[AGTTag entityName]];
                    
                    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:AGTTagAttributes.name ascending:YES]];
                                       // Recupera por lotes de X
                    req.fetchBatchSize = 20;

                    // FetchedResultsController
                    NSFetchedResultsController *fc = [[NSFetchedResultsController alloc] initWithFetchRequest:req
                                                                                         managedObjectContext:self.stack.context sectionNameKeyPath:@"name" cacheName:nil];
                    [self configureForPhoneWithFetchedResultsController:fc];
                    
                });
            });
        }];
        
    }
    // AGTLibrary *model = [[AGTLibrary alloc] initWithArray:data];
    
    //self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //if ([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
    //  [self configureForPadWithModel:model];
    //} else {
    //  [self configureForPhoneWithModel:model];
    // }
    
    
    // Override point for customization after application launch.
    AGTLoadingViewController *lVC = [[AGTLoadingViewController alloc] initWithNibName:nil
                                                                               bundle:nil];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = lVC;
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

-(void)configureForPhoneWithFetchedResultsController:(NSFetchedResultsController *)fc{
    
    // Creamos el controlador
    AGTLibraryViewController *libraryVC = [[AGTLibraryViewController alloc] initWithFetchedResultsController:fc
                                                                                                       style:UITableViewStylePlain];
    
    // Creamos el combinador
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:libraryVC];
    
    // Asignamos delegados
    //tableVC.delegate = libraryVC;
    
    // Lo hacemos root
    self.window.rootViewController = navVC;
    
}

//-(void)configureForPadWithModel:(AGTLibrary *)library{
    
    //AGTBooksTableViewController *tabVC = [[AGTBooksTableViewController alloc] initWithLibrary:library style:UITableViewStylePlain];
    //UINavigationController *navTab = [[UINavigationController alloc] initWithRootViewController:tabVC];
    
    //AGTBookViewController *bookVC = [[AGTBookViewController alloc] initWithBook:[library booksForTag:[[library tags] objectAtIndex:1] atIndex:0]];
   // UINavigationController *navBook = [[UINavigationController alloc] initWithRootViewController:bookVC];
    
    //tabVC.delegate = bookVC;
    
   // UISplitViewController *splitVC = [[UISplitViewController alloc] init];
    //splitVC.viewControllers = @[navTab, navBook];
    
    //bookVC.navigationItem.leftBarButtonItem = splitVC.displayModeButtonItem;
    
    //self.window.rootViewController = splitVC;
    
//}


@end
