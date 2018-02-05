//
//  WYVideoPlayerController.m
//  mybigbrother
//
//  Created by Loren on 2018/1/11.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "WYVideoPlayerController.h"
#import "CLPlayerView.h"
#import "UIView+CLSetRect.h"
#import "WYRelateVideoCell.h"
#import "UIImageView+WebCache.h"

#define CLheight    self.view.CLwidth

static NSString * const RelateVideoCellID = @"RelateVideoCellID";

@interface WYVideoPlayerController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *arrayDate;
}
/**CLplayer*/
@property (nonatomic,weak) CLPlayerView *playerView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *headView;
@property (nonatomic,strong) UIView *lineOne;
@property (nonatomic,strong) UIView *lineTwo;
@property (nonatomic,strong) UIView *botoomView;
@property (nonatomic,strong) UIView *botoomline;
@property (nonatomic,strong) UIView *lineThree;
@property (nonatomic,strong) UILabel *teacher;
@property (nonatomic,strong) UILabel *coruse;
@property (nonatomic,strong) UILabel *playerNumber;
@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UILabel *teacher2;
@end

@implementation WYVideoPlayerController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;
//    [self setBackBtn];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationItem.hidesBackButton = YES;
    
    [self CreateVideoUI];
    [self relatedVideoUI];
    [self setHeaderViewUI];
    [self shareButton];
    [self VideoMessage];
    [self requestData];
    
}

- (void)CreateVideoUI{
    
    CLPlayerView *playerView = [[CLPlayerView alloc] initWithFrame:CGRectMake(0, 0, self.view.CLwidth, 9 * CLheight / 16)];
    _playerView = playerView;
    [self.view addSubview:_playerView];
    
    [self backButton];
    
    //    //重复播放，默认不播放
    _playerView.repeatPlay = NO;
    //    //当前控制器是否支持旋转，当前页面支持旋转的时候需要设置，告知播放器
    _playerView.isLandscape = YES;
    //    //全屏是否隐藏状态栏，默认一直不隐藏
    _playerView.fullStatusBarHiddenType = FullStatusBarHiddenFollowToolBar;
    //顶部工具条隐藏样式，默认不隐藏
    _playerView.topToolBarHiddenType = TopToolBarHiddenSmall;
    //视频地址
//    _playerView.url = [NSURL URLWithString:@"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"];
    _playerView.url = [NSURL URLWithString:[self.dicItem valueForKey:@"mp4_url"]];
    //播放
    [_playerView playVideo];
    //返回按钮点击事件回调,小屏状态才会调用，全屏默认变为小屏
    [_playerView backButton:^(UIButton *button) {
        NSLog(@"返回按钮被点击");
    }];
    //播放完成回调
    [_playerView endPlay:^{
        NSLog(@"播放完成");
    }];
}

-(void)viewDidDisappear:(BOOL)animated{
    [_playerView destroyPlayer];
}

- (void)relatedVideoUI{
    
    // 创建tableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 9 * CLheight / 16, kScreenWidth, kScreenHeight-(9 * CLheight / 16)) style:UITableViewStylePlain];
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [_tableView registerClass:[WYRelateVideoCell class] forCellReuseIdentifier:RelateVideoCellID];
    [self.view addSubview:_tableView];
    
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 183)];
    self.tableView.tableHeaderView = _headView;
    _headView.backgroundColor = [UIColor whiteColor];
    
    
}

#pragma mark - TableViewDelegate && dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return arrayDate.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WYRelateVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:RelateVideoCellID forIndexPath:indexPath];
    NSDictionary *itemDic = arrayDate[indexPath.row];

    cell.teacher.text = [itemDic valueForKey:@"title"];
    cell.coruse.text = [itemDic valueForKey:@"mainlecture"];
    cell.playerNumber.text = [NSString stringWithFormat:@"%@ 次播放",[itemDic valueForKey:@"play_number"]];
    //图片
    UIImage *placeImage = [UIImage imageNamed:@"default_big"];
    NSString *imageName = [itemDic valueForKey:@"cover"];
    NSURL *url = [NSURL URLWithString:imageName];
    [cell.teacherIcon sd_setImageWithURL:url
                        placeholderImage:placeImage
                                 options:SDWebImageRetryFailed
                                progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                    NSLog(@"下载进度--%f",(double)receivedSize/expectedSize);
                                }
                               completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                   NSLog(@"图片下载完成！");
                               }];
    
    return cell;
    
}

