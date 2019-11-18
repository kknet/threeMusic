//
//  CoreDataManager.swift
//  ThreeMusic
//
//  Created by Chen Wei Wen on 18/11/2019.
//  Copyright © 2019 MvpProject. All rights reserved.
//

import CoreData
import UIKit

class CoreDataManager: NSObject {
    
    // 单例
    static let shared = CoreDataManager()
    
    // 拿到AppDelegate中创建好了的NSManagedObjectContext
    lazy var context: NSManagedObjectContext = {
        let context = ((UIApplication.shared.delegate) as! AppDelegate).context
        return context
    }()
    
    // 更新数据
    private func saveContext() {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    // 增加数据
    func savePersonWith(name: String, age: Int64) {
        let person = NSEntityDescription.insertNewObject(forEntityName: "Person", into: context) as! Person
        person.name = name
        person.age = age
        saveContext()
    }
    
    // 根据姓名获取数据
    func getPersonWith(name: String) -> [Person] {
        let fetchRequest: NSFetchRequest = Person.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        do {
            let result: [Person] = try context.fetch(fetchRequest)
            return result
        } catch {
            fatalError();
        }
    }
    
    // 获取所有数据
    func getAllPerson() -> [Person] {
        let fetchRequest: NSFetchRequest = Person.fetchRequest()
        do {
            let result = try context.fetch(fetchRequest)
            return result
        } catch {
            fatalError();
        }
    }
    
    // 根据姓名修改数据
    func changePersonWith(name: String, newName: String, newAge: Int64) {
        let fetchRequest: NSFetchRequest = Person.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        do {
            let result = try context.fetch(fetchRequest)
            for person in result {
                person.name = newName
                person.age = newAge
            }
        } catch {
            fatalError();
        }
        saveContext()
    }
    
    // 根据姓名删除数据
    func deleteWith(name: String) {
        let fetchRequest: NSFetchRequest = Person.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        do {
            let result = try context.fetch(fetchRequest)
            for person in result {
                context.delete(person)
            }
        } catch {
            fatalError();
        }
        saveContext()
    }
    
    // 删除所有数据
    func deleteAllPerson() {
        let result = getAllPerson()
        for person in result {
            context.delete(person)
        }
        saveContext()
    }
}
