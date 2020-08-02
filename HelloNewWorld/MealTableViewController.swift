//
//  MealTableViewController.swift
//  HelloNewWorld
//
//  Created by Andrew Allen on 28/07/2020.
//  Copyright © 2020 Andrew Allen. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {

    // MARK: Properties
    var meals = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // use the edit button provided by the table view controller
        navigationItem.leftBarButtonItem = editButtonItem
        
        // load the sample data
        loadSampleMeals()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // table view cells are reused and should be dequeued using a table cell view identifier
        let cellIdentifier = "MealTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else {
            fatalError("The dequeued cell is not an instance of a MealTableViewCell")
        }

        // fetches the appropriate meal for the data source layout
        let meal = meals[indexPath.row]
        
        // Configure the cell...
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Delete the row from the data source
            meals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class,
            // insert it into the array, and add a new row to the table view
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        // for debugging
        return true
    }
    // MARK: - Navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new meal", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            // set the meal for the `MealViewController` as the meal selected in the `MealTableViewController`
            os_log("Show detail of a meal", log: OSLog.default, type: .debug)
            
            guard let mealDetailViewController = segue.destination as? MealViewController else {
                fatalError("Unexpected destination, \(segue.destination)")
            }
            guard let selectedMealCell = sender as? MealTableViewCell else {
                fatalError("Unexpected sender, \(String(describing: sender))")
            }
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedMeal = meals[indexPath.row]
            mealDetailViewController.meal = selectedMeal
            
        default:
            fatalError("Unexpected Segue Identifier")
        }
    }

    // MARK: Actions
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        // get the source view and meal
        if let source = sender.source as? MealViewController,
         let meal = source.meal {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // update an existing meal
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
            } else {
                // add a new meal
                let newIndexPath = IndexPath(row: meals.count, section: 0)

                meals.append(meal)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
    
    // MARK: Private Methods
    private func loadSampleMeals() {
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")
        
        guard let meal1 = Meal.init(name: "Caprese Salad", photo: photo1, rating: 4) else {
            fatalError("Unable to instatiate meal1.")
        }
        guard let meal2 = Meal.init(name: "Chicken and potatoes", photo: photo2, rating: 5) else {
            fatalError("Unable to instatiate meal2.")
        }
        guard let meal3 = Meal.init(name: "Caprese Salad", photo: photo3, rating: 3) else {
            fatalError("Unable to instatiate meal3.")
        }
        
        meals += [meal1, meal2, meal3]
    }
}
