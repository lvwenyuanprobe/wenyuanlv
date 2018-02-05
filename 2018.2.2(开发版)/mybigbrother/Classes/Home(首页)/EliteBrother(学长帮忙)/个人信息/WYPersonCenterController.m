//
//  WYPersonCenterController.m
//  mybigbrother
//
//  Created by apple on 2018/1/7.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "WYPersonCenterController.h"
#import "WRCellView.h"
#import "MyCollectionViewCell.h"
#import "HUPhotoBrowser.h"
#import "UIImageView+WebCache.h"
#import "UILabel+Copy.h"
#import "WYAppointmentDetailController.h"

#define WRCellViewHeight  55
#define kBackColor [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0]

@interface WYPersonCenterController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic, strong) UIScrollView* containerView;
@property (nonatomic, strong) WRCellView*   headerView;
@property (nonatomic, strong) WRCellView*   currentSchoolView;
@property (nonatomic, strong) WRCellView*   specialtiesView;
@property (nonatomic, strong) WRCellView*   USAAddressView;
@property (nonatomic, strong) WRCellView*   freeTimeView;
@property (nonatomic, strong) WRCellView*   ContactInformationView;
@property (nonatomic, strong) WRCellView*   CertificatesView;
@property (nonatomic, strong) WRCellView*   uploadCertificatesView;
@property (nonatomic, strong) WRCellView*   NameView;
@property (nonatomic, strong) WRCellView*   SexView;

@property (nonatomic, strong) NSArray *images; // 加载本地图片
@property (nonatomic, strong) NSMutableArray *URLStrings; // 加载网络图片

@end

@implementation WYPersonCenterController
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
    self.title = @"个人信息";
    self.navigationItem.hidesBackButton = YES;
    
    self.containerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, self.view.bounds.size.height)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.containerView];
    
    _URLStrings = [NSMutableArray array];
    
    [self addViews];
    [self setCellFrame];
    [self onClickEvent];
    [self uploadView];
    [self images]; // 加载本地图片
//    [self getWebImages]; // 加载网络图片
    [self appointmentView];
    
}
- (void)addViews
{
    [self.containerView addSubview:self.headerView];
    [self.containerView addSubview:self.currentSchoolView];
    [self.containerView addSubview:self.specialtiesView];
    [self.containerView addSubview:self.USAAddressView];
    [self.containerView addSubview:self.freeTimeView];
    [self.containerView addSubview:self.CertificatesView];
    [self.containerView addSubview:self.uploadCertificatesView];
    [self.containerView addSubview:self.NameView];
    [self.containerView addSubview:self.SexView];
}

- (void)setCellFrame
{
    self.headerView.frame = CGRectMake(0, 0, kScreenWidth, 100);
    
    self.NameView.frame = CGRectMake(0, _headerView.frame.origin.y+8 + self.headerView.bounds.size.height, kScreenWidth, WRCellViewHeight);
    self.SexView.frame = CGRectMake(0, _NameView.frame.origin.y + WRCellViewHeight, kScreenWidth, WRCellViewHeight);
    self.currentSchoolView.frame = CGRectMake(0, _SexView.frame.origin.y + WRCellViewHeight, kScreenWidth, WRCellViewHeight);
    self.specialtiesView.frame = CGRectMake(0, _currentSchoolView.frame.origin.y + WRCellViewHeight, kScreenWidth, WRCellViewHeight);
    self.USAAddressView.frame = CGRectMake(0, _specialtiesView.frame.origin.y + WRCellViewHeight, kScreenWidth, WRCellViewHeight);
    self.freeTimeView.frame = CGRectMake(0, _USAAddressView.frame.origin.y + WRCellViewHeight, kScreenWidth, WRCellViewHeight);
//    self.ContactInformationView.frame = CGRectMake(0, _freeTimeView.frame.origin.y+8 + WRCellViewHeight, kScreenWidth, WRCellViewHeight);
    self.CertificatesView.frame = CGRectMake(0, _freeTimeView.frame.origin.y+8 + WRCellViewHeight, kScreenWidth, WRCellViewHeight);
    self.uploadCertificatesView.frame = CGRectMake(0, _CertificatesView.frame.origin.y + WRCellViewHeight, kScreenWidth, 100);
    self.containerView.contentSize = CGSizeMake(0, self.uploadCertificatesView.frame.origin.y+WRCellViewHeight+100);
    
}

