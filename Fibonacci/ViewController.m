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

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.fibonacciNumbers = [NSMutableDictionary new];
    
    [self.submitButton addTarget:self action:@selector(submitButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button handlers

- (void)submitButtonTapped:(id)sender
{
    NSLog(@"seed number: %@", self.inputTextField.text);
    
    NSInteger startPosition = [self.inputTextField.text integerValue];
    NSInteger endPosition = startPosition + 20;
    
    while (startPosition < endPosition) {
        
        if (startPosition == 0){
            NSLog(@"value: %@", @(startPosition));
        }
        else{
            NSInteger returnValue = [self generateFibonacciSequence:startPosition];
            NSLog(@"value: %@", @(returnValue));
        }
        
        startPosition++;
    }
}

#pragma mark - Helper methods

- (NSInteger)generateFibonacciSequence:(NSInteger)seedNumber
{
    if (seedNumber <= 2) {
        return 1;
    }
    
    if (self.fibonacciNumbers[@(seedNumber)]) {
        return [self.fibonacciNumbers[@(seedNumber)] intValue];
    }
    
    NSInteger returnValue = [self generateFibonacciSequence:seedNumber-1] + [self generateFibonacciSequence:seedNumber-2];
    self.fibonacciNumbers[@(seedNumber)] = @(returnValue);
    
    return returnValue;
}

@end
