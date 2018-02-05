//
//  WYConfirmController.m
//  mybigbrother
//
//  Created by Loren on 2018/1/31.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "WYConfirmController.h"
#import "WRCellView.h"

#define WRCellViewHeight  55
#define kBackColor [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0]

@interface WYConfirmController ()

@property(nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic, strong) UIScrollView* containerView;
//  头部信息
@property (nonatomic, strong) WRCellView*   HeadView;
// 服务内容
@property (nonatomic, strong) WRCellView*   ContentView;
// 服务资费
@property (nonatomic, strong) WRCellView*   PayView;
// 预约时间
@property (nonatomic, strong) WRCellView*   TimeView;
// 服务时长
@property (nonatomic, strong) WRCellView*   TimeLongView;
// 合计
@property (nonatomic, strong) WRCellView*   TotalView;


@end

@implementation WYConfirmController
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
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"确认订单";
     self.navigationItem.hidesBackButton = YES;
    
    self.containerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, self.view.bounds.size.height)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.containerView];
    
    [self addViews];
    [self setCellFrame];
    [self ConfirmPay];
}

- (void)ConfirmPay{
    
    UIButton *confirmPayBtn = [[UIButton alloc] init];
    [self.view addSubview:confirmPayBtn];
    [confirmPayBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    confirmPayBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [confirmPayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmPayBtn.backgroundColor = [UIColor colorWithHexString:@"#fb6030"];
    [confirmPayBtn addTarget:self action:@selector(confirmPay_click:) forControlEvents:UIControlEventTouchUpInside];
    
    [confirmPayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
}

- (void)confirmPay_click:(UIButton *)sender
{
    NSLog(@"确认支付");
}

- (void)addViews
{
    [self.containerView addSubview:self.HeadView];
    [self.containerView addSubview:self.ContentView];
    [self.containerView addSubview:self.PayView];
    [self.containerView addSubview:self.TimeView];
    [self.containerView addSubview:self.TimeLongView];
    [self.containerView addSubview:self.TotalView];
}

- (void)setCellFrame
{
    self.HeadView.frame = CGRectMake(0,0, kScreenWidth, 100);
    self.ContentView.frame = CGRectMake(0, _HeadView.frame.origin.y + self.HeadView.bounds.size.height, kScreenWidth, WRCellViewHeight);
    self.PayView.frame = CGRectMake(0, _ContentView.frame.origin.y + WRCellViewHeight, kScreenWidth, WRCellViewHeight);
    self.TimeView.frame = CGRectMake(0, _PayView.frame.origin.y + WRCellViewHeight, kScreenWidth, WRCellViewHeight);
    self.TimeLongView.frame = CGRectMake(0, _TimeView.frame.origin.y + WRCellViewHeight, kScreenWidth, WRCellViewHeight);
    self.TotalView.frame = CGRectMake(0, _TimeLongView.frame.origin.y + WRCellViewHeight, kScreenWidth, WRCellViewHeight+280);
    self.containerView.contentSize = CGSizeMake(0, self.TotalView.frame.origin.y+WRCellViewHeight+100);
    
}

- (WRCellView *)HeadView {
    if (_HeadView == nil) {
        _HeadView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Label];
        _HeadView.backgroundColor = [UIColor whiteColor];
        [_HeadView setLineStyleWithLeftZero];
        [self headViewUI];
    }
    return _HeadView;
}

- (WRCellView *)ContentView {
    if (_ContentView == nil) {
        _ContentView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Label];
        _ContentView.leftLabel.text = @"服务品类";
        _ContentView.rightLabel.text = @"校园导游";
        [_ContentView setLineStyleWithLeftZero];
    }
    return _ContentView;
}

- (WRCellView *)PayView {
    if (_PayView == nil) {
        _PayView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Label];
        _PayView.leftLabel.text = @"服务资费";
        _PayView.rightLabel.text = @"$35/时";
        [_PayView setLineStyleWithLeftZero];
    }
    return _PayView;
}

- (WRCellView *)TimeView {
    if (_TimeView == nil) {
        _TimeView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Label];
        _TimeView.leftLabel.text = @"预约时间";
        _TimeView.rightLabel.text = @"0000-00-00 00:00";
        [_TimeView setLineStyleWithLeftZero];
    }
    return _TimeView;
}

