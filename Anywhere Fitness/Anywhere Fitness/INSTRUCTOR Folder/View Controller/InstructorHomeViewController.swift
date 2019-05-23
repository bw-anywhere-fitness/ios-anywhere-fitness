//
//  InstructorHomeViewController.swift
//  Anywhere Fitness
//
//  Created by Michael Flowers on 5/22/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class InstructorHomeViewController: UIViewController {
    
    //MARK: - Properties
    var client: Client? {
        didSet {
            print("client was passed through/in and junk.")
        }
    }
    var cc: ClientController? {
        didSet {
            print("ClientController was set.")
        }
    }
    
    //MARK: - IBOutlets
    @IBOutlet weak var yourClassProperties: UIButton!
    @IBOutlet weak var addANewClassProperties: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - IBActions
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
            guard let yourClassVC = segue.destination as? YourClassTableViewController, let client = client, let cc = cc else { return }
            yourClassVC.client = client
            yourClassVC.cc = cc
        }
        
        if segue.identifier == "AddClassSegue" {
            guard let addClassVC = segue.destination as? AddClassViewController, let client = client, let cc = cc else { return }
            addClassVC.client = client
            addClassVC.cc = cc
        }
        
    }
    
    
}
