//
//  AGTPhotoViewController.h
//  HackerBooks
//
//  Created by Yago de la Fuente on 17/4/15.
//  Copyright (c) 2015 com.cininika. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AGTPhoto;

@interface AGTPhotoViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) AGTPhoto* photo;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;

-(id)initWithPhoto: (AGTPhoto *) photo;

- (IBAction)takePhoto:(id)sender;
- (IBAction)deletePhoto:(id)sender;

@end
