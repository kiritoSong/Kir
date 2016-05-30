//
//  ViewController.m
//  FilterTest
//
//  Created by kirito_song on 16/5/19.
//  Copyright © 2016年 kirito_song. All rights reserved.
//

#import "ViewController.h"
#import "FilterViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.navigationController pushViewController:[FilterViewController new] animated:YES];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
