//
//  AGTAnnotationViewController.h
//  HackerBooks
//
//  Created by Yago de la Fuente on 17/4/15.
//  Copyright (c) 2015 com.cininika. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AGTAnnotation;


@interface AGTAnnotationViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) AGTAnnotation *annotation;
@property (weak, nonatomic) IBOutlet UIToolbar *bottomBar;

- (IBAction)displayPhoto:(id)sender;
-(id) initWithAnnotation: (AGTAnnotation *) annotation;

@end
