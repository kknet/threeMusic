//
//  MusicDelegate.swift
//  ThreeMusic
//
//  Created by Vimen.chen on 2019/11/7.
//  Copyright © 2019 MvpProject. All rights reserved.
//

import Foundation
protocol MusicProtocol {
  func onGetCacheSuccess(model: [Modelclass]?)
  func onGetCacheFailure(error: Error)
}
