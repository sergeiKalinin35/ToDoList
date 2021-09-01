//
//  ViewController.swift
//  ToDoList
//
//  Created by Sergey on 28.08.2021.
//

import UIKit
import RealmSwift
class TaskListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
  
    
    @IBAction func addButtonPressed(_ sender: Any) {
         showAlert()
      }


      @IBAction func sortingList(_ sender: UISegmentedControl) {// сортировка данных
        
        taskLists = sender.selectedSegmentIndex == 0
            ? taskLists.sorted(byKeyPath: "name")
            : taskLists.sorted(byKeyPath: "date")
        
        tableView.reloadData()
    }

    @IBOutlet var tableView: UITableView!
    
    // данные отоброжаем в интерфейсе
    
    var taskLists: Results<TaskList>!//в методе viewDidload инициализируем этот объект
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskLists = StorageManager.shared.realm.objects(TaskList.self)// идем в дата соурсе
        // Кнопка работает из коробки и позволяет вызывать меню с лева
        self.navigationItem.leftBarButtonItem = editButtonItem
        
    }
    
    // обновление данных ячейки
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
    }
    
    
    
    
    
    
    
    // table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        taskLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath)
        
        let taskList = taskLists[indexPath.row]// извлекаем элемент по текущей строки, объект нашей модели
        
        var content = cell.defaultContentConfiguration()
        content.text = taskList.name
        
        // отоброжаем количество задач из realm
        content.secondaryText = "\(taskList.tasks.count)"
        
        // передаем контент
        cell.contentConfiguration = content
        
        
        
        return cell
    }
       
    // удаление справа на лево
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // извлекаем список tasks
        let taskList = taskLists[indexPath.row]
        
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
            
            StorageManager.shared.delete(taskList: taskList)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (_, _, isDone) in
            self.showAlert(with: taskList) {
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            isDone(true)
        }
           
        
        
        // создаем действие done action
        let doneAction = UIContextualAction(style: .normal, title: "Done") { (_, _, isDone) in
            StorageManager.shared.done(taskList: taskList)
            tableView.reloadRows(at: [indexPath], with: .automatic)
            isDone(true)
        }
        
        editAction.backgroundColor = .orange
        doneAction.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        
        
        // параметр isDone пора отпускть завершать взаимодействие с этой сторкой
        
        return UISwipeActionsConfiguration(actions: [doneAction, editAction, deleteAction]) // d массив передаем объекты этого типа
        
    }
    
    // переход на второй экран
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let taskList = taskLists[indexPath.row]
        let tasksVC = segue.destination as! TasksViewController
        tasksVC.taskList = taskList
    }
    
    
}
    extension TaskListViewController {
        
        
        
      // принять два параметра комплишен и тасклист
        private func showAlert(with taskList: TaskList? = nil, completion: (() -> Void)? = nil) {
            
            let title = taskList != nil ? "Edit List" : "New List"
            
            
            let alert = AlertController(title: title, message: "Please insert new value", preferredStyle: .alert)
            
            alert.action(with: taskList) { newValue in
                
                //редактировать  существующию задачу
                if let taskList = taskList, let copmletion = completion {
                    StorageManager.shared.edit(taskList: taskList, newValue: newValue)
                    copmletion()
                    
                } else {
                    
                    
                    let taskList = TaskList()
                    taskList.name = newValue
                    
                    
                    StorageManager.shared.save(taskList: taskList)// сохраняет данные в базеданных
                    
                    
                    
                    //визуально отобразить добавление  новой строки и отображение  внесенный пользователем значение
                    
                    let rowIndex = IndexPath(row: self.taskLists.count - 1 , section: 0)
                    self.tableView.insertRows(at: [rowIndex], with: .automatic)
                    
                     }
                
        }
            
           
            present(alert, animated:  true)
            
            
        }
        
    }
    





//    tableView.delegate = self
//    tableView.dataSource = self
    
    
    
//        // список
//        let shoppingList = TaskList()
//        shoppingList.name = "Shopping List"
//
//
//
//        //лучше так не писать
//        let moviesList = TaskList(value: ["Movies List", Date(), [["Best film ever"], ["The best of the best", "", Date(), true]]])
//
//
//        // объект задач
//
//        let milk = Task()
//        milk.name = "Milk"
//        milk.note = "2 Lt"
//
//
//        // можно использовать или массив или словарь
//        let bread = Task(value: ["Bread", "", Date(), true])
//        let apples = Task(value: ["name": "Apples", "isComplete": true])
//
//
//
//
//        //помещаем задачу в список
//
//        shoppingList.tasks.append(milk)
//        shoppingList.tasks.insert(contentsOf: [bread,apples], at: 1)
//
//        //сохраняем списки в базу данных в сторисМанаджер  и вызываем его
//        // выходим в основной поток через DispatchQueue
//
//        DispatchQueue.main.async {
//
//            StorageManager.shared.save(taskList: [shoppingList, moviesList])
//
//            }
//
//
//    }
    
 
    
    
    
    
    
    



    
    


