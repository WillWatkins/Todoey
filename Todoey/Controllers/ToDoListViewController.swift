//
//  ViewController.swift
//  Todoey
//
//  Created by William Watkins on 05/10/2019.
//  Copyright © 2019 William Watkins. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(dataFilePath)
        
        
        loadItems()

    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
    //MARK - Ternary Operator
        // value = condition? ValueIFTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    //This allows a checkmark to be added and removed
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        self.saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - Add new items
    
    
    @IBAction func addButtonPressed1(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //what will happen once the user clicks the add item button on our UIAlert
            //Below allows you to add a new item to the itemArray using the append feature
            //Then once it is added, you need to reloadData() to update the tableView
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveItems()
          
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK - Encoding data
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print ("Error encoding item array, \(error)")
        }
        self.tableView.reloadData()
    }
    
    //MARK - Decoding data
    func loadItems() {
        if let data =  try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error \(error)")
            }
            }
    }
    
    
}

