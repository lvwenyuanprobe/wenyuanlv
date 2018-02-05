//
//  WYPostTypeCell.m
//  mybigbrother
//
//  Created by Loren on 2018/1/23.
//  Copyright © 2018年 思能教育咨询(大连)有限公司. All rights reserved.
//

#import "WYPostTypeCell.h"
#import "Masonry.h"
#import "WYPostType.h"

/**用代码方式自定义某个视图
 1.都是给要自定认的视图的系统类型来一个子类
 2.重写父类指定的初始化方法:添加子控件
 
 
 */
@interface WYPostTypeCell ()
@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *nameLabel;

@end
@implementation WYPostTypeCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加子控件
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    // 1.创建显示图片的imageView
    UIImageView *iconView = [[UIImageView alloc] init];
    [self.contentView addSubview:iconView];
    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX).offset(0);
        make.top.offset(8);
        make.width.height.offset(30);
    }];
    
    // 2.创建显示名称的label
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    // 设置label中的文字局中
    nameLabel.textAlignment = NSTextAlignmentCenter;
    // 设置字体
    nameLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(iconView.mas_bottom).offset(8);
    }];
    
    self.iconView = iconView;
    self.nameLabel = nameLabel;
    
}

// 重写模型属性的set方法给cell内部子控件设置数据

- (void)setPostType:(WYPostType *)PostType
{
    _PostType = PostType;
    self.iconView.image = [UIImage imageNamed:PostType.icon];
    self.nameLabel.text = PostType.name;
}


// 重写高亮属性的set方法在此方法中设置cell的背景颜色
// 点击和松手都会调用方法
- (void)setHighlighted:(BOOL)highlighted {
    
    //    if (highlighted == YES) {
    //        self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    //    } else {
    //        self.backgroundColor = [UIColor whiteColor];
    //    }
    
    self.backgroundColor = highlighted ? [UIColor colorWithWhite:0.9 alpha:1] : [UIColor whiteColor];
}
@end
