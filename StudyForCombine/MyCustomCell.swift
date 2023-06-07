//
//  MyCustomCell.swift
//  StudyForCombine
//
//  Created by OpenObject on 2023/05/17.
//

import UIKit
import SnapKit

class MyCustomCell: UICollectionViewCell {
  static let id = "MyCustomCell"
  
  private let customView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.cornerRadius = 10
    return view
  }()
  
  private let numberText: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.contentView.addSubview(customView)
    customView.snp.makeConstraints { make in
      make.top.bottom.leading.trailing.equalToSuperview()
    }
    
    self.customView.addSubview(numberText)
    numberText.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    self.prepare(color: nil, numberText: "")
  }
  
  func prepare(color: UIColor?, numberText: String) {
    self.customView.backgroundColor = color
    self.numberText.text = numberText
  }
  
  func transformToLarge(){
    UIView.animate(withDuration: 0.2){
      self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
    }
  }
  
  func transformToStandard(){
    UIView.animate(withDuration: 0.2){
      self.transform = CGAffineTransform.identity
    }
  }
}

var randomColor: UIColor {
  UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
}

