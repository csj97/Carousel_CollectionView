//
//  AppNavigator.swift
//  StudyForCombine
//
//  Created by OpenObject on 2023/05/16.
//

import Foundation

class AppNavigator: BaseNavigator {
  static let shared = AppNavigator()

  init() {
    // 앱 초기 화면 설정
    let initialRoute: Route = HomeRoutes.login
    super.init(with: initialRoute)
  }

  required init(with route: Route) {
    super.init(with: route)
  }
}
