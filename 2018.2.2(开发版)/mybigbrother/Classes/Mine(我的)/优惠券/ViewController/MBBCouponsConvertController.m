//
//  MBBCouponsConvertController.m
//  mybigbrother
//
//  Created by SN on 2017/4/5.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBCouponsConvertController.h"

@interface MBBCouponsConvertController ()
@property (nonatomic, strong) UITextField * convertText;
@end

@implementation MBBCouponsConvertController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"优惠券兑换";
    
    UITextField * convertText = [[UITextField alloc]init];
    convertText.placeholder = @"     请输入兑换码";
    convertText.clipsToBounds = YES;
    convertText.layer.cornerRadius = 3;
    convertText.layer.borderWidth = 0.5;
    convertText.layer.borderColor = BASE_CELL_LINE_COLOR.CGColor;
    [self.view addSubview:convertText];
    _convertText = convertText;
    /** 兑换*/
    UIButton * convertBtn = [[UIButton alloc] init];
    [convertBtn setTitle:@"去兑换" forState:UIControlStateNormal];
    convertBtn.clipsToBounds = YES;
    convertBtn.layer.cornerRadius = 3;
    [convertBtn setBackgroundImage:[UIImage imageWithColor:BUTTON_COLOR] forState:UIControlStateNormal];
    [convertBtn addTarget:self action:@selector(convertClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:convertBtn];
    
    convertText.sd_layout
    .topSpaceToView(self.view ,60)
    .leftSpaceToView(self.view,40)
    .widthIs(SCREEN_WIDTH - 80)
    .heightIs(44);
    
    convertBtn.sd_layout
    .topSpaceToView(convertText ,20)
    .leftSpaceToView(self.view,60)
    .widthIs(SCREEN_WIDTH - 120)
    .heightIs(44);
    
}
- (void)convertClicked{
    [self.view endEditing:YES];
    
    if (self.convertText.text.length == 0) {
        [MyControl alertShow:@"请您输入兑换码..."];
        return;
    }    
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"registerexchange";
    MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    paramDic[@"token"] = model.token;
    paramDic[@"code"] = self.convertText.text;

    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager userConvertCodeCoupons:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            [MBProgressHUD showSuccess:@"兑换成功" toView:self.view];
           
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            [MBProgressHUD showError:@"兑换失败,请您重新输入..." toView:self.view];
        }
        
    }];

    
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
