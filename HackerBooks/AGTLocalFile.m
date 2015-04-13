//
//  AGTLocalFile.m
//  HackerBooks
//
//  Created by Yago de la Fuente on 1/4/15.
//  Copyright (c) 2015 com.cininika. All rights reserved.
//

#import "AGTLocalFile.h"
#import "AGTBook.h"

@interface AGTLocalFile ()

@property (strong, nonatomic) NSURLSession *downloadSession;
@property(strong, nonatomic) NSOperationQueue *delegateQueue;

@end

@implementation AGTLocalFile


+(NSData *) dataWithExternalURL:(NSURL *)url delegate: (id<NSURLSessionDownloadDelegate> *) delegate{
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response = [[NSURLResponse alloc]init];
    NSError *error;

    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (!data) {
        NSLog(@"Error al recuperar los datos, %@", error.localizedDescription);
    }
        return data;
}

-(void) saveData:(NSURL *)url completionBlock: (void (^)(NSArray * array)) completionBlock{
    
    // Cola de descargas
    self.delegateQueue = [[NSOperationQueue alloc] init];
    // Creamos configuracion por defecto
    NSURLSessionConfiguration *conf = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.downloadSession = [NSURLSession sessionWithConfiguration:conf];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
 
    NSURLSessionDataTask *task = [self.downloadSession dataTaskWithRequest:request
                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                NSArray *JSONObjects = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                completionBlock(JSONObjects);
                            }];
    [task resume];
    
}

+(NSURL *) URLToDocuments {
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *urls = [fm URLsForDirectory:NSDocumentDirectory
                               inDomains:NSUserDomainMask];
    NSURL *localURL = [urls lastObject];
    
    return localURL;
}


+(void) saveDataWithURL: (NSURL *) url {
    
    NSData *data = nil;
    NSURL *localURL = [AGTLocalFile URLToDocuments];
    NSError *error;
    
    NSURL *dataURL = [localURL URLByAppendingPathComponent:[url lastPathComponent]];
    
    BOOL success = [data writeToURL:dataURL options:NSDataWritingAtomic error:&error];
    
    if (!success) {
        NSLog(@"Error al guardar la imagen en local, %@", error.localizedDescription);
    }
    
}
// Devuelve archivos locales

+(NSData *)dataWithURL:(NSURL *)url {
    
    NSURL *dataURL = [[AGTLocalFile URLToDocuments] URLByAppendingPathComponent:[url lastPathComponent]];
    NSError *error;
    
    NSData *data = [NSData dataWithContentsOfURL:dataURL options:NSDataReadingMappedIfSafe error:&error];
    
    // Comprobamos si existe en local
    if (!data) {
        // Si no existe lo guardamos
        [AGTLocalFile saveDataWithURL:url];
        data = [NSData dataWithContentsOfURL:dataURL options:NSDataReadingMappedIfSafe error:&error];
    }
    
    
    if (!data) {
        // Error al cargar de url externa
        NSLog(@"Error al cargar el archivo, %@", error.localizedDescription);
    }
    
    return data;
}

+(NSString *) localPathWithURL: (NSURL *) url {
    
    return [[AGTLocalFile localURL:url] path];

}

+(NSURL *) localURL: (NSURL *) url {
    
    [AGTLocalFile dataWithURL:url];
    
    return [[AGTLocalFile URLToDocuments]
             URLByAppendingPathComponent:[url lastPathComponent]];

}

#pragma mark -NSURLSessionDownloadDelegate

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    
    NSLog(@"Acabó la descarga: %@", [NSData dataWithContentsOfURL:location]);
    
}
     


@end

