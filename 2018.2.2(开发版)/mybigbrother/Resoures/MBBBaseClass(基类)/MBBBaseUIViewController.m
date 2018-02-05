//
//  MBBBaseUIViewController.m
//  mybigbrother
//
//  Created by SN on 2017/3/30.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBBaseUIViewController.h"

@interface MBBBaseUIViewController ()

@end

@implementation MBBBaseUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)pushViewControllerAndHiddenTabbar:(id)viewController
{
    Class clazz = NULL;
    if ([viewController class] == viewController) {
        clazz = viewController;
    }else if([viewController isKindOfClass:[NSString class]]){
        clazz = NSClassFromString(viewController);
    }
    UIViewController *vc = nil;
    if (clazz) {
        vc = [[clazz alloc]init];
    }else{
        vc = viewController;
    }
    
    //push时影响下级页面tabbar的显示
    self.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
    //    pop时影响自己的页面的tabbar显示；
    if (self.navigationController.viewControllers.count == 2) {
        self.hidesBottomBarWhenPushed = NO;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
