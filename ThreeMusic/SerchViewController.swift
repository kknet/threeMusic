//
//  SerchViewController.swift
//  ThreeMusic
//
//  Created by Chen Wei Wen on 15/11/2019.
//  Copyright © 2019 MvpProject. All rights reserved.
//

import UIKit

class SerchViewController: UIViewController {

    
    @IBAction func buttonBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
 
    override func viewDidLoad() {
        
        self.view.backgroundColor = .black
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
