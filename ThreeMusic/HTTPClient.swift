//
//  HTTPClient.swift
//  MVPDemo
//
//  Created by ZhaoHeng on 2018/7/26.
//  Copyright © 2018年 ZhaoHeng. All rights reserved.
//

import Foundation

struct HTTPClient {
//  typealias Paramters = Dictionary<String, Any>
  var reponseHandle: HTTPResponProtocol?
  
  init(handle: HTTPResponProtocol?) {
    self.reponseHandle = handle
  }
  
  func get(url: String) {
    let session = URLSession(configuration: URLSessionConfiguration.default)
    let request = URLRequest(url: URL(string: url)!)
    session.dataTask(with: request, completionHandler: {
      data, response, error in
      if error == nil {
        if let da = data,
          let any = try? JSONSerialization.jsonObject(with: da, options: .mutableContainers),
          let dict = any as? [String: Any] {
          self.reponseHandle?.onSuccess(object: dict)
        }
      } else {
        self.reponseHandle?.onFailure(error: error!)
      }
    }).resume()
  }
}
