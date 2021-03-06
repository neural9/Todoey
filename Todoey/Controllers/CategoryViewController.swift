//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Robert Ellis on 23/01/2019.
//  Copyright © 2019 Robert Ellis. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework



class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()

    var categories : Results<Category>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
        
        tableView.separatorStyle = .none
        
        
    }
    
    
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 1
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories yet"
        cell.backgroundColor = UIColor(hexString: categories?[indexPath.row].cellColour ?? "")

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "gotoItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories?[indexPath.row]
        }else{
            print ("ERROR - index row not found")
        }
    }
    
    
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            if (textField.text != nil)
            {
                let newCategory = Category()
                newCategory.name = textField.text!
                newCategory.cellColour = UIColor.randomFlat.hexValue()

                self.save(category: newCategory)
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    //MARK:- Data Manipulation Methods
    
    func save(category: Category)
    {
        do{
            
            try realm.write {
                realm.add(category)
            }
        }
        catch{
            print("ERROR SAVING CONTEXT, \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories(){
        
        categories = realm.objects(Category.self)
        
        self.tableView.reloadData()
    }
    
    
    override func updateModel(at indexPath: IndexPath) {
        if let cat = self.categories?[indexPath.row]
        {
            do{
                try self.realm.write{
                    self.realm.delete(cat)
                    print("deleted")
                }
            }
            catch{
                print("ERROR : failed deleting")
            }
        }
    }
    
    
}

