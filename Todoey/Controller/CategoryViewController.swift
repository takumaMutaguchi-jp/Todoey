//
//  CategoryViewController.swift
//  Todoey
//
//  Created by 牟田口拓磨 on 2020/09/06.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    // MARK: - Properties
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }
    
    
    // MARK: - TableView DataSource Method
    // セクション数
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // セクション内セル数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    
    // セルの構築
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
    }
    

    // MARK: - TableView Delegate Method
    // セルが選択された時の処理
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }

    
    
    // MARK: - @IBAction
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { [self] (action) in
            
            let newCategory = Category(context : self.context)
            newCategory.name = textField.text
            self.categories.append(newCategory)
            
            self.saveCategories()
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            
            textField = field
            field.placeholder = "Add a new category"
            
        }
    
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Function
    // categoriesを保存
    func saveCategories() {
        
        do {
            try context.save()
        } catch {
            print("カテゴリーの保存エラー \(error)")
        }
        self.tableView.reloadData()
    }
    
    
    func loadCategories() {
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do {
            categories = try context.fetch(request)
        } catch {
            print("contextからカテゴリーデータの受信に失敗 \(error)")
        }
        tableView.reloadData()
        
    }
    

    
}
