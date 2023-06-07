//
//  CarouselLayout.swift
//  StudyForCombine
//
//  Created by OpenObject on 2023/05/17.
//

import UIKit

class CarouselLayout: UICollectionViewFlowLayout {
  
  public var sideItemScale: CGFloat = 0.5
  public var sideItemAlpha: CGFloat = 0.5
  public var spacing: CGFloat = 10
  
  public var isPagingEnabled: Bool = false
  
  private var isSetup: Bool = false
  
  override public func prepare() {
    super.prepare()
    if isSetup == false {
      setupLayout()
      isSetup = true
    }
  }
  
  private func setupLayout() {
    guard let collectionView = self.collectionView else { return }
    
    let collectionViewSize = collectionView.bounds.size
    
    let xInset = (collectionViewSize.width - self.itemSize.width) / 2
    let yInset = (collectionViewSize.height - self.itemSize.height) / 2
    
    self.sectionInset = UIEdgeInsets(top: yInset, left: xInset, bottom: yInset, right: xInset)
    
    let itemWidth = self.itemSize.width
    
    let scaledItemOffset = (itemWidth - (itemWidth * self.sideItemScale)) / 2
    self.minimumLineSpacing = spacing - scaledItemOffset
    
    self.scrollDirection = .horizontal
  }
  
  // 레이아웃 업데이트가 필요한지 요청
  // 레이아웃 변화가 필요할 경우 true
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
  
//  // 모든 셀과 뷰에 대한 레이아웃 속성을  UICollectionViewLayoutAttributes 배열로 반환
//  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//    guard let superAttributes = super.layoutAttributesForElements(in: rect),
//          let attributes = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes] else { return nil }
//
//    return attributes.map { self.transformLayoutAttributes(attributes: $0) }
//  }
//
//  private func transformLayoutAttributes(attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//    guard let collectionView = self.collectionView else { return attributes }
//
//    let collectionCenter = collectionView.frame.size.width / 2
//    let contentOffset = collectionView.contentOffset.x
//    let center = attributes.center.x - contentOffset
//
//    let maxDistance = self.itemSize.width + self.minimumLineSpacing
//
//  }
  
}
