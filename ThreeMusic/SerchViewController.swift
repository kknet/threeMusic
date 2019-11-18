//
//  SerchViewController.swift
//  ThreeMusic
//
//  Created by Chen Wei Wen on 15/11/2019.
//  Copyright © 2019 MvpProject. All rights reserved.
//

import UIKit
//import Security
import Security
import CoreData



class SerchViewController: UIViewController {

    
    let userDefault = UserDefaults()
    @IBAction func buttonBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBOutlet weak var userDefaultTextView: UITextView!

    @IBOutlet weak var userDefaultreadButton: UIButton!
    @IBOutlet weak var userDefaultButton: UIButton!
    @IBOutlet weak var userDefaultLabel: UILabel!
    @IBAction func fileMButtonRead(_ sender: Any) {
        
               let manager = FileManager.default
                   let urlsForDocDirectory = manager.urls(for: .documentDirectory, in:.userDomainMask)
                   let docPath = urlsForDocDirectory[0]
                   let file = docPath.appendingPathComponent("vimen.txt")
                   let readHandler = try! FileHandle(forReadingFrom:file)
                   let data = readHandler.readDataToEndOfFile()
                   let readString = String(data: data, encoding: String.Encoding.utf8)
//                   print("文件内容: \(readString)")
             userDefaultLabel.text =  readString
    }
    @IBAction func fileMButtonWrite(_ sender: Any) {
        

        let filePath:String = NSHomeDirectory() + "/Documents/vimen.txt"

        print("filePath  \(filePath)")
       
        let info = userDefaultTextView.text

        try! info?.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf8)

        
    }
    @IBAction func fileMButtonAdd(_ sender: Any) {
        
        let manager = FileManager.default
        let urlsForDocDirectory = manager.urls(for:.documentDirectory, in:.userDomainMask)
        let docPath = urlsForDocDirectory[0]
        let file = docPath.appendingPathComponent("vimen.txt")
        let string = userDefaultTextView.text
        let appendedData = string?.data(using: String.Encoding.utf8, allowLossyConversion: true)
        let writeHandler = try? FileHandle(forWritingTo:file)
        writeHandler!.seekToEndOfFile()
        writeHandler!.write(appendedData!)

        
    
    
    }
    
     func getContext()->NSManagedObjectContext{
            //获取总代理
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            //获取托管对象总管
            //let managedObjectContect = appDelegate.persistentContainer.viewContext
            //返回托管对象总管
            return appDelegate.persistentContainer.viewContext
    
    }
    @IBAction func userDefaultbutton(_ sender: Any) {
            userDefault.setValue(userDefaultTextView.text, forKey: "Message")
    }
    @IBAction func readButtonCiclk(_ sender: Any) {
        
        userDefaultLabel.text  = userDefault.value(forKey: "Message") as? String
    }
    
    func keychaintest()  {
        // 存储数据
        let saveBool = KeychainManager.keyChainSaveData(data: "我期待的女孩" as Any, withIdentifier: "123")
        if saveBool {
            print("存储成功")
        }else{
            print("存储失败")
        }
        // 获取数据
        let getString = KeychainManager.keyChainReadData(identifier: "123") as! String
        print(getString)


        // 更新数据
        let updataBool = KeychainManager.keyChainUpdata(data: "眼睛像云朵", withIdentifier: "123")
        if updataBool {
            print("更新成功")
        }else{
            print("更新失败")
        }
        // 获取更新后的数据
        let getUpdataString = KeychainManager.keyChainReadData(identifier: "123") as! String
        print(getUpdataString)
        // 删除数据
        KeychainManager.keyChianDelete(identifier: "123")
        // 获取删除后的数据
        let getDeleteString = KeychainManager.keyChainReadData(identifier: "123")
        print(getDeleteString)
    }
    
    
 
    override func viewDidLoad() {
        //keychain
        keychaintest()
        
        // Save Data to Disk
        
//         let manager = FileManager.default
//
//        let urlForDocument = manager.urls(for: .documentDirectory, in:.userDomainMask)
//
//        let url = urlForDocument[0] as URL
//
//        print(url)

//        let fileManager = FileManager.default


        
        

        
  
//
//        //        （2）把图片保存到文件路径下
//
//
//
//                let filePath = NSHomeDirectory() + "/Documents/hangge.png"
//
//                let image = UIImage(named: "apple.png")
//
//                let data:Data = UIImagePNGRepresentation(image!)!
//
//                try? data.write(to: URL(fileURLWithPath: filePath))
//
//
//
//        //        （3）把NSArray保存到文件路径下
//
//
//
//                let array = NSArray(objects: "aaa","bbb","ccc")
//
//                let filePath:String = NSHomeDirectory() + "/Documents/array.plist"
//
//                array.write(toFile: filePath, atomically: true)
//
//
//
//        //        （4）把NSDictionary保存到文件路径下
//
//
//
//                let dictionary:NSDictionary = ["Gold": "1st Place", "Silver": "2nd Place"]
//
//                let filePath:String = NSHomeDirectory() + "/Documents/dictionary.plist"
//
//                dictionary.write(toFile: filePath, atomically: true)
//
//
 
        
//          let urlForDocument = manager.urls(for: .documentDirectory, in: .userDomainMask)
//
//                let url = urlForDocument[0] as NSURL
//
//                    createFolder(name: "folder", baseUrl: url)
//        creat("folder", url)
    
        
        
        
        
        
        
        
        
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
