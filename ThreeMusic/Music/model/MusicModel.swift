//
//  MusicModel.swift
//  ThreeMusic
//
//  Created by Vimen.chen on 2019/11/7.
//  Copyright © 2019 MvpProject. All rights reserved.
//

import Foundation

//class Modelclass: NSObject {
//    var artistName:String?
//    var artworkUrl100:String?
//    var country:String?
//    var kind:String?
//    var releaseDate:String?
//    var wrapperType:String?
//    var previewUrl:String?
//
//}
struct Modelclass {
  var artistName:String?
  var artworkUrl100:String?
  var country:String?
  var kind:String?
  var releaseDate:String?
  var wrapperType:String?
  var previewUrl:String?
  init() {
    // 🚀 This is CacheModel
  }
    
    static func fromJSON(_ dictionary: [String: Any]? ) -> [Modelclass]? {
        if  let list1 = dictionary{

            let list = (list1 as NSDictionary).value(forKey: "results") as! NSArray

            var newsArr:[Modelclass] = []
                for item in list{
                let dic = item as! NSDictionary
                var oneNew = Modelclass()
                    
                oneNew.artistName = dic.value(forKey: "artistName") as? String
                oneNew.artworkUrl100 = dic.value(forKey: "artworkUrl100") as? String
                oneNew.country = dic.value(forKey: "country") as? String
                oneNew.releaseDate = dic.value(forKey: "releaseDate") as? String
                oneNew.wrapperType = dic.value(forKey: "wrapperType") as? String
                oneNew.previewUrl = dic.value(forKey: "previewUrl") as? String
                newsArr.append(oneNew)
            
        }
            return newsArr
    }
    return nil
    }
  
}
