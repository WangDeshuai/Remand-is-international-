//
//  ReleaseChildVC.m
//  NewProjects
//
//  Created by Mac on 2017/12/10.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "ReleaseChildVC.h"
#import "ReleaseChildCell.h"
#import "PhotoView.h"
@interface ReleaseChildVC ()
@property(nonatomic,strong)NSArray * dataArray;
@end

@implementation ReleaseChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    [self CreatDataArr];
    [self CreatTabelView];
}

-(void)CreatDataArr{
    _dataArray=@[@"Product name",@"Location",@"Inventory quantity(T)",@"Supply price($)",@"Package",@"Single package weight(kg)",@"Colour",@"Mesh",@"Density(%)",@"Calcium content(%)",@"Flammability",@"Image"];
}

-(void)CreatTabelView{

    self.baseTableView.frame=CGRectMake(0, 64+15+44, ScreenWidth, ScreenHeight-64-53-15-44);
    self.baseTableView.rowHeight=55;
    self.baseTableView.mj_header=nil;
    self.baseTableView.mj_footer=nil;
    self.baseTableView.tableFooterView=[self CreatFootView];
    self.baseTableView.keyboardDismissMode=UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:self.baseTableView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReleaseChildCell * cell =[ReleaseChildCell cellWithTableView:tableView IndexPath:indexPath];
    cell.namelabel.text=_dataArray[indexPath.row];
    if (indexPath.row==1) {
        cell.arrowBtn.hidden=NO;
    }else if (indexPath.row==11){
        cell.arrowBtn.hidden=NO;
        [cell.arrowBtn setImage:[UIImage imageNamed:@"release_add"] forState:0];
    }
    return cell;
}


-(UIView*)CreatFootView{
    UIView * footView =[UIView new];
    footView.backgroundColor=[UIColor orangeColor];
    footView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .heightIs(400);
    
    
    PhotoView * view =[[PhotoView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 200) MaxPhoto:8 EachRowNumber:4];
    view.photosArrBlock=^(NSArray *photosArr){
        NSLog(@"照片>>>%@",photosArr);
    };
    view.delegate=self;
    [footView addSubview:view];
    
//
    NSArray * btnArr =@[@"Release",@"Cancel"];
    int d =15;
    int k =(ScreenWidth-d*2);
    int g=35;
    for (int i =0; i<btnArr.count; i++) {
        UIButton * sureBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.sd_cornerRadius=@(g/2);
        [sureBtn setTitle:btnArr[i] forState:0];
        sureBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        [footView sd_addSubviews:@[sureBtn]];
        sureBtn.sd_layout
        .leftSpaceToView(footView, d)
        .rightSpaceToView(footView, d)
        .topSpaceToView(view, 20+(d+g)*i)
        .widthIs(k)
        .heightIs(g);
        if (i==0) {
            sureBtn.backgroundColor=Main_Color;
        }else{
            sureBtn.backgroundColor=[UIColor whiteColor];
            sureBtn.layer.borderColor=[[UIColor lightGrayColor]colorWithAlphaComponent:.4].CGColor;
            sureBtn.layer.borderWidth=.5;
            [sureBtn setTitleColor:[[UIColor lightGrayColor]colorWithAlphaComponent:.7] forState:0];
        }

    }
    
    return footView;
}



//- (void)configCollectionView {
//    // 如不需要长按排序效果，将LxGridViewFlowLayout类改成UICollectionViewFlowLayout即可
//    UICollectionViewFlowLayout * _layout=[[UICollectionViewFlowLayout alloc]init];
//    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
//    CGFloat rgb = 244 / 255.0;
//    _collectionView.alwaysBounceVertical = YES;
//    _collectionView.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1.0];
//    _collectionView.contentInset = UIEdgeInsetsMake(4, 4, 4, 4);
//    _collectionView.dataSource = self;
//    _collectionView.delegate = self;
//    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
//    [self.view addSubview:_collectionView];
//    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"TZTestCell"];
//}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return _selectedPhotos.count + 1;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
////    cell.videoImageView.hidden = YES;
////    if (indexPath.row == _selectedPhotos.count) {
////        cell.imageView.image = [UIImage imageNamed:@"AlbumAddBtn.png"];
////        cell.deleteBtn.hidden = YES;
////        cell.gifLable.hidden = YES;
////    } else {
////        cell.imageView.image = _selectedPhotos[indexPath.row];
////        cell.asset = _selectedAssets[indexPath.row];
////        cell.deleteBtn.hidden = NO;
////    }
////    if (!self.allowPickingGifSwitch.isOn) {
////        cell.gifLable.hidden = YES;
////    }
////    cell.deleteBtn.tag = indexPath.row;
////    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
//    return cell;
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == _selectedPhotos.count) {
//
//    } else {
//
//    }
//}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
