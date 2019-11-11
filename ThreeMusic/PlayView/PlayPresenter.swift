//
//  PlayPresenter.swift
//  ThreeMusic
//
//  Created by Chen Wei Wen on 8/11/2019.
//  Copyright © 2019 MvpProject. All rights reserved.
//

import Foundation


protocol MusicPlayView {
    
    func musicPlayer(player:String)
    
}
    
protocol MusicPlayViewPresenter {
 
    init(view :MusicPlayView)
    
    func showMusicPlay()
    
}
struct playMode {
    
    var isPlay :Bool
    
    
}
class PlayPresenter: MusicPlayViewPresenter {
   
    
    let  view :MusicPlayView
    var model = playMode(isPlay:true )
    var playButtonColor:String{
        
    return model.isPlay ? "ic_p_zanting" : "ic_p_play"
    }

    required init(view: MusicPlayView) {
        
        self.view = view
    }
    
   func stopPlay() {
          
        self.model.isPlay = false
      
    }
    
    func beginPlay() {
             
        self.model.isPlay = true
         
    }
    
    func updataPlay() {
        
        model.isPlay = !model.isPlay
        
        print("self.model.isPlay==\(model.isPlay)")

    }
    
    func showMusicPlay() {
        
        self.model.isPlay = true
        
        self.view.musicPlayer(player:"update")
   
    }
    
}
