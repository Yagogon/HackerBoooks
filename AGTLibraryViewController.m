//
//  AGTLibraryViewController.m
//  HackerBooks
//
//  Created by Yago de la Fuente on 14/4/15.
//  Copyright (c) 2015 com.cininika. All rights reserved.
//

#import "AGTLibraryViewController.h"
#import "AGTBook.h"
#import "AGTTag.h"
#import "AGTLocalFile.h"
#import "AGTBookViewController.h"
#import "Constants.h"

@interface AGTLibraryViewController ()

@end

@implementation AGTLibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) updateTable :(NSNotification *) n {
    
    NSError *error;
    [self.fetchedResultsController performFetch:&error];
}

#pragma mark - Table Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];

    AGTTag *tag = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    return tag.books.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"BookCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier];
    }
    
    AGTTag *tag = [self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section]];
    
    AGTBook *book =[[tag.books allObjects] objectAtIndex:indexPath.row];
    
    // Configure the cell...
    
    cell.textLabel.text = book.title;
    cell.detailTextLabel.text = book.authors;
    
    [self updateImageWithCell:cell book:book];
    
    return cell;
    
    
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    AGTTag *tag = [self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section]];
    
    AGTBook *book =[[tag.books allObjects] objectAtIndex:indexPath.row];
    
    [self.delegate booksTableViewController:self didSelectedBook:book];

    [[NSNotificationCenter defaultCenter] postNotificationName:BOOK_CHANGE_NOTIFICATION
                                                        object:self
                                                      userInfo:@{ BOOK_KEY : book }];

}

#pragma mark - AGTBooksTableViewControllerDelegate

-(void)booksTableViewController:(AGTLibraryViewController *)tabVC
                didSelectedBook:(AGTBook *)book {

    AGTBookViewController *bookVC = [[AGTBookViewController alloc] initWithBook:book];
    [self.navigationController pushViewController:bookVC animated:YES];

}

#pragma mark - Utils

-(void) updateImageWithCell: (UITableViewCell *) cell book: (AGTBook *) book {
    
    if (!book.bookImage) {
        
        cell.imageView.image = [UIImage imageNamed:@"libro_generico.png"];
        
        AGTLocalFile *localFile = [[AGTLocalFile alloc] init];
        [localFile dataWithURL:[NSURL URLWithString:book.bookUrl] completionBlock:^(NSData *data) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                book.bookImage = data;
                cell.imageView.image = [UIImage imageWithData:data];
            });
        }];
    } else {
         cell.imageView.image = [UIImage imageWithData:book.bookImage];
    }
}

@end
