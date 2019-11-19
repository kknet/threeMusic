//
//  SerchViewController.swift
//  ThreeMusic
//
//  Created by Chen Wei Wen on 15/11/2019.
//  Copyright © 2019 MvpProject. All rights reserved.
//

import UIKit
import Security
import CoreData



class SerchViewController: UIViewController ,UITextViewDelegate{

    
    var dataArray: [Person] = [Person]()
    var sqlArray   = [sqlModel]()
   
       var dataModel = DataModel()
    let userDefault = UserDefaults()
    @IBAction func buttonBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBOutlet weak var userDefaultTextView: UITextView!

    @IBOutlet weak var userDefaultreadButton: UIButton!
    @IBOutlet weak var userDefaultButton: UIButton!
    @IBOutlet weak var userDefaultLabel: UILabel!
   
    
 
    @IBOutlet weak var p_TableView: UITableView!
    override func viewDidLoad() {
        //keychain
        keychaintest()

        onCreateData()
        
        p_TableView.dataSource = self as? UITableViewDataSource
        p_TableView.delegate = self as? UITableViewDelegate
        p_TableView.register(UINib.init(nibName: "MyTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "mycell")
        
        userDefaultTextView.delegate = self
        sqltest()
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sqlReadButtonCiclk(_ sender: Any) {
          sqltest()
    
        p_TableView .reloadData()
    }
    @IBAction func sqldelButtonCiclk(_ sender: Any) {
    
    //SELECT * FROM vst_tvdata WHERE vst_cid&2 >= 2 order by vst_num asc
        let sql = "DELETE FROM vst_tvdata WHERE vst_vid =" + userDefaultTextView.text
        let db = getDb()
        db.open()
//        db.executeUpdate(sql, withArgumentsInArray: [10133])
//        db.executeUpdate(sql, withArgumentsIn: [10133])
        db.executeUpdate(sql, withArgumentsIn: [userDefaultTextView.text])
        db.close()
    
    }
    @IBAction func sqlAddButtonCiclk(_ sender: Any) {
        
        let sql="INSERT INTO vst_tvdata(vst_title,vst_vid,vst_hide,vst_cid)"+"VALUES(?,?,?,?)"
        let db = getDb()
        db.open()
        db.executeUpdate(sql, withArgumentsIn: ["vimen","10000",0,2])
        db.close()
        
        
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
    func getDb()->FMDatabase{
        
        let bundleDBPath:String? = Bundle.main.path(forResource: "xw", ofType: "db")

        print("bundleDBPath ==  \(bundleDBPath)")
             
        let fileManager = FileManager.default
        let file = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
      
        let fileName = "/wx.db"
        let path = file! + fileName
        print("path  \(path)")
//        fileManager.createFile(atPath: bundleDBPath, contents:nil, attributes:nil)

        if(fileManager.fileExists(atPath: path) == false ){
        do{
        try fileManager.copyItem(atPath: bundleDBPath!, toPath: path)
          print("Success to copy file.")
        }catch{
            print("Failed to copy file.")
            }
            
        }
        
        
//     let fileManager = FileManager.default
//             do{
//                 try fileManager.copyItem(atPath: sourceUrl, toPath: targetUrl)
//                 print("Success to copy file.")
//             }catch{
//                 print("Failed to copy file.")
//             }
     
    
        

         let feedlogDb = FMDatabase(path: path)

        return feedlogDb!
    }
    
    func sqltest()  {

        let db = getDb()
        db.open()
     
        let reddb2 :FMResultSet = (db.executeQuery("SELECT * FROM vst_tvdata WHERE vst_cid&2 >= 2 order by vst_num asc" , withArgumentsIn: []))!
//
        sqlArray.removeAll()
        print("reddb2  = \(reddb2)")
        while (reddb2.next()) {
            var model = sqlModel()
            model.vst_title = reddb2.string(forColumn: "vst_title")
            model.vst_vid  = reddb2.string(forColumn: "vst_vid")
            model.vst_hide = reddb2.string(forColumn: "vst_hide")
            model.vst_cid = reddb2.string(forColumn: "vst_cid")
            sqlArray.append(model)
            print("vst_title  \(model.vst_title )")
        }
        db.close()
//        sqlDb.close()


        
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
            userDefaultTextView.resignFirstResponder()

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


// MARK:- UITableViewDataSource
 extension SerchViewController: UITableViewDataSource {

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
      let counts = self.sqlArray.count
      
        return counts
        
    }
     
     func tableView(_ tableView:UITableView, heightForRowAt indexPath:IndexPath) ->CGFloat {
               
        return MyTableViewCell.height

      
     }
         
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
         let oneModel = self.sqlArray[indexPath.row]
         guard let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.identifier) as? MyTableViewCell else { return UITableViewCell() }
         cell.setup(titleName:oneModel.vst_title!,subtitleName:oneModel.vst_vid!)
         return cell

         }
     }
 
extension SerchViewController: UITableViewDelegate {

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    print("\(indexPath.row)")
//    self.model = arrMusicList![indexPath.row]
//    self.playView.isHidden  = false
//    self.presenter.showMusicPlay()
}

}
extension SerchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          //收起键盘
          textField.resignFirstResponder()
    
          return true;
      }

    
}


