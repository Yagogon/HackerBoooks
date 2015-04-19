//
//  AGTPdfReaderViewController.h
//  HackerBooks
//
//  Created by Yago de la Fuente on 31/3/15.
//  Copyright (c) 2015 com.cininika. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AGTBook;

@interface AGTPdfReaderViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *browser;
@property (strong, nonatomic) AGTBook *book;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

-(id) initWithBook: (AGTBook *)book;
- (IBAction)createAnnotation:(id)sender;

@end
