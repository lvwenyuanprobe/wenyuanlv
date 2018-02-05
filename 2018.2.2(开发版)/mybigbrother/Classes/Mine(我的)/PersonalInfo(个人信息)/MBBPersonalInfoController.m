//
//  MBBPersonalInfoController.m
//  mybigbrother
//
//  Created by SN on 2017/4/6.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "MBBPersonalInfoController.h"
#import "PersonalInfoCell.h"
#import "PersonalHeaderView.h"
#import "ChangePersonalInfoController.h"
#import "ChangePhoneController.h"

#import "MBBDatePicker.h"

/** 相机相关*/
#import "MLSelectPhotoPickerViewController.h"
#import "MLSelectPhotoAssets.h"
#import "MLSelectPhotoPickerAssetsViewController.h"
#import "MLSelectPhotoBrowserViewController.h"
/**********/

typedef NS_ENUM (NSInteger, KActionSheetType){
    KActionSheetSex = 100,
    KActionSheetPhoto,
};

@interface MBBPersonalInfoController ()<UITableViewDelegate,
UITableViewDataSource,
MBBDatePickerDelegate,
PersonalHeaderViewDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
LCActionSheetDelegate>
@property(nonatomic, strong) UITableView * menuTableView;
@property(nonatomic, strong) NSArray *menuDatas;
/** 更改对应字段*/
@property(nonatomic, strong) NSArray *postStrs;

/** 已有数据*/
@property(nonatomic, strong) NSArray *rightDatas;

@property(nonatomic, strong) UIImagePickerController * imagePicker;
@property(nonatomic, strong) PersonalHeaderView * Header;

@end

