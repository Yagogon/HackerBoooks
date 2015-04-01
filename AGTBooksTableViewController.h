//
//  AGTBooksTableViewController.h
//  HackerBooks
//
//  Created by Yago de la Fuente on 30/3/15.
//  Copyright (c) 2015 com.cininika. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AGTLibrary;
@class AGTBook;
@class AGTBooksTableViewController;

@protocol AGTBooksTableViewControllerDelegate <NSObject>

@optional
-(void)booksTableViewController: (AGTBooksTableViewController *)
          tabVC didSelectedBook: (AGTBook *) book;

@end

@interface AGTBooksTableViewController : UITableViewController <AGTBooksTableViewControllerDelegate>

@property (strong, nonatomic) AGTLibrary *library;
@property (weak, nonatomic) id<AGTBooksTableViewControllerDelegate> delegate;

-(id) initWithLibrary: (AGTLibrary *)library style: (UITableViewStyle) aStyle;

@end
