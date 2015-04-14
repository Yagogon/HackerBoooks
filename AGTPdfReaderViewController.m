//
//  AGTPdfReaderViewController.m
//  HackerBooks
//
//  Created by Yago de la Fuente on 31/3/15.
//  Copyright (c) 2015 com.cininika. All rights reserved.
//

#import "AGTPdfReaderViewController.h"
#import "AGTBook.h"
#import "AGTLocalFile.h"
#import "Constants.h"

@interface AGTPdfReaderViewController ()

@end

@implementation AGTPdfReaderViewController

#pragma mark - Init

-(id) initWithBook:(AGTBook *)book {
    
    if (self = [super initWithNibName:nil bundle:nil]) {
        _book = book;
        self.title = book.title;
    }
    
    return self;
}

#pragma  mark - View LifeCycle

//-(void) viewWillAppear:(BOOL)animated {
//    
//    [super viewWillAppear:animated];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(onChangeBook:)
//                                                 name:BOOK_CHANGE_NOTIFICATION
//                                               object:nil];
//    
//    [self.activityIndicator setHidden:NO];
//    [self.activityIndicator startAnimating];
//    [self.view bringSubviewToFront:self.activityIndicator];
//    
//   }
//
//-(void) viewDidAppear:(BOOL)animated {
//    
//    [super viewDidAppear:animated];
//    // Asignamos delegado
//    self.browser.delegate = self;
//    [self displayPDF];
//
//    
//}
//
//#pragma mark - Utils
//
//-(void) displayPDF{
//    
//    // Load pdf into NSData
//    NSError *error;
//    
//    NSData *PDFData = [NSData dataWithContentsOfURL:[AGTLocalFile localURL:self.book.pdfURL]
//                                            options:kNilOptions
//                                              error:&error];
//    if(!PDFData){
//        NSLog(@"Error al cargar el PDF, %@",error.localizedDescription);
//    }
//    else{
//         self.title = self.book.title;
//        [self.browser loadData:PDFData MIMEType:@"application/pdf" textEncodingName:@"utf-8" baseURL:nil];
//    }
//}
//
//
//#pragma mark - Notifications
//
//-(void) onChangeBook: (NSNotification *) notification {
//    
//    AGTBook *book = [[notification userInfo] objectForKey:BOOK_KEY];
//    
//    [self.activityIndicator setHidden:NO];
//    [self.activityIndicator startAnimating];
//    [self.view bringSubviewToFront:self.activityIndicator];
//    
//    self.book = book;
//    
//    [self displayPDF];
//}
//
//#pragma mark - UIWebViewDelegate
//
//-(void)webViewDidFinishLoad:(UIWebView *)webView {
//    
//    [self.activityIndicator stopAnimating];
//    self.activityIndicator.hidden = YES;
//}

@end
