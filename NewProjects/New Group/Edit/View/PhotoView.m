//
//  PhotoView.m
//  NewProjects
//
//  Created by feijiu_1 on 2017/12/16.
//  Copyright © 2017年 DSOperation. All rights reserved.
//

#import "PhotoView.h"
#import "TZImagePickerController.h"
#import "UIView+Layout.h"
#import "TZTestCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "TZImageManager.h"
#import "TZVideoPlayerController.h"
#import "TZPhotoPreviewController.h"
#import "TZGifPhotoPreviewController.h"
#import "TZLocationManager.h"

@interface PhotoView ()<TZImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate>{
    
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;
    CGFloat _itemWH;
}
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger maxNum;//最多可以选择的张数
@property (nonatomic, assign) NSInteger rowNum;//每行展示几个
@property (nonatomic,strong)NSMutableArray *imageURLArr;
@end
@implementation PhotoView
static CGFloat  _labelHeight =30;
-(id)initWithFrame:(CGRect)frame MaxPhoto:(NSInteger)maxPhoto EachRowNumber:(NSInteger)number{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        _maxNum=maxPhoto;
        _rowNum=number;
        
        UILabel * namelabel =[UILabel new];
        namelabel.text=@"请选择照片，最少2个最多8个";
        namelabel.alpha=.7;
        namelabel.textAlignment=0;
        namelabel.font=[UIFont systemFontOfSize:15];
        [self sd_addSubviews:@[namelabel]];
        namelabel.sd_layout
        .leftSpaceToView(self,15)
        .rightSpaceToView(self, 15)
        .topSpaceToView(self, 0)
        .heightIs(_labelHeight);
        _imageURLArr = [NSMutableArray array];
        
        _selectedPhotos = [NSMutableArray array];
        [self configCollectionView];
    }
    
    return self;
}

#pragma mark --创建collectionView
- (void)configCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    int num =4;
    
    CGFloat kj=5;//间距
    CGFloat itemWH=(ScreenWidth-kj*(_rowNum+1))/_rowNum;  //item大小
    _itemWH=itemWH;
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    layout.minimumInteritemSpacing = kj;//宽度间距
    layout.minimumLineSpacing = 0;//高度间距
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _labelHeight, ScreenWidth, self.frame.size.height-_labelHeight) collectionViewLayout:layout];
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.scrollEnabled = NO;
    _collectionView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self addSubview:_collectionView];
    
//    _collectionView.sd_layout
//    .leftSpaceToView(self, 0)
//    .rightSpaceToView(self, 0)
//    .topSpaceToView(self, _labelHeight)
//    .bottomSpaceToView(self, 0)
    
    
    [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
    
    
    
}

#pragma mark UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_selectedPhotos.count==_maxNum) {
        return _selectedPhotos.count;
    }else{
         return _selectedPhotos.count + 1;
    }
  
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    
    if (indexPath.row == _selectedPhotos.count) {
            cell.imageView.image = [UIImage imageNamed:@"release_pic"];
            cell.deleteBtn.hidden = YES;
    }else {
        
        if ([_selectedPhotos[indexPath.row] isKindOfClass:[UIImage class]]) {
            cell.imageView.image = _selectedPhotos[indexPath.row];
        }else {
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:_selectedPhotos[indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder_1"]];
        }
//        cell.asset = _selectedAssets[indexPath.row];
        cell.deleteBtn.hidden = NO;
    }
//    cell.backgroundColor=[UIColor redColor];
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn setImage:[UIImage imageNamed:@"search_cancel"] forState:0];
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
#pragma mark ---点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _selectedPhotos.count) {//点击加号
        if (_selectedPhotos.count==_maxNum) {
            return;
        }
        [self pushTZImagePickerController];
    }/*else{
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_selectedAssets selectedPhotos:_selectedPhotos index:indexPath.row];
        imagePickerVc.maxImagesCount = _maxNum;
         imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            _selectedPhotos = [NSMutableArray arrayWithArray:photos];
            _selectedAssets = [NSMutableArray arrayWithArray:assets];
            _isSelectOriginalPhoto = isSelectOriginalPhoto;
            if (_selectedPhotos.count<_rowNum) {
                [self RowFrameHeight:_itemWH];
            }
            [_collectionView reloadData];
            self.photosArrBlock(photos);
        }];
        [_delegate presentViewController:imagePickerVc animated:YES completion:nil];
    }*/
}






#pragma mark -------调用相册
- (void)pushTZImagePickerController {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:_maxNum columnNumber:4 delegate:self pushPhotoPickerVc:YES];
//    imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    imagePickerVc.naviBgColor=Main_Color;
    imagePickerVc.maxImagesCount=_maxNum;
//    imagePickerVc.allowTakePicture = self.showTakePhotoBtnSwitch.isOn; // 在内部显示拍照按钮
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        _collectionView.sd_layout
        .bottomSpaceToView(self, 0);
        NSMutableArray *muTablephotos = [NSMutableArray arrayWithArray:photos];
        [self upLoadImage: muTablephotos];  //上传图片
    }];
    [_delegate presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)upLoadImage:(NSMutableArray *)imageArr
{
    [[Engine sharedEngine]requestUpdatePoto:imageArr.firstObject photoStr:@"pic" urlStr:ImageApi_Name parameters:@{} successBlock:^(NSString *urlStr) {
        if ([urlStr hasPrefix:@"http://"] || [urlStr hasPrefix:@"https://"]) {
            [self.imageURLArr  addObject:urlStr];   //生成的URL 添加内存
            [_selectedPhotos addObject:imageArr.firstObject];
            //已经传完的image 方便传剩余未传的
            [imageArr removeObject:imageArr.firstObject];
            if (imageArr.count) {  //如果有继续上传
                [self upLoadImage:imageArr];
            }else{
                self.photosArrBlock(self.imageURLArr);  //回传生成的URL
            }
            if (_selectedPhotos.count>=_rowNum) {
                [self RowFrameHeight:_itemWH+_itemWH];
            }else{
                [self RowFrameHeight:_itemWH];
            }
            [self.collectionView reloadData];
        }
    } failedBlock:^(NSError *error) {
        
    }];
}


#pragma mark -----删除按钮
- (void)deleteBtnClik:(UIButton* )sender {
    
    [UIView animateWithDuration:1 animations:^{
        [_selectedPhotos removeObjectAtIndex:sender.tag];
        [self.imageURLArr removeObjectAtIndex:sender.tag];
//        [_selectedAssets removeObjectAtIndex:sender.tag];
    } completion:^(BOOL finished) {
        if (_selectedPhotos.count<_rowNum) {
            [self RowFrameHeight:_itemWH];
        }
        [_collectionView reloadData];
    }];
    
     self.photosArrBlock(self.imageURLArr);
}

#pragma mark ----相册中取消按钮
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    NSLog(@"用户点击了取消");
}
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
//    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    [_collectionView reloadData];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}
//坐标
-(void)RowFrameHeight:(CGFloat)height{
    self.frame=CGRectMake(0, 0, self.frame.size.width, height+_labelHeight);
    _collectionView.sd_layout
    .bottomSpaceToView(self, 0);
}
-(void)setSelectedPhotos:(NSMutableArray *)selectedPhotos
{
    _selectedPhotos = selectedPhotos;
    if ([selectedPhotos.firstObject isKindOfClass:[NSString class]]) {
        self.imageURLArr = [NSMutableArray arrayWithArray:selectedPhotos];
    }
    [self.collectionView reloadData];
}
@end
