//
//  MBBServiceViewController.m
//  mybigbrother
//
//  Created by SN on 2017/3/30.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBServiceViewController.h"
#import "StudentServiceController.h"
#import "ParentsServiceController.h"

@interface MBBServiceViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView * banner;
@property (nonatomic, strong) UIImageView * leftImage;
@property (nonatomic, strong) UIImageView * rightImage;
@property(nonatomic, strong) UIScrollView * mainScrollView;

@end

@implementation MBBServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    /** 监测网络情况*/
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(reachabilityChanged:)
     name:kReachabilityChangedNotification
     object:nil];
    
    
    //主滚动视图
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,
                                                                    0,
                                                                    SCREEN_WIDTH,
                                                                    SCREEN_HEIGHT)];
    _mainScrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT * 1.1);
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.backgroundColor = [UIColor whiteColor];
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_mainScrollView];
    
    [self setupViews];

  
    // Do any additional setup after loading the view.
}
#pragma mark - 断网处理
- (void)reachabilityChanged:(NSNotification * )notice{
    Reachability *curReach = [notice object];
    NetworkStatus status = [curReach currentReachabilityStatus];
    if (status != NotReachable) {
        [self fetPictureFromSever];
    }
}

- (void)setupViews{
    
    SDCycleScrollView * banner = [[SDCycleScrollView alloc]init];
    banner.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    banner.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    banner.placeholderImage = [UIImage imageNamed:@"default_big"];
    banner.delegate = self;
    
    UIImageView * leftImage = [[UIImageView alloc]init];
    leftImage.image = [UIImage imageNamed:@"default_big"];
    UIImageView * rightImage = [[UIImageView alloc]init];
    rightImage.image = [UIImage imageNamed:@"default_big"];

    UILabel * studentLabel = [[UILabel alloc]init];
    studentLabel.text = @"我是学生";
    studentLabel.font = MBBFONT(15);
    studentLabel.textAlignment = NSTextAlignmentCenter;
    UILabel * teacherLabel = [[UILabel alloc]init];
    
    teacherLabel.text = @"我是家长";
    teacherLabel.font = MBBFONT(15);
    teacherLabel.textAlignment = NSTextAlignmentCenter;
    
    NSArray * subviews = @[banner,
                           leftImage,
                           rightImage,
                           studentLabel,
                           teacherLabel];
    [_mainScrollView sd_addSubviews: subviews];
    
    _banner = banner;
    _rightImage = rightImage;
    _leftImage = leftImage;
    
    
    banner.sd_layout
    .topSpaceToView(_mainScrollView,0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(SCREEN_WIDTH * 0.42)
    .leftSpaceToView(_mainScrollView,0);
    
    leftImage.sd_layout
    .topSpaceToView(banner,20)
    .widthIs((SCREEN_WIDTH-40)/2)
    .heightIs(((SCREEN_WIDTH-35)/2)*1.5)
    .leftSpaceToView(_mainScrollView,10);
    
    rightImage.sd_layout
    .topSpaceToView(banner,20)
    .widthIs((SCREEN_WIDTH-40)/2)
    .heightIs(((SCREEN_WIDTH-35)/2)*1.5)
    .rightSpaceToView(_mainScrollView,10);
    
    /** 投影*/
    leftImage.layer.shadowColor = [UIColor blackColor].CGColor;
    leftImage.layer.shadowOpacity = 0.5;
    leftImage.layer.shadowRadius = 3;
    leftImage.layer.shadowOffset = CGSizeMake(0.5, 0.5);

    rightImage.layer.shadowColor = [UIColor blackColor].CGColor;
    rightImage.layer.shadowOpacity = 0.5;
    rightImage.layer.shadowRadius = 3;
    rightImage.layer.shadowOffset = CGSizeMake(0.5, 0.5);
    
    
    studentLabel.sd_layout
    .topSpaceToView(leftImage,10)
    .widthIs(SCREEN_WIDTH/2 -30)
    .heightIs(20)
    .leftSpaceToView(_mainScrollView,10);
    
    teacherLabel.sd_layout
    .topSpaceToView(rightImage,10)
    .widthIs(SCREEN_WIDTH/2 -30)
    .heightIs(20)
    .rightSpaceToView(_mainScrollView,10);
    
    
    UITapGestureRecognizer * studentTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(studentCliked)];
    leftImage.userInteractionEnabled = YES;
    [leftImage addGestureRecognizer:studentTap];
    
    UITapGestureRecognizer * teacherTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(teacherCliked)];
    rightImage.userInteractionEnabled = YES;
    [rightImage addGestureRecognizer:teacherTap];
    
    _mainScrollView.frame = CGRectMake(0,
                                       0,
                                       SCREEN_WIDTH,
                                       SCREEN_HEIGHT);
    _mainScrollView.contentSize = CGSizeMake(0,
                                             SCREEN_HEIGHT + 1);
    
    
    [self fetPictureFromSever];
    
}

- (void)studentCliked{
    StudentServiceController * studentVC = [[StudentServiceController alloc]init];
    studentVC.hidesBottomBarWhenPushed  =YES;
    [self.navigationController pushViewController:studentVC animated:YES];
}

- (void)teacherCliked{
    ParentsServiceController * parentsVC = [[ParentsServiceController alloc]init];
    parentsVC.hidesBottomBarWhenPushed  =YES;
    [self.navigationController pushViewController:parentsVC animated:YES];

}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    /*** 跳转(banner详情)*/
    
    
}

- (void)fetPictureFromSever{
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"indexsbanner";
    [MBBNetworkManager getServicePageImages:paramDic responseResult:^(YTKBaseRequest *request) {
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            
            _banner.imageURLStringsGroup =[NSArray arrayWithObject:request.responseJSONObject[@"data"][@"banner"]];
            [_leftImage setImageWithURL: [NSURL URLWithString:request.responseJSONObject[@"data"][@"student"]]
                            placeholder:[UIImage imageNamed:@"default_big"]];
            [_rightImage setImageWithURL: [NSURL URLWithString:request.responseJSONObject[@"data"][@"parent"]]
                            placeholder:[UIImage imageNamed:@"default_big"]];

        }else{
        
        
        }
        
    }];

}
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
