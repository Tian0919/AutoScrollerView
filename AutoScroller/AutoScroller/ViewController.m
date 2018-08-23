//
//  ViewController.m
//  AutoScroller
//
//  Created by XXX on 2018/8/23.
//

#import "ViewController.h"
#import "TAutoScrollerView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSArray *imageArr = @[[UIImage imageNamed:@"01"],
                          [UIImage imageNamed:@"02"],
                          [UIImage imageNamed:@"03"],
                          [UIImage imageNamed:@"04"],
                          [UIImage imageNamed:@"05"],
                          [UIImage imageNamed:@"06"],
                          [UIImage imageNamed:@"07"]];
    
    
    TAutoScrollerView *autoScroller = [[TAutoScrollerView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 300)];
   
    autoScroller.imageArr = imageArr;
    [self.view addSubview:autoScroller];
    
}


@end
