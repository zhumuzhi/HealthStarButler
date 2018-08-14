//
//  FSSearchBarView.m
//  FangShengyun
//
//  Created by mac on 2018/6/18.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import "FSSearchBarView.h"
@interface FSSearchBarView()<UITextFieldDelegate,FSLocationViewDelegate>
@property (nonatomic , strong) UILabel *placeholderLabel;
@property (nonatomic , strong) FSButton *back;
@property (nonatomic , strong) FSButton *search;
@property (nonatomic , assign) CGFloat finalX;

@end
@implementation FSSearchBarView

- (void)setSearchBarAlpha:(CGFloat)searchBarAlpha {
    _searchBarAlpha = searchBarAlpha;
    self.alpha = searchBarAlpha;
}
- (void)setSearchString:(NSString *)searchString {
    _searchString = searchString;
    self.searchBar.text = searchString;
    if (searchString.length) {
        self.placeholderLabel.hidden = YES;
        self.searchBar.rightViewMode = UITextFieldViewModeAlways;
        self.search.enabled = YES;
    } else {
        self.search.enabled = NO;
        self.placeholderLabel.hidden = NO;
        self.searchBar.rightViewMode = UITextFieldViewModeNever;
    }
}
- (void)setSearchBarType:(FSSearchBarType)searchBarType {
    _searchBarType = searchBarType;
    if (searchBarType == FSSearchBarTypeHome) {
        self.back.hidden = YES;
    } else if (searchBarType == FSSearchBarTypeSubCategory) {
        self.locationView.hidden = YES;
    } else if (searchBarType == FSSearchBarTypeSearch) {
        self.search.hidden = NO;
        self.locationView.hidden = YES;
    } else if (searchBarType == FSSearchBarTypeZoneSearch) {
        self.search.hidden = NO;
        self.locationView.hidden = YES;
        self.back.hidden = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self.search setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
        [self.search setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     
    } else if (searchBarType == FSSearchBarTypeCategory) {
        self.back.hidden = YES;
        self.locationView.hidden = YES;

    }
}
- (void)setSearchBarBackColor:(UIColor *)searchBarBackColor {
    _searchBarBackColor = searchBarBackColor;
    self.backgroundColor = searchBarBackColor;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.searchBar];
    [self addSubview:self.locationView];
    [self addSubview:self.back];
    [self.searchBar addSubview:self.placeholderLabel];
    [self addSubview:self.search];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:self.searchBar];
}
- (void)textChange: (NSNotification *)noti {
    
    if (self.searchBar.text.length && ![self isEmpty:self.searchBar.text]) {
        self.placeholderLabel.hidden = YES;
        self.searchBar.rightViewMode = UITextFieldViewModeAlways;
        self.search.enabled = YES;
    } else {
        if ([self isEmpty:self.searchBar.text]) {
            self.placeholderLabel.hidden = YES;
        } else {
            self.placeholderLabel.hidden = NO;
        }
        self.searchBar.rightViewMode = UITextFieldViewModeNever;
        self.search.enabled = NO;
     
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarView:userInput:)]) {
        [self.delegate searchBarView:self userInput:self.searchBar.text];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.searchBarType == FSSearchBarTypeHome ||self.searchBarType == FSSearchBarTypeCategory ||self.searchBarType ==  FSSearchBarTypeSubCategory) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarViewDidClick:type:)]) {
            [self.delegate searchBarViewDidClick:self type:FSSearchBarButtonTypeSearch];
        }
        return NO;
    } else {
        return YES;
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField.text.length) {
        self.searchBar.rightViewMode = UITextFieldViewModeAlways;
    } else {
        self.searchBar.rightViewMode = UITextFieldViewModeNever;
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.searchBar.rightViewMode = UITextFieldViewModeNever;
}

- (void)locationView:(FSLocationView *)locationView finalX:(CGFloat)finalX {
    self.finalX = finalX;
    if (self.searchBarType == FSSearchBarTypeHome) {
        [UIView animateWithDuration:0.25 animations:^{
            self.searchBar.x = self.finalX +kAutoWithSize(6) + kAutoWithSize(3) + kAutoWithSize(5) + 20;;
        }];
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
#pragma mark - 根据searchBarType 布局子控件
    /** 首页 */
    if (self.searchBarType == FSSearchBarTypeHome) {
        self.searchBar.frame = CGRectMake(self.finalX  + kAutoWithSize(6) + kAutoWithSize(3) + kAutoWithSize(5), (self.bounds.size.height -kAutoWithSize(32)) * 0.5 , kAutoWithSize(268), kAutoWithSize(32));
    /** 分类 && 商品页 */
    } else if (self.searchBarType == FSSearchBarTypeSubCategory) {
        self.searchBar.frame = CGRectMake(kAutoWithSize(45), (self.bounds.size.height -kAutoWithSize(32)) * 0.5 , kAutoWithSize(313), kAutoWithSize(32));
    /** 搜索控制器 */
    } else if (self.searchBarType == FSSearchBarTypeSearch) {

        self.search.frame = CGRectMake(kScreenWidth - kAutoWithSize(10) - kAutoWithSize(30), (self.bounds.size.height -kAutoWithSize(20)) * 0.5 , kAutoWithSize(30), kAutoWithSize(20));
        
        self.searchBar.frame = CGRectMake(self.back.width + kAutoWithSize(20)+kAutoWithSize(10) , (self.bounds.size.height -kAutoWithSize(32)) * 0.5 , kScreenWidth - (self.back.width + kAutoWithSize(20)+kAutoWithSize(10)) -self.search.width-kAutoWithSize(20), kAutoWithSize(32));
    /** 区域搜索控制器 */
    } else if (self.searchBarType == FSSearchBarTypeZoneSearch) {
        self.searchBar.frame = CGRectMake(kAutoWithSize(20), (self.bounds.size.height -kAutoWithSize(32)) * 0.5 , kAutoWithSize(293), kAutoWithSize(32));
        self.search.frame = CGRectMake(self.searchBar.x +self.searchBar.width + kAutoWithSize(20) , (self.bounds.size.height -kAutoWithSize(20))* 0.5 , kAutoWithSize(30), kAutoWithSize(20));
    } else if (self.searchBarType == FSSearchBarTypeCategory ) {
        self.searchBar.frame = CGRectMake(kMargin10 * 2, (self.bounds.size.height -kAutoWithSize(32)) * 0.5 , kScreenWidth - kMargin10 * 4, kAutoWithSize(32));
    }
}
/** searchBar按钮的点击事件 */
- (void)clickButton: (UIButton *)button {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarViewDidClick:type:)]) {
        [self.delegate searchBarViewDidClick:self type:button.tag];
    }
}
- (BOOL)isEmpty:(NSString *) str {
    if (!str) {
        return true;
    } else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}
