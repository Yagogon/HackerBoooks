//
//  AGTBooksTableViewController.m
//  HackerBooks
//
//  Created by Yago de la Fuente on 30/3/15.
//  Copyright (c) 2015 com.cininika. All rights reserved.
//

#import "AGTBooksTableViewController.h"
#import "AGTLibrary.h"
#import "AGTBook.h"
#import "AGTBookViewController.h"
#import "AGTJSONUtils.h"
#import "AGTLocalFile.h"
#import "Constants.h"
#import "ReaderDocument.h"

@interface AGTBooksTableViewController ()

@end

@implementation AGTBooksTableViewController

#pragma mark - Init

-(id) initWithLibrary:(AGTLibrary *)library style:(UITableViewStyle)aStyle {
    
    if (self = [super initWithStyle:aStyle]) {
        _library = library;
        self.title = @"Biblioteca";
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(markAsFavorite:) name:FAVORITE_NOTIFICATION object:nil];
        
    }
    
    return self;
}

#pragma  mark - View LifeCycle

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
       UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(saveData:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:app];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void) viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidEnterBackgroundNotification
                                                  object:nil];    
}

-(void) dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:FAVORITE_NOTIFICATION object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return [self.library tagsCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    NSString *tag = [self.library tagWithSection:section];
    return [self.library bookCountForTag:tag];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"BookCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier];
    }
    
    NSString *tag = [self.library tagWithSection:indexPath.section];
    
    AGTBook *book = [self.library booksForTag:tag atIndex:indexPath.row];
    
    
    
    
    // Configure the cell...
    
    cell.textLabel.text = book.title;
    cell.detailTextLabel.text = [[book.authors valueForKey:@"description"] componentsJoinedByString:@","];
    
    cell.imageView.image = [UIImage imageWithData:[AGTLocalFile dataWithURL:book.photoURL]];
    
    return cell;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [self.library tagWithSection:section];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *tag = [self.library tagWithSection:indexPath.section];
    AGTBook *book = [self.library booksForTag:tag atIndex:indexPath.row];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center postNotificationName:BOOK_CHANGE_NOTIFICATION object:self userInfo:@{ BOOK_KEY : book }];
    
    [self.delegate booksTableViewController:self didSelectedBook:book];
    
}

#pragma mark - AGTBooksTableViewControllerDelegate

-(void)booksTableViewController:(AGTBooksTableViewController *)tabVC
                didSelectedBook:(AGTBook *)book {
    
    AGTBookViewController *bookVC = [[AGTBookViewController alloc] initWithBook:book];
    [self.navigationController pushViewController:bookVC animated:YES];
    
}

#pragma mark - Notifications

-(void) markAsFavorite: (NSNotification *) notification {
    
    AGTBook *book = [[notification userInfo] objectForKey:BOOK_KEY];
    
    [self.library updateFavoriteTag:book];
    [self.tableView reloadData];
}

-(void) saveData: (NSNotification *) notification {
    
    [AGTJSONUtils saveJSONWithArray:[self.library asJSONArray]];
}

@end
