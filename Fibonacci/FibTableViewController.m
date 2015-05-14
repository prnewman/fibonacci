//
//  FibTableViewController.m
//  Fibonacci
//
//  Created by Paul Newman on 5/12/15.
//  Copyright (c) 2015 Newman Zone. All rights reserved.
//

#import "FibTableViewController.h"

@interface FibTableViewController ()

@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger offset;
@property (nonatomic, assign) NSInteger limit;

@end

@implementation FibTableViewController

static NSString *CellIdentifier = @"CellIdentifier";
static const NSInteger kDefaultPageSize = 40;

- (instancetype)init
{
    self = [super init];
    if (self) {
        // initialization
        self.limit = kDefaultPageSize;
        self.offset = 0;
        self.datasource = [NSMutableArray new];
        
        [self requestMoreData];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)offsetForPage:(NSInteger)page
{
    NSInteger offset = 0;
    
    if (page > 0) {
        offset = (page * self.limit);
    }
    
    return offset;
}

- (void)requestMoreData
{
    self.offset = [self offsetForPage:self.currentPage];
    [self requestDataWithLimit:self.limit offset:self.offset];
    
    self.currentPage++;
}

- (void)requestDataWithLimit:(NSInteger)limit offset:(NSInteger)offset
{
    // get fibonacci numbers
    NSInteger startIndex = offset;
    NSInteger endIndex = startIndex + limit;
    
    while (startIndex < endIndex) {
        
        long fib = [self fibonacci:startIndex];
        [self.datasource addObject:@(fib)];
        
        startIndex++;
    }
    
    [self.tableView reloadData];
}

#pragma mark - Helper methods

// http://rosettacode.org/wiki/Fibonacci_sequence#Objective-C
- (long)fibonacci:(NSInteger)index
{
    long beforeLast = 0;
    long last = 1;
    
    while (index > 0) {
        last += beforeLast;
        beforeLast = last - beforeLast;
        --index;
    }
    return last;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = self.datasource.count;
    
    return count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row == self.datasource.count) { // 40, 80, etc.
        cell.textLabel.text = @"Loading...";
    }
    else{
        NSNumber *fib = self.datasource[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ value: %lu", @(indexPath.row), [fib longValue]];
    }

    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.datasource.count) {
        [self requestMoreData];
    }
}

@end
