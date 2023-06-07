//
//  MainView.swift
//  StudyForCombine
//
//  Created by OpenObject on 2023/05/16.
//

import UIKit
import SnapKit

class MainView: UIView {
  lazy var titleLabel = UILabel()
  lazy var imageView = UIImageView()
  
  lazy var firstStackView = UIStackView()
  lazy var secondStackView = UIStackView()
  lazy var thirdStackView = UIStackView()
  
  lazy var reservationView = UIView()
  lazy var reservationTitle = UILabel()
  lazy var reservationSubtitle = UILabel()
  
  lazy var waitingView = UIView()
  lazy var waitingTitle = UILabel()
  lazy var waitingSubtitle = UILabel()
  
  lazy var categoryView1: [UIView] = []
  lazy var categoryView2: [UIView] = []
  
  var categoryImage: [[String]] = [["camera", "camera", "camera", "camera", "camera"],
                                   ["gearshape", "gearshape", "gearshape", "gearshape", "gearshape"]]
  var categoryText: [[String]] = [["가정의달", "오마카세", "우마카세", "디저트 픽업", "인기핫플"],
                                  ["다이닝입문", "호텔다이닝", "데이트 코스", "모임예약", "저장TOP"]]
  
//  private var items = (0...9).map { _ in randomColor }
  private var items = [("1", randomColor),("2", randomColor), ("3", randomColor),
                       ("4", randomColor), ("5", randomColor), ("6", randomColor), ("7", randomColor)]
  
  private enum Const {
    static let itemWidthScale: CGFloat = 0.65
    static let itemHeightScale: CGFloat = 0.3
    static let screenSize = UIScreen.main.bounds.size
    
    static let itemSize = CGSize(width: floor(screenSize.width * itemWidthScale),
                                 height: floor(screenSize.height * itemHeightScale))
    static let itemSpacing = 24.0
  }
  
  private let collectionViewLayout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.itemSize = Const.itemSize
    layout.minimumLineSpacing = Const.itemSpacing
    layout.minimumInteritemSpacing = 0
    
