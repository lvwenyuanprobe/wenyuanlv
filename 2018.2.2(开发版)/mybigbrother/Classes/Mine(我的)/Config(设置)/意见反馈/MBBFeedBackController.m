//
//  MBBFeedBackController.m
//  mybigbrother
//
//  Created by SN on 2017/3/31.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBFeedBackController.h"
#import "MBBCustomTextView.h"

@interface MBBFeedBackController ()<UITextViewDelegate>
{
    MBBCustomTextView * feedBackTextView;
    
}


@end

@implementation MBBFeedBackController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"意见反馈";
    [self setupViews];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)setupViews{
    
    /** 意见输入框*/
    feedBackTextView = [[MBBCustomTextView alloc] initWithFrame:CGRectMake(0,
                                                                           10,
                                                                           SCREEN_WIDTH,
                                                                           200)
                                                 andPlaceholder:@"请留下您的宝贵建议或意见。"
                                            andPlaceholderColor:FONT_LIGHT];
    [self.view addSubview:feedBackTextView];
    feedBackTextView.layer.borderWidth = 0.5;
    feedBackTextView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    feedBackTextView.textColor = BASE_COLOR;
    feedBackTextView.font = [UIFont systemFontOfSize:17];
    feedBackTextView.backgroundColor = [UIColor whiteColor];
    feedBackTextView.keyboardType = UIKeyboardTypeDefault;
    feedBackTextView.delegate = self;
    [feedBackTextView becomeFirstResponder];
    UIButton * btn = [[UIButton alloc] init];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#fb6030"]] forState:UIControlStateNormal];
//    btn.clipsToBounds = YES;
//    btn.layer.cornerRadius = 3;
    [btn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
}

- (void)submit{
    if (feedBackTextView.text.length == 0) {
        [MyControl alertShow:@"请输入反馈意见"];
        return;
    }
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"indexfeedback";
    paramDic[@"content"] = feedBackTextView.text;
    
    MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    if (model.token) {
        paramDic[@"token"] = model.token;
    }
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager userOpinionFeedBack:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            
            [MBProgressHUD showSuccess:@"发送成功" toView:self.view];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
           
            [MBProgressHUD showError:@"发送失败" toView:self.view];
        }
        
    }];

}

-(BOOL)prefersHomeIndicatorAutoHidden{
    return YES;
}


- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event{
    [feedBackTextView resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
