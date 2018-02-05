//
//  MBBCommitOrderController.m
//  mybigbrother
//
//  Created by SN on 2017/4/6.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBCommitOrderController.h"
#import "MyJudgeTopView.h"
#import "OrderInfoCell.h"

#import "CustomServiceDetailBottomView.h"
#import "MBBCollectMoneyController.h"
#import "InputTextView.h"
#import "MBBDatePicker.h"

#import "MBBAboutUsController.h"

typedef NS_ENUM (NSInteger, KDatePickerType){
    KDatePickerBirthDay = 100,
    KDatePickerSeverDay,
};

@interface MBBCommitOrderController ()<UITableViewDelegate,
UITableViewDataSource,
CustomServiceDetailBottomViewDelegate,
MBBDatePickerDelegate,
LCActionSheetDelegate,
OrderInfoCellDelegate>
@property(nonatomic, strong) UITableView * menuTableView;
@property(nonatomic, strong) NSArray *menuDatas;
@property(nonatomic, strong) NSMutableArray *leftDatas;

@property (nonatomic, strong) CustomServiceDetailBottomView * bottomView;
@property (nonatomic, strong) NSIndexPath * currentIndexPath;

@property (nonatomic, strong) NSMutableDictionary * infoDic;
@end

@implementation MBBCommitOrderController
#pragma mark - 重写loadView() 重置self.view 解决IQkeyBoard导航栏漂移
-(void)loadView{
    UIScrollView * scr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scr.backgroundColor = [UIColor whiteColor];
    self.view = scr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"提交订单";
    
    MyJudgeTopView * topView = [[MyJudgeTopView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140)];
    topView.model = self.model;
    
    
    
    _menuDatas  = [NSArray array];

    _menuDatas  = @[@"姓名*",
                    @"性别*",
                    @"出生年月*",
                    @"联系电话*",
                    @"微信/QQ*",
                    @"邮箱*",
                    @"紧急联系人电话*",
                    @"就读国家*",
                    @"就读院校*",
                    @"服务日期*",
                    @"备注",
                    ];
    _leftDatas  = [NSMutableArray arrayWithArray:@[@"请输入本人姓名",
                    @"请选择",
                    @"请选择",
                    @"请输入联系电话(手机)",
                    @"请输入微信或QQ号码",
                    @"请输入邮箱地址",
                    @"请输入便于随时联系",
                    @"请填写",
                    @"请填写",
                    @"请选择",
                    @"请写下您的其他需求",
                    ]];
    
    _menuTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44 - 64)style:UITableViewStylePlain];
    _menuTableView.delegate = self;
    _menuTableView.dataSource = self;
    _menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_menuTableView];
    self.menuTableView.tableHeaderView = topView;
    
    UILabel * explain = [[UILabel alloc]init];
    explain.text = @"    点击去付款表示你已阅读并同意留学大师兄重要条款>>";
    explain.textColor = FONT_LIGHT;
    explain.font = MBBFONT(10);
    explain.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    
    UITapGestureRecognizer * explianDetailTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoPayExplainDetail)];
    explain.userInteractionEnabled = YES;
    [explain addGestureRecognizer:explianDetailTap];
    self.menuTableView.tableFooterView = explain;
    
    CustomServiceDetailBottomView * bottomView;
    if (kDevice_Is_iPhoneX) {
        bottomView = [[CustomServiceDetailBottomView alloc]initWithFrame:CGRectMake(0,
                                                                                    SCREEN_HEIGHT - 64 - 45 - 20,
                                                                                    SCREEN_WIDTH,
                                                                                    44)
                      
                                                              rightTitle:@"去付款"];
    }else{
        bottomView = [[CustomServiceDetailBottomView alloc]initWithFrame:CGRectMake(0,
                                                                                    SCREEN_HEIGHT - 64 - 45,
                                                                                    SCREEN_WIDTH,
                                                                                    44)
                      
                                                              rightTitle:@"去付款"];
    }
    
    bottomView.delegate = self;
    bottomView.servicePrice = [NSString stringWithFormat:@"总价:$ %@",self.price];
    _bottomView = bottomView;
    
    [self.view addSubview:bottomView];
    self.infoDic = [NSMutableDictionary dictionary];
}

-(BOOL)prefersHomeIndicatorAutoHidden{
    return YES;
}

