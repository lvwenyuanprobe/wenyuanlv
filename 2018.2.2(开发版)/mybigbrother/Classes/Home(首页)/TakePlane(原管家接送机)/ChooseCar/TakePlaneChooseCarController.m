//
//  TakePlaneChooseCarController.m
//  mybigbrother
//
//  Created by SN on 2017/4/26.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "TakePlaneChooseCarController.h"
#import "ChooseCarTopView.h"
#import "ChooseCarMiddleView.h"
#import "CarModel.h"

@interface TakePlaneChooseCarController ()
@property (nonatomic, strong) ChooseCarTopView * cycleViews;
@property (nonatomic, strong) ChooseCarMiddleView * middleView;
@property (nonatomic, strong) NSArray * carModels ;
@property (nonatomic, strong) CarModel * currentModel;

@end

@implementation TakePlaneChooseCarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"车型选择";
    
    ChooseCarTopView * cycleViews = [[ChooseCarTopView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    
    //    MBBWeakSelf;
    /** 改变展示信息*/
    cycleViews.presentPageBlock = ^(NSInteger page){
        /** 实时获取页码*/
        CarModel * model = _carModels[page];
        _currentModel = model;
        _middleView.packageCountLabel.text = [NSString stringWithFormat:@"%ld件",(long)model.car_lugaae];
        _middleView.packageLabel.text      = [NSString stringWithFormat:@"可携带行李数(%ld寸)",(long)model.lugaae_size];
        _middleView.personCountLabel.text  = [NSString stringWithFormat:@"%ld人/%ld人",(long)self.personNumber,(long)model.car_number];
    };
    
    [self.view addSubview:cycleViews];
    /** 展示信息*/
    ChooseCarMiddleView * middleView =[[ChooseCarMiddleView alloc]init];
    middleView.frame = CGRectMake(0,CGRectGetMaxY(cycleViews.frame)+ 10, SCREEN_WIDTH, 110) ;
    [self.view addSubview:middleView];
    
    _cycleViews = cycleViews;
    _middleView = middleView;
    
    
    /**  购买*/
    UIButton * chooseBtn = [[UIButton alloc] init];
    [chooseBtn setTitle:@"确定" forState:UIControlStateNormal];
    [chooseBtn setBackgroundImage:[UIImage imageWithColor:BUTTON_COLOR] forState:UIControlStateNormal];
    [chooseBtn addTarget:self action:@selector(makeSureClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view  addSubview:chooseBtn];
    
    
    chooseBtn.sd_layout
    .topSpaceToView(_middleView,40)
    .leftSpaceToView(self.view,40)
    .widthIs(SCREEN_WIDTH - 80)
    .heightIs(44);
    chooseBtn.clipsToBounds = YES;
    chooseBtn.layer.cornerRadius = 3;

    
    [self fetchDataSourceFromServer];
    // Do any additional setup after loading the view.
}
- (void)fetchDataSourceFromServer{
    
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"sign"] = @"cartypecartype";
    [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
    [MBBNetworkManager carServiceGetCarType:paramDic responseResult:^(YTKBaseRequest *request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        /** 请求成功*/
        if ([request.responseJSONObject[@"msg"] integerValue]== 200) {
            
            NSArray * carModels = [CarModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject[@"data"]];
            _carModels = carModels;
            if (carModels.count == 0) {
                return ;
            }
            _currentModel = [carModels firstObject];
            _cycleViews.carModels = carModels;
        }else{
            
            
        }
        
    }];
    
    
}
- (void)makeSureClicked{
    if (_currentModel) {
        self.carPopBlock(_currentModel);
        [self.navigationController popViewControllerAnimated:YES];
    }

}
- (void)setPersonNumber:(NSInteger)personNumber{
    
    _personNumber = personNumber;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