    return layout
  }()
  
  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewLayout)
    
    collectionView.isScrollEnabled = true
    collectionView.isPagingEnabled = false
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.showsVerticalScrollIndicator = false
    collectionView.backgroundColor = .clear
    collectionView.clipsToBounds = true
    collectionView.register(MyCustomCell.self, forCellWithReuseIdentifier: MyCustomCell.id)
    collectionView.contentInsetAdjustmentBehavior = .never    // 자동으로 inset 조정하는 것 비활성화
    collectionView.decelerationRate = .fast
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    
    return collectionView
  }()
  
  init() {
    super.init(frame: .zero)
    
    setUp()
    addSubViews()
    setConstraint()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    collectionView.setContentOffset(.init(x: (Const.itemSize.width + Const.itemSpacing),
                                      y: collectionView.contentOffset.y),
                                animated: false)
  }
  
  func setUp() {
    
    items.insert(items[items.count-1], at: 0)
    items.append(items[1])
    
    titleLabel.text = "오픈오브젝트"
    titleLabel.textColor = .black
    titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    
    imageView.image = UIImage(named: "Apple")
    imageView.layer.cornerRadius = 10
    imageView.clipsToBounds = true
    
    reservationView.layer.cornerRadius = 10
    reservationView.layer.borderColor = UIColor.gray.cgColor
    reservationView.layer.borderWidth = 1
    
    reservationTitle.text = "title"
    reservationTitle.textColor = .gray
    reservationTitle.font = UIFont.systemFont(ofSize: 12, weight: .light)
    reservationSubtitle.text = "subtitle"
    reservationSubtitle.textColor = .black
    reservationSubtitle.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    
    waitingView.layer.cornerRadius = 10
    waitingView.layer.borderColor = UIColor.gray.cgColor
    waitingView.layer.borderWidth = 1
    
    waitingTitle.text = "title"
    waitingTitle.textColor = .gray
    waitingTitle.font = UIFont.systemFont(ofSize: 12, weight: .light)
    waitingSubtitle.text = "subtitle"
    waitingSubtitle.textColor = .black
    waitingSubtitle.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    
    firstStackView.axis = .horizontal
    firstStackView.distribution = .fillEqually
    firstStackView.spacing = 20
    
    secondStackView.axis = .horizontal
    secondStackView.distribution = .fillEqually
    
    thirdStackView.axis = .horizontal
    thirdStackView.distribution = .fillEqually
  }
  
  func addSubViews() {
    
    for i in 0..<categoryImage.count {
      for j in 0..<categoryImage[i].count {
        let view = UIView()
        let imageView = UIImageView(image: UIImage(systemName: categoryImage[i][j]))
        imageView.tintColor = .black
        let label = UILabel()
        label.text = categoryText[i][j]
        label.font = UIFont.systemFont(ofSize: 10)
        
        view.addSubview(imageView)
        view.addSubview(label)
        
        imageView.snp.makeConstraints { make in
          make.top.equalToSuperview().offset(5)
          make.centerX.equalToSuperview()
          make.width.height.equalTo(20)
        }
        
        label.snp.makeConstraints { make in
          make.top.equalTo(imageView.snp.bottom).offset(10)
          make.centerX.equalToSuperview()
          make.bottom.equalToSuperview().offset(5)
        }
        
        if i == 0 {
          categoryView1.append(view)
        } else if i == 1 {
          categoryView2.append(view)
        }
        
      }
    }
        
    [reservationTitle, reservationSubtitle]
      .forEach { view in
        reservationView.addSubview(view)
      }
    
    [waitingTitle, waitingSubtitle]
      .forEach { view in
        waitingView.addSubview(view)
      }
    
    [collectionView, titleLabel, firstStackView, secondStackView, thirdStackView]
      .forEach { view in
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
      }
    
    collectionView.delegate = self
    collectionView.dataSource = self
    
    [reservationView, waitingView]
      .forEach { view in
        firstStackView.addArrangedSubview(view)
      }
    
    categoryView1
      .forEach { view in
        secondStackView.addArrangedSubview(view)
      }
    
    categoryView2
      .forEach { view in
        thirdStackView.addArrangedSubview(view)
      }
    
  }
  
  private func setConstraint() {
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
      make.leading.equalToSuperview().offset(20)
    }
    
    collectionView.snp.makeConstraints { make in
      make.top.equalTo(titleLabel).offset(30)
      make.leading.equalToSuperview().offset(20)
      make.trailing.equalToSuperview().offset(-20)
      make.height.equalTo(Const.itemSize.height)
    }
    
    reservationTitle.snp.makeConstraints { make in
      make.top.equalTo(reservationView.snp.top).offset(10)
      make.leading.equalTo(reservationView.snp.leading).offset(10)
    }
    reservationSubtitle.snp.makeConstraints { make in
      make.top.equalTo(reservationTitle.snp.bottom).offset(5)
      make.leading.equalTo(reservationView.snp.leading).offset(10)
      make.bottom.equalTo(reservationView.snp.bottom).offset(-30)
    }
    
    waitingTitle.snp.makeConstraints { make in
      make.top.equalTo(waitingView.snp.top).offset(10)
      make.leading.equalTo(waitingView.snp.leading).offset(10)
    }
    waitingSubtitle.snp.makeConstraints { make in
      make.top.equalTo(waitingTitle.snp.bottom).offset(5)
      make.leading.equalTo(waitingView.snp.leading).offset(10)
      make.bottom.equalTo(waitingView.snp.bottom).offset(-30)
    }
    
    firstStackView.snp.makeConstraints { make in
      make.top.equalTo(collectionView.snp.bottom).offset(20)
      make.leading.equalToSuperview().offset(20)
      make.trailing.equalToSuperview().offset(-20)
    }
    
    secondStackView.snp.makeConstraints { make in
      make.top.equalTo(firstStackView.snp.bottom).offset(20)
      make.leading.equalToSuperview().offset(20)
      make.trailing.equalToSuperview().offset(-20)
    }
    
    thirdStackView.snp.makeConstraints { make in
      make.top.equalTo(secondStackView.snp.bottom).offset(20)
      make.leading.equalToSuperview().offset(20)
      make.trailing.equalToSuperview().offset(-20)
    }
    
  }
}

extension MainView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
  func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                 withVelocity velocity: CGPoint,
                                 targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
    
    var offset = targetContentOffset.pointee
    let index11 = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
    let roundedIndex = round(index11)
    
    // 다음 cell의 시작점으로 이동하기 위한 offset
    offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left,
                     y: scrollView.contentInset.top)
    
    targetContentOffset.pointee = offset
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    
    let count = items.count
    
    if scrollView.contentOffset.x == 0 {
      scrollView.setContentOffset(.init(x: (Const.itemSize.width + Const.itemSpacing) * Double(count - 2),
                                        y: scrollView.contentOffset.y),
                                  animated: false)
    }
    if scrollView.contentOffset.x == (Const.itemSize.width + Const.itemSpacing) * Double(count - 1) {
      scrollView.setContentOffset(.init(x: Const.itemSize.width + Const.itemSpacing,
                                        y: scrollView.contentOffset.y),
                                  animated: false)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    let cellWidth = Const.itemSize.width
    let collectionviewWidth = collectionView.bounds.width
    
    let sideInset = (collectionviewWidth - cellWidth) / 2
    return UIEdgeInsets(top: 0, left: sideInset, bottom: 0, right: sideInset)
  }
}

extension MainView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.items.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCustomCell.id, for: indexPath) as? MyCustomCell else { return UICollectionViewCell() }
    cell.prepare(color: items[indexPath.row % items.count].1,
                 numberText: items[indexPath.row % items.count].0)
    
    return cell
  }
}
