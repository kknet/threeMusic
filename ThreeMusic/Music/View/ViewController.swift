//
//  ViewController.swift
//  ThreeMusic
//
//  Created by Vimen.chen on 2019/11/7.
//  Copyright © 2019 MvpProject. All rights reserved.
//

import UIKit
import MJRefresh
import AVFoundation
class ViewController: UIViewController,MusicPlayView{

    
 
    
    
    private var musicPresenter =  MusicPresenter<ViewController>()
    let mjHeaderView = MJRefreshNormalHeader()
    let mjFooterView = MJRefreshAutoNormalFooter()
    var avPlayer = PlayerModel()
    var arrMusicList : [Modelclass]!

    
    
    var presenter : PlayPresenter!
    
    var model : Modelclass!
 
    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var playTableView: UITableView!
    @IBOutlet weak var serchTextField: UITextField!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var playLabel: UILabel!
    @IBOutlet weak var playSlider: UISlider!

    override func viewDidLoad() {
        
        self.musicPresenter.initial(self)
        presenter = PlayPresenter(view: self)
        self.model = Modelclass.init()
        
//        reloadData(serch: "vi", page: 1)
        serchTextField.delegate = self as UITextFieldDelegate
        playTableView.dataSource = self as UITableViewDataSource
        playTableView.delegate = self as UITableViewDelegate
        playTableView.register(UINib.init(nibName: "MyTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "mycell")
        mjHeaderView.setRefreshingTarget(self, refreshingAction: #selector(self.headerRefresh))
        playTableView.mj_header = mjHeaderView
        mjFooterView.setRefreshingTarget(self, refreshingAction: #selector(self.footerRefresh))
        playTableView.mj_footer = mjFooterView
        playView.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(finishedPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: avPlayer.playerItem)
        
        
        
        
        //同步+并发
//        self.syncConcurrent()
        //异步+并发
        self.asyncConcurrent()
        //同步+串行
//        self.syncSerial()
        
        //异步+串行
//        self.asyncSerial()
        
        
        
        
        
        super.viewDidLoad()

    }
    
    //同步+并发队列
        func syncConcurrent()  {
        
        print("syncConcurrent---%@",Thread.current)
        print("syncConcurrent--begin")
        
        let queue = DispatchQueue(label: "vimenQuene1",  attributes: .concurrent)
        queue.sync {
            for _ in 0...2{
                Thread.sleep(forTimeInterval: 2)
                print("线程1运行---%@",Thread.current)
            }
            
        }
        
        queue.sync {
            for _ in 0...2{
                Thread.sleep(forTimeInterval: 2)
                print("线程2运行---%@",Thread.current)
            }
            
        }
        
        queue.sync {
            for _ in 0...2{
                Thread.sleep(forTimeInterval: 2)
                print("线程3运行---%@",Thread.current)
            }
            
        }
        
         print("syncConcurrent--end")
    }
    //异步+并发
    func asyncConcurrent()  {
        
        print("asyncConcurrent---%@",Thread.current)
        print("asyncConcurrent--begin")
        
        let queue = DispatchQueue(label:"vimenQuene2",  attributes: .concurrent)
        queue.async {
            for _ in 0...2{
                Thread.sleep(forTimeInterval: 2)
                print("线程1运行---%@",Thread.current)
            }
            
        }
        
        queue.async {
            for _ in 0...2{
                Thread.sleep(forTimeInterval: 2)
                print("线程2运行---%@",Thread.current)
            }
            
        }
        
        queue.async {
            for _ in 0...2{
                Thread.sleep(forTimeInterval: 2)
                print("线程3运行---%@",Thread.current)
            }
            
        }
        
         print("asyncConcurrent--end")
    }
    
    
     //同步+串行
    func syncSerial()  {
        
        print("syncSerial---%@",Thread.current)
        print("syncSerial--begin")
        
        let queue = DispatchQueue(label: "vimenQuene3")
        queue.sync {
            for _ in 0...2{
                Thread.sleep(forTimeInterval: 2)
                print("线程1运行---%@",Thread.current)
            }
            
        }
        
        queue.sync {
            for _ in 0...2{
                Thread.sleep(forTimeInterval: 2)
                print("线程2运行---%@",Thread.current)
            }
            
        }
        
        queue.sync {
            for _ in 0...2{
                Thread.sleep(forTimeInterval: 2)
                print("线程3运行---%@",Thread.current)
            }
            
        }
        
        print("syncSerial--end")
    }
    
     //异步+串行
    func asyncSerial()  {
        
        print("asyncSerial---%@",Thread.current)
        print("asyncSerial--begin")
        
        let queue = DispatchQueue(label:"vimenQuene4")
        queue.async {
            for _ in 0...2{
                Thread.sleep(forTimeInterval: 2)
                print("线程1运行---%@",Thread.current)
            }
            
        }
        
        queue.async {
            for _ in 0...2{
                Thread.sleep(forTimeInterval: 2)
                print("线程2运行---%@",Thread.current)
            }
            
        }
        
        queue.async {
            for _ in 0...2{
                Thread.sleep(forTimeInterval: 2)
                print("线程3运行---%@",Thread.current)
            }
            
        }
        
        print("asyncSerial--end")
    }
    
    
    
    func reloadData(serch:String,page:Int) {
       // 请求网络
        
    self.musicPresenter.getCache(by: serch, by: page)
        
     }
    @IBAction func playSliderChanged(_ sender: Any) {
        
        let seconds : Int64 = Int64(self.playSlider.value)
        avPlayer.playBackSliderValueChanged(seconds: seconds)
        
    }
    @IBAction func playButtonCiclk(_ sender: Any) {

        self.presenter.updataPlay()
     
        if self.presenter.model.isPlay {
            avPlayer.player.play()
              } else {
            avPlayer.player.pause()
              }
            playButton .setImage(UIImage(named:self.presenter.playButtonColor), for: .normal)

     }
    // MARK:-EventTableView_header and footer
  
     @objc func headerRefresh(){
            print("下拉刷新")
        self.playTableView.mj_header.endRefreshing()
        self.playTableView.mj_footer.resetNoMoreData()
        self.musicPresenter.pageLimit.limit = 1
        reloadData(serch: self.musicPresenter.serchString.string, page: self.musicPresenter.pageLimit.limit)
     }

     @objc func footerRefresh(){
         print("上拉刷新")
        if self.musicPresenter.pageLimit.limit >= 8{
        playTableView.mj_footer.endRefreshingWithNoMoreData()
         }else{
        self.musicPresenter.pageLimit.limit += 1
        reloadData(serch: self.musicPresenter.serchString.string, page: self.musicPresenter.pageLimit.limit)
        }
       
}
    @objc func finishedPlaying(myNotification:NSNotification) {
        
        print("播放完毕!")
        self.presenter.stopPlay()
        self.playView.isHidden  = !self.presenter.model.isPlay
        self.playButton  .setImage(UIImage(named:self.presenter.playButtonColor ), for: .normal)
        self.avPlayer.stopPlayerItem()
    
    }
       
    func musicPlayer(player: String) {
        print("player==== \(player)")
        
        self.presenter.beginPlay()
        self.playView.isHidden  = !self.presenter.model.isPlay
        self.playButton  .setImage(UIImage(named:self.presenter.playButtonColor ), for: .normal)
        self.avPlayer .playUrl(url: URL(string:self.model!.previewUrl!)!)
        let duration : CMTime = avPlayer.playerItem.asset.duration
        let seconds:Float64 = CMTimeGetSeconds(duration)
        playSlider.maximumValue = Float(seconds)
        playSlider.isContinuous = false
        avPlayer.player .addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1),
                                                          queue: DispatchQueue.main) { _ in
        let currentTime = CMTimeGetSeconds(self.avPlayer.player.currentTime())
        self.playSlider.value = Float(currentTime)
        self.playLabel.text = self.avPlayer.timeConversion(time:currentTime)
                                                            
        }
  }
    

}
extension ViewController: MusicProtocol {
    
    func onGetCacheSuccess(model: [Modelclass]?) {
        arrMusicList = model
        DispatchQueue.main.async(execute: {
            self.playTableView.mj_footer.endRefreshing()
            self.playTableView.reloadData()
        })
    }
    
    func onGetCacheFailure(error: Error) {
    
        dump(error)

    }
    

}
// MARK:- UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        self.model = arrMusicList![indexPath.row]
        self.presenter.showMusicPlay()
    }
    
}
// MARK:- UITableViewDataSource
extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        if let counts = self.arrMusicList?.count{
       
            return counts
        }
            return 0

        }
    
    func tableView(_ tableView:UITableView, heightForRowAt indexPath:IndexPath) ->CGFloat {
        
        return MyTableViewCell.height
     
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let oneModel = self.arrMusicList[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.identifier) as? MyTableViewCell else { return UITableViewCell() }
        cell.setup(titleName:oneModel.artistName!,subtitleName:oneModel.country!)
        return cell

        }
    }
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          //收起键盘
          textField.resignFirstResponder()
          self.musicPresenter.pageLimit.limit = 1
          playTableView.mj_footer.resetNoMoreData()

          if (self.musicPresenter.serchString.string.count>0){
            self.musicPresenter.serchString.string = textField.text ?? ""
            reloadData(serch: self.musicPresenter.serchString.string, page: self.musicPresenter.pageLimit.limit)
        }
          return true;
      }

    
}

