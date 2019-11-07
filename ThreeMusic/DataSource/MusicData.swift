//
//  MusicData.swift
//  ThreeMusic
//
//  Created by Vimen.chen on 2019/11/7.
//  Copyright © 2019 MvpProject. All rights reserved.
//

import Foundation
class MusicData {

// var arrMusicList : [Modelclass]!
//    var  startNum = 0
    
//    func loadData(serchString:String,startNum:Int,callback:((String)->viod)) {
//
//        if startNum == 0{
//
//            self.startNum = 1
//        }
//
//        getNewsData(term: serchString, limit: self.startNum * 25){ (data, success) in
//            if !success{
//
//                return
//
//            }
//            self.arrMusicList?.removeAll()
//            self.arrMusicList = data as? [Modelclass]
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadData"), object: self)
//        }
//    }
    
//    func getNewsData(term:String,limit:Int,completion:@escaping (Any,Bool)->Void) -> Void {
//
//    var urlStr="https://itunes.apple.com/search?term=\(term)&limit=\(limit)&entity=song"
//        print("urlstr ===\(urlStr)")
//        urlStr = urlStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)!
//        let url = URL(string: urlStr)
//        let req = URLRequest(url: url!, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 5.0)
//        let task:URLSessionDataTask = URLSession.shared.dataTask(with: req) { (data, response, error) in
//
//            if error != nil{
//                completion("网络服务器错误",false)
//                return
//            }
//            //json数据解析
//            let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
//            //json解析失败，返回错误信息
//            if jsonData == nil{
//                completion("网络数据错误",false)
//                return
//            }
//            let list = (jsonData as! NSDictionary).value(forKey: "results") as! NSArray
//            var newsArr:[Modelclass] = []
//
//            for item in list{
//                let dic = item as! NSDictionary
//                let oneNew = Modelclass()
//                oneNew.artistName = dic.value(forKey: "artistName") as? String
//                oneNew.artworkUrl100 = dic.value(forKey: "artworkUrl100") as? String
//                oneNew.country = dic.value(forKey: "country") as? String
//                oneNew.releaseDate = dic.value(forKey: "releaseDate") as? String
//                oneNew.wrapperType = dic.value(forKey: "wrapperType") as? String
//                oneNew.previewUrl = dic.value(forKey: "previewUrl") as? String
//                newsArr.append(oneNew)
//            }
//            completion(newsArr,true)
//
//        }
//        //(6)开启任务
//        task.resume()
//
//
//
//    }
}
