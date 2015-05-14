//
//  FibTableViewController.h
//  Fibonacci
//
//  Created by Paul Newman on 5/12/15.
//  Copyright (c) 2015 Newman Zone. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FibTableViewDelegate <NSObject>

- (long)fibForIndex:(NSInteger)index limit:(NSInteger)limit;

@end

@interface FibTableViewController : UITableViewController

@end
