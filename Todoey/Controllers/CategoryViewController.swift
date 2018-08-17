//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Allen Hou on 8/8/18.
//  Copyright © 2018 nEmmY. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var catagories : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        
    }
    //Mark: - Tableview Datasource methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = catagories?[indexPath.row]
        cell.textLabel?.text = category?.name ?? "No Categories added"
        //cell.textLabel?.text = categoryArray[indexPath.row].name
        //^same code
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catagories?.count ?? 1 //the 'Nil Coalescing Operator'
    }
    
    //Mark: - TableView Delagate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = catagories?[indexPath.row]
        }
    }
    
    //Mark: - Data manipulation methods
    //save
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving context \(error)")
        }
        tableView.reloadData()
    }
    //load
    func loadCategories() {
        catagories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    //Mark: - addButtonPressed
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (alert) in
            let newCategory = Category()
            if textField.text != "" {
                newCategory.name = textField.text!
                self.save(category: newCategory)
            } else {
                print("empty textfield")
                }
            }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }

    
}
