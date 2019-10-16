//
//  CategoryViewController.swift
//  Todoey
//
//  Created by William Watkins on 14/10/2019.
//  Copyright © 2019 William Watkins. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()

    }

    //MARK: - TableView Datasource Methods
      override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return categories.count
      }
      override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
          
          cell.textLabel?.text = categories[indexPath.row].name
          
          return cell
      }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }

    //MARK: - UIButton: new category
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add category", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text
            self.categories.append(newCategory)
            
            self.saveCategories()
           
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
    func saveCategories() {
        
        do{
            try context.save()
        }   catch {
            print("Error saving category \(error)")
        }
        tableView.reloadData()
    }
    
    //MARK: - Decoding Data
    //CRUD - Read - This method loads the data from the container
    func loadCategories() {
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do {
            categories = try context.fetch(request)
        } catch {
            print("Error loading categories \(error)")
            
        }
        tableView.reloadData()
    }
}

