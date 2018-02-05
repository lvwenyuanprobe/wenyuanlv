//
//  WYBreifController.m
//  mybigbrother
//
//  Created by Loren on 2018/1/10.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "WYBreifController.h"
#import "RemarksCellHeightModel.h"
#import "RemarksTableViewCell.h"
#import "UIImageView+WebCache.h"


static NSString *IdentifierCell0 = @"Cell0";
static NSString *IdentifierCell1 = @"Cell1";
static NSString *IdentifierCell2 = @"Cell2";
static NSString *IdentifierCell3 = @"Cell3";
static NSString *IdentifierCell4 = @"Cell4";

@interface WYBreifController ()<UITableViewDelegate,UITableViewDataSource, RemarksCellDelegate>
{
    BOOL _isShow; // 是否展开
    NSString *_cellContentStr; // 备注消息
}

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation WYBreifController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
    self.hidesBottomBarWhenPushed = YES;
    [self loadDataSource];
    [self tableView];
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
    
    self.title = @"个人简介";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    
    [self setupUI];
}

- (void)setupUI{
    
}

#pragma mark - tableView Delegate && DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2 || section == 3 || section == 4) {
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 80;
    }else if (indexPath.section == 1){
        return 60;
    }else if (indexPath.section == 2 && indexPath.row == 0){
        return 60;
    }
    else if (indexPath.section == 2 && indexPath.row == 1) {
        return [RemarksCellHeightModel cellHeightWith:_cellContentStr andIsShow:_isShow andLableWidth:BOUNDS.size.width-30 andFont:15 andDefaultHeight:125 andFixedHeight:52 andIsShowBtn:4];
    }else if(indexPath.section == 3) {
        return 60;
    }else{
        return 80;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSIndexPath *indexPath = [[NSIndexPath alloc] initWithIndex:section];
    if (indexPath.section == 0) {
        return 0.00000001f;
    }else{
        return 10.0f;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //取消选中效果
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IdentifierCell0];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IdentifierCell0];
        }
        cell.textLabel.text = [self.dicItem valueForKey:@"title"];
        cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#282828"];
        cell.backgroundColor = [UIColor whiteColor];
        
        // 设置头像
        UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiaoshou.jpg"]];
        [cell addSubview:iconView];
        
        //图片
        UIImage *placeImage = [UIImage imageNamed:@"default_big"];
        NSString *imageName = [self.dicItem valueForKey:@"cover"];
        NSURL *url = [NSURL URLWithString:imageName];
        [iconView sd_setImageWithURL:url
                            placeholderImage:placeImage
                                     options:SDWebImageRetryFailed
                                    progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                        NSLog(@"下载进度--%f",(double)receivedSize/expectedSize);
                                    }
                                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                       NSLog(@"图片下载完成！");
                                   }];
        
        
        
        iconView.contentMode=UIViewContentModeScaleAspectFill;
        iconView.clipsToBounds=YES;
        iconView.layer.cornerRadius = 10;
        iconView.layer.masksToBounds = YES;
        [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.equalTo(cell);
            make.width.height.mas_equalTo(60);
        }];
        
        return cell;
        
    }else if (indexPath.section == 1){
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IdentifierCell1];
        }
        cell.textLabel.text = @"课程:";
        cell.textLabel.font = [UIFont systemFontOfSize:18.0f];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#282828"];
        cell.backgroundColor = [UIColor whiteColor];
        
        UILabel *coureName = [[UILabel alloc] init];
        [cell addSubview:coureName];
        coureName.text = [self.dicItem valueForKey:@"mainlecture"];
        coureName.font = [UIFont systemFontOfSize:16.0f];
        coureName.textColor = [UIColor colorWithHexString:@"#050505"];
        [coureName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(70);
            make.centerY.equalTo(cell);
        }];
        
        return cell;
        
    }else if (indexPath.section == 2 && indexPath.row == 0){
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IdentifierCell3];
        }
        cell.textLabel.text = @"简介";
        cell.textLabel.font = [UIFont systemFontOfSize:18.0f];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#050505"];
        cell.backgroundColor = [UIColor whiteColor];
        // 分割线View
        UIView *lineView = [[UIView alloc] init];
        [cell addSubview:lineView];
        lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(cell);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(1);
        }];
        
        return cell;
    }
    else if(indexPath.section == 2 && indexPath.row == 1) {
        
        RemarksTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IdentifierCell2];
        if (!cell) {
            cell = [[RemarksTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:IdentifierCell2];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setCellContent:_cellContentStr andIsShow:_isShow  andCellIndexPath:indexPath];
        
        return cell;
        
    }else if (indexPath.section == 3 && indexPath.row == 0){
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IdentifierCell3];
        }
        cell.textLabel.text = @"课程特色";
        cell.textLabel.font = [UIFont systemFontOfSize:18.0f];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#050505"];
        cell.backgroundColor = [UIColor whiteColor];

        // 分割线View
        UIView *lineView = [[UIView alloc] init];
        [cell addSubview:lineView];
        lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(cell);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(1);
        }];
        
        return cell;
    }else if (indexPath.section == 3 && indexPath.row == 1){
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IdentifierCell3];
        }
        cell.textLabel.text = [self.dicItem valueForKey:@"fecture"];
        cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        cell.backgroundColor = [UIColor whiteColor];
        
        return cell;
    }
    else if(indexPath.section == 4 && indexPath.row == 0) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IdentifierCell4];
        }
        cell.textLabel.text = @"老师寄语";
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont systemFontOfSize:18.0f];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#050505"];
        // 分割线View
        UIView *lineView = [[UIView alloc] init];
        [cell addSubview:lineView];
        lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(cell);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(1);
        }];
        
        return cell;
    }else if(indexPath.section == 4 && indexPath.row == 1) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IdentifierCell4];
        }
        cell.textLabel.text = [self.dicItem valueForKey:@"verb"];
        cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.numberOfLines = 0;
        
        return cell;
    }
    return 0;
}

#pragma mark -- Dalegate
- (void)remarksCellShowContrntWithDic:(NSDictionary *)dic andCellIndexPath:(NSIndexPath *)indexPath
{
    _isShow = [[NSString stringWithFormat:@"%@",[dic objectForKey:@"isShow"]] boolValue];
    [_tableView reloadData];
}

#pragma mark - LAyoutUI

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeigth - 44) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:IdentifierCell0];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:IdentifierCell1];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:IdentifierCell3];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:IdentifierCell4];
        [self.view addSubview:_tableView];
        
        
        // iOS11默认开启Self-Sizing，关闭Self-Sizing即可。
        self.tableView.estimatedRowHeight = 0.01;
        _tableView.sectionHeaderHeight = 0.01;
        _tableView.sectionFooterHeight = 0.01;
        _tableView.separatorStyle = UITableViewCellAccessoryNone;
    }
    return _tableView;
}

- (void)loadDataSource {
    
//    _cellContentStr = @"互联网（英语：Internet），又称网际网络，或音译因特网(Internet)、英特网，互联网始于1969年美国的阿帕网。是网络与网络之间所串连成的庞大网络，这些网络以一组通用的协议相连，形成逻辑上的单一巨大国际网络。通常internet泛指互联网，而Internet则特指因特网。";
    
    _cellContentStr = [self.dicItem valueForKey:@"breif"];
    
}

// 处理分割线不到头问题
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)viewDidLayoutSubviews {
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
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
