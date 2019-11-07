//
//  MusicPresenter.swift
//  ThreeMusic
//
//  Created by Vimen.chen on 2019/11/7.
//  Copyright © 2019 MvpProject. All rights reserved.
//

import Foundation

struct MusicPresenter <U> where U: MusicProtocol {
  
  var view: U?
  mutating func initial(_ view: U) {
    self.view = view
    self.httpClient = HTTPClient(handle: self )
  }
  
  var httpClient: HTTPClient?
  init() {}
  
  typealias Value = Int
    func getCache(by term:String, by limit: Int) {
    // 网络请求 ...
    self.httpClient?.get(url: "https://itunes.apple.com/search?term=\(term)&limit=\(limit)&entity=song")
        
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
//class MusicPresenter: NSObject {
//
//
//    private var MusicDelegate :MusicProtocol?
//    private var Musicclass : MusicData?
//
//    override init() {
//        self.Musicclass = MusicData()
//    }
//
//    func load(serchstring:String,startNum :Int) {
//
////        self.Musicclass?.loadData(serchString: serchstring, startNum: startNum,  callback: { in self.MusicDelegate?.ro})
//    }
//}

//protocol MusicView {
//
//    func setMusic(musicstring:String)
//}
//protocol MusicViewPresenters {
//
//    init(view:MusicView,preson:Modelclass)
//    func showMusic()
//
//}
//class MusicViewPresenter: MusicViewPresenters {
//
//    let view :MusicView
//    let preson :Modelclass
//
//
//    required init(view: MusicView, preson: Modelclass) {
//
//        self.view = view
//        self.preson = preson
//
//    }
//
//    func showMusic() {
//
//        self.view.setMusic(musicstring: "ddd")
//    }
//
//
//
//}

