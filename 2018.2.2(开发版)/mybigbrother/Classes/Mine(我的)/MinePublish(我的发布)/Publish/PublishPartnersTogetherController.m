//
//  PublishPartnersTogetherController.m
//  mybigbrother
//
//  Created by SN on 2017/4/7.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "PublishPartnersTogetherController.h"

#import "PublishInfoTopView.h"
#import "PublishMiddleView.h"
#import "PublishInfoBottomView.h"
#import "MBBPublishInputController.h"
#import "OrderInfoCell.h"
#import "MBBDatePicker.h"
/** 相机相关*/
#import "MLSelectPhotoPickerViewController.h"
#import "MLSelectPhotoAssets.h"
#import "MLSelectPhotoPickerAssetsViewController.h"
#import "MLSelectPhotoBrowserViewController.h"

#import "MBBLoginContoller.h"


@interface PublishPartnersTogetherController ()<PublishInfoBottomViewDelegate,
PublishInfoTopViewDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
LCActionSheetDelegate,
PublishMiddleViewDelegate,
MBBDatePickerDelegate,
UIScrollViewDelegate>

@property(nonatomic, strong)UIScrollView * mainScrollView;
@property(nonatomic, strong)UIImagePickerController * imagePicker;

@property(nonatomic, strong)PublishInfoBottomView *  bottomView;
@property(nonatomic, strong)PublishInfoTopView *  topView;
@property(nonatomic, strong)PublishMiddleView *  middleView;

/** 上传信息*/
@property(nonatomic, strong)NSMutableDictionary *  postDic;


@end

@implementation PublishPartnersTogetherController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发布约伴";
    self.view.backgroundColor = [UIColor whiteColor];
    /** 保存*/
    UIButton * seeRuleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 17)];
    [seeRuleBtn setTitle:@"发布" forState:UIControlStateNormal];
    [seeRuleBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [seeRuleBtn.titleLabel setFont:MBBFONT(15)];
    [seeRuleBtn addTarget:self action:@selector(publishPartersTogether) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * selectBar = [[UIBarButtonItem alloc] initWithCustomView:seeRuleBtn];
    self.navigationItem.rightBarButtonItem = selectBar;

    //主滚动视图
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,
                                                                    0,
                                                                    SCREEN_WIDTH,
                                                                    SCREEN_HEIGHT)];
    _mainScrollView.contentSize = CGSizeMake(0, SCREEN_HEIGHT * 1.3);
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.backgroundColor = [UIColor whiteColor];
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_mainScrollView];
    _mainScrollView.delegate = self;
    _mainScrollView.backgroundColor = BASE_VC_COLOR;
    
    PublishInfoTopView * topView = [[PublishInfoTopView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 176 + 44)];
    topView.delegate = self;
    _topView = topView;
    [_mainScrollView addSubview:topView];
    
    PublishMiddleView *   middleView = [[PublishMiddleView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame)+5, SCREEN_WIDTH, 210)];
    middleView.delegate = self;
    _middleView = middleView;
    [_mainScrollView addSubview:middleView];
    PublishInfoBottomView *   bottomView;
    if (kDevice_Is_iPhoneX) {
        bottomView = [[PublishInfoBottomView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(middleView.frame)+5, SCREEN_WIDTH, 300)];
    }else{
        bottomView = [[PublishInfoBottomView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(middleView.frame)+5, SCREEN_WIDTH, 230)];
    }
    
    bottomView.delegate = self;
    [_mainScrollView addSubview:bottomView];
    _bottomView = bottomView;
    
    self.postDic = [NSMutableDictionary dictionary];
    self.postDic[@"r_astrict"] = @(0);

}

#pragma mark - delegate
- (void)datePickerSureClick:(NSString *)dateStr view:(MBBDatePicker *)picker{
    for (OrderInfoCell * cell in _topView.cellArray) {
        if (cell.tag == KInfoSetoutTime) {
            cell.rightField.text = dateStr;
            self.postDic[@"r_starttime"] = dateStr;
        }
    }
}

