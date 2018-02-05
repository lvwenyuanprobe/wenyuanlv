//
//  WYCourseGuidanceController.m
//  mybigbrother
//
//  Created by Loren on 2018/1/9.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "WYCourseGuidanceController.h"
#import "WYCourseGuidanceCell.h"
#import "UIView+Utils.h"
#import "WYVideoPlayerController.h"
#import "WYBreifController.h"
#import "UIImageView+WebCache.h"
#import "NDSearchTool.h"
#import "PYTempViewController.h"

// 搜索
#import "PYSearch.h"

static NSString * const CourseGuidanceCellID = @"CourseGuidanceCellID";
static NSString * const CourseGuidanceCellID1 = @"CourseGuidanceCellID1";

@interface WYCourseGuidanceController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,PYSearchViewControllerDelegate>
{
    NSMutableArray *arrayDate;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar * searchBar ;
@property (nonatomic, strong) UIButton *customSearchBar;
// 1bu
@property(nonatomic,strong)NSMutableArray *resultArray;

@end

@implementation WYCourseGuidanceController

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
    self.navigationItem.hidesBackButton = YES;
    
    // 2bu
     self.resultArray = [NSMutableArray arrayWithCapacity:0];
   
    [self setupUI];
    [self setNav];
    [self requestData];
    [self searchViewDidLoad];

}

/** 自定义导航栏*/
- (void)setNav{

    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 120, 30)];
    searchView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationItem.titleView = searchView;
    searchView.layer.cornerRadius = 15;
    searchView.layer.masksToBounds = YES;
    searchView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchViewTap)];
    [searchView addGestureRecognizer:recognizer];

    UIImageView *searchImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kc_ss"]];
    [searchView addSubview:searchImg];
    searchImg.frame =CGRectMake(searchView.bounds.size.width/2 - 70, searchView.bounds.size.height/2 - 7, 15, 15);
    
    UILabel *label = [[UILabel alloc] init];
    [searchView addSubview:label];
    label.text = @"请输入课程或者讲师";
    label.font = [UIFont systemFontOfSize:14.0f];
    label.textColor = [UIColor colorWithHexString:@"#999999"];
    label.frame = CGRectMake(searchView.bounds.size.width/2 - 50, searchView.bounds.size.height/2 - 15, 150, 30);
    
}

#pragma mark - 名校师兄搜索功能 -

- (void)searchViewDidLoad{
 
}

// 3bu
- (void)searchViewTap
{
    NSLog(@"点击手势");
    
    // 1. 创建一个“热门搜索数组”
    NSArray *hotSeaches = @[@"SAT", @"TOEFL", @"SSAT", @"IELTS", @"ACT", @"A-level", @"AP", @"BEC"];
    
    // 2. 创建一个搜索视图控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:NSLocalizedString(@"Search", @"搜索") didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        
        // 4bu    搜索结果
        PYTempViewController *py = [[PYTempViewController alloc] init];
        py.resultArray = self.resultArray;
        [searchViewController.navigationController pushViewController:py animated:YES];
        
    }];
    
    // 3. 设置搜索历史
    searchViewController.hotSearchStyle = PYHotSearchStyleColorfulTag; // 热门搜索
    searchViewController.searchHistoryStyle = PYHotSearchStyleDefault; // 搜索历史
    
    // 4. 设置搜索代理
    searchViewController.delegate = self;
    
    // 5. 弹出一个 navigation controller
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav animated:YES completion:nil];
    
}

// 5bu
#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    [self.resultArray removeAllObjects];
    if (searchText!=nil && searchText.length>0) {
        // Simulate a send request to get a search suggestions
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (NSDictionary *dic in arrayDate) {
                NSString *tempStr = [NSString stringWithFormat:@"%@ %@",dic[@"title"],dic[@"mainlecture"]];
                //----------->把所有的搜索结果转成成拼音
                NSString *pinyin = [self transformToPinyin:tempStr];
                NSLog(@"pinyin--%@",pinyin);
                
                if ([pinyin rangeOfString:searchText options:NSCaseInsensitiveSearch].length >0 ) {
                    //把搜索结果存放self.resultArray数组
                    [searchSuggestionsM addObject:tempStr];
                    [self.resultArray addObject:dic];
                }
            }
            // Refresh and display the search suggustions
            searchViewController.searchSuggestions = searchSuggestionsM;
        });
    }
}

// 7bu
- (void)searchViewController:(PYSearchViewController *)searchViewController
   didSelectHotSearchAtIndex:(NSInteger)index
                  searchText:(NSString *)searchText{
    
    [self.resultArray removeAllObjects];
    if (searchText!=nil && searchText.length>0) {
        // Simulate a send request to get a search suggestions
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (NSDictionary *dic in arrayDate) {
                NSString *tempStr = [NSString stringWithFormat:@"%@ %@",dic[@"title"],dic[@"mainlecture"]];
                //----------->把所有的搜索结果转成成拼音
                NSString *pinyin = [self transformToPinyin:tempStr];
                NSLog(@"pinyin--%@",pinyin);
                
                if ([pinyin rangeOfString:searchText options:NSCaseInsensitiveSearch].length >0 ) {
                    //把搜索结果存放self.resultArray数组
                    [searchSuggestionsM addObject:tempStr];
                    [self.resultArray addObject:dic];
                }
            }
            // Refresh and display the search suggustions
            searchViewController.searchSuggestions = searchSuggestionsM;
        });
    }
}

