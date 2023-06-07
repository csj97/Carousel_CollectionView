//
//  LoginViewModel.swift
//  StudyForCombine
//
//  Created by OpenObject on 2022/12/05.
//

import Foundation
import Combine

class LoginViewModel {
  @Published var login: String = ""
  @Published var password: String = ""
  @Published var isLoading = false
  let validationResult = PassthroughSubject<String, Error>()
  
  private(set) lazy var isInputValid = Publishers.CombineLatest($login, $password)
    .map { $0.count > 2 && $0 == "abc" && $1.count > 2 && $1 == "123" }
    .eraseToAnyPublisher()
  
  private let credentialsValidator: CredentialsValidatorProtocol
  
  init(credentailsValidator: CredentialsValidatorProtocol = CredentialsValidator()) {
    self.credentialsValidator = credentailsValidator
  }
  
  func validateCredentials() {
    isLoading = true
    
    credentialsValidator.validateCredentials(login: login, password: password) { [weak self] result in
      self?.isLoading = false
      switch result {
      case .success:
        self?.validationResult.send("HELLO")
      case let .failure(error):
        self?.validationResult.send(completion: .failure(error))
      }
    }
  }
}


// MARK: - CredentialsValidatorProtocol
// TODO: Promises 적용 
protocol CredentialsValidatorProtocol {
    func validateCredentials(
        login: String,
        password: String,
        completion: @escaping (Result<(), Error>) -> Void)
}

/// This class acts as an example of asynchronous credentials validation
/// It's for demo purpose only. In the real world it would make an actual request or use other authentication method
final class CredentialsValidator: CredentialsValidatorProtocol {
    func validateCredentials(
        login: String,
        password: String,
        completion: @escaping (Result<(), Error>) -> Void) {
        let time: DispatchTime = .now() + .milliseconds(Int.random(in: 200 ... 1_000))
        DispatchQueue.main.asyncAfter(deadline: time) {
            // hardcoded success
            completion(.success(()))
        }
    }
}

