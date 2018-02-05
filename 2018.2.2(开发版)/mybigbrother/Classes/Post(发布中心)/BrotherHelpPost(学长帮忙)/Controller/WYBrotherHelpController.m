//
//  WYBrotherHelpController.m
//  mybigbrother
//
//  Created by apple on 2018/1/23.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "WYBrotherHelpController.h"
#import "TextFieldCell.h"
#import "CreateTableModel.h"
#import "LLImagePickerView.h"

@interface WYBrotherHelpController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableDictionary *formDict;
@property (nonatomic,strong) UIView *footView;
@end

@implementation WYBrotherHelpController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"信息发布";
    [self CreateTableView];
}

- (void)CreateTableView{
    
    // 创建发布按钮
    UIButton *postBtn = [[UIButton alloc] init];
    [self.view addSubview:postBtn];
    [postBtn setTitle:@"发布" forState:UIControlStateNormal];
    postBtn.backgroundColor = [UIColor colorWithHexString:@"#f76236"];
    [postBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    postBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [postBtn addTarget:self action:@selector(post_click:) forControlEvents:UIControlEventTouchUpInside];
    [postBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(55);
        make.bottom.equalTo(self.view);
    }];
    
    // 创建表单
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero  style:UITableViewStylePlain];
//    self.tableView.bounces = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(postBtn.mas_top);
    }];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(commitAction)];
    self.navigationItem.rightBarButtonItem = item;
    
    self.formDict = [NSMutableDictionary dictionary];
    
    [self creatData];
    [self createFooterView];
}

- (void)commitAction
{
    NSLog(@"表单处于编辑状态%@",self.formDict);
}

- (void)creatData
{
    self.dataArray = @[].mutableCopy;
    
    CreateTableModel *name = [CreateTableModel new];
    name.cellType = CreateTableTFCell;
    name.title = @"姓名";
    name.placeholder = @"请输入真实姓名";
    //提交到服务器的key
    name.key = @"name";
    [self.dataArray addObject:name];
    
    CreateTableModel *sex = [CreateTableModel new];
    sex.cellType = CreateTableTFCell;
    sex.title = @"性别";
    sex.placeholder = @"请输入性别";
    //提交到服务器的key
    sex.key = @"sex";
    [self.dataArray addObject:sex];
    
    CreateTableModel *CHAddress = [CreateTableModel new];
    CHAddress.cellType = CreateTableTFCell;
    CHAddress.title = @"中国住所";
    CHAddress.placeholder = @"请输入详细住址";
    //提交到服务器的key
    CHAddress.key = @"CHAddress";
    [self.dataArray addObject:CHAddress];
    
    CreateTableModel *verbSchool = [CreateTableModel new];
    verbSchool.cellType = CreateTableTFCell;
    verbSchool.title = @"在读院校";
    verbSchool.placeholder = @"请确认在读院校";
    //提交到服务器的key
    verbSchool.key = @"verbSchool";
    [self.dataArray addObject:verbSchool];
    
    CreateTableModel *specializ = [CreateTableModel new];
    specializ.cellType = CreateTableTFCell;
    specializ.title = @"在读专业";
    specializ.placeholder = @"请输入所在专业";
    //提交到服务器的key
    specializ.key = @"specializ";
    [self.dataArray addObject:specializ];
    
    CreateTableModel *GPA = [CreateTableModel new];
    GPA.cellType = CreateTableTFCell;
    GPA.title = @"GPA平均分";
    GPA.placeholder = @"请输入GPA平均分";
    //提交到服务器的key
    GPA.key = @"GPA";
    [self.dataArray addObject:GPA];
    
    CreateTableModel *USACity = [CreateTableModel new];
    USACity.cellType = CreateTableTFCell;
    USACity.title = @"美国所在城市";
    USACity.placeholder = @"请输入所在城市";
    //提交到服务器的key
    USACity.key = @"USACity";
    [self.dataArray addObject:USACity];
    
    CreateTableModel *leisureTime = [CreateTableModel new];
    leisureTime.cellType = CreateTableTFCell;
    leisureTime.title = @"空闲时间";
    leisureTime.placeholder = @"请输入空闲时间";
    //提交到服务器的key
    leisureTime.key = @"leisureTime";
    [self.dataArray addObject:leisureTime];
    
    CreateTableModel *interest = [CreateTableModel new];
    interest.cellType = CreateTableTFCell;
    interest.title = @"兴趣爱好";
    interest.placeholder = @"请输入您的兴趣爱好";
    //提交到服务器的key
    interest.key = @"interest";
    [self.dataArray addObject:interest];
    
    CreateTableModel *serveArea = [CreateTableModel new];
    serveArea.cellType = CreateTableTFCell;
    serveArea.title = @"服务范围";
    serveArea.placeholder = @"例如：健身教练、校园导游";
    //提交到服务器的key
    serveArea.key = @"serveArea";
    [self.dataArray addObject:serveArea];
    
    CreateTableModel *wechatNum = [CreateTableModel new];
    wechatNum.cellType = CreateTableTFCell;
    wechatNum.title = @"微信号";
    wechatNum.placeholder = @"请输入您的微信号";
    //提交到服务器的key
    wechatNum.key = @"wechatNum";
    [self.dataArray addObject:wechatNum];
    
    CreateTableModel *phoneNum = [CreateTableModel new];
    phoneNum.cellType = CreateTableTFCell;
    phoneNum.title = @"手机号";
    phoneNum.placeholder = @"请输入您的手机号";
    //提交到服务器的key
    phoneNum.key = @"phoneNum";
    [self.dataArray addObject:phoneNum];
    
    CreateTableModel *mailBox = [CreateTableModel new];
    mailBox.cellType = CreateTableTFCell;
    mailBox.title = @"邮箱";
    mailBox.placeholder = @"请输入您的电子邮箱";
    //提交到服务器的key
    mailBox.key = @"mailBox";
    [self.dataArray addObject:mailBox];
    
    // 分割线cell
    CreateTableModel *separator = [CreateTableModel new];
    separator.cellType = CreateTableSeparatorCell;
    [self.dataArray addObject:separator];
    
//    CreateTableModel *StudyCredentials = [CreateTableModel new];
//    StudyCredentials.cellType = CreateTablePhotoCell;
//    //提交到服务器的key
//    StudyCredentials.key = @"StudyCredentials";
//    [self.dataArray addObject:StudyCredentials];
//
//    CreateTableModel *identityCard = [CreateTableModel new];
//    identityCard.cellType = CreateTablePhotoCell;
//    //提交到服务器的key
//    identityCard.key = @"identityCard";
//    [self.dataArray addObject:identityCard];
    
}

