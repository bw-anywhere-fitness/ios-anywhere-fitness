//
//  YourClassTableViewController.swift
//  Anywhere Fitness
//
//  Created by Michael Flowers on 5/22/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class YourClassTableViewController: UITableViewController {
    
//    private var workouts: [Workout]? {
//        didSet {
//            print("this was set also")
//        }
//    }
    
    var client: Client? {
        didSet {
            print("client was set boi")
        }
    }
    
    var cc: ClientController? {
        didSet {
            print("ClientController was set.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        getWorkouts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cc?.wc.workouts.count ?? 0
//       return workouts?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "yourClassCell", for: indexPath)
        
        // Configure the cell...
        guard let workout = cc?.wc.workouts[indexPath.row] else { return UITableViewCell() }
//        guard let workout = workouts?[indexPath.row] else { return UITableViewCell() }
        cell.textLabel?.text = workout.name
        cell.detailTextLabel?.text = workout.location
//        cell.textLabel?.text = "test"
//        cell.detailTextLabel?.text = "more tests"
     
        return cell
    }
    
    
//    func getWorkouts(){
//        guard let cc = cc, let myclient = client else { return }
//        cc.wc.fetchClassesBy(instructor: myclient) { (workouts, error) in
//            if let error = error {
//                print("Error fetching classes in YourClassTableViewController: \(error.localizedDescription)")
//                return
//            }
//
//            self.workouts = workouts ?? []
//            print("YourClassTableViewController workouts returned: \(self.workouts)")
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//
//        }
//    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CellSegue" {
            guard let destinationVc = segue.destination as? DetailYourClassTableViewController, let cc = cc, let client = client, let index = tableView.indexPathForSelectedRow else { return }
            let workoutToPass = cc.wc.workouts[index.row]
            destinationVc.cc = cc
            destinationVc.client = client
            destinationVc.workout = workoutToPass
        }
    }
   

}
