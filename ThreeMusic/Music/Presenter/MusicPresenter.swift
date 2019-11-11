//
//  MusicPresenter.swift
//  ThreeMusic
//
//  Created by Vimen.chen on 2019/11/7.
//  Copyright © 2019 MvpProject. All rights reserved.
//

import Foundation

struct pageClass {
    var limit : Int
}
struct MusicPresenter <U> where U: MusicProtocol {
  
    var  pageLimit = pageClass(limit: 1)

  var view: U?
  mutating func initial(_ view: U) {
    self.view = view
    self.httpClient = HTTPClient(handle: self )
    
    
  }
  
  var httpClient: HTTPClient?
  init() {}

    
    
    lazy var musicList : [Modelclass] =  {
        
        var musicList  = Array<Modelclass>()
        return musicList
    }()
    
    
    func getCache(by term:String, by limit : Int) {
      
    
    self.httpClient?.get(url: "https://itunes.apple.com/search?term=\(term)&limit=\(limit*25)&entity=song")
  }
}


extension MusicPresenter: HTTPResponProtocol {
    
  func onSuccess(object: Dictionary<String, Any>) {
    
    view?.onGetCacheSuccess(model: Modelclass.fromJSON(object))
    
  }
  
  func onFailure(error: Error) {
    
    print(error)

    }
}