#pragma mark - UITableDelegate & UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CreateTableModel *model = self.dataArray[indexPath.row];
    if (model.cellType == CreateTableSeparatorCell) {
        static NSString *cellID = @"SeparatorCellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }
        
        return cell;
    }else if (model.cellType == CreateTableTFCell){
        static NSString *cellID = @"textFieldCellID";
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //监听textField输入
            [cell textFieldAddObserver:self selector:@selector(textFieldValueChange:)];
        }
        
        cell.formDict = self.formDict;
        cell.creatTableModel = model;
        return cell;
        
    }
    
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CreateTableModel *model = self.dataArray[indexPath.row];
    if (model.cellType == CreateTableSeparatorCell) {
        return 10;
    }
    
    return 55;
}

- (void)textFieldValueChange:(NSNotification *)note
{
    
        UITextField *textField = note.object;
        //可以这样取值
        NSString *name = self.formDict[@"name"];
        NSString *nickName = self.formDict[@"nickName"];
        NSString *psw = self.formDict[@"psw"];
        NSString *psw2 = self.formDict[@"psw2"];
    
        NSLog(@"现在输入的是：%@\nname = %@,\nnickName = %@,\npsw = %@,\npsw2 = %@,\n",textField.text,
              name,
              nickName,
              psw,
              psw2);
}

- (void)post_click:(UIButton *)sender
{
    NSLog(@"发布");
}

//因为监听了textField通知，所以记得要在注销时，注销通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)createFooterView
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
    footView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = footView;
    
        UILabel *studentID = [[UILabel alloc] init];
        [footView addSubview:studentID];
        studentID.text = @"学生证件";
        studentID.font = [UIFont systemFontOfSize:15.0f];
        [studentID mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(15);
        }];
    
#pragma mark - 上传学生件 - 目前限定8张 -
    // CountOfRow 每行上传多少张
    LLImagePickerView *pickerStuID = [LLImagePickerView ImagePickerViewWithFrame:CGRectMake(0, 35, [UIScreen mainScreen].bounds.size.width, 0) CountOfRow:4];
    pickerStuID.type = LLImageTypePhotoAndCamera; // 相机类型
    pickerStuID.maxImageSelected = 8; // 最多上传张数
    pickerStuID.allowPickingVideo = YES;
    [footView addSubview:pickerStuID];
    pickerStuID.backgroundColor = [UIColor greenColor];
    [pickerStuID observeSelectedMediaArray:^(NSArray<LLImagePickerModel *> *list) {
        NSLog(@"%@",list);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    [footView addSubview:lineView];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.width.mas_equalTo(kScreenWidth);
        make.top.equalTo(pickerStuID.mas_bottom).offset(10);
    }];
    
    UILabel *myselfID = [[UILabel alloc] init];
    [footView addSubview:myselfID];
    myselfID.text = @"有效身份证件";
    myselfID.font = [UIFont systemFontOfSize:15.0f];
    [myselfID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.equalTo(lineView.mas_bottom).offset(15);
    }];
    
//    LLImagePickerView *pickerIdentityID = [LLImagePickerView ImagePickerViewWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 0) CountOfRow:4];
////    [pickerIdentityID mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.width.mas_equalTo(kScreenWidth);
////        make.top.equalTo(myselfID.mas_bottom).offset(15);
////    }];
//    pickerIdentityID.type = LLImageTypePhotoAndCamera; // 相机类型
//    pickerIdentityID.maxImageSelected = 2; // 最多上传张数
//    pickerIdentityID.allowPickingVideo = YES;
//    [footView addSubview:pickerIdentityID];
//    pickerIdentityID.backgroundColor = [UIColor yellowColor];
//    [pickerIdentityID observeSelectedMediaArray:^(NSArray<LLImagePickerModel *> *list) {
//        NSLog(@"%@",list);
//    }];
    
}

// 设置动态footerView
//- (void)viewDidLayoutSubviews {
//    [super viewDidLayoutSubviews];
//    UIView *footerView = self.tableView.tableFooterView;
//    float height = [self.tableView.tableFooterView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
//    if (height != footerView.frame.size.height ) {
//        footerView.frame = (CGRect){footerView.frame.origin, footerView.frame.size.height, height};
//        self.tableView.tableFooterView = footerView;
//    }
//}


@end


















