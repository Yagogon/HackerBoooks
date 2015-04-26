//
//  AGTAnnotationsCollectionViewController.m
//  HackerBooks
//
//  Created by Yago de la Fuente on 17/4/15.
//  Copyright (c) 2015 com.cininika. All rights reserved.
//

#import "AGTAnnotationsCollectionViewController.h"
#import "AGTAnnotation.h"
#import "AGTAnnotationCollectionViewCell.h"
#import "AGTPhoto.h"
#import "AGTBook.h"
#import "Constants.h"
#import "AGTAnnotationViewController.h"

@interface AGTAnnotationsCollectionViewController ()

@end

@implementation AGTAnnotationsCollectionViewController

static NSString * const reuseIdentifier = @"noteCell";

#pragma mark - Init

-(id) initWithAnnotations: (NSArray *) annotations {
    
    if (self = [super initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc]init]]) {
        _annotations = annotations;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onChangeNote:)
                                                     name:ANNOTATION_CHANGE_NOTIFICATION
                                                   object:nil];
        
    }
    
    return self;
}

#pragma mark -  View Lifecicle

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onChangeBook:)
                                                 name:BOOK_CHANGE_NOTIFICATION
                                               object:nil];
    
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self registerCell];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

-(void) viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
     ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.annotations.count;
}

-(void) registerCell{
    
    UINib *nib = [UINib nibWithNibName:@"AGTAnnotationCollectionViewCell"
                                bundle:nil];
    [self.collectionView registerNib:nib
          forCellWithReuseIdentifier:reuseIdentifier];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AGTAnnotationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    AGTAnnotation *note = [self.annotations objectAtIndex:indexPath.row];
    // Configure the cell
    
    cell.title.text = note.name;
    cell.photoView.image = [UIImage imageWithData:note.photo.photoData];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = self.collectionView.frame.size.height / 4;
    CGFloat width = self.collectionView.frame.size.width / 2.2;
    
    return CGSizeMake( width,  height);
}

#pragma mark - Notifications

-(void) onChangeBook: (NSNotification *) notification {
    
    AGTBook *book = [notification.userInfo objectForKey:BOOK_KEY];
    
    self.annotations = [book.annotations allObjects];
    
    [self.collectionView reloadData];
    
}

-(void)onChangeNote:(NSNotification *) notification {
    
    [self.collectionView reloadData];
    
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AGTAnnotation *note = [self.annotations objectAtIndex:indexPath.row];
    AGTAnnotationViewController *nVC = [[AGTAnnotationViewController alloc] initWithAnnotation:note];
    
    [self.navigationController pushViewController:nVC animated:YES];
    
}

@end
