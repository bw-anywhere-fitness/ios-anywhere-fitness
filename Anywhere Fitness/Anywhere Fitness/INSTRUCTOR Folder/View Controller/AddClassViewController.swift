//
//  AddClassViewController.swift
//  Anywhere Fitness
//
//  Created by Michael Flowers on 5/22/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class AddClassViewController: UIViewController {
    
    var client: Client? {
        didSet {
            print("AddClassViewController: Client was set")
        }
    }
    
    var cc: ClientController? {
        didSet {
            print("ClientController was set.")
        }
    }
    
    //MARK: IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var classNameTF: UITextField!
    @IBOutlet weak var typeOfClassTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - IBActions
    @IBAction func addPhoto(_ sender: UIButton) {
        guard let cc = cc, let myClient = client else { return }
        
//        cc.wc.fetchClasses { (workouts, error) in
//            if let error = error {
//                print("Error pulling down workouts by client ID : \(error.localizedDescription)")
//                return
//            }
//
//            DispatchQueue.main.async {
//                print("These are the workouts we got back :\(workouts)")
//                self.view.backgroundColor = .magenta
//            }
//        }
        
        cc.wc.fetchClassesBy(instructor: myClient) { (workouts, error) in
            if let error = error {
                print("Error pulling down workouts by client ID : \(error.localizedDescription)")
                return
            }

            DispatchQueue.main.async {
                print("These are the workouts we got back :\(workouts)")
                self.view.backgroundColor = .magenta
            }
        }
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
    }
    
    @IBAction func saveEverything(_ sender: UIButton) {
        guard let className = classNameTF.text, !className.isEmpty, let type = typeOfClassTF.text, !type.isEmpty, let location = locationTF.text, !location.isEmpty, let cc = cc else {
            print("Problem with the guard let.")
            return }
        let workout = cc.wc.createClass(id: nil, name: className, schedule: "Tuesday Morning", location: location, image: nil, instructorId: client?.id, punchPass: nil, clients: nil)
        
        
        cc.wc.postClass(with: workout) { (error) in
            if let error = error {
                print("Error trying to post class in AddClassViewcontroller: \(error.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async {
                print("Workout Saved worked")
                self.view.backgroundColor = .magenta
                self.cc?.wc.workouts.append(workout)
            }
        }
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
