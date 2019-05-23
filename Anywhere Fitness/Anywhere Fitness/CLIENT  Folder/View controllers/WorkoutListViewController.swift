//
//  WorkoutListViewController.swift
//  Anywhere Fitness
//
//  Created by Michael Flowers on 5/22/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class WorkoutListViewController: UIViewController {

    var client: Client? {
        didSet {
            print("this client was set")
        }
    }
    
    var cc: ClientController? {
        didSet {
            print("client controller was set also.")
        }
    }
    
    var wc: WorkoutController? {
        didSet {
            print("Workout controller was set toooooo. ")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
