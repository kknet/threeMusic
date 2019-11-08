//
//  ViewController.swift
//  ThreeMusic
//
//  Created by Vimen.chen on 2019/11/7.
//  Copyright © 2019 MvpProject. All rights reserved.
//

import UIKit
import MJRefresh

class ViewController: UIViewController {
    private var musicPresenter =  MusicPresenter<ViewController>()
    let mjHeaderView = MJRefreshNormalHeader()
    let mjFooterView = MJRefreshAutoNormalFooter()
 
    var arrMusicList : [Modelclass]!
    var serchString:String  = "vi"
    var  limit  = 1
    

    @IBOutlet weak var playTableView: UITableView!
    @IBOutlet weak var serchTextField: UITextField!
    override func viewDidLoad() {
     self.musicPresenter.initial(self)

        reloadData(serch: "vi", page: 1)
        serchTextField.delegate = self as! UITextFieldDelegate
        playTableView.dataSource = self as! UITableViewDataSource
        playTableView.delegate = self as! UITableViewDelegate
        playTableView.register(UINib.init(nibName: "MyTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "mycell")
        mjHeaderView.setRefreshingTarget(self, refreshingAction: #selector(self.headerRefresh))
              playTableView.mj_header = mjHeaderView
              mjFooterView.setRefreshingTarget(self, refreshingAction: #selector(self.footerRefresh))
              playTableView.mj_footer = mjFooterView
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func reloadData(serch:String,page:Int) {
       // 请求网络
        
        self.musicPresenter.getCache(by: serch, by: page)
        
     }
     
    // MARK:-EventTableView_header and footer
     @objc func headerRefresh(){
            print("下拉刷新")
        
         self.playTableView.mj_header.endRefreshing()
         self.playTableView.mj_footer.resetNoMoreData()
        limit = 1
        reloadData(serch: serchString, page: limit)
//
//         musicListplay.loadData(serchString: serchString, startNum: 0)
     }
     @objc func footerRefresh(){
         print("上拉刷新")
         if limit >= 8{
         playTableView.mj_footer.endRefreshingWithNoMoreData()
         
         }else{
            
         limit += 1
            
         reloadData(serch: serchString, page: limit)
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
//        self.playModel = musicListplay.arrMusicList![indexPath.row]
//        self.listTableView.mj_footer.resetNoMoreData()
//
//        self.playNewMusic(playurl: self.playModel.previewUrl!)
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
        cell.setup(titleName:oneModel.artistName! ,subtitleName:oneModel.country!)
        return cell

        }
    }
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          //收起键盘
          textField.resignFirstResponder()
          limit = 1
          playTableView.mj_footer.resetNoMoreData()

          if (serchString.count>0){
           serchString = textField.text ?? ""
            reloadData(serch: serchString, page: limit)
        }
          return true;
      }

    
}

