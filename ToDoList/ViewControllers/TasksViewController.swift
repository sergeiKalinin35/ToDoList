//
//  TasksViewController.swift
//  ToDoList
//
//  Created by Sergey on 28.08.2021.
//

import UIKit

class TasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var taskList: TaskList!
 
    

    @IBOutlet var tableViewC: UITableView!
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = taskList.name
        
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2" , for: indexPath)
        
        return cell
    }
    
    
    
 

}
