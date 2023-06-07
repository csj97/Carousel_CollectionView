//
//  ViewController.swift
//  StudyForCombine
//
//  Created by OpenObject on 2022/12/05.
//

import UIKit
import Combine

class LoginViewController: UIViewController {
  
  private lazy var contentView = LoginView()
  private let viewModel: LoginViewModel
  private var bindings = Set<AnyCancellable>()
  
  init(viewModel: LoginViewModel = LoginViewModel()) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func loadView() {
    view = contentView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    setUpTargets()
    setUpBindings()
  }
  
  private func setUpTargets() {
    contentView.loginButton.addTarget(self, action: #selector(onClick), for: .touchUpInside)
  }
  
  private func setUpBindings() {
    func bindViewToViewModel() {
      /// publisher를 구독하면서 새로운 값을 viewModel의 login에 할당한다.
      contentView.loginTextField.textPublisher
        .receive(on: DispatchQueue.main)
        .assign(to: \.login, on: viewModel)
        .store(in: &bindings)
      
      contentView.passwordTextField.textPublisher
        .receive(on: RunLoop.main)
        .assign(to: \.password, on: viewModel)
        .store(in: &bindings)
    }
    
    func bindViewModelToView() {
      /// RunLoop는 이벤트 처리 루프이다.
      /// 따라서, 로그인 버튼을 눌렀을 때의 스케줄러를 RunLoop.main으로 둔 것이다.
      viewModel.isInputValid
        .receive(on: RunLoop.main)
        .assign(to: \.isValid, on: contentView.loginButton)
        .store(in: &bindings)
      
      viewModel.$isLoading
        .assign(to: \.isLoading, on: contentView)
        .store(in: &bindings)
      
      viewModel.validationResult
        .sink { completion in
          switch completion {
          case .failure:
            return
          case .finished:
            return
          }
        } receiveValue: { [weak self] value in
          self?.navigateToSecondView()
        }
        .store(in: &bindings)
    }
    
    bindViewToViewModel()
    bindViewModelToView()
  }
  
  @objc private func onClick() {
    viewModel.validateCredentials()
  }
  
  private func navigateToSecondView() {
    AppNavigator.shared.navigate(to: HomeRoutes.main, with: .reset, animated: false)
  }
}


extension UIButton {
  // TODO: didSet 교체
  // didSet을 사용하려면 초기값을 부여해줘야하는데
  // extension에서는 프로퍼티에 값을 저장하지 못한다.
  var isValid: Bool {
    get { isEnabled && backgroundColor == .green }
    set {
      backgroundColor = newValue ? .green : .red
      isEnabled = newValue
    }
  }
}
