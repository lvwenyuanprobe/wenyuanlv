//
//  MBBChooseAirportController.m
//  mybigbrother
//
//  Created by SN on 2017/4/17.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBChooseAirportController.h"
#import "AirportCell.h"
#import "AirportModel.h"
#import "AirportCityLishModel.h"

@interface MBBChooseAirportController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * mainTableView;
@property (nonatomic,strong) NSMutableArray *sectionArray;
@property (nonatomic, strong) NSMutableArray *sectionTitlesArray;
@property (nonatomic, strong) NSArray *citysArr;
@end

@implementation MBBChooseAirportController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择机场";
    self.view.backgroundColor  = [UIColor whiteColor];
    
    /** 设置tableView属性*/
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4, 0,SCREEN_WIDTH*3/4 , SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    [self.mainTableView setDelegate:self];
    [self.mainTableView setDataSource:self];
    [self.mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.mainTableView setTableFooterView:[UIView new]];
    
    self.mainTableView.sectionIndexColor = [UIColor lightGrayColor];
    self.mainTableView.sectionIndexBackgroundColor = [UIColor clearColor];
    [self.view addSubview:self.mainTableView];
    
    [self fetchDataSourceFromServer];

}

- (void)creatListBtnWithListArray:(NSArray<AirportCityLishModel *> *)arr {
    for (int i = 0; i < arr.count; i++) {
        AirportCityLishModel *model = arr[i];
        NSString *c_name = model.c_name;
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:c_name forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:BASE_YELLOW] forState:UIControlStateNormal];
        [btn setTitleColor:FONT_DARK forState:UIControlStateNormal];
        [btn.titleLabel setFont:MBBFONT(15)];
        btn.frame = CGRectMake(0, i * 45, SCREEN_WIDTH/4, 44);
        btn.tag = i;
        [btn addTarget:self action:@selector(cityEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

- (void)cityEvent:(UIButton *)btn {
    AirportCityLishModel *listModel = _citysArr[btn.tag];
    NSArray *model = [AirportModel mj_objectArrayWithKeyValuesArray:listModel.data];
    
    [self updataCityWithArray:model];
}

- (void)fetchDataSourceFromServer{
#if 1
    //修改成有城市和国家
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager getCitysList:nil responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"status"] integerValue] > 0) {
            
            _citysArr = [AirportCityLishModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"data"]];
            
            //更新城市列表
            [self creatListBtnWithListArray:_citysArr];
            
            AirportCityLishModel *listModel = [_citysArr firstObject];
            NSArray *model = [AirportModel mj_objectArrayWithKeyValuesArray:listModel.data];
            
            [self updataCityWithArray:model];
           
        }else{
            
            [MBProgressHUD showError:@"网络好像丢了..." toView:self.view];
        }
    }];
    
#else
    //原需求，写死美国城市
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager getAirportsList:nil responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"status"] integerValue] > 0) {
            
            NSArray * models = [AirportModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"data"]];
            self.sectionArray = [NSMutableArray arrayWithArray:models];
            
            //更新城市列表
            [self creatListBtnWithArray:models];
            
            [self setUpTableSection];

            [self.mainTableView reloadData];
            
        }else{
            
            [MBProgressHUD showError:@"网络好像丢了..." toView:self.view];
        }
    }];
    
#endif
}

- (void)updataCityWithArray:(NSArray *)models {
    self.sectionArray = [NSMutableArray arrayWithArray:models];
    
    [self setUpTableSection];
    
    [self.mainTableView reloadData];
}

- (void) setUpTableSection {
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    
    NSUInteger numberOfSections = [[collation sectionTitles] count];
    NSMutableArray *newSectionArray =  [[NSMutableArray alloc]init];
    for (NSUInteger index = 0; index<numberOfSections; index++) {
        [newSectionArray addObject:[[NSMutableArray alloc]init]];
    }
    for (AirportModel * model in self.sectionArray) {
        NSUInteger sectionIndex = [collation sectionForObject:model collationStringSelector:@selector(c_name)];
        
        NSMutableArray * arr = newSectionArray[sectionIndex];
        [arr addObject:model];
        [newSectionArray replaceObjectAtIndex:sectionIndex withObject:arr];
    }
    for (NSUInteger index=0; index<numberOfSections; index++) {
        NSMutableArray *personsForSection = newSectionArray[index];
        NSArray *sortedPersonsForSection = [collation sortedArrayFromArray:personsForSection collationStringSelector:@selector(c_name)];
        newSectionArray[index] = sortedPersonsForSection;
    }
    
    NSMutableArray *temp = [NSMutableArray new];
    self.sectionTitlesArray = [NSMutableArray new];
    [newSectionArray enumerateObjectsUsingBlock:^(NSArray *arr, NSUInteger idx, BOOL *stop) {
        if (arr.count == 0) {
            [temp addObject:arr];
        } else {
            [self.sectionTitlesArray addObject:[collation sectionTitles][idx]];
        }
    }];
    
    [newSectionArray removeObjectsInArray:temp];
    self.sectionArray = newSectionArray;
}

#pragma mark - tableview delegate and datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 94;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionTitlesArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sectionArray[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"AirportCell";
    AirportCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[AirportCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    AirportModel *model = self.sectionArray[section][row];
    cell.model = model;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.sectionTitlesArray objectAtIndex:section];
}


- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.sectionTitlesArray;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.mainTableView deselectRowAtIndexPath:indexPath animated:YES];
    AirportModel * model = self.sectionArray[indexPath.section][indexPath.row];
    self.airportBlock(model);
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
