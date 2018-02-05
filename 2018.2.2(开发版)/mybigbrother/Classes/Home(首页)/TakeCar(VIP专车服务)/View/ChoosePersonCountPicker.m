//
//  ChoosePersonCountPicker.m
//  mybigbrother
//
//  Created by SN on 2017/4/14.
//  Copyright © 2017年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "ChoosePersonCountPicker.h"


@interface ChoosePersonCountPicker()<UIPickerViewDataSource,UIPickerViewDelegate>{
    
    /** 成人*/
    UIPickerView * adultPicker;
    
    /** 儿童*/
    UIPickerView * childPicker;

    
    NSMutableArray * dataArray;
    
    NSMutableArray * childArray;
    
    NSInteger  adultRow;
    NSInteger  childRow;

}
@property (nonatomic, strong) UIView *   bgView;
@property (nonatomic, strong) UIView *   pickerView ;
@end

@implementation ChoosePersonCountPicker

- (BOOL)createAreaArray{
    
    dataArray = [NSMutableArray array];

    childArray = [NSMutableArray array];
    
    for (int i = 1 ; i < 13; i ++ ) {
        
        [dataArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    for (int i = 0 ; i < 13; i ++ ) {
        
        [childArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    return YES;
}

- (id)initWithFrame:(CGRect)frame withData:(NSMutableArray *)outDataArray withCancel:(void (^)(void))cancelBlock withConfirm:(void (^)(NSInteger adult,NSInteger child))confirmBlock{
    
    if (self = [super initWithFrame:frame]) {
        if (outDataArray) {
            dataArray = outDataArray;
            childArray = outDataArray;
        }
        else{
            //如果数据为空,return nil
            if (![self createAreaArray]) {
                return nil;
            }
        }
        
        [self setupPickerView];
        
        self.cancelAction = cancelBlock;
        
        self.SelectType = confirmBlock;
        
        return self;
    }
    return nil;
}

- (void)setupPickerView{
    
    /** 灰层*/
    UIView *  bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgView.backgroundColor = MBBCOLOR_ALPHA(1, 1, 1, 0.2);
    [self  addSubview:bgView];
    /** 动画*/
    [UIView animateWithDuration:0.4
                     animations:^{
                         bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
                     }
                     completion:^(BOOL finished){
                     }];

    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelTapClick:)];
    [bgView addGestureRecognizer:tapGR];
    _bgView = bgView;

    UIView * pickerView = [[UIView alloc] init];
    pickerView.backgroundColor = [UIColor whiteColor];
    pickerView.alpha = 1;
    pickerView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 320);
    
    [UIView animateWithDuration:0.4
                     animations:^{
                         pickerView.frame = CGRectMake(0, SCREEN_HEIGHT - 320, SCREEN_WIDTH, 320);
                     }
                     completion:^(BOOL finished){
                     }];
    
    [self.bgView addSubview:pickerView];
    
    _pickerView = pickerView;

    
    
    adultPicker = [[UIPickerView alloc] init];
    childPicker = [[UIPickerView alloc] init];

    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"请选择出发人数";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = BASE_YELLOW;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = MBBFONT(15);
    titleLabel.frame = CGRectMake(0, 0,SCREEN_WIDTH, 40);
    [pickerView addSubview:titleLabel];
    
    UIButton * cancel = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 4, 40)];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    cancel.titleLabel.textAlignment = NSTextAlignmentCenter;
    [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancel.titleLabel setFont:MBBFONT(15)];
    [cancel setBackgroundImage:[UIImage imageWithColor:BASE_YELLOW] forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [pickerView addSubview:cancel];
    
    
    UIButton * confirm = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*3 / 4, 0,SCREEN_WIDTH / 4, 40)];
    [confirm setTitle:@"确定" forState:UIControlStateNormal];
    confirm.titleLabel.textAlignment = NSTextAlignmentCenter;
    [confirm.titleLabel setFont:MBBFONT(15)];
    [confirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirm addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [confirm setBackgroundImage:[UIImage imageWithColor:BASE_YELLOW] forState:UIControlStateNormal];

    [pickerView addSubview:confirm];
    
    
    UILabel * adult = [[UILabel alloc]init];
    adult.text = @"成人";
    adult.textColor = FONT_DARK;
    adult.font = MBBFONT(15);
    adult.textAlignment = NSTextAlignmentCenter;
    adult.frame = CGRectMake(0, 50,SCREEN_WIDTH / 2, 20);

    [pickerView addSubview:adult];

    UILabel * chlid = [[UILabel alloc]init];
    chlid.text = @"儿童(12岁及以下)";
    chlid.textColor = FONT_DARK;
    chlid.font = MBBFONT(15);
    chlid.textAlignment = NSTextAlignmentCenter;

    chlid.frame = CGRectMake(SCREEN_WIDTH/ 2, 50,SCREEN_WIDTH / 2, 20);

    [pickerView addSubview:chlid];

    
    
    adultPicker.frame = CGRectMake(0, 70, SCREEN_WIDTH/2, 120);
    
    adultPicker.backgroundColor = [UIColor whiteColor];
    
    [pickerView addSubview:adultPicker];
    
    adultPicker.delegate = self;
    
    adultPicker.dataSource = self;
    
    
    childPicker.frame = CGRectMake(SCREEN_WIDTH/2, 70, SCREEN_WIDTH/2, 120);
    
    childPicker.backgroundColor = [UIColor whiteColor];
    
    [pickerView addSubview:childPicker];
    
    childPicker.delegate = self;
    
    childPicker.dataSource = self;

}

#pragma mark ==
#pragma mark Delegate

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if ([pickerView isEqual:adultPicker]) {
        return dataArray.count;
    }
    if ([pickerView isEqual:childPicker]) {
        return childArray.count;
    }
    return 0;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}

// these methods return either a plain NSString, a NSAttributedString, or a view (e.g UILabel) to display the row for the component.
// for the view versions, we cache any hidden and thus unused views and pass them back for reuse.
// If you return back a different object, the old one will be released. the view will be centered in the row rect
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    
    if ([pickerView isEqual:adultPicker]) {
        NSLog(@"titile = %@",[dataArray objectAtIndex:row]);
        return [dataArray objectAtIndex:row];

    }
    if ([pickerView isEqual:childPicker]) {
        NSLog(@"titile = %@",[childArray objectAtIndex:row]);
        return [childArray objectAtIndex:row];
    }
    return 0;

}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (pickerView == adultPicker) {
        adultRow = row;
 
    }
    if (pickerView == childPicker) {
        
        childRow = row;
    }
}

- (void)cancel{
    self.cancelAction();
    [self PickerBackClick];

}

- (void)confirm{
    [self PickerBackClick];

    self.SelectType([[dataArray objectAtIndex:adultRow] integerValue],[[childArray objectAtIndex:childRow] integerValue]);
}

#pragma mark - 蒙板点击
/** 消失*/
- (void)cancelTapClick:(UITapGestureRecognizer *)tap{
    
    
    [self PickerBackClick];
    
}
/** 取消*/
- (void)PickerBackClick{
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.pickerView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 320);
                     }
                     completion:^(BOOL finished){
                         if (finished == YES) {
                             [UIView animateWithDuration:0.4
                                              animations:^{
                                                  self.bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
                                              }
                                              completion:^(BOOL finished){
                                                  if (finished == YES) {
                                                      [self removeFromSuperview];
                                                  }
                                              }];
                         }
                     }];
}

@end