#pragma mark - 支付条款
- (void)gotoPayExplainDetail{
    MBBAboutUsController * explainDetail = [[MBBAboutUsController alloc]init];
    explainDetail.loadType = @"4";
    [self.navigationController pushViewController:explainDetail animated:YES];
    
}
#pragma mark - bottomViewDelegate
- (void)rihgtButtonClicked{
    for (int i = 0 ; i < _leftDatas.count; i ++ ) {
        NSIndexPath * path = [NSIndexPath indexPathForRow:i inSection:0];
        OrderInfoCell * cell = [self.menuTableView cellForRowAtIndexPath:path];
        NSString * content = cell.rightField.text;
        /** 联系人姓名*/
        if (i  == 0) {
            self.infoDic[@"name"] = content;
        }
        /** 性别*/
        if (i   == 1) {
            if ([content isEqualToString:@"男"]) {
                self.infoDic[@"ma_sex"] = @(1);
            }
            if ([content isEqualToString:@"女"]) {
                self.infoDic[@"ma_sex"] = @(2);
            }
            
        }
        /** 生日*/
        if (i   == 2) {
            self.infoDic[@"birthday"] = content;
        }
        /** 手机号*/
        if (i   == 3 || i == 6) {
            if(![MyControl isPhoneNumber:content]){
                [MyControl alertShow:@"请输入正确的手机号码"];
                return;
            }
        }
        if (i == 3) {
            self.infoDic[@"mobile"] = content;
        }
        /** QQ Wechat*/
        if (i   == 4) {
            self.infoDic[@"qq"] = content;
            
        }
        /** 邮箱*/
        if (i   == 5) {
            if (![MyControl validateEmail:content]) {
                [MyControl alertShow:@"请确认邮箱"];
                return;
            }
            self.infoDic[@"email"] = content;
        }
        
        if (i == 6) {
            self.infoDic[@"urgent_phone"] = content;
        }
        /** 国家*/
        if (i   == 7) {
            self.infoDic[@"country"] = content;
            
        }
        /** 学校*/
        if (i   == 8) {
            self.infoDic[@"school"] = content;
            
        }
        /** 服务日期*/
        if (i  == 9) {
            
            self.infoDic[@"date"] = content;
        }
        /** 备注*/
        if (i  == 10) {
            self.infoDic[@"remarks"] = content;
            
        }
    }
    
#warning
#pragma mark  - || 之后字段与_leftDatas 中原始数据相匹配    
    //0
    if ([self.infoDic[@"name"] isEqualToString:@""] ||[self.infoDic[@"name"] isEqualToString:@"请输入本人姓名"]) {
        [MyControl alertShow:@"请您输入姓名"];
        return;
    }
    //1
    if ([self.infoDic[@"ma_sex"]isEqual:@""]||[self.infoDic[@"ma_sex"] isEqual:@"请选择"]) {
        [MyControl alertShow:@"请您选择性别"];
        return;
    }
    //2
    if ([self.infoDic[@"birthday"]isEqualToString:@""]||[self.infoDic[@"birthday"] isEqualToString:@"请选择"]) {
        [MyControl alertShow:@"请您选择出生年月"];
        return;
    }
    //3
    if ([self.infoDic[@"mobile"]isEqualToString:@""]||[self.infoDic[@"mobile"] isEqualToString:@"请输入联系电话(手机)"]) {
        [MyControl alertShow:@"请您输入联系电话"];
        return;
    }
    //4
    if ([self.infoDic[@"qq"]isEqualToString:@""]||[self.infoDic[@"qq"] isEqualToString:@"请输入微信或QQ号码"]) {
        [MyControl alertShow:@"请您输入微信/QQ"];
        return;
    }
    //5
    if ([self.infoDic[@"email"]isEqualToString:@""]||[self.infoDic[@"email"] isEqualToString:@"请输入邮箱地址"]) {
        [MyControl alertShow:@"请您输入邮箱"];
        return;
    }
    //6
    if ([self.infoDic[@"urgent_phone"]isEqualToString:@""]||[self.infoDic[@"urgent_phone"] isEqualToString:@"请输入便于随时联系"]) {
        [MyControl alertShow:@"请您输入紧急联系人"];
        return;
    }
    //7
    if ([self.infoDic[@"country"]isEqualToString:@""]||[self.infoDic[@"country"] isEqualToString:@"请填写"]) {
        [MyControl alertShow:@"请您输入就读国家"];
        return;
    }
    //8
    if ([self.infoDic[@"school"]isEqualToString:@""]||[self.infoDic[@"school"] isEqualToString:@"请填写"]) {
        [MyControl alertShow:@"请您输入学校"];
        return;
    }
    //9
    if ([self.infoDic[@"date"]isEqualToString:@""]||[self.infoDic[@"date"] isEqualToString:@"请选择"]) {
        [MyControl alertShow:@"请您选择服务日期"];
        return;
    }
    
    MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    self.infoDic[@"token"] = model.token;
    
    self.infoDic[@"sign"] = @"indexpurchase";
    /** 定制服务 1*/
    self.infoDic[@"f_id"] = @(1);
    self.infoDic[@"or_price"] = self.price;
    self.infoDic[@"ma_id"] = self.ma_id;

    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager userBuyService:self.infoDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            [MBProgressHUD showSuccess:@"成功" toView:self.view];
            
            MBBCollectMoneyController * collectVC = [[MBBCollectMoneyController alloc]init];
            collectVC.serviceId = self.ma_id;
            collectVC.orderId = request.responseJSONObject[@"data"][@"or_id"];
            collectVC.orderPrice = self.price;
            [self.navigationController pushViewController:collectVC animated:YES];
            
        }else{
            
            [MBProgressHUD showError:@"失败" toView:self.view];
        }
        
    }];
    
}
#pragma mark - cellDelegate
- (void)rightFieldDidEndEdit:(OrderInfoCell *)cell{
    
    [_leftDatas replaceObjectAtIndex:cell.cellIndexPath.row withObject:cell.rightField.text];
    [self.menuTableView reloadData];
}

