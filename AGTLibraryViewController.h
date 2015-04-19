//
//  AGTLibraryViewController.h
//  HackerBooks
//
//  Created by Yago de la Fuente on 14/4/15.
//  Copyright (c) 2015 com.cininika. All rights reserved.
//

#import "AGTCoreDataTableViewController.h"
@class AGTBook;
@class AGTLibraryViewController;

@protocol AGTLibraryViewControllerDelegate <NSObject>

@optional
-(void)booksTableViewController: (AGTLibraryViewController *)
tabVC didSelectedBook: (AGTBook *) book;

@end

@interface AGTLibraryViewController : AGTCoreDataTableViewController <AGTLibraryViewControllerDelegate>

@property (weak, nonatomic) id<AGTLibraryViewControllerDelegate> delegate;

@end
