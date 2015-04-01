//
//  AGTPdfReaderViewController.m
//  HackerBooks
//
//  Created by Yago de la Fuente on 31/3/15.
//  Copyright (c) 2015 com.cininika. All rights reserved.
//

#import "AGTPdfReaderViewController.h"
#import "AGTBook.h"

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

-(void) viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [self displayPDF];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Utils

-(void) displayPDF{
    
    // Load pdf into NSData
    NSError *error;
    NSData *PDFData = [NSData dataWithContentsOfURL:self.book.pdfURL
                                            options:kNilOptions
                                              error:&error];
    if(!PDFData){
        NSLog(@"Error al cargar el PDF, %@",error.localizedDescription);
    }
    else{
        [self.browser loadData:PDFData MIMEType:@"application/pdf" textEncodingName:@"utf-8" baseURL:nil];
    }
}


@end