// 切换视频
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *itemDic = arrayDate[indexPath.row];

    _playerView.url = [NSURL URLWithString:[itemDic valueForKey:@"mp4_url"]];
    [_playerView playVideo];
    
    self.teacher.text = [itemDic valueForKey:@"title"];
    self.coruse.text = [itemDic valueForKey:@"mainlecture"];
    self.playerNumber.text = [NSString stringWithFormat:@"%@ 次播放",[itemDic valueForKey:@"play_number"]];
    self.teacher2.text = [itemDic valueForKey:@"title"];
    
    //图片
    UIImage *placeImage = [UIImage imageNamed:@"default_big"];
    NSString *imageName = [itemDic valueForKey:@"cover"];
    NSURL *url = [NSURL URLWithString:imageName];
    [self.iconView sd_setImageWithURL:url
                        placeholderImage:placeImage
                                 options:SDWebImageRetryFailed
                                progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                    NSLog(@"下载进度--%f",(double)receivedSize/expectedSize);
                                }
                               completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                   NSLog(@"图片下载完成！");
                               }];
    
    [WYCustomAlter showMessage:@"正在切换"];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)requestData{
    
    // 获取JSON文件所在的路径
    NSString* jsonPath = [[NSBundle mainBundle] pathForResource:@"ralateVideo"
                                                         ofType:@"json"];
    // 读取jsonPath对应文件的数据
    NSData* data = [NSData dataWithContentsOfFile:jsonPath];
    // 解析JSON数据，返回Objective-C对象
    NSMutableDictionary  *parseResult = [NSJSONSerialization JSONObjectWithData:data
                                                                        options:0 error:nil];
    arrayDate =[parseResult valueForKey:@"VAP4BFR16"];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0f;
}

#pragma mark -- 需要设置全局支持旋转方向，然后重写下面三个方法可以让当前页面支持多个方向
// 是否支持自动转屏
- (BOOL)shouldAutorotate {
    return YES;
}
// 支持哪些屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}
// 默认的屏幕方向（当前ViewController必须是通过模态出来的UIViewController（模态带导航的无效）方式展现出来的，才会调用这个方法）
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

// 视频信息
- (void)VideoMessage
{
    UILabel *teacherLabel = [[UILabel alloc] init];
    [_headView addSubview:teacherLabel];
    teacherLabel.text = @"讲师:";
    teacherLabel.textColor = [UIColor colorWithHexString:@"#000000"];
    teacherLabel.font = [UIFont systemFontOfSize:15.0f];
    [teacherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(19);
        make.top.mas_equalTo(19);
    }];
    
    // 赋值 - 讲师名称
    UILabel *teacher = [[UILabel alloc] init];
    [_headView addSubview:teacher];
    self.teacher = teacher;
    teacher.text = [self.dicItem valueForKey:@"title"];
    teacher.textColor = [UIColor colorWithHexString:@"#000000"];
    teacher.font = [UIFont systemFontOfSize:15.0f];
    [teacher mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(teacherLabel);
        make.left.equalTo(teacherLabel.mas_right).offset(10);
    }];
    
    UILabel *coruseLabel = [[UILabel alloc] init];
    [_headView addSubview:coruseLabel];
    coruseLabel.text = @"主讲:";
    coruseLabel.textColor = [UIColor colorWithHexString:@"#000000"];
    coruseLabel.font = [UIFont systemFontOfSize:15.0f];
    [coruseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(teacherLabel);
        make.left.equalTo(teacher.mas_right).offset(20);
    }];
    
    // 赋值 - 课程名称
    UILabel *coruse = [[UILabel alloc] init];
    [_headView addSubview:coruse];
    self.coruse = coruse;
    coruse.text = [self.dicItem valueForKey:@"mainlecture"];
    coruse.textColor = [UIColor colorWithHexString:@"#000000"];
    coruse.font = [UIFont systemFontOfSize:15.0f];
    [coruse mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(teacherLabel);
        make.left.equalTo(coruseLabel.mas_right).offset(10);
    }];
    
    // 赋值 - 播放次数
    UILabel *playerNumber = [[UILabel alloc] init];
    [_headView addSubview:playerNumber];
    self.playerNumber = playerNumber;
    playerNumber.text = [NSString stringWithFormat:@"%@ 次播放",[self.dicItem valueForKey:@"play_number"]];
    playerNumber.textColor = [UIColor colorWithHexString:@"#999999"];
    playerNumber.font = [UIFont systemFontOfSize:12.0f];
    [playerNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(teacherLabel);
        make.top.equalTo(teacherLabel.mas_bottom).offset(10);
    }];
    
    // 赋值 - 头像
    UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiaoshou.jpg"]];
    [_botoomView addSubview:iconView];
    self.iconView = iconView;
    
    //图片
    UIImage *placeImage = [UIImage imageNamed:@"default_big"];
    NSString *imageName = [self.dicItem valueForKey:@"cover"];
    NSURL *url = [NSURL URLWithString:imageName];
    [self.iconView sd_setImageWithURL:url
                     placeholderImage:placeImage
                              options:SDWebImageRetryFailed
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 NSLog(@"下载进度--%f",(double)receivedSize/expectedSize);
                             }
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                NSLog(@"图片下载完成！");
                            }];
    
    iconView.contentMode = UIViewContentModeScaleAspectFill;
    iconView.clipsToBounds = YES;
    iconView.layer.cornerRadius = 8;
    iconView.layer.masksToBounds = YES;
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(34);
        make.centerY.equalTo(_botoomView);
        make.left.mas_equalTo(20);
    }];
    
    // 讲师名称
    UILabel *teacher2 = [[UILabel alloc] init];
    [_botoomView addSubview:teacher2];
    self.teacher2 = teacher2;
    teacher2.text = [self.dicItem valueForKey:@"title"];
    teacher2.textColor = [UIColor colorWithHexString:@"#282828"];
    teacher2.font = [UIFont systemFontOfSize:16.0f];
    [teacher2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_botoomView);
        make.left.equalTo(iconView.mas_right).offset(10);
    }];
    
    // + 收藏
    UIButton *collectBtn = [[UIButton alloc] init];
    [_botoomView addSubview:collectBtn];
    [collectBtn setTitle:@"+ 收藏" forState:UIControlStateNormal];
    collectBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [collectBtn setTitleColor:[UIColor colorWithHexString:@"#fb6030"] forState:UIControlStateNormal];
    [collectBtn addTarget:self action:@selector(collection_click) forControlEvents:UIControlEventTouchUpInside];
    [collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_botoomView);
        make.right.mas_equalTo(-20);
    }];
    
    UILabel *relateVideoLabel = [[UILabel alloc] init];
    [_headView addSubview:relateVideoLabel];
    relateVideoLabel.text = @"相关视频";
    relateVideoLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    relateVideoLabel.font = [UIFont systemFontOfSize:15.0f];
    [relateVideoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(teacherLabel);
        make.bottom.mas_equalTo(-20);
    }];
    
}

