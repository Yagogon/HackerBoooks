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
#import "AGTLocalFile.h"
#import "AGTAnnotationsCollectionViewController.h"

@interface AGTBookViewController ()

@end

@implementation AGTBookViewController

#pragma  mark - Init

-(id) initWithBook:(AGTBook *)book {
    
    if (self = [super initWithNibName:nil bundle:nil]) {
        _book = book;
        self.title = book.title;
    }
    return self;
}

#pragma  mark - View LifeCycle

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self addObserver:self
           forKeyPath:@"book.favorite"
              options:NSKeyValueObservingOptionNew
              context:nil];
    
    
    [self syncViewAndModel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkFavoriteTag:) name:FAVORITE_NOTIFICATION object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void) viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self removeObserver:self
              forKeyPath:@"book.favorite"];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:FAVORITE_NOTIFICATION object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Targets

- (IBAction)openPdf:(id)sender {
    
    AGTPdfReaderViewController *PDFVc = [[AGTPdfReaderViewController alloc] initWithBook:self.book];
    
    [self.navigationController pushViewController:PDFVc animated:YES];
}

- (IBAction)markAsFavorite:(id)sender {
    
    self.book.favoriteValue = ![self.book.favorite boolValue];
    
}

- (IBAction)verNotas:(id)sender {
    
    AGTAnnotationsCollectionViewController *nVC = [[AGTAnnotationsCollectionViewController alloc] initWithAnnotations:[self.book.annotations allObjects]];
    
    [self.navigationController pushViewController:nVC animated:YES];
}


#pragma mark - Utils

-(void) syncViewAndModel {
    
    [self syncImage];
    self.titleLabel.text = self.book.title;
    self.authorsLabel.text = self.book.authors;
    self.title = self.book.title;
    [self updateFavoriteButtonWithBool:self.book.favoriteValue];
    
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

-(void) syncImage {
    
    if (!self.book.bookImage) {
        
        self.pdfImage.image = [UIImage imageNamed:@"libro_generico.png"];
        
        AGTLocalFile *localFile = [[AGTLocalFile alloc] init];
        [localFile dataWithURL:[NSURL URLWithString:self.book.bookUrl] completionBlock:^(NSData *data) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.book.bookImage = data;
                self.pdfImage.image = [UIImage imageWithData:data];
            });
        }];
    } else {
        self.pdfImage.image = [UIImage imageWithData:self.book.bookImage];
    }
    
}

#pragma mark - Notifications

-(void) checkFavoriteTag: (NSNotification *) notification {
    
    BOOL favorite = [[[notification userInfo] objectForKey:BOOK_KEY] favorite];
    
    [self updateFavoriteButtonWithBool:favorite];
    
}

#pragma  mark - AGTBooksTableViewControllerDelegate

-(void)booksTableViewController:(AGTLibraryViewController *)tabVC
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

#pragma mark - KVO

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context {
    
    BOOL favorite = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
    
    [self updateFavoriteButtonWithBool:favorite];
    
}


@end
