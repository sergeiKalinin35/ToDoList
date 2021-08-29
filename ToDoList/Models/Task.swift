//
//  Task.swift
//  ToDoList
//
//  Created by Sergey on 28.08.2021.
//

import RealmSwift

class Task: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var note = ""
    @objc dynamic var date = Date()
    @objc dynamic var  isComplete = false
    
    
}
