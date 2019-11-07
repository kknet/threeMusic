//
//  Presenter.swift
//  MVPDemo
//
//  Created by ZhaoHeng on 2018/7/26.
//  Copyright © 2018年 ZhaoHeng. All rights reserved.
//

import Foundation

protocol Presenter {
  associatedtype T
  var view: T? { get set }
  mutating func initial(_ view: T)
}

extension CachePresenter: Presenter {}
