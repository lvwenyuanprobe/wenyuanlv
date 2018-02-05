//
//  MXContactsTableController.m
//  mybigbrother
//
//  Created by SN on 2017/4/20.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MXContactsTableController.h"

#import "CityModel.h"

#import "CityNameCell.h"

@interface MXContactsTableController ()

@property (nonatomic,strong) NSMutableArray *sectionArray;

@property (nonatomic, strong) NSMutableArray *sectionTitlesArray;
@end

@implementation MXContactsTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"城市";
    
    self.tableView.sectionIndexColor = [UIColor lightGrayColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.sectionHeaderHeight = 25;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self fetchCitysFromServer];
}


- (void)fetchCitysFromServer{
    
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager putCityList:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"status"] integerValue] > 0) {
            NSArray * models = [CityModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"data"]];
            self.sectionArray = [NSMutableArray arrayWithArray:models];
        
            [self setUpTableSection];
            
            [self.tableView reloadData];
        }else{
            
        }
        
    }];
    
}
- (void) setUpTableSection {
    /**该方法是使用UILocalizedIndexedCollation来进行本地化下按首字母分组排序的，
     是建立在对对象的操作上的。
     不同于以前的那些比如把汉字转成拼音再排序的方法了，效率不高，同时很费内存。
     但该方法有一个缺点就是不能区分姓氏中的多音字，
     比如“曾”会被分到"C"组去*/
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    
    //create a temp sectionArray
    /** 得出collation索引的数量，这里是27个（26个字母和1个#）*/
    NSUInteger numberOfSections = [[collation sectionTitles] count];
    /**初始化27个空数组加入newSectionsArray*/
    NSMutableArray *newSectionArray =  [[NSMutableArray alloc]init];
    for (NSUInteger index = 0; index<numberOfSections; index++) {
        [newSectionArray addObject:[[NSMutableArray alloc]init]];
    }
    // insert Persons info into newSectionArray
    /** 将每个名字分到某个section下*/
    for (CityModel * model in self.sectionArray) {
        //获取name属性的值所在的位置，比如"林丹"，首字母是L，在A~Z中排第11（第一位是0），sectionNumber就为11
        NSUInteger sectionIndex = [collation sectionForObject:model collationStringSelector:@selector(c_name)];
        //把name为“林丹”的p加入newSectionsArray中的第11个数组中去
        NSMutableArray * arr = newSectionArray[sectionIndex];
        [arr addObject:model];
        [newSectionArray replaceObjectAtIndex:sectionIndex withObject:arr];
    }
    //sort the person of each section
    //对每个section中的数组按照name属性排序
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
    
//    NSMutableArray *operrationModels = [NSMutableArray new];
//    NSArray *dicts = @[@{@"name" : @"藏兵谷",},
//                       @{@"name" : @"天山铸剑阁",},
//                       @{@"name" : @"汴州城",},
//                       ];
//    for (NSDictionary *dict in dicts) {
//        CityModel *model = [CityModel new];
//        model.c_name = dict[@"name"];
//        [operrationModels addObject:model];
//    }
//    [newSectionArray insertObject:operrationModels atIndex:0];
//    [self.sectionTitlesArray insertObject:@"热门" atIndex:0];
    self.sectionArray = newSectionArray;
}

#pragma mark - tableview delegate and datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionTitlesArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sectionArray[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"CityNameCell";
    CityNameCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[CityNameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    CityModel *model = self.sectionArray[section][row];
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
    
    CityModel * model = self.sectionArray[indexPath.section][indexPath.row];
    self.cityBlock(model);
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
