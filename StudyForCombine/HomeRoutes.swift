//
//  HomeRoutes.swift
//  StudyForCombine
//
//  Created by OpenObject on 2023/05/16.
//

import Foundation
import UIKit

enum HomeRoutes: Route {
  case intro
  case login
  case main
  
  var screen: UIViewController {
    switch self {
    case .intro:
      return UIViewController()
      
    case .login:
      let loginVC = LoginViewController()
      return loginVC
      
    case .main:
      let mainVC = MainViewController()
      
      return mainVC
    }
  }
}
