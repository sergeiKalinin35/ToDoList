//
//  Task.swift
//  ToDoList
//
//  Created by Sergey on 28.08.2021.
//

import RealmSwift
// модель данных связана с Realm данные на прямую не меняются //только в приложении  Realm

class Task: Object {
    @objc dynamic var name = ""
    @objc dynamic var note = ""
    @objc dynamic var date = Date()
    @objc dynamic var  isComplete = false
    
    
}


class TaskList: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var date = Date()
    
    let tasks = List<Task>()
}











