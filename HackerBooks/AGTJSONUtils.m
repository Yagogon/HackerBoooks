//
//  AGTJSONUtils.m
//  HackerBooks
//
//  Created by Yago de la Fuente on 30/3/15.
//  Copyright (c) 2015 com.cininika. All rights reserved.
//

#import "AGTJSONUtils.h"
#import "Constants.h"
#import "AGTLocalFile.h"


@implementation AGTJSONUtils

+(void) JSONBooksWithCompletionBlock : (void (^)(NSArray * array)) completionBlock{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:FIRST_EXECUTION] == nil) {
        
        AGTLocalFile *localFile = [[AGTLocalFile alloc] init];
        [localFile saveData:[NSURL URLWithString:@"https://t.co/K9ziV0z3SJ"] completionBlock:completionBlock];
    }
}

+(void) markAsExecuted: (NSData *)data{
    
    
    NSURL *url = [self urlForJSONBooks];
    NSError *error;
    BOOL save = [data writeToURL:url
                         options:NSDataWritingAtomic
                           error:&error];
    if (!save) {
        NSLog(@"Error al guardar JSON: %@", error.localizedDescription);
    } else {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@1 forKey:FIRST_EXECUTION];
    }
    
}

+(NSURL *) urlForJSONBooks {
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *urls = [fm URLsForDirectory:NSDocumentDirectory
                               inDomains:NSUserDomainMask];
    NSURL *url = [urls lastObject];
    
    url = [url URLByAppendingPathComponent:JSON_FILE];
    
    return url;
    
}

+(void) saveJSONWithArray: (NSArray *) array {
    
    NSURL *url = [AGTJSONUtils urlForJSONBooks];
    NSError *error;
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    
    if (!data) {
        NSLog(@"Error al crear el archivo JSON, %@", error.localizedDescription);
    } else {
        
        if (![data writeToURL:url options:NSDataWritingAtomic error:&error]) {
            NSLog(@"Error al guardar el archivo JSON, %@", error.localizedDescription);
        }
    }
    
}

#pragma mark -NSURLSessionDownloadDelegate

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    
    NSError *error;
    NSLog(@"Acabó la descarga: %@", [NSData dataWithContentsOfURL:location]);
    NSData *data = [NSData dataWithContentsOfURL:location];
    if (!([data writeToURL:[AGTJSONUtils urlForJSONBooks] options:NSDataWritingAtomic error:&error])) {
        NSLog(@"Error al guardar JSON: %@", error);
    }
    
}

@end
