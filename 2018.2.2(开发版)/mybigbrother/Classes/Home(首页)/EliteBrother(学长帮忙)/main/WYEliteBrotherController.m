//
//  WYEliteBrotherController.m
//  mybigbrother
//
//  Created by Loren on 2018/1/5.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "WYEliteBrotherController.h"
#import "WYEliteBrotherCell.h"
#import "WYPersonCenterController.h"
/////
#import "MMComBoBoxView.h"
#import "MMComboBoxHeader.h"
#import "MMAlternativeItem.h"
#import "MMSelectedPath.h"
#import "MMCombinationItem.h"
#import "MMMultiItem.h"
#import "MMSingleItem.h"

#import "UIImageView+WebCache.h"

static NSString * const eliteBrotherCellID = @"eliteBrotherCellID";

@interface WYEliteBrotherController ()<UITableViewDelegate,UITableViewDataSource,MMComBoBoxViewDataSource, MMComBoBoxViewDelegate>
{
    NSMutableArray *arrayDate;
}
//  顶部btn
@property (nonatomic,strong) UIButton *leftBtn;
@property (nonatomic,strong) UIButton *rightBtn;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic, strong) NSArray *mutableArray;
@property (nonatomic, strong) MMComBoBoxView *comBoBoxView;
@end

@implementation WYEliteBrotherController

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
     [self.comBoBoxView dimissPopView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"学长帮忙";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    
    [self setUpTopView];
    [self requestData];
}

- (void)setUpTopView
{
    
    self.comBoBoxView = [[MMComBoBoxView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    self.comBoBoxView.dataSource = self;
    self.comBoBoxView.delegate = self;
    [self.view addSubview:self.comBoBoxView];
    [self.comBoBoxView reload];
    
    // 创建tableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight-124) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[WYEliteBrotherCell class] forCellReuseIdentifier:eliteBrotherCellID];
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
    
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(60);
        make.left.top.mas_equalTo(0);
        make.width.mas_equalTo(kScreenWidth/2);
    }];
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(60);
        make.right.top.mas_equalTo(0);
        make.width.mas_equalTo(kScreenWidth/2);
    }];
}

- (void)nounInfo{
    
    /** 咨询*/
    NSMutableString *str =[[NSMutableString alloc] initWithFormat:@"telprompt://%@", @"010-56617246"];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
    
}

- (void)requestData{
    
    // 获取JSON文件所在的路径
    NSString* jsonPath = [[NSBundle mainBundle] pathForResource:@"EliteBrother"
                                                         ofType:@"json"];
    // 读取jsonPath对应文件的数据
    NSData* data = [NSData dataWithContentsOfFile:jsonPath];
    // 解析JSON数据，返回Objective-C对象
    NSMutableDictionary  *parseResult = [NSJSONSerialization JSONObjectWithData:data
                                                                        options:0 error:nil];
    arrayDate =[parseResult valueForKey:@"data"];
}

#pragma mark - TableViewDelegate && dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return arrayDate.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

        WYEliteBrotherCell *cell = [tableView dequeueReusableCellWithIdentifier:eliteBrotherCellID forIndexPath:indexPath];
        
    NSDictionary *itemDic;
    itemDic = arrayDate[indexPath.row];
    
    cell.uiniversityName.text = [itemDic valueForKey:@"school"];
    cell.partTimeName.text = [itemDic valueForKey:@"service_scope"];
    cell.professinalName.text = [itemDic valueForKey:@"major"];
    cell.weekLabel.text = [itemDic valueForKey:@"free_time"];
    cell.starTime.text = [itemDic valueForKey:@"free_time_star"];
    cell.endTime.text = [itemDic valueForKey:@"free_time_end"];
    cell.priceLabel.text = [NSString stringWithFormat:@"$%@",[itemDic valueForKey:@"price"]];
    
    //图片
    UIImage *placeImage = [UIImage imageNamed:@"default_big"];
    NSString *imageName = [itemDic valueForKey:@"photo"];
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
    
    cell.backgroundColor = RGB(234, 233, 233);
        return cell;
    
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
////    DFWSCModle *model = self.dataArray[indexPath.row];
////    if (isNotEmptyNotNullString(model.mid)) {
//        WYPersonCenterController *VC = [[WYPersonCenterController alloc] init];
//        [self.navigationController pushViewController:VC animated:YES];
//        self.hidesBottomBarWhenPushed = YES;
////    }
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WYPersonCenterController *VC = [[WYPersonCenterController alloc] init];
    VC.dicItem = arrayDate[indexPath.row];
    [self.navigationController pushViewController:VC animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 107.5f;
}

#pragma mark - 筛选部分 -

