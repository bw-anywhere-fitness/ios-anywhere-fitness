//
//  InstructorHomeViewController.swift
//  Anywhere Fitness
//
//  Created by Michael Flowers on 5/22/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class InstructorHomeViewController: UIViewController {

    var client: Client? {
        didSet {
            print("client was passed through/in and junk.")
        }
    }
    var wc: WorkoutController? {
        didSet {
            print("workoutController was set.")
        }
    }
    
    @IBOutlet weak var yourClassProperties: UIButton!
    @IBOutlet weak var addANewClassProperties: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func segueToYourClass(_ sender: UIButton) {
        if client == nil {
            print("Client is empty")
            return
        } else {
            performSegue(withIdentifier: "YourClassSegue", sender: self)
        }
    }
    
    @IBAction func segueToAddClass(_ sender: UIButton) {
        if client == nil {
            print("Client is empty")
            return
        } else {
            performSegue(withIdentifier: "AddClassSegue", sender: self)
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "YourClassSegue" {
            guard let yourClassVC = segue.destination as? YourClassTableViewController, let client = client else { return }
            yourClassVC.client = client
        }
        
        if segue.identifier == "AddClassSegue" {
            guard let addClassVC = segue.destination as? AddClassViewController, let client = client else { return }
            addClassVC.client = client
        }
        
    }
    

}
