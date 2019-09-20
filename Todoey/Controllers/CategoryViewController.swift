 //
//  CategoryViewControllerTableViewController.swift
//  Todoey
//
//  Created by ogi on 2019/09/19.
//  Copyright © 2019 Taichi. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext // for CoreData

    let realm = try! Realm()

    var categories: Results<Category>?

    
    override func viewDidLoad() {
        super.viewDidLoad()

       loadCategories()
    }

    // MARK: - TableView Datasource  method ++++++++++++++++++++++++++++++++++++++++++

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No category is added yet"
        
        return cell
    }
    
    //MARK: - TableView Delegate method +++++++++++++++++++++++++++++++++++++++++++++++
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    } 

    //MARK: - Data Manipulation method +++++++++++++++++++++++++++++++++++++++++++++++++
    
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category: \(error)")
        }
        
        tableView.reloadData() // call TableViewDatasource and TableViewDelegate method again
    }
    
    func loadCategories() {
        categories = realm.objects(Category.self).sorted(byKeyPath: "name", ascending: true)
        
        tableView.reloadData()
    }

    
    //MARK: - Add new category +++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textFiled = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Create new category "
            textFiled = alertTextfield
        }
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textFiled.text!
            
            self.save(category: newCategory)
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
 }