- (WRCellView *)TimeLongView {
    if (_TimeLongView == nil) {
        _TimeLongView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Label];
        _TimeLongView.leftLabel.text = @"预计服务时长";
        _TimeLongView.rightLabel.text = @"2小时";
        [_TimeLongView setLineStyleWithLeftZero];
    }
    return _TimeLongView;
}

- (WRCellView *)TotalView {
    if (_TotalView == nil) {
        _TotalView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Label];
        _TotalView.backgroundColor = [UIColor whiteColor];
//        [_TotalView setLineStyleWithLeftZero];
        [self footViewUI];
    }
    return _TotalView;
}

- (void)headViewUI{
    
    // 头像
    self.iconImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timg"]];
    [_HeadView addSubview:self.iconImgView];
    self.iconImgView.contentMode=UIViewContentModeScaleAspectFill;
    self.iconImgView.clipsToBounds=YES;
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(15);
        make.bottom.mas_equalTo(-15);
        make.width.height.mas_equalTo(70);
    }];
    
    // 兼职名称
    self.partTimeName = [[UILabel alloc] init];
    [_HeadView addSubview:self.partTimeName];
    self.partTimeName.text = @"电商运营助理";
    self.partTimeName.textColor = [UIColor colorWithHexString:@"#282828"];
    self.partTimeName.font = [UIFont  systemFontOfSize:16.0f];
    self.partTimeName.font = [UIFont boldSystemFontOfSize:16.0f];
    [self.partTimeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImgView);
        make.left.equalTo(self.iconImgView.mas_right).offset(10);
    }];
    
    // 校标
    self.universityTipImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sx_xiao"]];
    [_HeadView addSubview:self.universityTipImg];
    [self.universityTipImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.partTimeName);
        make.centerY.equalTo(self.iconImgView);
    }];
    
    // 大学名称
    self.uiniversityName = [[UILabel alloc] init];
    [_HeadView addSubview:self.uiniversityName];
    self.uiniversityName.text = @"斯坦福大学";
    self.uiniversityName.font = [UIFont systemFontOfSize:14];
    self.uiniversityName.textColor = [UIColor colorWithHexString:@"#999999"];
    [self.uiniversityName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.universityTipImg);
        make.left.equalTo(self.universityTipImg.mas_right).offset(5);
    }];
    
    // 专业标志
    self.professionalImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sx_zhuan"]];
    [_HeadView addSubview:self.professionalImgView];
    [self.professionalImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.universityTipImg);
        make.left.equalTo(self.uiniversityName.mas_right).offset(10);
    }];
    
    // 专业名称
    self.professinalName = [[UILabel alloc] init];
    [_HeadView addSubview:self.professinalName];
    self.professinalName.font = [UIFont systemFontOfSize:14];
    self.professinalName.textColor = [UIColor colorWithHexString:@"#999999"];
    self.professinalName.text = @"市场营销";
    [self.professinalName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.universityTipImg);
        make.left.equalTo(self.professionalImgView.mas_right).offset(5);
    }];
    
    UIView *weekView = [[UIView alloc] init];
    [_HeadView addSubview:weekView];
    weekView.backgroundColor = [UIColor colorWithHexString:@"#f3f3f3"];
    weekView.layer.borderWidth = 0.5f;
    weekView.layer.borderColor = [UIColor colorWithHexString:@"#cfcfcf"].CGColor;
    [weekView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(16.5);
        make.width.mas_equalTo(45);
        make.bottom.equalTo(_iconImgView.mas_bottom);
        make.left.equalTo(_universityTipImg);
    }];
    
    UIView *timeView = [[UIView alloc] init];
    [_HeadView addSubview:timeView];
    timeView.layer.borderColor = [UIColor colorWithHexString:@"#cfcfcf"].CGColor;
    timeView.layer.borderWidth = 0.5f;
    [timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(16.5f);
        make.width.mas_equalTo(83);
        make.centerY.equalTo(weekView);
        make.left.equalTo(weekView.mas_right);
    }];
    
    UILabel *fengeLabel = [[UILabel alloc] init];
    [timeView addSubview:fengeLabel];
    fengeLabel.text = @"~";
    fengeLabel.font = [UIFont systemFontOfSize:10.0f];
    fengeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    [fengeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(timeView);
    }];
    
    // 星期几
    _weekLabel = [[UILabel alloc] init];
    [weekView addSubview:_weekLabel];
    _weekLabel.text = @"周日";
    _weekLabel.font = [UIFont systemFontOfSize:10.0f];
    _weekLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    [_weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weekView);
    }];
    
    // 起始时间
    _starTime = [[UILabel alloc] init];
    [timeView addSubview:_starTime];
    _starTime.text = @"9:00";
    _starTime.font = [UIFont systemFontOfSize:10.0f];
    _starTime.textColor = [UIColor colorWithHexString:@"#999999"];
    [_starTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(timeView);
        make.right.equalTo(fengeLabel.mas_left).offset(-5);
    }];
    
    // 结束时间
    _endTime = [[UILabel alloc] init];
    [timeView addSubview:_endTime];
    _endTime.text = @"18:00";
    _endTime.font = [UIFont systemFontOfSize:10.0f];
    _endTime.textColor = [UIColor colorWithHexString:@"#999999"];
    [_endTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(timeView);
        make.left.equalTo(fengeLabel.mas_right).offset(5);
    }];
    
    _everyDayLabel = [[UILabel alloc] init];
    [_HeadView addSubview:_everyDayLabel];
    _everyDayLabel.font = [UIFont systemFontOfSize:17.0f];
    _everyDayLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    _everyDayLabel.text = @"/ 时";
    [_everyDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_partTimeName);
        make.right.mas_equalTo(-15);
    }];
    
    // 价钱
    _priceLabel = [[UILabel alloc] init];
    [_HeadView addSubview:_priceLabel];
    _priceLabel.font = [UIFont systemFontOfSize:17.0f];
    _priceLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    _priceLabel.text = @"$35";
    _priceLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_partTimeName);
        make.right.equalTo(_everyDayLabel.mas_left).offset(-5);
    }];
}

