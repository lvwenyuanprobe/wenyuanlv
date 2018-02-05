//
//  MBBCrisisHandlingViewController.m
//  mybigbrother
//
//  Created by qiu on 21/1/18.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBCrisisHandlingViewController.h"
#import "WYCrisisHandlingTableViewCell.h"
#import "MBBChooseSchoolController.h"
#import "SchoolsModel.h"
#import "CJCalendarViewController.h"
#import "MBBServiceHeadView.h"
#import "WYWaitcontactController.h"

@interface MBBCrisisHandlingViewController ()<CalendarViewControllerDelegate>
{
    NSString *name;
    NSString *age;
    NSString *tel;
    NSString *stringTime;
    NSString *scholle;
    NSMutableArray *proArray;
    NSString *detailString;
    BOOL isChooseOneToTwenty;
}
@property (nonatomic, strong) UIView *footerButtonView;
@property (strong, nonatomic)  UIButton *sendRequstButton;
@property (nonatomic, strong) NSMutableDictionary *  tripInfoDic;
@end

@implementation MBBCrisisHandlingViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"危机处理";
    
   MBBServiceHeadView *headView = [[MBBServiceHeadView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
    [self.view addSubview:headView];
    
    self.tableView.frame = CGRectMake(0, 60, kScreenWidth, kScreenHeight-124);
    
    proArray = [NSMutableArray new];
    isChooseOneToTwenty = YES;
    [self showFooterButtonView];
    
}
- (void)showFooterButtonView{
    self.footerButtonView = [[UIView alloc]initWithFrame:CGRectMake(0, self.tableView.frame.size.height-55, [UIScreen mainScreen].applicationFrame.size.width, 90)];
    self.footerButtonView.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    self.sendRequstButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 35, [UIScreen mainScreen].applicationFrame.size.width , 55)];
    
    [self.sendRequstButton setTitle:@"提交" forState:UIControlStateNormal];
        [self.sendRequstButton setBackgroundColor:[UIColor colorWithRed:251.0/255.0 green:97.0/255.0  blue:48.0/255.0  alpha:1]];
    
    [self.sendRequstButton addTarget:self action:@selector(confirmeData) forControlEvents:UIControlEventTouchUpInside];
    [self.footerButtonView addSubview:self.sendRequstButton];
    self.tableView.tableFooterView =self.footerButtonView;
    
}

