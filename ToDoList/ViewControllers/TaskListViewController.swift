//
//  ViewController.swift
//  ToDoList
//
//  Created by Sergey on 28.08.2021.
//

import UIKit
import RealmSwift
class TaskListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
  
    

    

    
    @IBOutlet var tableView: UITableView!
    
    // данные отоброжаем в интерфейсе
    
    var taskLists: Results<TaskList>!//в методе viewDidload инициализируем этот объект
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskLists = StorageManager.shared.realm.objects(TaskList.self)// идем в дата соурсе
        
        
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
        
    // переход на второй экран
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let taskList = taskLists[indexPath.row]
        let tasksVC = segue.destination as! TasksViewController
        tasksVC.taskList = taskList
    }
    
    
}
//    extension TaskListViewController {
   //     private func showAlert() {
   //         let alert = AlertController(title: "New List", message: "Please insert new value", preferredStyle: .alert)
            
    //        alert.actionWIthTaskList { newValue in
                
     //           }
            
   //         else
  //      }
        
        
        
//    }
    





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
    
 
    
    
    
    
    
    


///   @IBAction func addButtonPressed(_ sender: Any) {
//     showAlert()
//  }


//  @IBAction func sortingList(_ sender: UISegmentedControl) {

//}
    
    


