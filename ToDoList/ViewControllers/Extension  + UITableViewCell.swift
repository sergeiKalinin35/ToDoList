//
//  Extension  + UITableViewCell.swift
//  ToDoList
//
//  Created by Sergey on 01.09.2021.
//

import UIKit

 // выполнение задач чек бокс
extension UITableViewCell {
    func configure(with taskList: TaskList) {
        let currentTasks = taskList.tasks.filter("isComplete = false")
        let completedTasks = taskList.tasks.filter("isComplete = true")
        
        var content = defaultContentConfiguration()
        
        content.text = taskList.name
        
        if !currentTasks.isEmpty {
         
            content.secondaryText = "\(currentTasks.count)"
            accessoryType = .none
        } else if !completedTasks.isEmpty {
            
            content.secondaryText = nil
            accessoryType = .checkmark // нужно обнулять чекмарк
            
        } else {
            accessoryType = .none
            content.secondaryText = "0"
            
        }
        
        contentConfiguration = content
        
    }
}












