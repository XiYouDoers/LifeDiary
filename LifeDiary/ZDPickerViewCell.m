//
//  ZDPickerViewCell.m
//  LifeDiary
//
//  Created by JACK on 2018/5/20.
//  Copyright © 2018年 JACK. All rights reserved.
//
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#import "ZDPickerViewCell.h"
@interface ZDPickerViewCell()<UIPickerViewDelegate,UIPickerViewDataSource>

@end
@implementation ZDPickerViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        //_tabImageView
        _tabImageView = [[UIImageView alloc]init];
        _tabImageView.frame = CGRectMake(10, 13, 19, 19);
        _tabImageView.image = [UIImage imageNamed:@"add"];
        [self addSubview:_tabImageView];
        
        
        //_tabLabel
        _tabLabel = [[UILabel alloc]init];
        _tabLabel.frame = CGRectMake(45, 10, 100, 25);
        [self addSubview:_tabLabel];
        
        //_textField
        _textField = [[UITextField alloc]init];
        _textField.frame = CGRectMake(150, 10, 150, 25);
        
        
        //_pickerView
        _pickerView = [[UIPickerView alloc]init];
        _pickerView.frame = CGRectMake(0, HEIGHT/4*3, WIDTH, HEIGHT/4);
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
        _textField.inputView = _pickerView;
        [self addSubview:_textField];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
    
}
//返回指定列的行数

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return 10;
    
}

//返回指定列，行的高度，就是自定义行的高度

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 30.f;
}

//返回指定列的宽度

- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    return  WIDTH;
}

// 自定义指定列的每行的视图，即指定列的每行的视图行为一致

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    if (!view){
        view = [[UIView alloc]init];
        
    }
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
    
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = [UIFont systemFontOfSize:16];
    textLabel.text = [_pickerViewDataArray objectAtIndex:row];
    
    [view addSubview:textLabel];
    
    //隐藏上下直线
    
    //    　　[self.pickerView.subviews objectAtIndex:1].backgroundColor = [UIColor clearColor];
    //
    //    [self.pickerView.subviews objectAtIndex:2].backgroundColor = [UIColor clearColor];
    
    return view;
    
}

//显示的标题

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *str = [_pickerViewDataArray objectAtIndex:row];
    
    return str;
    
}

//显示的标题字体、颜色等属性

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    //    NSString *str = [_nameArray objectAtIndex:row];
    //
    //    NSMutableAttributedString *AttributedString = [[NSMutableAttributedString alloc]initWithString:str];
    //
    //    [AttributedString addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, [AttributedString  length])];
    //
    //
    //
    //    return AttributedString;'
    return nil;
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    

    _textField.text = [_pickerViewDataArray objectAtIndex:row];
}

@end
