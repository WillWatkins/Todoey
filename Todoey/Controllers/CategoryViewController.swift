//
//  CategoryViewController.swift
//  Todoey
//
//  Created by William Watkins on 14/10/2019.
//  Copyright © 2019 William Watkins. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {

    let realm = try! Realm()
    
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()

    }

    //MARK: - TableView Datasource Methods
      override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return categories?.count ?? 1
        
      }
    
    
      override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
          
          cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added yet"
          
          return cell
      }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }

    //MARK: - UIButton: new category
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add category", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            self.save(category: newCategory)
           
        }
    
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new Category"
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        }
    
    //MARK: - Encoding Data
    //CRUD -Create- This method saves the created items in the container
    func save(category: Category) {
        
        do{
            try realm.write {
                realm.add(category)
            }
        }   catch {
            print("Error saving category \(error)")
        }
        tableView.reloadData()
    }
    
    //MARK: - Decoding Data
    //CRUD - Read - This method loads the data from the container
    func loadCategories() {
      
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }
}

