//
//  HBBButlerServiceViewController.m
//  mybigbrother
//
//  Created by qiu on 2/1/18.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "HBBButlerServiceViewController.h"
#import "MBBTripTimeTableViewCell.h"
#import "MBBTripPeopleTableViewCell.h"
#import "MBBTripServiceTableViewCell.h"
#import "MBBServiceHeadView.h"
#import "MBBTripModel.h"
#import "WYTableViewCell.h"
#import "ButlerServiceModel.h"
#import "MBBNetworkManager.h"
#import "CJCalendarViewController.h"
#import "MBBTextViewTableViewCell.h"
#import "MBBTravelDateViewController.h"
#import "WYWaitcontactController.h"

@interface HBBButlerServiceViewController ()<UITableViewDataSource,UITableViewDelegate,CalendarViewControllerDelegate>
{

    NSMutableArray  *arraySchedule;
    MBBTripModel *tripModel;
    ButlerServiceModel *serviceModel;
    NSString *stringTime;
    NSInteger numberPenple;

    NSInteger numberAdult;
    NSInteger numberChildren;
    NSString *stringName;
    NSString *stringTelPhone;
    
    NSString *isTranslation;
    NSString * isPrivateTourGuide;
    NSString * isAirTicketDetermined;
    NSString * isAirportShuttle;
    NSString *stringOtherTrips;
}
@property (nonatomic, strong) UIView *footerButtonView;
@property (strong, nonatomic)  UIButton *sendRequstButton;
@property (nonatomic, weak) UIButton *CJButton;
@end

@implementation HBBButlerServiceViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
    self.hidesBottomBarWhenPushed = YES;
    
