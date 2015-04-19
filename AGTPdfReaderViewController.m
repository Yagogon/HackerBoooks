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
#import "AGTLocalFile.h"
#import "AGTPdf.h"
#import "AGTAnnotation.h"
#import "AGTAnnotationViewController.h"

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

#pragma mark - actions

- (IBAction)createAnnotation:(id)sender {
    
    AGTAnnotation *note = [AGTAnnotation annotationWithName:@"" text:@"" context:self.book.managedObjectContext];
    
    AGTAnnotationViewController *aVC = [[AGTAnnotationViewController alloc] initWithAnnotation:note];
    
    [self.book addAnnotationsObject:note];
    
    [self.navigationController pushViewController:aVC animated:YES];
    
}

#pragma  mark - View LifeCycle

-(void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onChangeBook:)
                                                 name:BOOK_CHANGE_NOTIFICATION
                                               object:nil];
   
    [self displayPDF];
    
   }

-(void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    // Asignamos delegado
    self.browser.delegate = self;

    
}

-(void) viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
}

#pragma mark - Utils

-(void) displayPDF{
    
    AGTLocalFile *localFile = [[AGTLocalFile alloc] init];
    
    if (!self.book.pdf.pdfData) {
        
        [self.activityIndicator setHidden:NO];
        [self.activityIndicator startAnimating];
        [self.view bringSubviewToFront:self.activityIndicator];
        
        [localFile dataWithURL:[NSURL URLWithString:self.book.pdf.url]
               completionBlock:^(NSData *data) {
                   dispatch_async(dispatch_get_main_queue(), ^{
                       self.book.pdf.pdfData = data;
                        [self.browser loadData:data
                                      MIMEType:@"application/pdf"
                              textEncodingName:@"utf-8"
                                       baseURL:nil];
                        self.title = self.book.title;
                       [self.activityIndicator setHidden:YES];
                       [self.activityIndicator stopAnimating];
                   });

               }];
    } else {
      
        [self.browser loadData:self.book.pdf.pdfData
                      MIMEType:@"application/pdf"
              textEncodingName:@"utf-8"
                       baseURL:nil];
    }
   
    
}


#pragma mark - Notifications

-(void) onChangeBook: (NSNotification *) notification {
    
    AGTBook *book = [[notification userInfo] objectForKey:BOOK_KEY];
    
    [self.activityIndicator setHidden:NO];
    [self.activityIndicator startAnimating];
    [self.view bringSubviewToFront:self.activityIndicator];
    
    self.book = book;
    
    [self displayPDF];
}

#pragma mark - UIWebViewDelegate

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
}

@end
