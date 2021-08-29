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
    func save(taskList: [TaskList]) {
        try! realm.write {
            realm.add(taskList)
            
        }
    }
    
}















