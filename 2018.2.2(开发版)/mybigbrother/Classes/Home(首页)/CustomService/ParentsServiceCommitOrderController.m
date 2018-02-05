//
//  ParentsServiceCommitOrderController.m
//  mybigbrother
//
//  Created by SN on 2017/6/15.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "ParentsServiceCommitOrderController.h"

#import "MyJudgeTopView.h"
#import "OrderInfoCell.h"
#import "CustomServiceDetailBottomView.h"
#import "MBBCollectMoneyController.h"
#import "InputTextView.h"
#import "MBBDatePicker.h"
#import "MBBAboutUsController.h"


typedef NS_ENUM (NSInteger, KDatePickerType){
    KDatePickerDistanceDay = 100,
};


@interface ParentsServiceCommitOrderController()<UITableViewDelegate,
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

@implementation ParentsServiceCommitOrderController
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
    topView.SPCommitOrderModel = self.model;
    
    
    
    _menuDatas  = [NSArray array];
    
    _menuDatas  = @[@"姓名*",
                    @"性别*",
                    @"手机号*",
                    @"QQ/微信",
                    @"意向国家*",
                    
                    @"出行城市*",
                    @"子女学校",
                    @"行程时间*",
                    @"出行人数*",
                    
                    @"预算范围",
                    @"出行目的",
                    @"个性需求",
                    @"上传文件",
                    @"咨询客服",
                    ];
    _leftDatas  = [NSMutableArray arrayWithArray:@[@"请输入本人姓名",
                    @"请选择",
                    @"请输入联系电话(手机)",
                    @"请输入QQ或微信号码",
                    @"请输入",
                    
                    @"请输入",
                    @"请备注下预计入住时间和周期",
                    @"请选择",
                    @"请输入",
                    @"请输入",
                    
                    @"请输入",
                    @"请输入",
                    @"",
                    @"",
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
                                                                                    SCREEN_HEIGHT - 64 - 68,
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
                self.infoDic[@"sex"] = @(1);
            }
            if ([content isEqualToString:@"女"]) {
                self.infoDic[@"sex"] = @(2);
            }
        }
        /** 手机号*/
        if (i   == 2) {
            self.infoDic[@"phone"] = content;
        }
        if (i  == 2) {
            if(![MyControl isPhoneNumber:content]){
                [MyControl alertShow:@"请输入正确的手机号码"];
                return;
            }
        }
        /** QQ Wechat*/
        if (i == 3) {
            self.infoDic[@"qq"] = content;
        }
        /** 意向国家*/
        if (i   == 4) {
            self.infoDic[@"country"] = content;
            
        }
        /** 出行城市*/
        if (i   == 5) {
            self.infoDic[@"city"] = content;
        }
        /** 子女学校*/
        if (i == 6) {
            self.infoDic[@"school"] = content;
        }
        /** 行程时间*/
        if (i   == 7) {
            self.infoDic[@"datetime"] = content;
            
        }
        /** 出行人数*/
        if (i   == 8) {
            self.infoDic[@"number"] = content;
            
        }
        /** 预算范围*/
        if (i  == 9) {
            
            self.infoDic[@"gudget"] = content;
        }
        /** 出行目的*/
        if (i  == 10) {
            self.infoDic[@"objective"] = content;
            
        }
        /** 个性需求*/
        if (i  == 11) {
            self.infoDic[@"demand"] = content;
            
        }
        /** 上传文件*/
        if (i  == 12) {
            self.infoDic[@"path"] = content;
        }
    }
    
