//
//  WYAppointmentDetailController.m
//  mybigbrother
//
//  Created by Loren on 2018/1/30.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "WYAppointmentDetailController.h"
#import "WRCellView.h"
#import "CCDatePickerView.h"
#import "PPNumberButton.h"
#import "WYConfirmController.h"

#define WRCellViewHeight  60
#define kBackColor [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0]

@interface WYAppointmentDetailController ()<PPNumberButtonDelegate>
{
    UIButton *selectBtn;
    NSInteger totalPrice;
    NSInteger Price;
    UILabel *PriceLab;
}

@property(nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic, strong) UIScrollView* containerView;
// 名称
@property (nonatomic, strong) WRCellView*   NameView;
// 性别
@property (nonatomic, strong) WRCellView*   SexView;
// 所在学校
@property (nonatomic, strong) WRCellView*   SchoolView;
// 服务内容
@property (nonatomic, strong) WRCellView*   ContentView;
// 服务资费
@property (nonatomic, strong) WRCellView*   PayView;
// 预约时间
@property (nonatomic, strong) WRCellView*   TimeView;
// 预计服务时长
@property (nonatomic, strong) WRCellView*   TimeLongView;
// 合计
@property (nonatomic, strong) WRCellView*   TotalView;

@end

@implementation WYAppointmentDetailController
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
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#eae9e9"];
    //    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"预约详情";
    self.navigationItem.hidesBackButton = YES;
    
    self.containerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, self.view.bounds.size.height)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.containerView];
    
    [self addViews];
    [self setCellFrame];
    [self payUI];
}

- (void)addViews
{
    [self.containerView addSubview:self.NameView];
    [self.containerView addSubview:self.SexView];
    [self.containerView addSubview:self.SchoolView];
    [self.containerView addSubview:self.ContentView];
    [self.containerView addSubview:self.PayView];
    [self.containerView addSubview:self.TimeView];
    [self.containerView addSubview:self.TimeLongView];
    [self.containerView addSubview:self.TotalView];

}

- (void)setCellFrame
{
    self.NameView.frame = CGRectMake(0, 0, kScreenWidth, WRCellViewHeight);
    self.SexView.frame = CGRectMake(0, _NameView.frame.origin.y + WRCellViewHeight, kScreenWidth, WRCellViewHeight);
    self.SchoolView.frame = CGRectMake(0, _SexView.frame.origin.y + 8 + WRCellViewHeight, kScreenWidth, WRCellViewHeight);
    self.ContentView.frame = CGRectMake(0, _SchoolView.frame.origin.y + WRCellViewHeight, kScreenWidth, WRCellViewHeight);
    self.PayView.frame = CGRectMake(0, _ContentView.frame.origin.y + WRCellViewHeight, kScreenWidth, WRCellViewHeight);
      self.TimeView.frame = CGRectMake(0, _PayView.frame.origin.y + WRCellViewHeight, kScreenWidth, WRCellViewHeight);
    self.TimeLongView.frame = CGRectMake(0, _TimeView.frame.origin.y + WRCellViewHeight, kScreenWidth, WRCellViewHeight);
    self.TotalView.frame = CGRectMake(0, _TimeLongView.frame.origin.y + WRCellViewHeight, kScreenWidth, WRCellViewHeight + 140);
    self.containerView.contentSize = CGSizeMake(0, self.TotalView.frame.origin.y+WRCellViewHeight+100);
    
}

- (WRCellView *)NameView {
    if (_NameView == nil) {
        _NameView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Label];
        _NameView.leftLabel.text = @"姓名";
        _NameView.rightLabel.text = @"张晶";
        [_NameView setLineStyleWithLeftZero];
    }
    return _NameView;
}

- (WRCellView *)SexView {
    if (_SexView == nil) {
        _SexView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Label];
        _SexView.leftLabel.text = @"性别";
        _SexView.rightLabel.text = @"女";
        [_SexView setLineStyleWithLeftZero];
    }
    return _SexView;
}

