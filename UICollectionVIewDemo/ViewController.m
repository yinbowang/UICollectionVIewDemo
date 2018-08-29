//
//  ViewController.m
//  UICollectionVIewDemo
//
//  Created by wyb on 2018/8/28.
//  Copyright © 2018年 世纪佳缘. All rights reserved.
//

#import "ViewController.h"
#import "CustomLayout.h"

#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), 255)

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = @[
                       @[@"1",@"2",@"3"],
                       @[@"4",@"5",@"6",@"7"],
                       @[@"8",@"9",@"10",@"11",@"12",@"13",@"14"],
                       @[@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"22",@"22",@"22"]
                       ];
    

    CustomLayout *layout = [[CustomLayout alloc]init];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"id"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return  self.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *subArray = self.dataArray[section];
    return subArray.count;
}


- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"id" forIndexPath:indexPath];
    cell.backgroundColor = randomColor;
    return cell;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
    footerView.backgroundColor = [UIColor cyanColor];
    for (UIView *subView in footerView.subviews) {
        [subView removeFromSuperview];
    }
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:footerView.bounds];
    titleLabel.text = [NSString stringWithFormat:@"第%ld个分区的区尾",(long)indexPath.section];
    [footerView addSubview:titleLabel];
    return footerView;
  
}





@end