#pragma mark - get
- (FSButton *)search {
    if (_search == nil) {
        _search = [[FSButton alloc]init];
        [_search setTitle:@"搜索" forState:UIControlStateNormal];
        [_search sizeToFit];
        [_search setTitleColor:[UIColor colorWithHexString:@"E5E5E5"] forState:UIControlStateDisabled];
        [_search setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
        _search.enabled = NO;
        _search.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kFont(14)];
        _search.hidden = YES;
        [_search addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        _search.tag = FSSearchBarButtonTypeSearch;
    }
    return _search;
}
- (FSLocationView *)locationView {
    if (_locationView == nil) {
        _locationView = [[FSLocationView alloc]init];
        _locationView.frame = CGRectMake(kAutoWithSize(18), 12, kAutoWithSize(64), 20);
        [_locationView addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        _locationView.tag = FSSearchBarButtonTypeLocation;
        _locationView.delegate = self;
    }
    return _locationView;
}

- (FSButton *)back {
    if (_back == nil) {
        _back = [[FSButton alloc]init];
        [_back setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
        [_back sizeToFit];
        _back.frame = CGRectMake(kAutoWithSize(20), (self.height - _back.height) * 0.5, _back.width, _back.height);
        [_back addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        _back.tag = FSSearchBarButtonTypeBack;
    }
    return _back;
}
- (UITextField *)searchBar {
    if (_searchBar == nil) {
        _searchBar = [[UITextField alloc]init];
        _searchBar.backgroundColor = [UIColor colorWithHexString:@"#ECECEC"];
        _searchBar.layer.masksToBounds = YES;
        _searchBar.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kFont(12)];
        _searchBar.layer.cornerRadius = kAutoWithSize(15);
        UIView *leftView = [[UIView alloc]init];
        leftView.frame = CGRectMake(0, 0, kAutoWithSize(29), kAutoWithSize(32));
        UIImageView *iconView = [[UIImageView alloc]init];
        [leftView addSubview:iconView];
        iconView.image = [UIImage imageNamed:@"home_search"];
        iconView.frame = CGRectMake(kAutoWithSize(12), (kAutoWithSize(32) - kAutoWithSize(14)) * 0.5, kAutoWithSize(14), kAutoWithSize(14));
        _searchBar.leftViewMode = UITextFieldViewModeAlways;
        _searchBar.leftView = leftView;
        _searchBar.delegate = self;
        UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kAutoWithSize(40), kAutoWithSize(32))];
        FSButton *clear = [[FSButton alloc]initWithFrame:rightView.bounds];
        [clear addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [clear setImage:[UIImage imageNamed:@"clear"] forState:UIControlStateNormal];
        [clear setImage:[UIImage imageNamed:@"clear"] forState:UIControlStateHighlighted];
        [clear setImage:[UIImage imageNamed:@"clear"] forState:UIControlStateSelected];
        [rightView addSubview:clear];
        _searchBar.rightView = clear;
        _searchBar.rightViewMode = UITextFieldViewModeNever;
        clear.tag = FSSearchBarButtonTypeClearSearchString;
        _searchBar.tintColor = [UIColor colorWithHexString:@"#F08327"];
    }
    return _searchBar;
}
- (UILabel *)placeholderLabel {
    if (_placeholderLabel == nil) {
        _placeholderLabel = [[UILabel alloc]init];
        _placeholderLabel.textColor =[UIColor colorWithHexString:@"#999999"];
        _placeholderLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:kFont(12)];
        _placeholderLabel.frame = CGRectMake(kAutoWithSize(29), (kAutoWithSize(32) -kAutoWithSize(17) ) * 0.5 , kAutoWithSize(232), kAutoWithSize(17));
        _placeholderLabel.text = @"请输入商品名称、品牌名称、型号、sku码";
        _placeholderLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _placeholderLabel;
}

- (void)dealloc {
    
}
@end