- (void)onClickEvent
{
//    __weak typeof(self) weakSelf = self;
//    self.headerView.tapBlock = ^ {
//        __strong typeof(self) pThis = weakSelf;
//        [pThis openNewVC];
//        [WYCustomAlter showMessage:@"发布功能稍后开放"];
//    };
//    self.currentSchoolView.tapBlock = ^ {
//        __strong typeof(self) pThis = weakSelf;
////        [pThis openNewVC];
//    };
//    self.specialtiesView.tapBlock = ^ {
//        __strong typeof(self) pThis = weakSelf;
////        [pThis openNewVC];
//    };
//    self.USAAddressView.tapBlock = ^ {
//        __strong typeof(self) pThis = weakSelf;
////        [pThis openNewVC];
//    };
//    self.GPAAverageView.tapBlock = ^ {
//        __strong typeof(self) pThis = weakSelf;
////        [pThis openNewVC];
//    };
//    self.freeTimeView.tapBlock = ^ {
//        __strong typeof(self) pThis = weakSelf;
////        [pThis openNewVC];
//    };
//    self.ContactInformationView.tapBlock = ^ {
//        __strong typeof(self) pThis = weakSelf;
////        [pThis openNewVC];
//    };
//    self.CertificatesView.tapBlock = ^ {
//        __strong typeof(self) pThis = weakSelf;
////        [pThis openNewVC];
//    };
}

- (void)openNewVC
{
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.title = @"发布";
    [self.navigationController pushViewController:vc animated:YES];
}

- (WRCellView *)headerView {
    if (_headerView == nil) {
        _headerView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_IconIndicator];
        _headerView.leftLabel.text = @"头像";
         [_headerView setLineStyleWithLeftZero];
        
        UIImageView *headImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default_big"]];
        [_headerView addSubview:headImg];
        headImg.layer.cornerRadius = 15;
        headImg.layer.masksToBounds = YES;
        headImg.contentMode=UIViewContentModeScaleAspectFill;
        headImg.clipsToBounds=YES;
        [headImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-35);
            make.width.height.mas_equalTo(68);
            make.centerY.equalTo(_headerView);
        }];
       
        UIImage *placeImage = [UIImage imageNamed:@"default_big"];
         NSString *imageName = [self.dicItem valueForKey:@"photo"];
        NSURL *url = [NSURL URLWithString:imageName];
        [headImg sd_setImageWithURL:url
                                     placeholderImage:placeImage
                                              options:SDWebImageRetryFailed
                                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                 NSLog(@"下载进度--%f",(double)receivedSize/expectedSize);
                                             }
                                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                NSLog(@"图片下载完成！");
                                            }];
        
    }
    return _headerView;
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

- (WRCellView *)USAAddressView {
    if (_USAAddressView == nil) {
        _USAAddressView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Label];
        _USAAddressView.leftLabel.text = @"美国住所";
        _USAAddressView.rightLabel.text = @"纽约市";
        [_USAAddressView setLineStyleWithLeftZero];
    }
    return _USAAddressView;
}

- (WRCellView *)specialtiesView {
    if (_specialtiesView == nil) {
        _specialtiesView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Label];
        _specialtiesView.leftLabel.text = @"所属专业";
        _specialtiesView.rightLabel.text = [self.dicItem valueForKey:@"major"];
         [_specialtiesView setLineStyleWithLeftZero];
    }
    return _specialtiesView;
}

- (WRCellView *)currentSchoolView {
    if (_currentSchoolView == nil) {
//        _currentSchoolView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_LabelIndicator];
        _currentSchoolView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Label];
        _currentSchoolView.leftLabel.text = @"在读学校";
        _currentSchoolView.rightLabel.text = [self.dicItem valueForKey:@"school"];
        [_currentSchoolView setLineStyleWithLeftZero];
    }
    return _currentSchoolView;
}

- (WRCellView *)freeTimeView {
    if (_freeTimeView == nil) {
        _freeTimeView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Label];
        _freeTimeView.leftLabel.text = @"空闲时间";
        _freeTimeView.rightLabel.text = [NSString stringWithFormat:@"%@、%@ ~ %@",[self.dicItem valueForKey:@"free_time"],[self.dicItem valueForKey:@"free_time_star"],[self.dicItem valueForKey:@"free_time_end"]];
        [_freeTimeView setLineStyleWithLeftZero];
    }
    return _freeTimeView;
}

//- (WRCellView *)ContactInformationView {
//    if (_ContactInformationView == nil) {
//        _ContactInformationView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Label];
//        _ContactInformationView.leftLabel.text = @"联系方式";
//        _ContactInformationView.rightLabel.text = [NSString stringWithFormat:@"%@",[self.dicItem valueForKey:@"wechat"]];
//        _ContactInformationView.rightLabel.isCopyable = YES;
//        [_ContactInformationView setLineStyleWithLeftZero];
//    }
//    return _ContactInformationView;
//}

- (WRCellView *)CertificatesView {
    if (_CertificatesView == nil) {
        _CertificatesView = [[WRCellView alloc] initWithLineStyle:WRCellStyleLabel_Label];
        _CertificatesView.leftLabel.text = @"学生证件";
//        [_CertificatesView setLineStyleWithLeftZero];
    }
    return _CertificatesView;
}

- (WRCellView *)uploadCertificatesView {
    if (_uploadCertificatesView == nil) {
        _uploadCertificatesView = [[WRCellView alloc] init];
        _uploadCertificatesView.backgroundColor = [UIColor whiteColor];
    }
    return _uploadCertificatesView;
}