//提交按钮数据请求
- (void)confirmeData{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.HTTPShouldHandleCookies = YES;
    manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept" ];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/JavaScript", @"text/json", @"text/html",nil];
    
    MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    NSString *string =[NSString stringWithFormat:@"%@",isChooseOneToTwenty?@"1":@"0"];
    NSDictionary *dic = @{
                          @"full_name":name, // 姓名
                          @"age":age, // 年龄
                          @"phone":tel, // 联系方式
                          @"go_at":stringTime, // 来美时间
                          @"school":scholle, // 在读学校
                          @"is_in_time":string, // I-20有效
                          @"problem_arr":proArray, // 问题[数组]【array】
                          @"mark":detailString,  // 备注信息
                          @"uid":@(model.user.uid),
                          @"token":model.token
                          };
    
    [manager POST:Crisis_Handle parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return  6;
    }else if (section == 1){
        
        return 4;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        return  160;
    }
    return 60.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"FEUIRelationCollaborationCell";
    
    WYCrisisHandlingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (indexPath.section == 0) {
        if (indexPath.row == 5) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"WYCrisisHandlingTableViewCell" owner:self options:nil] objectAtIndex:1];
            isChooseOneToTwenty = YES;
            [cell chooseCheckWithBlock:^(BOOL isCheck) {
                isChooseOneToTwenty = isCheck;
            }];
        }else{
            cell = [[[NSBundle mainBundle] loadNibNamed:@"WYCrisisHandlingTableViewCell" owner:self options:nil] objectAtIndex:0];
            if (indexPath.row == 0) {
                [cell setTitleName:NameStyle withRightString:name];
                [cell nameChangedBlock:^(NSString *stringTextField) {
                    name = stringTextField;
                }];
            }else if (indexPath.row == 1){
                [cell setTitleName:AgeStyle withRightString:age];
                [cell nameChangedBlock:^(NSString *stringTextField) {
                    age = stringTextField;
                }];
                
            }else if (indexPath.row == 2){
                
                [cell setTitleName:TelStyle withRightString:tel];
                [cell nameChangedBlock:^(NSString *stringTextField) {
                    tel = stringTextField;
                }];

            }else if (indexPath.row == 3){
                
                [cell setTitleName:TimeStyle withRightString:stringTime];
                if (stringTime.length == 0) {
                    stringTime = @"请选择";
                }
                [cell.rightLable setTitle:stringTime forState:UIControlStateNormal];
                [cell chooseSchooleTime:^(NSString *time) {
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

            }else if (indexPath.row == 4){
                [cell setTitleName:SchoolStyle withRightString:nil];
            
                if (scholle.length >0) {
                    [cell.rightLable setTitle:scholle forState:UIControlStateNormal];
                }else{
                    [cell.rightLable setTitle:@"请选择" forState:UIControlStateNormal];
                } cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

            }
        }
    }
    else if (indexPath.section == 1){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WYCrisisHandlingTableViewCell" owner:self options:nil] objectAtIndex:2];
        if (indexPath.row == 0) {
            
            [cell setSectionTwoTitleName:SchoolExpulsionStyle];
            [cell chooseCheckWithBlock:^(BOOL isCheck) {
                if (isCheck) {
                    [proArray addObject:@"10001"];
                }else{
                    if ([proArray containsObject: @"10001"]) {
                        [proArray removeObject:@"10001"];
                    }
                }
            }];
        }else if (indexPath.row == 1){
            [cell setSectionTwoTitleName:PhysicalDiseaseStyle];
            [cell chooseCheckWithBlock:^(BOOL isCheck) {
                if (isCheck) {
                    [proArray addObject:@"10002"];
                }else{
                    if ([proArray containsObject: @"10002"]) {
                        [proArray removeObject:@"10002"];
                    }
                }
            }];
            
        }else if (indexPath.row == 2){
            
            [cell setSectionTwoTitleName:PsychologicalCounselingStyle];
            [cell chooseCheckWithBlock:^(BOOL isCheck) {
                if (isCheck) {
                    [proArray addObject:@"10003"];
                }else{
                    if ([proArray containsObject: @"10003"]) {
                        [proArray removeObject:@"10003"];
                    }
                }
            }];
        }else if (indexPath.row == 3){
            
            [cell setSectionTwoTitleName:LegalAdviceStyle];
            [cell chooseCheckWithBlock:^(BOOL isCheck) {
                if (isCheck) {
                    [proArray addObject:@"10004"];
                }else{
                    if ([proArray containsObject: @"10004"]) {
                        [proArray removeObject:@"10004"];
                    }
                }
            }];
        }
    }else{
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WYCrisisHandlingTableViewCell" owner:self options:nil] objectAtIndex:3];
        [cell setDetaildBlock:^(NSString *stringTextView) {
            detailString = stringTextView;
        }];
    }

    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 3) {
          
        } else if (indexPath.row == 4) {
            MBBChooseSchoolController * schoolsVC = [[MBBChooseSchoolController alloc]init];
            schoolsVC.schoolBlock = ^(SchoolsModel *model) {
                scholle = model.s_name;
                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:4 inSection:0];
                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            };
            [self.navigationController pushViewController:schoolsVC animated:YES];
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
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
    NSString *headTitle;
    if (section == 0) {
        headTitle = @"个人信息(必填)";
    }else if (section == 1){
        headTitle = @"常见问题(可多选)";
    }else{
        headTitle = @"问题描述";
    }
    headerLabel.text = headTitle;//
    [view addSubview:headerLabel];
    
    return view;
    
}

-(void)CalendarViewController:(CJCalendarViewController *)controller didSelectActionYear:(NSString *)year month:(NSString *)month day:(NSString *)day{
    
    stringTime = [NSString stringWithFormat:@"%@-%@-%@", year, month, day];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:3 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

//之所以不定义为NSString的类别是因为，接口可能返回的不是字符串，那么会导致崩溃；
bool isNotEmptyNotNullString(NSString *string)
{
    if (string && [string isKindOfClass:[NSString class]] && string.length > 0) {
        return YES;
    }
    return NO;
}

//  颜色转换为背景图片
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
