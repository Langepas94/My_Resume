//import UIKit
//
//class FullWidthCellsFlowLayout : UICollectionViewFlowLayout {
//
//    func fullWidth(forBounds bounds:CGRect) -> CGFloat {
//        
//        let contentInsets = self.collectionView!.contentInset
//        
//        return bounds.width - sectionInset.left - sectionInset.right - contentInsets.left - contentInsets.right
//    }
//    
//    // MARK: Overrides
//    
//    override func prepare() {
//        itemSize.width = fullWidth(forBounds: collectionView!.bounds)
//        super.prepare()
//    }
//    
//    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
//        if !CGSizeEqualToSize(newBounds.size, collectionView!.bounds.size) {
//            itemSize.width = fullWidth(forBounds: newBounds)
//            return true
//        }
//        return false
//    }
//}