- (void)uploadView{
    
    _collectionView = ({
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(115, 100);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, -5, self.view.frame.size.width,105) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.scrollsToTop = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        [collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:kMyCollectionViewCellID];
        [self.uploadCertificatesView addSubview:collectionView];
        collectionView;
        
    });
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    // 本地图片数组
    return _images.count;
    // 网络图片数组
//    return _URLStrings.count;
    
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MyCollectionViewCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:kMyCollectionViewCellID forIndexPath:indexPath];
    // 加载网络图片
//    [myCell.posterView hu_setImageWithURL:[NSURL URLWithString:_URLStrings[indexPath.row]]];
    // 加载本地图片
    myCell.posterView.image = self.images[indexPath.row];
    return myCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    // 加载本地图片
     [HUPhotoBrowser showFromImageView:cell.posterView withImages:self.images placeholderImage:nil atIndex:indexPath.row dismiss:nil];
    // 加载网络图片
//    [HUPhotoBrowser showFromImageView:cell.posterView withURLStrings:_URLStrings atIndex:indexPath.row];
}

// 加载网络图片
- (void)getWebImages {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURL *url = [NSURL URLWithString:@"http://api.tietuku.com/v2/api/getrandrec?key=bJiYx5aWk5vInZRjl2nHxmiZx5VnlpZkapRuY5RnaGyZmsqcw5NmlsObmGiXYpU="];

    NSURLRequest *repuest = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:repuest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        NSArray *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];


        for (NSDictionary *dict in result) {
            NSString *linkurl = dict[@"linkurl"];

            [_URLStrings addObject:linkurl];
        }
        dispatch_async(dispatch_get_main_queue(), ^{

            [self.collectionView reloadData];
        });

    }];
    [task resume];
}


// 加载本地图片
- (NSArray *)images {
    if (!_images) {
        NSArray *array =  @[@"default_bag",@"default_bag",@"default_bag",@"default_bag",@"default_bag"];
        NSMutableArray *images = [NSMutableArray arrayWithCapacity:array.count];
        for (NSString *named in array) {
            UIImage *img = [UIImage imageNamed:named];
            [images addObject:img];
        }
        _images = [NSArray arrayWithArray:images];
    }
    return _images;
}

#pragma mark - 聊天和预约 -
- (void)appointmentView{
    
    UIView *appointmentView = [[UIView alloc] init];
    [self.view addSubview:appointmentView];
    appointmentView.userInteractionEnabled = YES;
    appointmentView.backgroundColor = [UIColor greenColor];
    [appointmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.left.right.bottom.mas_equalTo(0);
    }];
    
    UIView *botView = [[UIView alloc] init];
    [appointmentView addSubview:botView];
    botView.backgroundColor = [UIColor colorWithHexString:@"#666666"];
    [botView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.left.right.mas_equalTo(0);
        make.top.equalTo(appointmentView);
    }];
    
    // 聊天触发事件
    UIButton *chatBtn = [[UIButton alloc] init];
    [appointmentView addSubview:chatBtn];
    chatBtn.backgroundColor = [UIColor whiteColor];
    [chatBtn addTarget:self action:@selector(chatTap:) forControlEvents:UIControlEventTouchUpInside];
    [chatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.left.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(130);
    }];

    UIImageView *chatImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gr_lt"]];
    [chatBtn addSubview:chatImg];
    [chatImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(chatBtn);
        make.left.mas_equalTo(40);
    }];
    UILabel *chatLabel = [[UILabel alloc] init];
    [chatBtn addSubview:chatLabel];
    chatLabel.text = @"聊天";
    chatLabel.font = [UIFont systemFontOfSize:15.0f];
    chatLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    [chatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(chatBtn);
        make.left.equalTo(chatImg.mas_right).offset(8);
    }];
    
    // 预约触发事件
    UIButton *appointmentBtn = [[UIButton alloc] init];
    [appointmentView addSubview:appointmentBtn];
    appointmentBtn.backgroundColor = [UIColor colorWithHexString:@"#fb6030"];
    [appointmentBtn addTarget:self action:@selector(appointmentTap:) forControlEvents:UIControlEventTouchUpInside];
    [appointmentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.right.top.bottom.mas_equalTo(0);
        make.left.equalTo(chatBtn.mas_right);
    }];
    
    UILabel *appointmentLabel = [[UILabel alloc] init];
    [appointmentView addSubview:appointmentLabel];
    appointmentLabel.text = @"预约";
    appointmentLabel.font = [UIFont systemFontOfSize:17.0f];
    appointmentLabel.textColor = [UIColor whiteColor];
    [appointmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(appointmentBtn);
        make.center.equalTo(appointmentBtn);
    }];
    
}

- (void)chatTap:(UIButton *)sender
{
    NSLog(@"聊天");
}
- (void)appointmentTap:(UIButton *)sender
{
    NSLog(@"预约");
    WYAppointmentDetailController *appointmentVC = [[WYAppointmentDetailController alloc] init];
    appointmentVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:appointmentVC animated:YES];
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
































