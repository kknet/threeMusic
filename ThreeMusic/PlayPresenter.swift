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
    init(view :MusicPlayView, person:Modelclass)
    
    func showMusicplay()
    
}
class PlayPresenter: MusicPlayViewPresenter {

    
    let  view :MusicPlayView
    let  modelclass :Modelclass
    
    required init(view: MusicPlayView, person: Modelclass) {
        
        self.view = view
        self.modelclass = person
    }
    
    func showMusicplay() {
        
        
        self.view.Musicplayer(player:"\(String(describing: self.modelclass.previewUrl))")
   
    }
    

    
}
