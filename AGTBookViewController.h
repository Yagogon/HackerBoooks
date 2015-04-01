//
//  AGTBookViewController.h
//  HackerBooks
//
//  Created by Yago de la Fuente on 31/3/15.
//  Copyright (c) 2015 com.cininika. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AGTBook;
#import "AGTBooksTableViewController.h"

@interface AGTBookViewController : UIViewController <AGTBooksTableViewControllerDelegate, UISplitViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *pdfImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorsLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagsLabel;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;

@property (strong, nonatomic) AGTBook *book;

- (IBAction)openPdf:(id)sender;
- (IBAction)markAsFavorite:(id)sender;

-(id) initWithBook: (AGTBook *) book;

@end
