//
//  LxGridView.h
//  LxGridView
//

#import "LxGridViewCell.h"
#import "LxGridViewFlowLayout.h"
#import <UIKit/UIKit.h>

#define stringify __STRING

@interface LxGridView : UICollectionView

@property (nonatomic, assign) BOOL editing;

@end
