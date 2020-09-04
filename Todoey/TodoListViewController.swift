//
//  ViewController.swift
//  Todoey
//
//  Created by 牟田口拓磨 on 2020/08/29.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    // MARK: - Properties
    let itemArray = ["Find Mike", "Buy Eggos", "Destory Demogorgon"]

    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    // MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
        
    }
    
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        } else {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}

