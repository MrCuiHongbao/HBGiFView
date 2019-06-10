//
//  HBViewController.m
//  HBGifView
//
//  Created by MrCuiHongbao on 06/06/2019.
//  Copyright (c) 2019 MrCuiHongbao. All rights reserved.
//

#import "HBViewController.h"
#import "HBGifView.h"
@interface HBViewController ()

@end

@implementation HBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"timg" ofType:@"gif"];
    HBGifView *gifVuew = [[HBGifView alloc] initWithFrame:CGRectMake(0, 0, 100,100) WithGifPath:path];
    [self.view addSubview:gifVuew];
    gifVuew.center = self.view.center;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