- (void)footViewUI{
    
    _GoodsNumberName = [[UILabel alloc] init];
    [_TotalView addSubview:_GoodsNumberName];
    _GoodsNumberName.font = [UIFont systemFontOfSize:15];
    _GoodsNumberName.textColor = [UIColor colorWithHexString:@"#333333"];
    _GoodsNumberName.text = @"服务编号：";
    [_GoodsNumberName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(15);
    }];
    
    _GoodsNumber = [[UILabel alloc] init];
    [_TotalView addSubview:_GoodsNumber];
    _GoodsNumber.font = [UIFont systemFontOfSize:15];
    _GoodsNumber.textColor = [UIColor colorWithHexString:@"#fb6030"];
    _GoodsNumber.text = @"Edd1345224";
    [_GoodsNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_GoodsNumberName);
        make.left.equalTo(_GoodsNumberName.mas_right).offset(0);
    }];
    
    _appointmentTime = [[UILabel alloc] init];
    [_TotalView addSubview:_appointmentTime];
    _appointmentTime.font = [UIFont systemFontOfSize:14];
    _appointmentTime.textColor = [UIColor colorWithHexString:@"#999999"];
    _appointmentTime.text = @"0000-00-00 00:00";
    [_appointmentTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_GoodsNumberName);
        make.right.mas_equalTo(-15);
    }];
    
    _payAcconut = [[UILabel alloc] init];
    [_TotalView addSubview:_payAcconut];
    _payAcconut.font = [UIFont systemFontOfSize:24];
    _payAcconut.font = [UIFont boldSystemFontOfSize:24.0f];
    _payAcconut.textColor = [UIColor colorWithHexString:@"#fb6030"];
    _payAcconut.text = [NSString stringWithFormat:@"$70"];
    [_payAcconut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_appointmentTime);
        make.top.equalTo(_appointmentTime.mas_bottom).offset(40);
    }];
    
    _payName = [[UILabel alloc] init];
    [_TotalView addSubview:_payName];
    _payName.font = [UIFont systemFontOfSize:15];
    _payName.font = [UIFont boldSystemFontOfSize:15.0f];
    _payName.textColor = [UIColor colorWithHexString:@"#666666"];
    _payName.text = @"应付金额：";
    [_payName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_payAcconut.mas_bottom);
        make.right.equalTo(_payAcconut.mas_left).offset(0);
    }];
    
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
