//
//  LoginView.swift
//  StudyForCombine
//
//  Created by OpenObject on 2022/12/05.
//

import Foundation
import UIKit
import SnapKit
import Combine

class LoginView: UIView {
  lazy var loginTextField = UITextField()
  lazy var passwordTextField = UITextField()
  lazy var loginButton = UIButton()
  lazy var loginLabel = UILabel()
  lazy var activityIndicator = ActivityIndicatorView(style: .medium)
  
  var isLoading: Bool = false {
    didSet {
      isLoading ? startLoading() : finishLoading()
    }
  }
  
  init() {
    super.init(frame: .zero)
    
    addSubViews()
    setUpConstraints()
    setUpViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  func startLoading() {
    isUserInteractionEnabled = false
    activityIndicator.isHidden = false
    activityIndicator.startAnimating()
  }
  
  func finishLoading() {
    isUserInteractionEnabled = true
    activityIndicator.stopAnimating()
  }
  
  private func addSubViews() {
    [loginLabel, loginTextField, passwordTextField, loginButton, activityIndicator]
      .forEach {
        addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
      }
  }
  
  private func setUpConstraints() {
    loginLabel.snp.makeConstraints { make in
      make.centerY.equalToSuperview().offset(-100)
      make.centerX.equalToSuperview()
    }
    
    loginTextField.snp.makeConstraints { make in
      make.width.equalTo(200)
      make.centerX.equalToSuperview()
      make.top.equalTo(loginLabel.snp.bottom).offset(20)
      make.height.equalTo(45)
    }
    
    passwordTextField.snp.makeConstraints { make in
      make.top.equalTo(loginTextField.snp.bottom).offset(10)
      make.centerX.equalTo(loginTextField.snp.centerX)
      make.width.equalTo(loginTextField.snp.width).multipliedBy(1.0)
      make.height.equalTo(loginTextField.snp.height)
    }
    
    loginButton.snp.makeConstraints { make in
      make.top.equalTo(passwordTextField.snp.bottom).offset(20)
      make.centerX.equalTo(loginTextField.snp.centerX)
      make.width.equalTo(120)
      make.height.equalTo(30)
    }
    
    activityIndicator.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.centerY.equalToSuperview()
      make.height.equalTo(50)
      make.width.equalTo(50)
    }
  }
  
  private func setUpViews() {
    backgroundColor = .white
    
    loginLabel.text = "LOGIN"
    loginLabel.textColor = .black
    loginLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    
    loginTextField.backgroundColor = .lightGray
    loginTextField.placeholder = "아이디"
    loginTextField.autocapitalizationType = .none 
    
    passwordTextField.backgroundColor = .lightGray
    passwordTextField.placeholder = "비밀번호"
    
    loginButton.setTitle("로그인", for: .normal)
    loginButton.setTitleColor(.black, for: .normal)
    loginButton.backgroundColor = .white
  }
}

extension UITextField {
  var textPublisher: AnyPublisher<String, Never> {
    NotificationCenter.default
      .publisher(for: UITextField.textDidChangeNotification, object: self)
      .compactMap { $0.object as? UITextField }
      .compactMap(\.text)
      .eraseToAnyPublisher()
  }
}
