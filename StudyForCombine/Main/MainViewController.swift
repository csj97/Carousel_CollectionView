//
//  MainViewController.swift
//  StudyForCombine
//
//  Created by OpenObject on 2023/05/16.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
  private lazy var mainView = MainView()
  private let mainViewModel: MainViewModel
  
  init(mainViewModel: MainViewModel = MainViewModel()) {
    self.mainViewModel = mainViewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    view = mainView
  }
  
  override func viewDidLoad() {
    view.backgroundColor = .white
  }
  
  func setConstraint() {
    
  }
  
}