- (WRCellView *)SchoolView {
    if (_SchoolView == nil) {
        _SchoolView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Label];
        _SchoolView.leftLabel.text = @"所在学校";
        _SchoolView.rightLabel.text = @"哈佛大学";
        [_SchoolView setLineStyleWithLeftZero];
    }
    return _SchoolView;
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
        
        UIImageView *IndicatorImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gj_fhx"]];
        [_TimeView addSubview:IndicatorImg];
       
        [IndicatorImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_TimeView);
            make.right.mas_equalTo(-15);
        }];
        
        selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        selectBtn.backgroundColor = [UIColor whiteColor];
        [selectBtn setTitle:@"请选择" forState:UIControlStateNormal];
        [selectBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        selectBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_TimeView addSubview:selectBtn];
        [selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_TimeView);
            make.right.equalTo(IndicatorImg.mas_left).offset(-10);
        }];
        
        [_TimeView setLineStyleWithLeftZero];
    }
    return _TimeView;
}
- (void)selectAction:(UIButton *)btn {
    
    CCDatePickerView *dateView=[[CCDatePickerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:dateView];
    dateView.blcok = ^(NSDate *dateString){
        NSLog(@"年 = %ld  月 = %ld  日 = %ld  时 = %ld  分 = %ld",(long)dateString.year,(long)dateString.month,(long)dateString.day,dateString.hour,dateString.minute);
        NSString *datestr = [NSString stringWithFormat:@"%ld-%02ld-%ld %ld:%02ld",(long)dateString.year,(long)dateString.month,(long)dateString.day,dateString.hour,dateString.minute];
        [selectBtn setTitle:datestr forState:UIControlStateNormal];
    };
    dateView.chooseTimeLabel.text = @"选择时间";
    [dateView fadeIn];
}

- (WRCellView *)TimeLongView {
    if (_TimeLongView == nil) {
        _TimeLongView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Label];
        _TimeLongView.leftLabel.text = @"预约服务时长";
        [_TimeLongView setLineStyleWithLeftZero];
        
        
        PPNumberButton *numberButton = [PPNumberButton numberButtonWithFrame:CGRectMake(300,15, 100, 30)];
        numberButton.shakeAnimation = YES;
        numberButton.increaseImage = [UIImage imageNamed:@"xz_zj"];
        numberButton.decreaseImage = [UIImage imageNamed:@"xz_js"];
        [_TimeLongView addSubview:numberButton];
        
        numberButton.resultBlock = ^(NSInteger num ,BOOL increaseStatus){
            
#warning 价格暂时写死，对接口时再接入传入价格 -
            
            Price = 35;
            totalPrice = num * Price;
            PriceLab.text = [NSString stringWithFormat:@"$%ld",totalPrice];
            
            NSLog(@"数量 = %ld ， 总价 = %ld",num,totalPrice);
            
        };
    }
    
    return _TimeLongView;
}

- (WRCellView *)TotalView {
    if (_TotalView == nil) {
        _TotalView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Label];
        [_TotalView setLineStyleWithLeftZero];
        
        PriceLab = [[UILabel alloc] init];
        [_TotalView addSubview:PriceLab];
        PriceLab.textColor = [UIColor colorWithHexString:@"#fb6030"];
        PriceLab.font = [UIFont systemFontOfSize:25.0f];
        PriceLab.font = [UIFont boldSystemFontOfSize:25.0f];
        PriceLab.text = [NSString stringWithFormat:@"$0"];
        [PriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(20);
        }];
        
        UILabel *totalLabel = [[UILabel alloc] init];
        [_TotalView addSubview:totalLabel];
        totalLabel.text = @"合计：";
        totalLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        totalLabel.font = [UIFont systemFontOfSize:14.0f];
        [totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(PriceLab);
            make.right.equalTo(PriceLab.mas_left).offset(-3);
        }];
    }
    return _TotalView;
}

- (void)payUI{
    
    UIButton *payBtn = [[UIButton alloc] init];
    [self.view addSubview:payBtn];
    payBtn.backgroundColor = [UIColor colorWithHexString:@"#fb6030"];
    [payBtn setTitle:@"去付款" forState:UIControlStateNormal];
    [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    payBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [payBtn addTarget:self action:@selector(pay_Click:) forControlEvents:UIControlEventTouchUpInside];
    
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(55);
        make.left.right.bottom.mas_equalTo(0);
    }];
}

- (void)pay_Click:(UIButton *)sender
{
    NSLog(@"去付款");
    WYConfirmController *confirmPayVC = [[WYConfirmController alloc] init];
    confirmPayVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:confirmPayVC animated:YES];
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

