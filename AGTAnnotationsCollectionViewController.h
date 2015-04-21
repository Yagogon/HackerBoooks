//
//  AGTAnnotationsCollectionViewController.h
//  HackerBooks
//
//  Created by Yago de la Fuente on 17/4/15.
//  Copyright (c) 2015 com.cininika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGTLibraryViewController.h"

@interface AGTAnnotationsCollectionViewController : UICollectionViewController <AGTLibraryViewControllerDelegate>

@property (strong, nonatomic) NSArray *annotations;

-(id) initWithAnnotations: (NSArray *)array;

@end