// 8bu
- (void)searchViewController:(PYSearchViewController *)searchViewController
didSelectSearchHistoryAtIndex:(NSInteger)index
                  searchText:(NSString *)searchText{
    
    [self.resultArray removeAllObjects];
    if (searchText!=nil && searchText.length>0) {
        // Simulate a send request to get a search suggestions
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (NSDictionary *dic in arrayDate) {
                NSString *tempStr = [NSString stringWithFormat:@"%@ %@",dic[@"title"],dic[@"mainlecture"]];
                //----------->把所有的搜索结果转成成拼音
                NSString *pinyin = [self transformToPinyin:tempStr];
                NSLog(@"pinyin--%@",pinyin);
                
                if ([pinyin rangeOfString:searchText options:NSCaseInsensitiveSearch].length >0 ) {
                    //把搜索结果存放self.resultArray数组
                    [searchSuggestionsM addObject:tempStr];
                    [self.resultArray addObject:dic];
                }
            }
            // Refresh and display the search suggustions
            searchViewController.searchSuggestions = searchSuggestionsM;
        });
    }
}

- (void)setupUI{
    
    // 创建tableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerClass:[WYCourseGuidanceCell class] forCellReuseIdentifier:CourseGuidanceCellID];
    [_tableView registerClass:[WYCourseGuidanceCell class] forCellReuseIdentifier:CourseGuidanceCellID1];
    
    [self.view addSubview:_tableView];
    
    // 客服
    UIButton *nounButton = [[UIButton alloc] init];
    [nounButton setImage:[UIImage imageNamed:@"sx_xz"] forState:UIControlStateNormal];
        [nounButton addTarget:self action:@selector(nounInfo) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *nounButtonItem = [[UIBarButtonItem alloc] initWithCustomView:nounButton];
    self.navigationItem.rightBarButtonItem = nounButtonItem;
    [nounButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(20);
    }];
}

- (void)nounInfo{
    
    /** 咨询*/
    NSMutableString *str =[[NSMutableString alloc] initWithFormat:@"telprompt://%@", @"010-56617246"];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
}

- (void)requestData{
    
    // 获取JSON文件所在的路径
    NSString* jsonPath = [[NSBundle mainBundle] pathForResource:@"Video"
                                                         ofType:@"json"];
    // 读取jsonPath对应文件的数据
    NSData* data = [NSData dataWithContentsOfFile:jsonPath];
    // 解析JSON数据，返回Objective-C对象
    NSMutableDictionary  *parseResult = [NSJSONSerialization JSONObjectWithData:data
                                                                        options:0 error:nil];
    arrayDate =[parseResult valueForKey:@"VAP4BFR16"];
    
}

#pragma mark - TableViewDelegate && dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return arrayDate.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WYCourseGuidanceCell *cell = [tableView dequeueReusableCellWithIdentifier:CourseGuidanceCellID1 forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    
    NSDictionary *itemDic;
    itemDic = arrayDate[indexPath.row];
    
    cell.teacherName.text = [itemDic valueForKey:@"title"];
    cell.mainLectureName.text = [itemDic valueForKey:@"mainlecture"];
    cell.message.text = [itemDic valueForKey:@"play_number"];
    
    //图片
    UIImage *placeImage = [UIImage imageNamed:@"default_big"];
    NSString *imageName = [itemDic valueForKey:@"cover"];
    NSURL *url = [NSURL URLWithString:imageName];
    [cell.iconImgView sd_setImageWithURL:url
             placeholderImage:placeImage
             options:SDWebImageRetryFailed
             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                 NSLog(@"下载进度--%f",(double)receivedSize/expectedSize);
             }
             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                 NSLog(@"图片下载完成！");
             }];

    [cell goToBreifVCBlock:^(NSString *ButtonText) {
        WYBreifController *breifVC = [[WYBreifController alloc] init];
        breifVC.hidesBottomBarWhenPushed = YES;
        breifVC.dicItem = itemDic;
        [self.navigationController pushViewController:breifVC animated:YES];
    }];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WYVideoPlayerController *VC = [[WYVideoPlayerController alloc] init];
    VC.dicItem = arrayDate[indexPath.row];
    [self.navigationController pushViewController:VC animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 107.5f;
}


// 6bu
#pragma mark -- 私有方法
- (NSString *)transformToPinyin:(NSString *)dataStr{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:dataStr];
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    NSArray *pinyinArray = [str componentsSeparatedByString:@" "];
    NSMutableString *allString = [NSMutableString new];
    
    int count = 0;
    
    for (int  i = 0; i < pinyinArray.count; i++)
    {
        for(int i = 0; i < pinyinArray.count;i++)
        {
            if (i == count) {
                [allString appendString:@"#"];
                //区分第几个字母
            }
            [allString appendFormat:@"%@",pinyinArray[i]];
        }
        [allString appendString:@","];
        count ++;
    }
    NSMutableString *initialStr = [NSMutableString new];
    //拼音首字母
    for (NSString *s in pinyinArray)
    {
        if (s.length > 0)
        {
            [initialStr appendString:  [s substringToIndex:1]];
        }
    }
    [allString appendFormat:@"#%@",initialStr];
    [allString appendFormat:@",#%@",dataStr];
    return allString;
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
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end