#warning 
#pragma mark  - || 之后字段与_leftDatas 中原始数据相匹配
    //0
    if ([self.infoDic[@"name"] isEqualToString:@""] ||[self.infoDic[@"name"] isEqualToString:@"请输入本人姓名"]  ) {
        [MyControl alertShow:@"请您输入姓名"];
        return;
    }
    //1
    if (!self.infoDic[@"sex"]|| [self.infoDic[@"sex"] isEqual:@"请选择"] ) {
        [MyControl alertShow:@"请您选择性别"];
        return;
    }
    //2
    if ([self.infoDic[@"phone"]isEqualToString:@""]|| [self.infoDic[@"phone"] isEqualToString:@"请输入联系电话(手机)"] ) {
        [MyControl alertShow:@"请您输入手机号"];
        return;
    }
    
    //4
    if ([self.infoDic[@"country"]isEqualToString:@""]||[self.infoDic[@"country"] isEqualToString:@"请输入"] ) {
        [MyControl alertShow:@"请您输入意向国家"];
        return;
    }
    //5
    if ([self.infoDic[@"city"]isEqualToString:@""]||[self.infoDic[@"city"] isEqualToString:@"请输入"] ) {
        [MyControl alertShow:@"请您输入出行城市"];
        return;
    }
    
    //6
    if ([self.infoDic[@"datetime"]isEqualToString:@""]||[self.infoDic[@"datetime"] isEqualToString:@"请选择"] ) {
        [MyControl alertShow:@"请您选择行程时间"];
        return;
    }
    //8
    if ([self.infoDic[@"number"]isEqualToString:@""]||[self.infoDic[@"number"] isEqualToString:@"请输入"] ) {
        [MyControl alertShow:@"请您输入出行人数"];
        return;
    }

    
    MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    self.infoDic[@"token"] = model.token;
    self.infoDic[@"sign"] = @"servepay";
    self.infoDic[@"type"] = @(1);/** 家长*/
    self.infoDic[@"or_price"] = self.price;
    self.infoDic[@"f_id"] = self.ma_id;
        
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager studentOrParentsGetService:self.infoDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            [MBProgressHUD showSuccess:@"成功" toView:self.view];
            
            if([self.price isEqualToString:@"0.00"]){
                [MBProgressHUD showSuccess:@"成功下单,返回" toView:self.view];
                [self.navigationController popViewControllerAnimated:YES];
                return ;
            }
            
            
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
    
    static NSString *cellIdentifier = @"OrderInfoCell";
    
    OrderInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[OrderInfoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.leftLabel.text  = _menuDatas[indexPath.row];
    cell.rightField.text = _leftDatas[indexPath.row];
    
    cell.cellDelegate = self;
    cell.cellIndexPath = indexPath;
    
    
    if (indexPath.row == 3||
        indexPath.row == 6||
        indexPath.row == 9||
        indexPath.row == 10||
        indexPath.row == 11||
        indexPath.row == 12||
        indexPath.row == 13) {
        cell.leftLabel.textColor = FONT_DARK;
    }else{
        cell.leftLabel.textColor = [UIColor redColor];
        cell.leftLabel.attributedText = [MyControl originalStr:cell.leftLabel.text position:1 color:FONT_DARK];
    }
    
    /** 联系方式 人数*/
    if (indexPath.row == 2 ||indexPath.row == 8) {
        cell.rightField.keyboardType = UIKeyboardTypePhonePad;
        
    }else{
        cell.rightField.keyboardType = UIKeyboardTypeDefault;
    }
    
    /**  性别 行程时间 客服*/
    if (indexPath.row == 1 ||
        indexPath.row == 7 ||
        indexPath.row == 12||
        indexPath.row == 13) {
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
    if (indexPath.row == 7){
        /** 行程时间*/
        MBBDatePicker * picker = [[MBBDatePicker alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        picker.datePicker.datePickerMode = UIDatePickerModeDate;
        picker.datePicker.minimumDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
        picker.delegate = self;
        picker.tag = KDatePickerDistanceDay;
        [self.view addSubview:picker];
        
    }
    if(indexPath.row == 13){
        /** 咨询*/
        NSMutableString *str =[[NSMutableString alloc] initWithFormat:@"telprompt://%@", @"010-56617246"];
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
    }
    
}
#pragma mark -MBBDatePickerDelegate
- (void)datePickerSureClick:(NSString *)dateStr view:(MBBDatePicker *)picker{
    
    if (KDatePickerDistanceDay == picker.tag){
//        OrderInfoCell * cell = [self.menuTableView cellForRowAtIndexPath:self.currentIndexPath];
//        cell.rightField.text = dateStr;
//        self.infoDic[@"datetime"] = dateStr;
        OrderInfoCell * cell = [self.menuTableView cellForRowAtIndexPath:self.currentIndexPath];
        cell.rightField.text = dateStr;
        [_leftDatas replaceObjectAtIndex:self.currentIndexPath.row withObject:cell.rightField.text];
        [self.menuTableView reloadData];

        
    }
}
#pragma mark - LCAtionSheetDelegate

- (void)actionSheet:(LCActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        /** 男*/
//        OrderInfoCell * cell = [self.menuTableView cellForRowAtIndexPath:self.currentIndexPath];
//        cell.rightField.text = @"男";
//        self.infoDic[@"sex"] = @(1);
        
        OrderInfoCell * cell = [self.menuTableView cellForRowAtIndexPath:self.currentIndexPath];
        cell.rightField.text = @"男";
        [_leftDatas replaceObjectAtIndex:self.currentIndexPath.row withObject:cell.rightField.text];
        [self.menuTableView reloadData];

        
    }
    if (buttonIndex == 2) {
        /** 女*/
//        OrderInfoCell * cell = [self.menuTableView cellForRowAtIndexPath:self.currentIndexPath];
//        cell.rightField.text = @"女";
//        self.infoDic[@"sex"] = @(2);
        
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