- (void)chooseSexSign:(KSexSignType)type{
    
    self.postDic[@"r_astrict"] = @(type-100);
}
/** 填写信息*/
- (void)turnToInputView:(KInfoType)infoType{
    /** 出发时间*/
    if (KInfoSetoutTime == infoType) {
        /** 防止键盘遮挡*/
        [self.view endEditing:YES];
        /** 时间选择器*/
        MBBDatePicker * picker = [[MBBDatePicker alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        picker.datePicker.datePickerMode = UIDatePickerModeDate;
        picker.datePicker.minimumDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
        picker.datePicker.maximumDate = [NSDate distantFuture];
        picker.delegate = self;
        [self.view addSubview:picker];
        return;
    }
}
/** 添加图片*/
- (void)bottomViewAddPhotos{
    
    LCActionSheet * sheet  = [[LCActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照",@"相册", nil];
    [sheet show];
    

}

- (void)actionSheet:(LCActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
   
    if (buttonIndex == 1) {
        /** 检查权限*/
        BOOL  isCanUseCamera = [MyControl checkCameraJurisdiction];
        if (isCanUseCamera) {
            [self pickImageFromCamera];
        }else{
            [MBProgressHUD showMessage:@"请您在设置中,设置打开我的大师兄相机使用权限" toView:self.view];
        }
    }
    if (buttonIndex == 2) {
        [self pickImageFromAlbum];
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
        _bottomView.selectIamge.image = image;

        [self sendCoverToSever:image];
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
        _bottomView.selectIamge.image = image;
        [self sendCoverToSever:image];
    };
}

- (void)sendCoverToSever:(UIImage * )image{
    NSData *  iamgeData = UIImageJPEGRepresentation(image, 0.7);
    NSString * encodedImageStr = [iamgeData base64EncodedString];
    self.postDic[@"r_img"] = encodedImageStr;
}
#pragma mark - 发布
- (void)publishPartersTogether{
    [self.view endEditing:YES];
    MBBUserInfoModel * usermodel = [MBBToolMethod fetchUserInfo];
    if (!usermodel.token) {
        MBBLoginContoller *login = [[MBBLoginContoller alloc] init];
        [self.navigationController presentViewController:[[MBBNavigationController alloc]initWithRootViewController:login]
                                                animated:YES
                                              completion:nil];
        return;
    }


    for (int i = 0 ; i < _topView.cellArray.count; i ++) {
        OrderInfoCell * cell = [_topView.cellArray objectAtIndex:i];
        NSString * str = cell.rightField.text;
        if (KInfoLeave == i + 100) {
            self.postDic[@"r_setout"] = str;
        }
        if (KInfoArrive ==  i + 100) {
            self.postDic[@"r_arrive"] = str;
        }
        if (KInfoPlaneNum==i + 100){
            self.postDic[@"r_flight"] = str;
        }
        if (KInfoSchool ==  i + 100){
            self.postDic[@"r_school"] = str;
        }
    }
    
    
    self.postDic[@"r_desc"] = _middleView.explain.text;
    
    
    
    if (!self.postDic[@"r_setout"] || [self.postDic[@"r_setout"] isEqualToString:@""]) {
        [MyControl alertShow:@"请您填写出发地"];
        return;
    }
    if (!self.postDic[@"r_arrive"]|| [self.postDic[@"r_arrive"] isEqualToString:@""]) {
        [MyControl alertShow:@"请您填写目的"];
        return;
    }
    if (!self.postDic[@"r_flight"]|| [self.postDic[@"r_flight"] isEqualToString:@""]) {
        [MyControl alertShow:@"请您填写航班号"];
        return;
    }
    if (!self.postDic[@"r_school"]|| [self.postDic[@"r_school"] isEqualToString:@""]) {
        [MyControl alertShow:@"请您填写就读学校"];
        return;
    }
    if (!self.postDic[@"r_desc"]|| [self.postDic[@"r_desc"] isEqualToString:@""]) {
        [MyControl alertShow:@"请填您写约伴简介"];
        return;
    }
    if (!self.postDic[@"r_astrict"]) {
        [MyControl alertShow:@"请您选择标签"];
        return;
    }
    if (!self.postDic[@"r_starttime"]) {
        [MyControl alertShow:@"请您选择出发时间"];
        return;
    }
    if (!self.postDic[@"r_img"]) {
        [MyControl alertShow:@"请您选择图片"];
        return;
    }

     MBBUserInfoModel * model = [MBBToolMethod fetchUserInfo];
    self.postDic[@"token"] = model.token;
    self.postDic[@"sign"]  = @"releasereleaseadd";
    
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager myPublishGetPartnersTogether:self.postDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            
//            NSLog(@"%@",request.responseJSONObject[@"data"]);
            
            [MBProgressHUD showSuccess:@"发送成功" toView:self.view];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [MBProgressHUD showError:@"发送失败" toView:self.view];
        }
        
    }];

}
#pragma mark - 拖拽弹回
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