@implementation MBBPersonalInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人信息";//用户
    
    _menuDatas  = [NSArray array];
    _postStrs   = [NSArray array];
    _rightDatas = [NSArray array];
    
    _menuDatas  = @[@"昵称",
                    @"真实姓名",
                    @"性别",
                    @"年龄",
                    @"护照号",
                    @"在读学校",
                    @"在读年级",
                    @"个性签名",
                    @"手机号",
                    @"紧急联系人",
                    ];
    
    _postStrs = @[@"u_nickname",
                  @"u_name",
                  @"u_sex",
                  @"u_age",
                  @"x_passport",
                  @"x_school",
                  @"x_grade",
                  @"u_autograph",
                  @"u_phone",
                  @"u_urgent",
                  ];
    MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    
    NSString * sex = [NSString string];
    NSString * age = [NSString string];

    if (model.user.sex == 0){
        sex = @"请选择";
        
    }else{
        if (model.user.sex == 1) {
            sex  = @"男";
        }else{
            sex  = @"女";
        }
    }
    if (model.user.age){
        age = [NSString stringWithFormat:@"%ld",(long)model.user.age];
    }else{
        age = @"请选择";
    }


    _rightDatas = @[model.user.nickName?model.user.nickName:@"请填写",
                    model.user.name?model.user.name:@"请填写",
                    sex,
                    age,
                    model.user.passportNum?model.user.passportNum:@"请填写",
                    model.user.school?model.user.school:@"请填写",
                    model.user.grade?model.user.grade:@"请填写",
                    model.user.autograph?model.user.autograph:@"请填写",
                    model.user.phoneNum?model.user.phoneNum:@"请填写",
                    model.user.urgent?model.user.urgent:@"请填写",
                    ];
    
    _menuTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)style:UITableViewStylePlain];
    _menuTableView.delegate = self;
    _menuTableView.dataSource = self;
    _menuTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _menuTableView.separatorColor = MBBHEXCOLOR(0xdddddd);
    [self.view addSubview:_menuTableView];
    self.menuTableView.tableFooterView = [[UIView alloc]init];
    
    PersonalHeaderView * Header = [[PersonalHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
    Header.delegate = self;
    [Header.icon  setImageWithURL: [NSURL URLWithString:model.user.icon] placeholder:[UIImage imageNamed:@"default_icon"]];
    _Header = Header;
    self.menuTableView.tableHeaderView = Header;
    
}
#pragma mark - delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _menuDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"PersonalInfoCell";
    
    PersonalInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[PersonalInfoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.left.text = _menuDatas[indexPath.row];
    cell.right.text =_rightDatas[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ChangePersonalInfoController * change = [[ChangePersonalInfoController alloc]init];
    change.hidesBottomBarWhenPushed = YES;
    change.navTitle = _menuDatas[indexPath.row];
    MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    
    if (indexPath.row == 0||
        indexPath.row == 1||
        indexPath.row == 4||
        indexPath.row == 5||
        indexPath.row == 6||
        indexPath.row == 7||
        indexPath.row == 9) {
        
        if (indexPath.row == 0) {
            if (model.user.nickName) {
                change.placeholder = model.user.nickName;
            }
        }
        if (indexPath.row == 1) {
            if (model.user.name) {
                change.placeholder = model.user.name;
            }
        }
        if (indexPath.row == 4) {
            if (model.user.passportNum) {
                change.placeholder = model.user.passportNum;
            }
        }
        if (indexPath.row == 5) {
            if (model.user.school) {
                change.placeholder = model.user.school;
            }
        }
        if (indexPath.row == 6) {
            if (model.user.grade) {
                change.placeholder = model.user.grade;
            }
        }
        if (indexPath.row == 7) {
            if (model.user.autograph) {
                change.placeholder = model.user.autograph;
            }
        }
        if (indexPath.row == 9) {
            if (model.user.urgent) {
                change.placeholder = model.user.urgent;
            }
        }

        change.changeKey  = _postStrs[indexPath.row];
        change.changeStrBlock = ^(NSString * changeStr){
            PersonalInfoCell * cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.right.text = changeStr;
            if(indexPath.row == 0){
            
            }
        };
        [self.navigationController pushViewController:change animated:YES];
        
    }else if (indexPath.row == 2){
        
        LCActionSheet * sheet  = [[LCActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"男",@"女", nil];
        sheet.tag = KActionSheetSex;
        [sheet show];
        
    }else if (indexPath.row == 3){
        /** 年龄*/
        MBBDatePicker * picker = [[MBBDatePicker alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        picker.delegate = self;
        picker.datePicker.maximumDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
        picker.datePicker.minimumDate = [NSDate distantPast];
        [self.view addSubview:picker];
        
    }else if (indexPath.row == 8){
        ChangePhoneController * change = [[ChangePhoneController alloc]init];
        change.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:change animated:YES];
    }else{
        
    }
}

#pragma mark - MBBDatePickerDelegate
/** 更改年龄*/
- (void)datePickerSureClick:(NSString *)dateStr view:(UIView *)picker{
    
    if (dateStr.length < 4) {
        return;
    }
    NSDate * now = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYYMMdd"];
    NSString *locationString = [dateformatter stringFromDate:now];
    locationString = [locationString substringToIndex:4];
    NSString *selectBirthDay = [dateStr substringToIndex:4];
    int age = [locationString intValue] - [selectBirthDay intValue];
    if (age < 0) {
        age = 0;
    }
    
    [self changeAgeWith:age];

}

#pragma mark - PersonalHeaderViewDelegate
- (void)PersonalChangeIconImage{
    
    LCActionSheet * sheet  = [[LCActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照",@"相册", nil];
    sheet.tag = KActionSheetPhoto;
    [sheet show];

}

- (void)actionSheet:(LCActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        if (KActionSheetPhoto == actionSheet.tag) {
            /** 检查权限*/
            BOOL  isCanUseCamera = [MyControl checkCameraJurisdiction];
            if (isCanUseCamera) {
                [self pickImageFromCamera];
            }else{
                [MBProgressHUD showMessage:@"请您在设置中,设置打开我的大师兄相机使用权限" toView:self.view];
            }
   
        }
        if (KActionSheetSex == actionSheet.tag) {
            /** 男*/
            [self changeSexWith:1];
        }
    }
    
    if (buttonIndex == 2) {
        
        if (KActionSheetPhoto == actionSheet.tag) {
            
            [self pickImageFromAlbum];
            
        }
        if (KActionSheetSex == actionSheet.tag) {
            /** 女*/
            [self changeSexWith:2];

        }
    }
    
}
#pragma mark 从摄像机选择图片
- (void)pickImageFromCamera {
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.imagePicker.allowsEditing = YES;
    [self.imagePicker setShowsCameraControls:YES];
    self.imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:self.imagePicker animated:YES completion:^{
        //回调
        
    }];
}
- ( void )imagePickerController:( UIImagePickerController  *)picker didFinishPickingMediaWithInfo:( NSDictionary  *)info{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
       
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        [self sendCoverToSever:image];
        _Header.icon.image = image;
        
//        UIImage * imageUP = [self imageCompressForSize:image targetSize:CGSizeMake(1280, 1280)];

        
        
    }];
}

#pragma mark 从相册选择图片
- (void)pickImageFromAlbum {
    MLSelectPhotoPickerViewController *pickerVc = [[MLSelectPhotoPickerViewController alloc] init];
    pickerVc.maxCount = 1;
    pickerVc.status = PickerViewShowStatusCameraRoll;
    [pickerVc showPickerVc:self];
    pickerVc.callBack = ^(NSArray * assets){
        UIImage * image = [MLSelectPhotoPickerViewController getImageWithImageObj:[assets firstObject]];
        // 选取相册内的照片直接转为image
        for (MLSelectPhotoAssets * asset in assets) {
            asset.currentImage = [asset thumbImage];
        }
        
        [self sendCoverToSever:image];
        _Header.icon.image = image;
    };
}
#pragma mark - 上传头像
- (void)sendCoverToSever:(UIImage * )image{
    
    NSData *  iamgeData = UIImageJPEGRepresentation(image, 0.7);
    NSString * encodedImageStr = [iamgeData base64EncodedString];
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"registerpersonaldata";
    MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    paramDic[@"u_id"] = @(model.user.uid);
    paramDic[@"u_type"] = @(model.user.type);
    paramDic[@"u_img"] = encodedImageStr;
    paramDic[@"token"] = model.token;

    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager userChangePersonalData:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            [MBProgressHUD showSuccess:@"更换头像成功" toView:self.view];
           
            MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
            /** 更新本地*/
            model.user.icon = request.responseJSONObject[@"data"][@"u_img"];
            NSDictionary * infoDic = [model toDictionary];
            [MBBToolMethod setUserInfo:infoDic];
            
            /** 刷新个人中心表头*/
            [[NSNotificationCenter defaultCenter]postNotificationName:MBB_LOGIN_IN object:nil];

            
        }else{
            [MBProgressHUD showError:@"更换头像失败啦" toView:self.view];
        }
        
    }];
}
#pragma mark - 更改性别
- (void)changeSexWith:(NSInteger)sex{
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"registerpersonaldata";
    MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    paramDic[@"u_id"] = @(model.user.uid);
    paramDic[@"u_type"] = @(model.user.type);
    paramDic[@"u_sex"] =@(sex);
    paramDic[@"token"] = model.token;

    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager userChangePersonalData:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            [MBProgressHUD showSuccess:@"成功" toView:self.view];
            PersonalInfoCell * cell = [self.menuTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
            MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
            if (sex == 1) {
                cell.right.text = @"男";
                model.user.sex = 1;
            }else if(sex == 2){
                cell.right.text = @"女";
                model.user.sex = 2;
            }
            /** 更新本地*/
            NSDictionary * infoDic = [model toDictionary];
            [MBBToolMethod setUserInfo:infoDic];
            
        }else{
            [MBProgressHUD showError:@"失败啦" toView:self.view];
        }
        
    }];
}
#pragma mark - 更改年龄
- (void)changeAgeWith:(NSInteger)age{
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"registerpersonaldata";
    MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    paramDic[@"u_id"] = @(model.user.uid);
    paramDic[@"u_type"] = @(model.user.type);
    paramDic[@"u_age"] = @(age);
    paramDic[@"token"] = model.token;

    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager userChangePersonalData:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            [MBProgressHUD showSuccess:@"成功" toView:self.view];
            PersonalInfoCell * cell = [self.menuTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
            cell.right.text = [NSString stringWithFormat:@"%ld",(long)age];
            
            /** 更新本地*/
            MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
            model.user.age = age;
            NSDictionary * infoDic = [model toDictionary];
            [MBBToolMethod setUserInfo:infoDic];

        }else{
            [MBProgressHUD showError:@"失败啦" toView:self.view];
        }
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
