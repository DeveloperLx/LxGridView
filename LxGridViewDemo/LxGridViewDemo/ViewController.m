//
//  ViewController.m
//  LxGridView
//

#import "ViewController.h"
#import "LxGridView.h"


static NSString * const LxGridViewCellReuseIdentifier = @stringify(LxGridViewCellReuseIdentifier);

static CGFloat const HOME_BUTTON_RADIUS = 21;
static CGFloat const HOME_BUTTON_BOTTOM_MARGIN = 9;

@interface ViewController () <LxGridViewDataSource, LxGridViewDelegateFlowLayout, LxGridViewCellDelegate>

@property (nonatomic,retain) NSMutableArray * dataArray;

@end

@implementation ViewController
{
    LxGridViewFlowLayout * _gridViewFlowLayout;
    LxGridView * _gridView;
    UIButton * _homeButton;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    for (int i = 0; i < 15; i++) {
        
        NSMutableDictionary * dataDict = [[NSMutableDictionary alloc]init];
        [dataDict setValue:[NSString stringWithFormat:@"App %d", i] forKey:@"index"];
        [dataDict setValue:[UIImage imageNamed:[NSString stringWithFormat:@"%i", i]] forKey:@"icon_image"];
        [self.dataArray addObject:dataDict];
    }
    
    _gridViewFlowLayout = [[LxGridViewFlowLayout alloc]init];
    _gridViewFlowLayout.sectionInset = UIEdgeInsetsMake(18, 18, 18, 18);
    _gridViewFlowLayout.minimumLineSpacing = 9;
    _gridViewFlowLayout.itemSize = CGSizeMake(58, 78);
    
    _gridView = [[LxGridView alloc]initWithFrame:self.view.bounds collectionViewLayout:_gridViewFlowLayout];
    _gridView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    _gridView.delegate = self;
    _gridView.dataSource = self;
    _gridView.scrollEnabled = NO;
    _gridView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_gridView];
    
    [_gridView registerClass:[LxGridViewCell class] forCellWithReuseIdentifier:LxGridViewCellReuseIdentifier];
    
    _homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _homeButton.showsTouchWhenHighlighted = YES;
    _homeButton.layer.cornerRadius = HOME_BUTTON_RADIUS;
    _homeButton.layer.masksToBounds = YES;
    _homeButton.layer.borderWidth = 1;
    _homeButton.layer.borderColor = [UIColor blackColor].CGColor;
    _homeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_homeButton setTitle:@"☐" forState:UIControlStateNormal];
    [_homeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_homeButton addTarget:self action:@selector(homeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_homeButton];
    
    _gridView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint * gridViewTopMargin =
    [NSLayoutConstraint constraintWithItem:_gridView
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeTop
                                multiplier:1
                                  constant:0];
    
    NSLayoutConstraint * gridViewRightMargin =
    [NSLayoutConstraint constraintWithItem:_gridView
                                 attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeRight
                                multiplier:1
                                  constant:0];
    
    NSLayoutConstraint * gridViewBottomMargin =
    [NSLayoutConstraint constraintWithItem:_gridView
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1
                                  constant:0];
    
    NSLayoutConstraint * gridViewLeftMargin =
    [NSLayoutConstraint constraintWithItem:_gridView
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1
                                  constant:0];
    
    [self.view addConstraints:@[gridViewTopMargin,gridViewRightMargin,gridViewBottomMargin,gridViewLeftMargin]];
    
    _homeButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint * homeButtonCenterXConstraint =
    [NSLayoutConstraint constraintWithItem:_homeButton
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1
                                  constant:0];
    
    NSLayoutConstraint * homeButtonBottomMargin =
    [NSLayoutConstraint constraintWithItem:_homeButton
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1
                                  constant:-HOME_BUTTON_BOTTOM_MARGIN];
    
    NSLayoutConstraint * homeButtonWidthMargin =
    [NSLayoutConstraint constraintWithItem:_homeButton
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeWidth
                                multiplier:1
                                  constant:HOME_BUTTON_RADIUS * 2];
    
    NSLayoutConstraint * homeButtonHeightMargin =
    [NSLayoutConstraint constraintWithItem:_homeButton
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeHeight
                                multiplier:1
                                  constant:HOME_BUTTON_RADIUS * 2];
    
    [self.view addConstraints:@[homeButtonCenterXConstraint,homeButtonBottomMargin,homeButtonWidthMargin,homeButtonHeightMargin]];
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (void)homeButtonClicked:(UIButton *)btn
{
    _gridView.editing = NO;
}

#pragma mark - delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LxGridViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:LxGridViewCellReuseIdentifier forIndexPath:indexPath];
    
    cell.delegate = self;
    cell.editing = _gridView.editing;
    
    NSDictionary * dataDict = self.dataArray[indexPath.item];
    cell.title = dataDict[@"index"];
    cell.iconImageView.image = dataDict[@"icon_image"];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath willMoveToIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSDictionary * dataDict = self.dataArray[sourceIndexPath.item];
    [self.dataArray removeObjectAtIndex:sourceIndexPath.item];
    [self.dataArray insertObject:dataDict atIndex:destinationIndexPath.item];
}

- (void)deleteButtonClickedInGridViewCell:(LxGridViewCell *)gridViewCell
{
    NSIndexPath * gridViewCellIndexPath = [_gridView indexPathForCell:gridViewCell];
    
    if (gridViewCellIndexPath) {
        [self.dataArray removeObjectAtIndex:gridViewCellIndexPath.item];
        [_gridView performBatchUpdates:^{
            [_gridView deleteItemsAtIndexPaths:@[gridViewCellIndexPath]];
        } completion:nil];
    }
}

@end
