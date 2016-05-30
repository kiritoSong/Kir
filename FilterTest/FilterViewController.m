//
//  FilterViewController.m
//  YiBaiSong
//
//  Created by kirito_song on 16/5/11.
//  Copyright © 2016年 yibaisong. All rights reserved.//

#import "FilterViewController.h"
#import "KiritoCustom.h"

#define kScreenWidth self.view.frame.size.width
#define kScreenHeight self.view.frame.size.height

@interface FilterViewController ()<UISearchBarDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (weak, nonatomic   ) IBOutlet UITextField *priceTextField1;
@property (weak, nonatomic   ) IBOutlet UITextField *priceTextField2;
@property (weak, nonatomic   ) IBOutlet UISearchBar *searchBar;
@property (strong , nonatomic) UITableView * tableView;
@property (strong , nonatomic) NSArray     * cellArr;
@end

@implementation FilterViewController

#pragma mark– life cycle

-(instancetype)init {
    self = [super init];
    if (self) {
//        self.filterModel = [[BSFilterModel alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"高级筛选";
    self.view.backgroundColor = [UIColor whiteColor];
    //配置页面
    [self setUpViews];
    //配置确定按钮
    [self createSureBtn];
}

-(void)dealloc {
    NSLog(@"FilterViewController__dealloc");
}

#pragma mark- UITableViewDelegate&&UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }else {
        return 1;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id x_cell;
    for (UITableViewCell * cell in _cellArr) {
        if (cell.tag == indexPath.section * 100 + indexPath.row) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            x_cell = cell;
        }
    }
    return x_cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor whiteColor];
    return headerView;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self hiddenKeyboard];
}

#pragma mark- UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self sureBtnClick:nil];
}



#pragma mark– event respomse

- (void)hiddenKeyboard
{
    [_priceTextField1 resignFirstResponder];
    [_priceTextField2 resignFirstResponder];
    [_searchBar resignFirstResponder];
}

- (IBAction)didSelectSegment:(UISegmentedControl *)sender {

    [self.filterModel configureModelWithSegment:sender];
}



- (void)sureBtnClick:(UIButton *)btn
{
    self.filterModel.keyWord = _searchBar.text;
    if (_searchBar.text.length == 0) {
        self.filterModel.keyWord = @"0";
    }
    self.filterModel.priceMin = self.priceTextField1.text;
    self.filterModel.priceMax = self.priceTextField2.text;
    
    if (self.filterModel.priceMax.intValue < self.filterModel.priceMin.intValue) {
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"价格区间填写错误" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles: nil];
        
        [alert show];
        return;
    }
    
    
    if ([self.delegate respondsToSelector:@selector(filterWithModel:)]) {
        [self.delegate filterWithModel:self.filterModel];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark– private Enevt

- (void)createSureBtn
{
    //最下面的确定按钮的后背景
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-64-51, self.view.frame.size.width, 51)];
    bgImageView.image = [[UIImage imageNamed:@"list_downviewbg.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:10];
    bgImageView.userInteractionEnabled = YES;
    [self.view addSubview:bgImageView];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(self.view.frame.size.width/2-45, 8, 90, 34);
    sureBtn.layer.cornerRadius = 17;
    sureBtn.backgroundColor = [UIColor colorWithRed:255.0/255 green:91.0/255 blue:59.0/255 alpha:1];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:19];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bgImageView addSubview:sureBtn];
}


- (void) setUpViews {
    
    [self.view addSubview:self.tableView];
    //解固Nib保存Cell
    _cellArr = [[NSBundle mainBundle]loadNibNamed:@"BSFilterCell" owner:self options:nil];
    
    //配置SearchBar
    [self setUpSearchBar];
    //配置三个键盘
    [self setUpForTextField:_priceTextField1];
    [self setUpForTextField:_priceTextField2];
    _searchBar.inputAccessoryView = [KiritoCustom createKeyBoardBackViewWithTarget:self action:@selector(hiddenKeyboard)];

}

-(void)setUpForTextField:(UITextField *)textField {
    //添加回收按钮
    textField.inputAccessoryView = [KiritoCustom createKeyBoardBackViewWithTarget:self action:@selector(hiddenKeyboard)];
    //价格区间监听
    [textField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    textField.keyboardType = UIKeyboardTypeNumberPad;
}

#pragma mark - 配置SearchBar

-(void )setUpSearchBar
{
    //设置搜索框
    [self.searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [self.searchBar setImage:[UIImage imageNamed:@"goodsListBgsImage.png"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    self.searchBar.backgroundImage = [self imageWithColor:[UIColor clearColor] size:CGSizeMake(kScreenWidth, 45)];
    //给键盘添加回收按钮
    UIView * aa = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 31)];
    self.searchBar.inputAccessoryView = aa;
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kScreenWidth-60, 0, 60, 31);
    [button setImage:[UIImage imageNamed:@"feedback_keyBack.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(hiddenKeyboard) forControlEvents:UIControlEventTouchUpInside];
    [aa addSubview:button];
}

//取消searchbar背景色
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}



#pragma mark- getter&&setter
-(UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kScreenHeight-64-50) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.delegate        = self;
        _tableView.dataSource      = self;
    }
    return _tableView;
}

- (void)textFieldEditChanged:(UITextField *)textField
{
    if (textField.text.length > 7) {
        textField.text = [textField.text substringToIndex:7];
        return;
    }
}

- (UIView *)createKeyBoardBackView{
    //给键盘添加回收按钮
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 31)];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kScreenWidth-60, 0, 60, 31);
    [button setImage:[UIImage imageNamed:@"feedback_keyBack.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(hiddenKeyboard) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:button];
    return backView;
}

#pragma mark- other

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
