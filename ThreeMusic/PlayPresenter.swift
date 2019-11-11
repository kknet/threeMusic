//
//  PlayPresenter.swift
//  ThreeMusic
//
//  Created by Chen Wei Wen on 8/11/2019.
//  Copyright © 2019 MvpProject. All rights reserved.
//

import Foundation


protocol MusicPlayView {
    
    func Musicplayer(player:String)
    
    
}
    
protocol MusicPlayViewPresenter {
    init(view :MusicPlayView)
   
    
    
    func showMusicplay()
    
}
struct playMode {
    
    var isPlay :Bool
    
    
}
class PlayPresenter: MusicPlayViewPresenter {
   
    

    
    let  view :MusicPlayView
//    let  modelclass :Modelclass
    var model = playMode(isPlay: true)
    var playButtonColor:String{
        
        return model.isPlay ? "ic_p_zanting" : "ic_p_play"
    }

    required init(view: MusicPlayView) {
        
        self.view = view
//        self.modelclass = person
    }
    
    func updataplay() {
        
        model.isPlay =   !model.isPlay
        
        print("self.model.isPlay==\(model.isPlay)")

    }
    func showMusicplay() {
        
        self.model.isPlay = true
        
        self.view.Musicplayer(player:"update")
   
    }
    

    
}
