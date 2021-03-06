//
//  AGTBookViewController.m
//  HackerBooks
//
//  Created by Yago de la Fuente on 31/3/15.
//  Copyright (c) 2015 com.cininika. All rights reserved.
//

#import "AGTBookViewController.h"
#import "AGTBook.h"
#import "AGTPdfReaderViewController.h"
#import "Constants.h"
#import "ReaderDocument.h"
#import "AGTLocalFile.h"
#import "ReaderViewController.h"

@interface AGTBookViewController ()

@end

@implementation AGTBookViewController

#pragma  mark - Init

-(id) initWithBook:(AGTBook *)book {
    
    if (self = [super initWithNibName:nil bundle:nil]) {
        _book = book;
        self.title = book.title;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updatePDF:)
                                                     name:BOOK_CHANGE_NOTIFICATION
                                                   object:nil];
    }
    return self;
}

#pragma  mark - View LifeCycle

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self syncViewAndModel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkFavoriteTag:) name:FAVORITE_NOTIFICATION object:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void) viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:FAVORITE_NOTIFICATION object:nil];
}

-(void) dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Targets

- (IBAction)openPdf:(id)sender {
    
    [self showPDF];
}

- (IBAction)markAsFavorite:(id)sender {
    
    self.book.favorite = !self.book.favorite;
    
}


#pragma mark - Utils

-(void) showPDF {
    
    [self.view bringSubviewToFront:self.activityIndicator];
    [self.activityIndicator setHidden:NO];
    [self.activityIndicator startAnimating];
    [self.view setNeedsDisplay];

    ReaderDocument *d = [[ReaderDocument alloc] initWithFilePath:[AGTLocalFile localPathWithURL:self.book.pdfURL] password:nil];
    ReaderViewController *readerVC = [[ReaderViewController alloc] initWithReaderDocument:d];
    readerVC.title = self.book.title;
    
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
    
    
    [self.navigationController pushViewController:readerVC animated:YES];
    
}

-(void) syncViewAndModel {
    
    
    NSData *imageData = [AGTLocalFile dataWithURL:self.book.photoURL];
    
    self.pdfImage.image = [UIImage imageWithData:imageData];
    self.titleLabel.text = self.book.title;
    self.authorsLabel.text = [[self.book.authors valueForKey:@"description"] componentsJoinedByString:@","];
    self.tagsLabel.text = [[self.book.tags valueForKey:@"description"] componentsJoinedByString:@","];
    self.title = self.book.title;
    [self updateFavoriteButtonWithBool:self.book.favorite];
    
}

-(void) updateFavoriteButtonWithBool: (BOOL) favorite {
    
    if (favorite) {
        UIImage *favoriteImage = [UIImage imageNamed:@"favorite.png"];
        [self.favoriteButton setImage:favoriteImage forState:UIControlStateNormal];
        self.favoriteButton.imageView.image = favoriteImage;
    } else {
        UIImage *noFavoriteImage = [UIImage imageNamed:@"no_favorite.png"];
        [self.favoriteButton setImage:noFavoriteImage forState:UIControlStateNormal];
    }
    
}

#pragma mark - Notifications

-(void) checkFavoriteTag: (NSNotification *) notification {
    
    BOOL favorite = [[[notification userInfo] objectForKey:BOOK_KEY] favorite];
    
    [self updateFavoriteButtonWithBool:favorite];
    
}

// Forma poco elegante mientras no soluciono las modificaciones en vfr reader para aceptar notificaciones

-(void) updatePDF: (NSNotification *) notification {
    
    AGTBook *book = [[notification userInfo] objectForKey: BOOK_KEY];
    
    self.book = book;

    // Para saber si tengo abierto un controller con el pdf
    if ( [[self.navigationController childViewControllers] count] > 1) {
         [self.navigationController popToRootViewControllerAnimated:YES];
         [self showPDF];
    }
    
}

#pragma  mark - AGTBooksTableViewControllerDelegate

-(void)booksTableViewController:(AGTBooksTableViewController *)tabVC
                didSelectedBook:(AGTBook *)book {
    
    self.book = book;
    [self syncViewAndModel];
}

#pragma mark - UISplitViewControllerDelegate

-(void)splitViewController:(UISplitViewController *)svc willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode {
    
    // Averiguar si la tabla se ve o no
    // La tabla está oculta y cuelga del botón
    if (displayMode == UISplitViewControllerDisplayModePrimaryHidden) {
        self.navigationItem.leftBarButtonItem = svc.displayModeButtonItem;
        
    } else {
        // Se muestra la tabla y por lo tanto oculto el botón de la barra de navegación
        self.navigationItem.leftBarButtonItem = nil;
    }
    
}


@end
