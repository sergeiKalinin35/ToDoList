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
        
       
        
        
        // вызываем метод при нажатие на кнопку добавить
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        
        //добавляем кнопки в бар  navigationInavigationItem
        navigationItem.rightBarButtonItems = [addButton, editButtonItem]
        
        
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
    
    // удаление справа на лево
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // извлекаем список tasks
        let task = indexPath.section == 0 ? currentTasks[indexPath.row] : completedTasks[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
            StorageManager.shared.delete(task: task)
           tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (_, _, isDone) in
            self.showAlert(with: task) {
               tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            
            
            isDone(true)
        }
           
        
        let title = indexPath.section == 0 ? "Done" : "Undone"
        // создаем действие done action
        let doneAction = UIContextualAction(style: .normal, title: title) { [self] (_, _, isDone) in
       
            StorageManager.shared.done(task: task)
            
            
            
         // перемищение строк анимированно
            
            let indexPathForCurrentTask = IndexPath(row: self.currentTasks.count - 1, section: 0)// последняя строка с первой секции
            
            let indexPathCompletedTask = IndexPath(row: self.completedTasks.count - 1, section: 1)// последняя строка из второй секции
            
            let destinationIndexRow = indexPath.section == 0 ? indexPathCompletedTask : indexPathForCurrentTask// индекс места назначения
            
            tableView.moveRow(at: indexPath, to: destinationIndexRow)
            
            isDone(true)
        }
        
        editAction.backgroundColor = .orange
        doneAction.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        
        
        // параметр isDone пора отпускть завершать взаимодействие с этой сторкой
        
        return UISwipeActionsConfiguration(actions: [doneAction, editAction, deleteAction]) // d массив передаем объекты этого типа
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @objc private func addButtonPressed() {
        showAlert()
        
        
    }
    
}




extension TasksViewController {
    
    private func showAlert(with task: Task? = nil, completion: (() -> Void)? = nil ) {
        
        let title = task != nil ? "Edit Task" : "New Task"
        
        let alert = AlertController(title: title, message: "What do you want to do?", preferredStyle: .alert)
        alert.action(with: task) { newValue, note in
            
            if let task = task, let completion = completion {
                
                StorageManager.shared.edit(task: task, name: newValue, note: note)
                completion()
                
                
            } else {
                
                let task = Task(value: [newValue, note])
                StorageManager.shared.save(task: task, in: self.taskList)
                let rowIndex = IndexPath(row: self.currentTasks.count - 1, section: 0)
                self.tableViewC.insertRows(at: [rowIndex], with: .automatic)
                
            }
            
            
            
            
      
    }
      
        present(alert, animated: true)
}

}
