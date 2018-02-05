//
//  Created by CoderKo1o.
//  Copyright © 2016 iphone5solo. All rights reserved.
//

#import "PYTempViewController.h"
#import "PYSearchConst.h"
#import "WYCourseGuidanceCell.h"
#import "UIImageView+WebCache.h"
#import "WYBreifController.h"
#import "WYVideoPlayerController.h"

//屏幕尺寸
#define CIO_SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define CIO_SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

 static NSString * const CourseCellID = @"CourseCellID";

@interface PYTempViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate,UISearchBarDelegate>

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation PYTempViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"课程辅导";
    self.navigationItem.hidesBackButton = YES;
//    self.view.backgroundColor = PYSEARCH_RANDOM_COLOR;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.resultTableview];
    self.resultTableview.tableFooterView = [UIView new];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WYCourseGuidanceCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CourseCellID];
    if (!cell1) {
        
        cell1 = [[WYCourseGuidanceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CourseCellID];
        //        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    // 测试暂时先用讲师名称代替
    NSDictionary *dic = self.dataArray[indexPath.row];
    cell1.teacherName.text = dic[@"title"];
    cell1.mainLectureName.text = dic[@"mainlecture"];
    cell1.message.text = dic[@"play_number"];
    
    //图片
    UIImage *placeImage = [UIImage imageNamed:@"default_big"];
    NSString *imageName = dic[@"cover"];
    NSURL *url = [NSURL URLWithString:imageName];
    [cell1.iconImgView sd_setImageWithURL:url
                        placeholderImage:placeImage
                                 options:SDWebImageRetryFailed
                                progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                    NSLog(@"下载进度--%f",(double)receivedSize/expectedSize);
                                }
                               completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                   NSLog(@"图片下载完成！");
                               }];
    
    [cell1 goToBreifVCBlock:^(NSString *ButtonText) {
        WYBreifController *breifVC = [[WYBreifController alloc] init];
        breifVC.hidesBottomBarWhenPushed = YES;
        breifVC.dicItem = dic;
        [self.navigationController pushViewController:breifVC animated:YES];
    }];
    
    return cell1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WYVideoPlayerController *VC = [[WYVideoPlayerController alloc] init];
    VC.dicItem = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:VC animated:YES];
    self.hidesBottomBarWhenPushed = YES;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

-(UITableView* )resultTableview{
    
    if (!_resultTableview) {
        
    _resultTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CIO_SCREEN_WIDTH, CIO_SCREEN_HEIGHT)];
    //        _resultTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _resultTableview.delegate = self;
    _resultTableview.dataSource = self;
    _resultTableview.backgroundColor  = [UIColor whiteColor];
     [_resultTableview registerClass:[WYCourseGuidanceCell class] forCellReuseIdentifier:CourseCellID];
        
    }
    
    return _resultTableview;
}

#pragma mark 下面的话题
-(NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc]init];
    }
    
    return _dataArray;
}

-(void)setResultArray:(NSMutableArray *)resultArray{
    
    _resultArray = resultArray;
    
    [self.dataArray removeAllObjects];
    
    [self.dataArray addObjectsFromArray:_resultArray];
    
    [self.resultTableview reloadData];
    
}

-(void)remAllobect{
    
    [self.dataArray removeAllObjects];
    [self.resultTableview reloadData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setBackBtn];
}

#pragma mark - 自定义返回按钮 -

- (void)setBackBtn
{
    //返回按钮
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.adjustsImageWhenHighlighted = NO;
    leftButton.frame=CGRectMake(10, 0, 30, 30);
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
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


@end
