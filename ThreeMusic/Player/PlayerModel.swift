//
//  PlayModel.swift
//  ThreeMusic
//
//  Created by Chen Wei Wen on 8/11/2019.
//  Copyright © 2019 MvpProject. All rights reserved.
//

import Foundation
import AVFoundation

class PlayerModel: NSObject {
    
    var player = AVPlayer()
    var playerItem:AVPlayerItem!

    func playUrl(url: URL){
        playerItem = AVPlayerItem(url:url)
        player = AVPlayer(playerItem:playerItem)
        player .play()
    }

    func playBackSliderValueChanged(seconds : Int64 ){
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
               player.seek(to: targetTime)
    }
    
    func timeConversion (time:Float64)->(String) {
        let all:Int=Int(time)
        let m:Int=all % 60
        let f:Int=Int(all/60)
        var time:String=""
        if f<10{
            time="0\(f):"
        }else {
            time="\(f)"
        }
        if m<10{
            time+="0\(m)"
        }else {

            time+="\(m)"
                }
        return time
    }


    func stopPlayerItem(){

        self.playerItem.seek(to: CMTime.zero, completionHandler: nil)

    }
}