//    [self setBackBtn];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)showFooterButtonView{
    self.footerButtonView = [[UIView alloc]initWithFrame:CGRectMake(0, self.tableView.frame.size.height-55, [UIScreen mainScreen].applicationFrame.size.width, 90)];
    self.footerButtonView.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    self.sendRequstButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 35, [UIScreen mainScreen].applicationFrame.size.width , 55)];
    [self.sendRequstButton setTitle:@"提交 " forState:UIControlStateNormal];
    self.sendRequstButton.titleLabel.font = [UIFont systemFontOfSize:20.0];
    [self.sendRequstButton setBackgroundColor:[UIColor colorWithRed:251.0/255.0 green:97.0/255.0  blue:48.0/255.0  alpha:1]];
    [self.sendRequstButton addTarget:self action:@selector(sendCollaboration:) forControlEvents:UIControlEventTouchUpInside];
    [self.footerButtonView addSubview:self.sendRequstButton];
    self.tableView.tableFooterView =self.footerButtonView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"管家服务";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];

    isPrivateTourGuide = @"2";
    isAirTicketDetermined = @"2";
    isAirportShuttle = @"2";

    [self showFooterButtonView];
    arraySchedule = [NSMutableArray new];
    
    tripModel = [[MBBTripModel alloc] init];
     tripModel.destination = @"行程";
    tripModel.daysOfExcursion = @"出游天数";
    tripModel.days = @"0";
    [arraySchedule addObject:tripModel];
    
    MBBServiceHeadView *headView = [[MBBServiceHeadView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
    self.tableView.tableHeaderView = headView;
    [self.view addSubview:self.tableView];
    [self updateData];
    serviceModel  = [[ButlerServiceModel alloc] init];
}
- (void)updateData{
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - H(49));
    
}
- (void)sendCollaboration:(id)sender {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.HTTPShouldHandleCookies = YES;
    manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept" ];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/JavaScript", @"text/json", @"text/html",nil];
    
    MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    NSDictionary *dic = @{
                          @"excursion_date":stringTime, //
                          @"people_num":[NSString stringWithFormat:@"%ld",numberPenple], //
                          @"adult_num":[NSString stringWithFormat:@"%ld",numberAdult], //
                          @"children_num":[NSString stringWithFormat:@"%ld",numberChildren], //
                          @"passenger_name":stringName, //
                          @"phone":stringTelPhone,  //
                          @"translate":isTranslation,  //
                          @"ticket":isAirTicketDetermined,  //
                          @"shuttle_bus":isAirportShuttle,  //
                          @"mark":stringOtherTrips,
                          @"token":model.token
                          };
    NSMutableDictionary *newdic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [newdic addEntriesFromDictionary:[self headleTripDestination]];

    [manager POST:Butle_Service parameters:newdic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([responseObject[@"code"] integerValue] == 200) {
            
            [MBProgressHUD showSuccess:@"提交成功" toView:self.view];
            NSLog(@"responseObject = %@",responseObject);
            WYWaitcontactController *waitViewVC = [[WYWaitcontactController alloc] init];
            waitViewVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:waitViewVC animated:YES];
            
        }else {
            
            [MBProgressHUD showError:@"提交失败" toView:self.view];
            NSLog(@"responseObject = %@",responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"failure--%ld",error.code);
        NSData * data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSString * str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"错误原因:%@",str);
    }];
}
-(NSMutableDictionary *)headleTripDestination{
// arraySchedule
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (int i = 0; i <arraySchedule.count; i++) {
         MBBTripModel *model = arraySchedule[i];
        [dic setValue:model.desString forKey:[NSString stringWithFormat:@"trip[%d][destination]",i+1]];
        [dic setValue:model.days forKey:[NSString stringWithFormat:@"trip[%d][days]",i+1]];
    }
    return dic;
}
#pragma mark - UITableViewDelegate - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if (section == arraySchedule.count +1){
        return 1;

    }else if (section == arraySchedule.count +2){
        return 4;
        
    }else if (section == arraySchedule.count +3){
        return 4;
        
    }else if (section == arraySchedule.count +4){
        return 1;
        
    }else{
        return 2;
    }
    return 0;

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3+arraySchedule.count+1+1;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NSLocalizedString(@"FE_CLIENT_2_10661", @"删除");
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == arraySchedule.count +1){
        return 0;
    }
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIControl *view = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    view.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0  blue:248/255.0  alpha:1];

    UILabel *headerLabel = [UILabel new];
    headerLabel.frame = CGRectMake(20, 0, self.view.frame.size.width-90, 40);
    headerLabel.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0  blue:248/255.0  alpha:1];
    [headerLabel setFont:[UIFont systemFontOfSize:15 weight:UIFontWeightThin]];

    headerLabel.textColor = [UIColor lightGrayColor];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-40, 10,20, 20)]
    ;
    button.tag = 1000 + section;
    [button setBackgroundImage:[UIImage imageNamed:@"gj_gb"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(sectionClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    button.hidden = YES;
    NSString *headTitle;
    if (section == 0) {
        headTitle = @"行程的基本信息";
    }else if (section == arraySchedule.count +1){
        headTitle = @"";
        
    }else if (section == arraySchedule.count +2){
        headTitle = @"客户信息";
        
    }else if (section == arraySchedule.count +3){
        headTitle = @"需要服务";
    }else if (section == arraySchedule.count +4){
        headTitle = @"其他的服务";
    }else{
        headTitle =[NSString stringWithFormat:@"行程(%ld)", section];
        if (section>1) {
            button.hidden = NO;
        }else{
            button.hidden = YES;
}
    }
    headerLabel.text = headTitle;//
    [view addSubview:headerLabel];
 

    return view;
    
}
- (void)sectionClick:(UIControl *)view
{
//    //获取点击的组
    NSInteger i = view.tag - 1000-1;
    [arraySchedule removeObjectAtIndex:i];
    [self.tableView reloadData];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString * cellid = @"MBBTripTimeTableViewCell";
            MBBTripTimeTableViewCell *  cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if(cell == nil){
                cell = [[MBBTripTimeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
            }
            cell.rightButton.hidden = NO;
            cell.titleLab.text = @"出游日期";
            cell.telTestFiled.hidden = YES;
            if (stringTime.length == 0) {
                stringTime = @"      请选择";
            }
            [cell.rightButton setTitle:stringTime forState:UIControlStateNormal];
            self.CJButton =cell.rightButton;
            [cell chooseTimeWithBlock:^(NSString *time) {
                
                CJCalendarViewController *calendarController = [[CJCalendarViewController alloc] init];
                calendarController.view.frame = self.view.frame;
                
                calendarController.delegate = self;
                NSArray *arr = [time componentsSeparatedByString:@"-"];
                if (arr.count > 1) {
                    [calendarController setYear:arr[0] month:arr[1] day:arr[2]];
                }
                [self presentViewController:calendarController animated:YES completion:nil];
            }];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }else if (indexPath.row == 1){
            static NSString * cellid = @"MBBTripPeopleTableViewCell";
            MBBTripPeopleTableViewCell *  cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if(cell == nil){
                cell = [[MBBTripPeopleTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
            }
            [cell setHideConfig:@"出游人数"];
            __block typeof(cell)wsCell = cell;
            [cell numberWithBlock:^(NSInteger number) {
                numberPenple = number;
                wsCell.rightNumLab.text = [NSString stringWithFormat:@"%ld",number];
            }];
            return cell;
        }
    }else if (indexPath.section == arraySchedule.count +1){
        static NSString * cellid = @"WYTableViewCell";
        WYTableViewCell *  cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if(cell == nil){
            cell = [[WYTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
        }
        [cell numberAddWithBlock:^(NSInteger number) {
            tripModel = [[MBBTripModel alloc] init];
            tripModel.destination =[NSString stringWithFormat:@"行程%ld",indexPath.section] ;
            tripModel.daysOfExcursion = [NSString stringWithFormat:@"出游天数%ld",indexPath.section];//@"出游天数";
            tripModel.days = @"0";
            [arraySchedule addObject:tripModel];
            [self.tableView reloadData];
        }];
        return cell;
 
    }
    
    
    else if (indexPath.section == arraySchedule.count +2){
        if (indexPath.row == 0) {
            static NSString * cellid = @"MBBTripPeopleTableViewCell";
            MBBTripPeopleTableViewCell *  cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if(cell == nil){
                cell = [[MBBTripPeopleTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
            }
            [cell setHidePeopleConfig:@"成人"];
            __block typeof(cell)wsCell = cell;
            [cell numberWithBlock:^(NSInteger number) {
                numberAdult = number;
                wsCell.rightNumLab.text = [NSString stringWithFormat:@"%ld",number];
            }];
            return cell;
        }else if (indexPath.row == 1){
            static NSString * cellid = @"MBBTripPeopleTableViewCell";
            MBBTripPeopleTableViewCell *  cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if(cell == nil){
                cell = [[MBBTripPeopleTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
            }
            [cell setHidePeopleConfig:@"儿童"];
            __block typeof(cell)wsCell = cell;
            
            [cell numberWithBlock:^(NSInteger number) {
                numberChildren = number;
                wsCell.rightNumLab.text = [NSString stringWithFormat:@"%ld",number];
            }];
            
            return cell;
        }else if (indexPath.row == 2){
            static NSString * cellid = @"MBBTripPeopleTableViewCell";
            MBBTripPeopleTableViewCell *  cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if(cell == nil){
                cell = [[MBBTripPeopleTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
            }
            cell.titleLab.text = @"预定人";
            __block typeof(cell)wsCell = cell;
            
            cell.rightNumLab.hidden = YES;
            cell.additionButton.hidden = YES;
            cell.subtractionButton.hidden = YES;
            [cell nameChangedBlock:^(NSString *stringTextField) {
                stringName = stringTextField;
            }];
            [cell numberWithBlock:^(NSInteger number) {
                wsCell.rightNumLab.text = [NSString stringWithFormat:@"%ld",number];
            }];
            
            return cell;
        }else if (indexPath.row == 3){
            static NSString * cellid = @"MBBTripTimeTableViewCell";
            MBBTripTimeTableViewCell *  cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if(cell == nil){
                cell = [[MBBTripTimeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
            }
            cell.titleLab.text = @"电话";
            cell.rightButton.hidden = YES;
            cell.telTestFiled.hidden = NO;
            cell.accessoryType = UITableViewCellAccessoryNone;
            [cell nameChangedBlock:^(NSString *stringTextField) {
                stringTelPhone = stringTextField;
            }];
            return cell;
        }
    }else if (indexPath.section == arraySchedule.count +3){
        if (indexPath.row == 0) {
            static NSString * cellid = @"MBBTripServiceTableViewCell";
            MBBTripServiceTableViewCell *  cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if(cell == nil){
                cell = [[MBBTripServiceTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
            }
            cell.titleLab.text = @"翻译需求";
            [cell chooseGenderWithBlock:^(BOOL isCheck) {
                [cell setButtonAlpha:isCheck];
                isTranslation = isCheck ? @"3":@"1";
            }];
            [cell chooseGenderBlockWithBlock:^(NSString *isCheckString) {
                isTranslation = isCheckString;
            }];
            cell.womenButton.hidden = NO;
            cell.manButton.hidden = NO;
            return cell;
        }else if (indexPath.row == 1){
            static NSString * cellid = @"MBBTripServiceTableViewCell";
            MBBTripServiceTableViewCell *  cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if(cell == nil){
                cell = [[MBBTripServiceTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
            }
            cell.titleLab.text = @"私人导游";
            cell.womenButton.hidden = NO;
            cell.manButton.hidden = NO;
            [cell chooseGenderWithBlock:^(BOOL isCheck) {
                [cell setButtonAlpha:isCheck];
                isPrivateTourGuide = isCheck ? @"1":@"2";
            }];
//            [cell chooseGenderBlockWithBlock:^(NSString *isCheckString) {
//                isPrivateTourGuide = isCheckString;
//            }];
            return cell;
        }else if (indexPath.row == 2){
            static NSString * cellid = @"MBBTripServiceTableViewCell";
            MBBTripServiceTableViewCell *  cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if(cell == nil){
                cell = [[MBBTripServiceTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
            }
            cell.titleLab.text = @"机票代订";
            [cell chooseGenderWithBlock:^(BOOL isCheck) {
                [cell setButtonAlpha:isCheck];
                isAirTicketDetermined = isCheck ? @"1":@"2";
            }];
            cell.womenButton.hidden = YES;
            cell.manButton.hidden = YES;
            return cell;
        }else if (indexPath.row == 3){
            static NSString * cellid = @"MBBTripServiceTableViewCell";
            MBBTripServiceTableViewCell *  cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if(cell == nil){
                cell = [[MBBTripServiceTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
            }
            [cell chooseGenderWithBlock:^(BOOL isCheck) {
                [cell setButtonAlpha:isCheck];
                isAirportShuttle = isCheck ? @"1":@"2";
            }];
            cell.titleLab.text = @"机场接送";
            cell.womenButton.hidden = YES;
            cell.manButton.hidden = YES;
            return cell;
        }
        
    }    else if (indexPath.section == arraySchedule.count +4){
        static NSString * cellid = @"MBBTextViewTableViewCell";
        MBBTextViewTableViewCell *  cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if(cell == nil){
            cell = [[MBBTextViewTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
        }
        
        [cell textViewWithBlock:^(NSString *stringTextView) {
            stringOtherTrips = stringTextView;
        }];
        return cell;
    }else{
            MBBTripModel *model = arraySchedule[indexPath.section-1];
            if (indexPath.row == 0) {
                static NSString * cellid = @"MBBTripTimeTableViewCell";
                MBBTripTimeTableViewCell *  cell = [tableView dequeueReusableCellWithIdentifier:cellid];
                if(cell == nil){
                    cell = [[MBBTripTimeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
                }
                [cell setConfigModel:model];
                return cell;
            }else if (indexPath.row == 1){
                static NSString * cellid = @"MBBTripPeopleTableViewCell";
                MBBTripPeopleTableViewCell *  cell = [tableView dequeueReusableCellWithIdentifier:cellid];
                if(cell == nil){
                    cell = [[MBBTripPeopleTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
                }
//                cell.nameTestFiled.hidden = YES;
//                cell.titleLab.text = model.daysOfExcursion;
//                cell.rightNumLab.text = model.days;
                [cell setHideConfig:model.daysOfExcursion];
                __block typeof(cell)wsCell = cell;
                [cell numberWithBlock:^(NSInteger number) {
                    NSLog(@"model.DaysOfExcursion%@",model.daysOfExcursion);
                    wsCell.rightNumLab.text = [NSString stringWithFormat:@"%ld",number];
                    model.days = [NSString stringWithFormat:@"%ld",number];
                    [arraySchedule replaceObjectAtIndex:indexPath.section-1 withObject:model];
                }];
                return cell;
            }
        
            }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == arraySchedule.count +4){
        return 160;
    }
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0||indexPath.section == arraySchedule.count +1||indexPath.section == arraySchedule.count +2||indexPath.section == arraySchedule.count +3||indexPath.section == arraySchedule.count +4) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }else{
        if (indexPath.row == 0) {
            MBBTripModel *model = arraySchedule[indexPath.section-1];
            MBBTravelDateViewController *courseGuidance = [[MBBTravelDateViewController alloc]init];
            courseGuidance.selectStringCallback = ^(NSString *selectString) {
                model.desString = selectString;
                model.days = model.days;
                [arraySchedule replaceObjectAtIndex:indexPath.section-1 withObject:model];
                NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:indexPath.section];
                [tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            };
            
            courseGuidance.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:courseGuidance animated:YES];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)CalendarViewController:(CJCalendarViewController *)controller didSelectActionYear:(NSString *)year month:(NSString *)month day:(NSString *)day{
    stringTime = [NSString stringWithFormat:@"%@-%@-%@", year, month, day];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    
}

/**
 *  tableView线条顶到头的方法
 */
-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
@end
