//
//  MBBPublishInputController.m
//  mybigbrother
//
//  Created by SN on 2017/4/14.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBPublishInputController.h"

@interface MBBPublishInputController ()
@property (nonatomic, strong) MBBCustomTextView * changeInfo;

@end

@implementation MBBPublishInputController
-(void)setNavTitle:(NSString *)navTitle{
    _navTitle = navTitle;
    self.navigationItem.title = _navTitle;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    /** 保存*/
    UIButton * seeRuleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 17)];
    [seeRuleBtn setTitle:@"确定" forState:UIControlStateNormal];
    [seeRuleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [seeRuleBtn.titleLabel setFont:MBBFONT(15)];
    [seeRuleBtn addTarget:self action:@selector(keepInfo) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * selectBar = [[UIBarButtonItem alloc] initWithCustomView:seeRuleBtn];
    self.navigationItem.rightBarButtonItem = selectBar;
    
    UIView * mainView =[[UIView alloc]initWithFrame:CGRectMake(0,
                                                               10,
                                                               SCREEN_WIDTH,
                                                               40)];
    mainView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mainView];
    
    MBBCustomTextView * changeInfo = [[MBBCustomTextView alloc]initWithFrame:CGRectMake(15,
                                                                                        5,
                                                                                        SCREEN_WIDTH - 30,
                                                                                        30)
                                                              andPlaceholder:@"请输入"
                                                         andPlaceholderColor:FONT_LIGHT];
    [mainView addSubview:changeInfo];
    _changeInfo = changeInfo;
    changeInfo.placeholderLabel.text = _placeholder?_placeholder:@"请输入";
    
    // Do any additional setup after loading the view.
}
- (void)keepInfo{
    [self.view endEditing:YES];
    self.changeStrBlock(_changeInfo.text);
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
