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
    
    //MARK: - Task lists methods
    // cохраняем список задач
    func save(taskList: TaskList) {  //   try! realm.write {    realm.add(taskList) }
        write {
            realm.add(taskList)
        }
    }
    
    // работаем со списками
    func delete(taskList: TaskList) {
        write {
            let tasks = taskList.tasks// удаляемзадачу
            realm.delete(tasks)//удаляем задачу
            realm.delete(taskList)// удаляем список 
        }
        
        
    }
    // метод для редактирования
    
    func edit(taskList: TaskList, newValue: String) {
        
        write {
            taskList.name = newValue
        }
        
    }
    
    func done(taskList: TaskList) {
        write {
            taskList.tasks.setValue(true, forKey: "isComplete")
        }
    }
    
    
    
    //MARK: - Tasks  methods
    // метод для добавления задачи
    func save(task: Task, in taskList: TaskList) {
        write {
            taskList.tasks.append(task)
            }
        }
    
    // редактирование  и тд задачи
    
    func delete(task: Task) {
        write {
            realm.delete(task)
        }
    }
    
    func edit(task: Task, name: String, note: String) {
        write {
            task.name = name
            task.note = note
            
        }
        
        
    }
    
    func done(task: Task) {
        write {
            task.isComplete.toggle()
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