// 分享按钮
- (void)shareButton{
    
    UIButton *shareBtn = [[UIButton alloc] init];
    [_playerView addSubview:shareBtn];
    [shareBtn addTarget:self action:@selector(shareButton_click) forControlEvents:UIControlEventTouchUpInside];
    [shareBtn setImage:[UIImage imageNamed:@"share4"] forState:UIControlStateNormal];
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    }];
}

// 返回按钮
- (void)backButton{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playerView addSubview:leftButton];
    leftButton.adjustsImageWhenHighlighted = NO;
    leftButton.frame=CGRectMake(0, 20, 60, 30);
    [leftButton setImage:[UIImage imageNamed:@"share2"] forState:UIControlStateNormal];
    //设置返回按钮的图片，跟系统自带的“<”符合保持一致
    [leftButton addTarget:self action:@selector(back_click) forControlEvents:UIControlEventTouchUpInside];
}
// 隐藏状态栏
//- (BOOL)prefersStatusBarHidden {
//    return YES;
//}
- (UIStatusBarStyle)preferredStatusBarStyle {
    // 返回你所需要的状态栏样式
    return UIStatusBarStyleLightContent;
}

- (void)setHeaderViewUI{
    
    // 分割线1
    _lineOne = [[UIView alloc] init];
    [_headView addSubview:_lineOne];
    _lineOne.backgroundColor = [UIColor colorWithHexString:@"#cfcfcf"];
    [_lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
        make.top.mas_equalTo(75);
    }];
    // 分割线2
    _lineTwo = [[UIView alloc] init];
    [_headView addSubview:_lineTwo];
    _lineTwo.backgroundColor = [UIColor colorWithHexString:@"#cfcfcf"];
    [_lineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
        make.bottom.mas_equalTo(-54);
    }];
    // 中间View的botoomView
    _botoomView = [[UIView alloc] init];
    [_headView addSubview:_botoomView];
    _botoomView.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    [_botoomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(_lineOne.mas_bottom);
        make.bottom.equalTo(_lineTwo.mas_top);
    }];
    _botoomline = [[UIView alloc] init];
    [_headView addSubview:_botoomline];
    _botoomline.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    [_botoomline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(5);
        make.bottom.equalTo(_headView);
    }];
    // 分割线3
    _lineThree = [[UIView alloc] init];
    [_headView addSubview:_lineThree];
    _lineThree.backgroundColor = [UIColor colorWithHexString:@"#cfcfcf"];
    [_lineThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
        make.bottom.equalTo(_botoomline.mas_top);
    }];
    
}


// 分割线重置
-(void)viewDidLayoutSubviews {
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
}

// 收藏按钮
- (void)collection_click
{
    NSLog(@"收藏");
}


- (void)shareButton_click
{
    NSLog(@"分享视频");
}

- (void)back_click
{
    // 返回上一级页面
    [self.navigationController popViewControllerAnimated:NO];
    
}


@end
