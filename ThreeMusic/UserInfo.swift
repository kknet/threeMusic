//
//  UserInfo.swift
//  ThreeMusic
//
//  Created by Chen Wei Wen on 18/11/2019.
//  Copyright © 2019 MvpProject. All rights reserved.
//

import Foundation
class UserInfo: NSObject, NSCoding {
    var name:String
    var phone:String
     
    //构造方法
    required init(name:String="", phone:String="") {
        self.name = name
        self.phone = phone
    }
     
    //从object解析回来
    required init(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: "Name") as? String ?? ""
        self.phone = decoder.decodeObject(forKey: "Phone") as? String ?? ""
    }
     
    //编码成object
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey:"Name")
        coder.encode(phone, forKey:"Phone")
    }
}
