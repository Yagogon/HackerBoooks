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

+(NSArray *) JSONBooks {
    
    NSData *JSONData;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSError *error;
    
    if ([defaults objectForKey:FIRST_EXECUTION] == nil) {
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://t.co/K9ziV0z3SJ"]];
        NSURLResponse *response = [[NSURLResponse alloc]init];
        NSError *error;
        JSONData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
         NSArray *JSONObjects = [NSJSONSerialization JSONObjectWithData:JSONData options:kNilOptions error:&error];
        
        for (NSDictionary *book in JSONObjects) {
            NSURL *imageURL = [NSURL URLWithString:[book objectForKey:IMAGE_URL_KEY]];
            [AGTLocalFile saveDataWithURL:imageURL];
        }
        
        [self markAsExecuted:JSONData];
    } else {
        
        JSONData = [NSData dataWithContentsOfURL:[self urlForJSONBooks] options:NSDataReadingMappedAlways error:&error];
        
        if (!JSONData) {
            NSLog(@"Error al recuperar el JSON: %@", error.localizedDescription);
        }
    }
    
    NSArray *JSONObjects = [NSJSONSerialization JSONObjectWithData:JSONData options:kNilOptions error:&error];
    
    
    return JSONObjects;
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

@end
