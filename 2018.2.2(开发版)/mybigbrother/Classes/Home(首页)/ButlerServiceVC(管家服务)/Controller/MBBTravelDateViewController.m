//
//  MBBTravelDateViewController.m
//  mybigbrother
//
//  Created by qiu on 21/1/18.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBTravelDateViewController.h"

@interface MBBTravelDateViewController (){
    
    NSMutableArray *arrayCountry;
    NSMutableArray *arrayProvince;
    NSMutableArray *arrayCity;
    BOOL isFirst;

}

@end

@implementation MBBTravelDateViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self selectZone];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    arrayCountry = [NSMutableArray new];
    arrayProvince = [NSMutableArray new];
    arrayCity = [NSMutableArray new];
    
}

- (void)selectZone{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    isFirst = YES;
    [manager GET:@"http://dev.wbapi.worldbuddy.cn/api/area/index?pid=0" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([responseObject[@"code"] longLongValue] == 200) {
            
            [MBProgressHUD showSuccess:@"发送成功" toView:self.view];
            arrayCountry = [[responseObject valueForKey:@"data"] valueForKey:@"data"];
            [self getProDate:[arrayCountry.firstObject valueForKey:@"id"]];
            [self.tableViewCountry reloadData];
            
        }else {
            
            [MBProgressHUD showError:@"发送失败" toView:self.view];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"failure--%@",error);
    }];
    
    self.tableVIewCity.tableFooterView = [[UIView alloc]init];
    self.tableViewProvince.tableFooterView = [[UIView alloc]init];
    self.tableViewCountry.tableFooterView = [[UIView alloc]init];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableViewCountry) {
        return arrayCountry.count;
    }else  if (tableView == self.tableViewProvince) {
        return arrayProvince.count;

    }else  if (tableView == self.tableVIewCity) {
        return arrayCity.count;
    }
    return  1;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * const reuseIdentifier = @"yearTableViewCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        
        
    }
    if (tableView == self.tableViewCountry) {
        cell.textLabel.text = [arrayCountry[indexPath.row] valueForKey:@"name"];

    }else  if (tableView == self.tableViewProvince) {
        cell.textLabel.text = [arrayProvince[indexPath.row]valueForKey:@"name"];

    }else  if (tableView == self.tableVIewCity) {
        cell.textLabel.text = [arrayCity[indexPath.row]valueForKey:@"name"];
    }
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableViewCountry) {
        if ([arrayCountry[indexPath.row] valueForKey:@"id"]) {
            [self getProDate:[arrayCountry[indexPath.row] valueForKey:@"id"]];
        }
    }else if (tableView == self.tableViewProvince){
        if (arrayProvince.count >0) {
            [self getCityDate:[arrayProvince[indexPath.row] valueForKey:@"id"]];
        }
    }else if (tableView == self.tableVIewCity){
        if (self.selectStringCallback) {
            self.selectStringCallback([arrayCity[indexPath.row] valueForKey:@"name"]);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getCityDate:(NSString *)stringid{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:[NSString stringWithFormat:@"http://dev.wbapi.worldbuddy.cn/api/area/index?pid=%@",stringid] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([responseObject[@"code"] integerValue] == 200) {
            
            [MBProgressHUD showSuccess:@"发送成功" toView:self.view];
            arrayCity = [[responseObject valueForKey:@"data"]valueForKey:@"data"];
            [self.tableVIewCity reloadData];
        }else {
            
            [MBProgressHUD showError:@"发送失败" toView:self.view];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"failure--%@",error);
    }];
    
}
-(void)getProDate:(NSString *)stringid{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:[NSString stringWithFormat:@"http://dev.wbapi.worldbuddy.cn/api/area/index?pid=%@&limit=100",stringid] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([responseObject[@"code"] integerValue] == 200) {
            [MBProgressHUD showSuccess:@"发送成功" toView:self.view];
            arrayProvince = [[responseObject valueForKey:@"data"]valueForKey:@"data"];
            if (isFirst) {
                [self getCityDate:[arrayProvince.firstObject valueForKey:@"id"]];
                isFirst = NO;
            }
            [self.tableViewProvince reloadData];
        }else {
            
            [MBProgressHUD showError:@"发送失败" toView:self.view];
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"failure--%@",error);
    }];
    
}



@end
