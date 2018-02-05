//
//  HomeGetParntersView.m
//  mybigbrother
//
//  Created by SN on 2017/4/4.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "HomeGetParntersView.h"
#import "PartnerIconView.h"
#import "NewMethodIconView.h"
/** 横向刷新*/
#import "UIScrollView+PSRefresh.h"
#import "PartnersListController.h"
#import "PartnersCollectionController.h"
#import "TacticsBannerModel.h"
#import "TacticsShareModel.h"
#import "TacticsShareDetailController.h"

#import "SNBrotherShareViewController.h"
#import "SNStrategyViewController.h"

static NSString * const CellId = @"PartnerIconView";
static NSString * const NewCellId = @"NewPartnerIconView";

@interface HomeGetParntersView ()<UICollectionViewDataSource,UICollectionViewDelegate>

/** 主图片*/
@property (nonatomic, strong) UIImageView * titleImage;
/** 主标题*/
@property (nonatomic, strong) UILabel *     title;

/** 主集合视图*/
@property (nonatomic, strong) UICollectionView * collectionView;
/** 无网络状态下 展示重新加载操作*/
@property (nonatomic, strong) UILabel *     reloadLabel;
/** 页数*/
@property(nonatomic, assign) NSInteger  deviation;
/** 模型数组*/
@property (nonatomic, strong) NSMutableArray * publicArray;
@property(nonatomic,strong)JQFMDB *db;
@property (nonatomic, assign) NSInteger  begin;
@property (nonatomic, assign) NSInteger  size;
@property (nonatomic, strong) UIView *botView;
@end

@implementation HomeGetParntersView

- (instancetype)initWithFrame:(CGRect)frame PageContolViewWithTyle:(PageContolRequstStyle)style{
    
    self = [super initWithFrame:frame];
    
    if(self){
        self.requstStyle = style;
        [self setUpUI];
    }
    
    return self;
}
+(instancetype)initFrame:(CGRect)frame PageContolViewWithTyle:(PageContolRequstStyle)style{
    HomeGetParntersView *playView = [[self alloc] initWithFrame:frame PageContolViewWithTyle:style];
    return playView;
}

- (void)moreAction
{
    NSLog(@"8888888");
    
    if (self.requstStyle == PartnerRequstStyle) {
        PartnersCollectionController *vc = [[PartnersCollectionController alloc]init];
        [[self viewController].navigationController pushViewController:vc animated:YES];
    }else if (self.requstStyle == NewRequstStyle){
        SNStrategyViewController *vc = [[SNStrategyViewController alloc]init];
        [[self viewController].navigationController pushViewController:vc animated:YES];
    }else if(self.requstStyle == BigRequstStyle){
        SNBrotherShareViewController *vc = [[SNBrotherShareViewController alloc]init];
        [[self viewController].navigationController pushViewController:vc animated:YES];
    }
   
}
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
- (void)setUpUI{

    self.backgroundColor = [UIColor whiteColor];
    
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = RGB(0, 0, 0);
    titleLabel.font = MBBFONT(20);
    if (self.requstStyle == PartnerRequstStyle) {
        titleLabel.text = @"约伴同行";
    }else     if (self.requstStyle == NewRequstStyle) {
        titleLabel.text = @"新生攻略";
    }else     if (self.requstStyle == BigRequstStyle) {
        titleLabel.text = @"师兄分享";
    }
    [self addSubview:titleLabel];
    _title = titleLabel;
    
    _botView = [[UIView alloc]init];
    [self addSubview:_botView];
    _botView.userInteractionEnabled = YES;
    _botView.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moreAction)];
    [_botView addGestureRecognizer:labelTapGestureRecognizer];
    [_botView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(40);
        make.centerY.equalTo(titleLabel);
        make.right.mas_equalTo(0);
    }];
    
    UIImageView *moreImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shouye_jt"]];
    [_botView addSubview:moreImg];
    [moreImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLabel);
        make.right.mas_equalTo(-10);
    }];
    
    UILabel *moreLabel = [[UILabel alloc]init];
    [_botView addSubview:moreLabel];
    moreLabel.text = @"更多";
    moreLabel.font = [UIFont systemFontOfSize:15];
    moreLabel.alpha = 0.7;
    moreLabel.textColor = RGB(0, 0, 0);
    [moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLabel);
        make.right.equalTo(moreImg.mas_left).offset(-10);
    }];
    

    
    CGFloat padding = 0;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(158, 250);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(padding * 2,10, padding * 2, padding);
    layout.minimumLineSpacing = padding * 2;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 55, SCREEN_WIDTH, 250) collectionViewLayout:layout];
    /** self.collectionView.backgroundColor = MBBHEXCOLOR(0xfdb400);*/
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;

    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self addSubview:_collectionView];
    
    
    if (self.requstStyle == PartnerRequstStyle) {
         [_collectionView registerClass:[PartnerIconView class] forCellWithReuseIdentifier:CellId];
    }else if (self.requstStyle == NewRequstStyle){
         [_collectionView registerClass:[NewMethodIconView class] forCellWithReuseIdentifier:NewCellId];
    }else if (self.requstStyle == BigRequstStyle){
        [_collectionView registerClass:[NewMethodIconView class] forCellWithReuseIdentifier:NewCellId];
    }
    
    /** (刷新不及时)*/
    /** 0508 delete:横向刷新*/
    /**
     MBBWeakSelf;
     [_collectionView addRefreshHeaderWithClosure:^{
     [__weakSelf loadData];
     } addRefreshFooterWithClosure:^{
     [__weakSelf loadMoreData];
     }];
     */
    [self layoutAllSubviews];
    [self loadData];
}