#pragma mark - delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _menuDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"PersonalInfoCell";
    
    OrderInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[OrderInfoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.leftLabel.text  = _menuDatas[indexPath.row];
    cell.rightField.text = _leftDatas[indexPath.row];
    
    cell.cellDelegate = self;
    cell.cellIndexPath = indexPath;
    
    
    if (indexPath.row == 10) {
        cell.leftLabel.textColor = FONT_DARK;
    }else{
        cell.leftLabel.textColor = [UIColor redColor];
        cell.leftLabel.attributedText = [MyControl originalStr:cell.leftLabel.text position:1 color:FONT_DARK];
    }
    
    /** 联系方式*/
    if (indexPath.row == 3 || indexPath.row == 6 ) {
        cell.rightField.keyboardType = UIKeyboardTypePhonePad;
        
    }else{
        cell.rightField.keyboardType = UIKeyboardTypeDefault;
    }
    
    /** 生日 性别 服务时间*/
    if (indexPath.row == 1 ||
        indexPath.row == 2 ||
        indexPath.row == 9) {
        cell.rightField.userInteractionEnabled = NO;
    }else{
        cell.rightField.userInteractionEnabled = YES;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.currentIndexPath = indexPath;
 
    if (indexPath.row == 1){
        LCActionSheet * sheet  = [[LCActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"男",@"女", nil];
        [sheet show];

    }
    if (indexPath.row == 2){
        /** 选择出生日期*/
        MBBDatePicker * picker = [[MBBDatePicker alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        picker.datePicker.datePickerMode = UIDatePickerModeDate;
        picker.datePicker.maximumDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
        picker.delegate = self;
        picker.tag = KDatePickerBirthDay;
        [self.view addSubview:picker];
        
    }
    if (indexPath.row == 9){
        /** 选择服务日期*/
        MBBDatePicker * picker = [[MBBDatePicker alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        picker.datePicker.datePickerMode = UIDatePickerModeDate;
        picker.datePicker.minimumDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
        picker.datePicker.maximumDate = [NSDate distantFuture];
        picker.delegate = self;
        picker.tag = KDatePickerSeverDay;
        [self.view addSubview:picker];
    }
}
#pragma mark -MBBDatePickerDelegate
- (void)datePickerSureClick:(NSString *)dateStr view:(MBBDatePicker *)picker{
    
//    if (KDatePickerBirthDay == picker.tag) {
//        OrderInfoCell * cell = [self.menuTableView cellForRowAtIndexPath:self.currentIndexPath];
//        cell.rightField.text = dateStr;
//        self.infoDic[@"birthday"] = dateStr;
//        
//    }
//    /** 服务日期*/
//    if (KDatePickerSeverDay == picker.tag) {
//        OrderInfoCell * cell = [self.menuTableView cellForRowAtIndexPath:self.currentIndexPath];
//        cell.rightField.text = dateStr;
//        self.infoDic[@"date"] = dateStr;
//    }
    NSString * dateSub = [dateStr substringToIndex:10];
    OrderInfoCell * cell = [self.menuTableView cellForRowAtIndexPath:self.currentIndexPath];
    cell.rightField.text = dateSub;
    [_leftDatas replaceObjectAtIndex:self.currentIndexPath.row withObject:dateSub];
    [self.menuTableView reloadData];

}
#pragma mark - LCAtionSheetDelegate

- (void)actionSheet:(LCActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        /** 男*/
//        OrderInfoCell * cell = [self.menuTableView cellForRowAtIndexPath:self.currentIndexPath];
//        cell.rightField.text = @"男";
//        self.infoDic[@"ma_sex"] = @(1);
        OrderInfoCell * cell = [self.menuTableView cellForRowAtIndexPath:self.currentIndexPath];
        cell.rightField.text = @"男";
        [_leftDatas replaceObjectAtIndex:self.currentIndexPath.row withObject:cell.rightField.text];
        [self.menuTableView reloadData];


    }
    if (buttonIndex == 2) {
        /** 女*/
//        OrderInfoCell * cell = [self.menuTableView cellForRowAtIndexPath:self.currentIndexPath];
//        cell.rightField.text = @"女";
//        self.infoDic[@"ma_sex"] = @(2);
        
        OrderInfoCell * cell = [self.menuTableView cellForRowAtIndexPath:self.currentIndexPath];
        cell.rightField.text = @"女";
        [_leftDatas replaceObjectAtIndex:self.currentIndexPath.row withObject:cell.rightField.text];
        [self.menuTableView reloadData];

    }
    
}
#pragma mark - 拖拽弹回
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
