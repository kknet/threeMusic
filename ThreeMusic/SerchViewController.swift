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

    
    var dataArray: [Person] = [Person]()

       var dataModel = DataModel()
    let userDefault = UserDefaults()
    @IBAction func buttonBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBOutlet weak var userDefaultTextView: UITextView!

    @IBOutlet weak var userDefaultreadButton: UIButton!
    @IBOutlet weak var userDefaultButton: UIButton!
    @IBOutlet weak var userDefaultLabel: UILabel!
   
    
 
    override func viewDidLoad() {
        //keychain
        keychaintest()

        onCreateData()
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func coreDatereloadButtonCiclk(_ sender: Any) {
        
//        dataArray = CoreDataManager.shared.getAllPerson()
        dataArray = CoreDataManager.shared.getAllPerson()
        print("dataArray   = \(dataArray)")
        
    

        
    }
    @IBAction func coreDataAddButtonCiclk(_ sender: Any) {
        
        guard let nameString = userDefaultTextView.text else { return }
         let age = 10
        
        CoreDataManager.shared.savePersonWith(name: nameString, age: Int64(age))
        
        
    }
    @IBAction func coreDataDelButtonCiclk(_ sender: Any) {
        
        CoreDataManager.shared.deleteWith(name:userDefaultTextView.text )
           dataArray = CoreDataManager.shared.getAllPerson()
        print("dataArray   = \(dataArray)")

    }
   
    
    @IBAction func plistButtonWriteCiclk(_ sender: Any) {
        
        dataModel.saveData()
        print("保存成功!")
    }
    
    
    @IBAction func plistButtonreadCiclk(_ sender: Any) {

        dataModel.loadData()
        print("读取成功!", dataModel.userList)
        
        
    }
    func onCreateData(){
        dataModel.userList.append(UserInfo(name: "张三", phone: "1234"))
        dataModel.userList.append(UserInfo(name: "李四", phone: "1212"))
        dataModel.userList.append(UserInfo(name: "航歌", phone: "3525"))
    }
    
    
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
        

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
