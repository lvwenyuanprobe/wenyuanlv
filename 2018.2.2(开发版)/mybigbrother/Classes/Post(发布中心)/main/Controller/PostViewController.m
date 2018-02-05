//
//  PostViewController.m
//  mybigbrother
//
//  Created by Loren on 2018/1/22.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "PostViewController.h"
#import "WYPostTypeView.h"
#import "WYPostType.h"


@interface PostViewController (){
    
    UIView *botView;
}
@property (nonatomic,strong)UIButton *btn;

@end

@implementation PostViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //         self.navBarBgAlpha = @"1.0";
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor yellowColor];
    
    [self setupUI];
    
}




- (void)setupUI{

    UIView *botView = [[UIView alloc] init];
    [self.view addSubview:botView];
    botView.backgroundColor = [UIColor whiteColor];
    [botView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(265);
    }];
    
    UILabel *popLabel = [[UILabel alloc] init];
    [botView addSubview:popLabel];
    popLabel.text = @"发布信息";
    popLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    popLabel.font = [UIFont systemFontOfSize:17.0];
    [popLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(botView);
        make.top.mas_equalTo(20);
    }];
    
    UIButton *popBtn = [[UIButton alloc] init];
    [botView addSubview:popBtn];
    [popBtn setImage:[UIImage imageNamed:@"sy_gb"] forState:UIControlStateNormal];
    [popBtn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [popBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(botView);
        make.bottom.mas_equalTo(-15);
    }];
    
    // 分类标签
    WYPostTypeView *businessTypeView = [[WYPostTypeView alloc] initWithFrame:CGRectMake(0, 65, self.view.bounds.size.width, 130)];
    businessTypeView.backgroundColor = [UIColor whiteColor];
    businessTypeView.postTypeData = [self loadBusinessTypeData];
    [botView addSubview:businessTypeView];
}

// 加载首页分类的本地数据
- (NSArray *)loadBusinessTypeData {
    
    NSArray *dictArr = [NSArray arrayWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"postType.plist" withExtension:nil]];
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:dictArr.count];
    [dictArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [arrayM addObject:[WYPostType businessTypeWithDict:obj]];
    }];
    return arrayM.copy;
}

- (void)pop
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end











