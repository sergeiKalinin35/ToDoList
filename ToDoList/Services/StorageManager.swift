//
//  StorageManager.swift
//  ToDoList
//
//  Created by Sergey on 29.08.2021.
//

import RealmSwift

class StorageManager {
    
    static let shared = StorageManager()
    
    //точка входа в базу
     let realm = try! Realm()
    
    private init() {}
    
    // объявляем публичные методы
    
    // cохраняем список задач
    func save(taskList: TaskList) {
        write {
            realm.add(taskList)
        }
        
       //   try! realm.write {
     //       realm.add(taskList)
            
     //   }
    }
    
    // метод для добавления задачи
    func save(task: Task, in taskList: TaskList) {
        write {
            taskList.tasks.append(task)
            
        }
        
    }
    
    
    
    
    
    
    private func write(_ completion: () -> Void) {
        
        do {
        
            try realm.write {
                
            completion()
            
            
            }
        } catch let error {
            
            print(error)
        }
        
        
    }
 
}















