//
//  ViewController.m
//  Fibonacci
//
//  Created by Paul Newman on 9/17/14.
//  Copyright (c) 2014 Newman Zone. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (nonatomic, strong) NSMutableDictionary *fibonacciNumbers;

@end

@implementation ViewController

static const NSInteger kMaxResults = 40;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.fibonacciNumbers = [NSMutableDictionary new];
    
    [self.submitButton addTarget:self action:@selector(submitButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button handlers

- (void)submitButtonTapped:(id)sender
{
//    NSLog(@"start index: %@", self.inputTextField.text);
    
    NSInteger startIndex = [self.inputTextField.text intValue];
    NSInteger endIndex = startIndex + kMaxResults;
    
    NSLog(@"Sequence:\n\n");
    
    while (startIndex < endIndex) {
        
        long returnValue = [self getFibonacciNumberAtIndex:startIndex];
        NSLog(@"value: %@", @(returnValue));

        startIndex++;
    }
}

#pragma mark - Helper methods

// Changed NSInteger to long because Fibonacci numbers get so large
- (long)getFibonacciNumberAtIndex:(long)n
{
    if (n <= 2) {
        return (n == 0) ? n : 1;
    }
    
    if (self.fibonacciNumbers[@(n)]) {
        return [self.fibonacciNumbers[@(n)] longValue];
    }
    
    long returnValue = [self getFibonacciNumberAtIndex:n-1] + [self getFibonacciNumberAtIndex:n-2];
    // cache result for performance
    self.fibonacciNumbers[@(n)] = @(returnValue);
    
    return returnValue;
}

@end
