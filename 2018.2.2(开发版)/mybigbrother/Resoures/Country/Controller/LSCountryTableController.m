//
//  LSCountryTableController.m
//  mybigbrother
//
//  Created by SN on 2017/6/16.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "LSCountryTableController.h"
#import "CountryNameCell.h"

@interface LSCountryTableController ()
@property (nonatomic,strong) NSMutableArray *sectionArray;

@property (nonatomic, strong) NSMutableArray *sectionTitlesArray;

@end

@implementation LSCountryTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"国家地区";
    
    self.tableView.sectionIndexColor = [UIColor lightGrayColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.sectionHeaderHeight = 20;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self fetchCitysFromServer];
}


- (void)fetchCitysFromServer{
    
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager areaNumberList:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue] == 200) {
            NSArray * models = [CountryNameModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"data"]];
            self.sectionArray = [NSMutableArray arrayWithArray:models];
            [self setUpTableSection];
            [self.tableView reloadData];
        }else{
            
        }
    }];
}
- (void) setUpTableSection {
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    NSUInteger numberOfSections = [[collation sectionTitles] count];
    NSMutableArray *newSectionArray =  [[NSMutableArray alloc]init];
    for (NSUInteger index = 0; index<numberOfSections; index++) {
        [newSectionArray addObject:[[NSMutableArray alloc]init]];
    }
    // insert Persons info into newSectionArray
    /** 将每个名字分到某个section下*/
    for (CountryNameModel * model in self.sectionArray) {
        //获取name属性的值所在的位置，比如"林丹"，首字母是L，在A~Z中排第11（第一位是0），sectionNumber就为11
        NSUInteger sectionIndex = [collation sectionForObject:model collationStringSelector:@selector(country)];
        //把name为“林丹”的p加入newSectionsArray中的第11个数组中去
        NSMutableArray * arr = newSectionArray[sectionIndex];
        [arr addObject:model];
        [newSectionArray replaceObjectAtIndex:sectionIndex withObject:arr];
    }
    //sort the person of each section
    //对每个section中的数组按照name属性排序
    for (NSUInteger index=0; index<numberOfSections; index++) {
        NSMutableArray *personsForSection = newSectionArray[index];
        NSArray *sortedPersonsForSection = [collation sortedArrayFromArray:personsForSection collationStringSelector:@selector(country)];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionTitlesArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sectionArray[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"CountryNameCell";
    CountryNameCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[CountryNameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    CountryNameModel*model = self.sectionArray[section][row];
    cell.model = model;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.sectionTitlesArray objectAtIndex:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.backgroundColor = BASE_VC_COLOR;
    titleLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH, 20);
    titleLabel.text = [NSString stringWithFormat:@"    %@",[self.sectionTitlesArray objectAtIndex:section]];
    titleLabel.textColor = BASE_YELLOW;
    titleLabel.font = MBBFONT(12);
    return titleLabel;
}
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.sectionTitlesArray;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CountryNameModel * model = self.sectionArray[indexPath.section][indexPath.row];
    self.countryBlock(model);
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
