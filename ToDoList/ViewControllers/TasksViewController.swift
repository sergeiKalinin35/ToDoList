//
//  TasksViewController.swift
//  ToDoList
//
//  Created by Sergey on 28.08.2021.
//

import UIKit
import RealmSwift

class TasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var taskList: TaskList!
 
    //две коллекции стипом резалс 1 невыполнимые вторая выполнимые
    
    var currentTasks: Results<Task>!
    var completedTasks: Results<Task>!
    

    @IBOutlet var tableViewC: UITableView!
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    title = taskList.name
        
        currentTasks = taskList.tasks.filter("isComplete = false")
        completedTasks = taskList.tasks.filter("isComplete = true")
        
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? currentTasks.count : completedTasks.count
    }
    // название для секции
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        section == 0 ? "CURRENT TASKS" : "COMPLETED TASKS"
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2" , for: indexPath)
        
        let task = indexPath.section == 0 ? currentTasks[indexPath.row] : completedTasks[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = task.name
        content.secondaryText = task.note
        cell.contentConfiguration = content
        
      return cell
    }
    
    
    private func addButtonPressed() {
        
        
    }
    
}




extension TasksViewController {
    
    private func showAlert() {
        
        let alert = AlertController(title: "New Task", message: "What do you want to do?", preferredStyle: .alert)
        alert.action { newValue in
            
    }
      
}

}