- (void)layoutAllSubviews{
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(25);
        make.left.mas_equalTo(20);
    }];
    
    /** 监测网络情况*/
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(reachabilityChanged:)
     name:kReachabilityChangedNotification
     object:nil];
}
#pragma mark - 断网处理
- (void)reachabilityChanged:(NSNotification * )notice{
    Reachability *curReach = [notice object];
    NetworkStatus status = [curReach currentReachabilityStatus];
    if (status != NotReachable) {
        [self loadData];
    }
}

#pragma mark - 加载
- (void)loadData{
    if (self.reloadLabel) {
        [self.reloadLabel removeFromSuperview];
    }
    self.deviation = 1;
    if (self.requstStyle == PartnerRequstStyle) {
        [self fetchDataSoureFromServer];
        
    }else if (self.requstStyle == NewRequstStyle){
        [self fetchDataSourceFromServerTacticsList];

    }else if (self.requstStyle == BigRequstStyle){
        [self fetchDataSourceFromServerShareList];

    }
    [self.collectionView endRefreshing];
    
}
- (void)loadMoreData{
    self.deviation = self.deviation;
    [self fetchDataSoureFromServer];
    [self.collectionView endRefreshing];

}

#pragma mark -  delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.publicArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.requstStyle == PartnerRequstStyle) {
        PartnerIconView * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellId forIndexPath:indexPath];
        cell.model = self.publicArray[indexPath.row];
        return cell;
    }else{
        NewMethodIconView * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NewCellId forIndexPath:indexPath];
        cell.model1 = self.publicArray[indexPath.row];
        return cell;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    /** 末尾loadMoreData*/
    if (self.requstStyle == PartnerRequstStyle) {
        if (indexPath.row == self.publicArray.count-1) {
            if ([self.delegate respondsToSelector:@selector(gotoGetPartnerDetail:)]) {
                [self.delegate loadMoreDataFromServerList];
                /** */
                [self loadData];
            }
        }else{
            
            if ([self.delegate respondsToSelector:@selector(gotoGetPartnerDetail:)]) {
                [self.delegate gotoGetPartnerDetail:self.publicArray[indexPath.row]];
                
            }
        }
    }else{//
        if ([self.delegate respondsToSelector:@selector(gotoShareVCDetail:)]) {
            [self.delegate gotoShareVCDetail:self.publicArray[indexPath.row]];
            
        }
    
    }
}
#pragma mark - 数据
- (void)fetchDataSourceFromServerTacticsList{
    [MBProgressHUD showMessage:@"请稍后..." toView:self];
    [MBBNetworkManager getStudentTacticsList:nil responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"status"] integerValue] >  0) {
            if (self.begin == 0) {
                NSArray * arr = [TacticsShareModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"data"]];
                self.publicArray = [NSMutableArray arrayWithArray:arr];
                
                NSArray * models = [TacticsBannerModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"other"]];
                NSMutableArray * blockArr = [NSMutableArray array];
                for (TacticsBannerModel * model  in models) {
                    [blockArr addObject:model.b_img];
                }
                [self.collectionView reloadData];

                //                self.bannerImagesBlock(blockArr);
            }
        }else{
            [MBProgressHUD showError:@"加载失败..." toView:self];
        }
        
    }];
    
}

- (void)fetchDataSourceFromServerShareList{
    [MBProgressHUD showMessage:@"请稍后..." toView:self];
    [MBBNetworkManager getBigBrotherShareList:nil responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"status"] integerValue] > 0) {
            NSArray * arr = [TacticsShareModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"data"]];
            self.publicArray = [NSMutableArray arrayWithArray:arr];
            [self.collectionView reloadData];

        }else{
            [MBProgressHUD showError:@"加载失败..." toView:self];
        }
        
    }];
    
}
- (void)fetchDataSoureFromServer{
    [MBProgressHUD showMessage:@"请稍后..." toView:self];
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    param[@"deviation"] = @(self.deviation);
    param[@"search"] = @"";
    [MBBNetworkManager getPartnersTogetherList:nil responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            NSArray * modelArr = [PartnersTogetherModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"data"]];
            
            /** 修改横向刷新为(加载更多)*/
            if (self.deviation == 1) {
                self.publicArray = [NSMutableArray arrayWithArray:modelArr];
                PartnersTogetherModel * model = [[PartnersTogetherModel alloc]init];
                [self.publicArray addObject:model];
            }else{
                
                [self.publicArray addObjectsFromArray:modelArr];
            }
           
            
             [_db jq_insertTable:@"PartnersTogetherModel" dicOrModelArray:self.publicArray];
            
//            BOOL isSucess =   [self.database addObjectsInTransaction:modelArr WithTableName:nil];
            
            
            [self.collectionView reloadData];
        }else{
            
            [MBProgressHUD showError:@"加载失败,请检查网络..." toView:self];
        }
        
        /**
         if (self.deviation == [request.responseJSONObject[@"other"][@"countpage"] integerValue]) {
            
            self.collectionView.isLastPage = YES;
        }
         */
        /** 联网请求失败 或 未能请求到数据*/
        if (self.publicArray.count == 0) {
            self.collectionView.backgroundColor = [UIColor whiteColor];
            UILabel * reload = [[UILabel alloc]init];
            reload.text = @"点击重新加载...";
            reload.textColor = FONT_LIGHT;
            reload.font = MBBFONT(15);
            reload.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
            reload.center = CGPointMake(SCREEN_WIDTH/2, 115/2);
            reload.textAlignment = NSTextAlignmentCenter;
            [self.collectionView addSubview:reload];
            _reloadLabel = reload;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loadData)];
            reload.userInteractionEnabled = YES;
            [reload addGestureRecognizer:tap];
        }
    }];

}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
