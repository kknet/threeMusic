//
//  ViewController.swift
//  ThreeMusic
//
//  Created by Vimen.chen on 2019/11/7.
//  Copyright © 2019 MvpProject. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var musicPresenter =  MusicPresenter<ViewController>()
    

    @IBOutlet weak var playTableView: UITableView!
    override func viewDidLoad() {
        reloadData()

        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func reloadData() {
       // 请求网络
        self.musicPresenter.getCache(by: "vi", by: 1)
     }
     


}
extension ViewController: MusicProtocol {
    func onGetCacheSuccess(model: [Modelclass]?) {
        print(" mode = \(model)")
        
    }
    
    func onGetCacheFailure(error: Error) {
    
        dump(error)

    }
    

}