#pragma mark - Action
- (void)respondsToButtonAction:(UIButton *)sender {
    WYEliteBrotherController *vc = [[WYEliteBrotherController alloc] init];
    vc.isMultiSelection = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - MMComBoBoxViewDataSource
- (NSUInteger)numberOfColumnsIncomBoBoxView :(MMComBoBoxView *)comBoBoxView {
    return self.mutableArray.count;
}

- (MMItem *)comBoBoxView:(MMComBoBoxView *)comBoBoxView infomationForColumn:(NSUInteger)column {
    return self.mutableArray[column];
}

#pragma mark - MMComBoBoxViewDelegate
- (void)comBoBoxView:(MMComBoBoxView *)comBoBoxViewd didSelectedItemsPackagingInArray:(NSArray *)array atIndex:(NSUInteger)index {
    MMItem *rootItem = self.mutableArray[index];
    switch (rootItem.displayType) {
        case MMPopupViewDisplayTypeNormal:
        case MMPopupViewDisplayTypeMultilayer:{
            //拼接选择项
            NSMutableString *title = [NSMutableString string];
            __block NSInteger firstPath;
            [array enumerateObjectsUsingBlock:^(MMSelectedPath * path, NSUInteger idx, BOOL * _Nonnull stop) {
                [title appendString:idx?[NSString stringWithFormat:@";%@",[rootItem findTitleBySelectedPath:path]]:[rootItem findTitleBySelectedPath:path]];
                if (idx == 0) {
                    firstPath = path.firstPath;
                }
            }];
            NSLog(@"当title为%@时，所选字段为 %@",rootItem.title ,title);
            break;}
        case MMPopupViewDisplayTypeFilters:{
            MMCombinationItem * combineItem = (MMCombinationItem *)rootItem;
            [array enumerateObjectsUsingBlock:^(NSMutableArray*  _Nonnull subArray, NSUInteger idx, BOOL * _Nonnull stop) {
                if (combineItem.isHasSwitch && idx == 0) {
                    for (MMSelectedPath *path in subArray) {
                        MMAlternativeItem *alternativeItem = combineItem.alternativeArray[path.firstPath];
                        NSLog(@"当title为: %@ 时，选中状态为: %d",alternativeItem.title,alternativeItem.isSelected);
                    }
                    return;
                }
                
                NSString *title;
                NSMutableString *subtitles = [NSMutableString string];
                for (MMSelectedPath *path in subArray) {
                    MMItem *firstItem = combineItem.childrenNodes[path.firstPath];
                    MMItem *secondItem = combineItem.childrenNodes[path.firstPath].childrenNodes[path.secondPath];
                    title = firstItem.title;
                    [subtitles appendString:[NSString stringWithFormat:@"  %@",secondItem.title]];
                }
                NSLog(@"当title为%@时，所选字段为 %@",title,subtitles);
            }];
            
            break;}
        default:
            break;
    }
}

#pragma mark - Getter
- (NSArray *)mutableArray {
    if (_mutableArray == nil) {
        NSMutableArray *mutableArray = [NSMutableArray array];
        //root 1
        MMSingleItem *rootItem1 = [MMSingleItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:nil];
        
        NSMutableString *title = [NSMutableString string];
        [rootItem1 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:YES titleName:@"全部" subtitleName:[NSString stringWithFormat:@"%ld",random()%10000] code:nil]];
        [title appendString:@"全部"];
        for (int i = 0; i < 100; i ++) {
            MMItem *subItem = [MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:NO titleName:[NSString stringWithFormat:@"蛋糕系列%d",i] subtitleName:[NSString stringWithFormat:@"%ld",random()%10000] code:nil];
            [rootItem1 addNode:subItem];
        }
        rootItem1.title = title;
        
        //root 2
        MMSingleItem *rootItem2 = [MMSingleItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:@"学校"];
        
        if (self.isMultiSelection)
            rootItem2.selectedType = MMPopupViewMultilSeMultiSelection;
        
        [rootItem2  addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:YES titleName:@"排序" subtitleName:nil code:nil]];
        [rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"哈佛大学"]]];
        [rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"斯坦福大学"]]];
        [rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"芝加哥大学"]]];
        [rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"宾夕法尼亚大学"]]];
        [rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"麻省理工学院"]]];
        [rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"加州大学伯克利分校"]]];
        [rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"哥伦比亚大学"]]];

        
        
        //root 4
        MMCombinationItem *rootItem4 = [MMCombinationItem itemWithItemType:MMPopupViewDisplayTypeUnselected isSelected:NO titleName:@"技能" subtitleName:nil];
        rootItem4.displayType = MMPopupViewDisplayTypeFilters;
        
        if (self.isMultiSelection)
            rootItem4.selectedType = MMPopupViewMultilSeMultiSelection;
        
        NSArray *arr = @[@{@"推荐":@[@"不限",@"家教",@"俱乐部策划",@"社交媒体助理",@"吧台服务员",@"写手",@"网站设计师",@"夜间核算员",@"客户协调员",@"特约摄影师"]}];
        
        for (NSDictionary *itemDic in arr) {
            MMItem *item4_A = [MMItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:[itemDic.allKeys lastObject]];
            [rootItem4 addNode:item4_A];
            for (int i = 0; i <  [[itemDic.allValues lastObject] count]; i++) {
                NSString *title = [itemDic.allValues lastObject][i];
                MMItem *item4_B = [MMItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:title];
                if (i == 0) {
                    item4_B.isSelected = YES;
                }
                [item4_A addNode:item4_B];
            }
        }
        
        [mutableArray addObject:rootItem2];
        [mutableArray addObject:rootItem4];
        _mutableArray  = [mutableArray copy];
    }
    return _mutableArray;
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










