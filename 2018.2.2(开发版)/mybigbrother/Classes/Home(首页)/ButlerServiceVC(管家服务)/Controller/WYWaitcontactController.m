//
//  WYWaitcontactController.m
//  mybigbrother
//
//  Created by Loren on 2018/1/26.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "WYWaitcontactController.h"
#import "WYWaitContactHeaderView.h"
#import "HBBButlerServiceViewController.h"
#import "MBBCrisisHandlingViewController.h"

@interface WYWaitcontactController ()

@end

@implementation WYWaitcontactController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
    self.hidesBottomBarWhenPushed = YES;
    [self setBackBtn];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    self.title = @"等待联系";
    self.navigationItem.hidesBackButton = YES;
    [self setupUI];
}

- (void)setupUI{
    
    UIView *bgView = [[UIView alloc] init];
    [self.view addSubview:bgView];
    bgView.backgroundColor = [UIColor whiteColor];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(260);
    }];
    bgView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    bgView.layer.shadowOffset = CGSizeMake(5,5);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    bgView.layer.shadowOpacity = 0.1;//阴影透明度，默认0
    bgView.layer.shadowRadius = 2;//阴影半径，默认3
    
    WYWaitContactHeaderView *waitContactView = [[WYWaitContactHeaderView alloc] init];
    [bgView addSubview:waitContactView];
    [waitContactView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sq_cg"]];
    [bgView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView);
        make.top.mas_equalTo(80);
    }];
    
    UILabel *conmmitS = [[UILabel alloc] init];
    [bgView addSubview:conmmitS];
    conmmitS.text = @"提交成功";
    conmmitS.font = [UIFont systemFontOfSize:17.0f];
    conmmitS.textColor = [UIColor colorWithHexString:@"#fb6030"];
    [conmmitS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imgView);
        make.top.equalTo(imgView.mas_bottom).offset(20);
    }];
    
    UILabel *waitS = [[UILabel alloc] init];
    [bgView addSubview:waitS];
    waitS.text = @"等待我们的联系";
    waitS.font = [UIFont systemFontOfSize:14.0f];
    waitS.textColor = [UIColor colorWithHexString:@"#999999"];
    [waitS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imgView);
        make.top.equalTo(conmmitS.mas_bottom).offset(10);
    }];
    
    
    
    UIButton *sureBtn = [[UIButton alloc] init];
    [self.view addSubview:sureBtn];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    sureBtn.backgroundColor = [UIColor colorWithHexString:@"#fb6030"];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [sureBtn addTarget:self action:@selector(sureBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.left.right.mas_equalTo(0);
        make.top.equalTo(bgView.mas_bottom).offset(20);
    }];
    
}

- (void)sureBtn:(UIButton *)sender
{
    NSLog(@"确定");
    
    //返回到指定的控制器：遍历一遍子控制器，判断一下哪个是要返回的控制器，进行返回
    
    for(UIViewController *controller in self.navigationController.viewControllers) {
        
        if([controller isKindOfClass:[HBBButlerServiceViewController class]])
        {
            [self.navigationController popToViewController:controller animated:YES];
            
        }else if ([controller isKindOfClass:[MBBCrisisHandlingViewController class]]){
            
             [self.navigationController popToViewController:controller animated:YES];
        }
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 自定义返回按钮 -

- (void)setBackBtn
{
    //返回按钮
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.adjustsImageWhenHighlighted = NO;
    leftButton.frame=CGRectMake(0, 0, 60, 30);
    [leftButton setImage:[UIImage imageNamed:@"backLeft"] forState:UIControlStateNormal];
    //设置返回按钮的图片，跟系统自带的“<”符合保持一致
    [leftButton addTarget:self action:@selector(back_click) forControlEvents:UIControlEventTouchUpInside];
    //图片 居左，
    [leftButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    //ios7.0系统中，自定义的返回按钮 有点 偏右，需要调整位置
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0))
    {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           
                                                                                       target:nil action:nil];
        negativeSpacer.width = -8;//这个数值可以根据情况自由变化
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftItem];
    }else
    {
        self.navigationItem.leftBarButtonItem = leftItem;
    }
}
- (void)back_click
{
    // 返回上一级页面
    [self.navigationController popViewControllerAnimated:YES];
}

@end
