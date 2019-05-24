//
//  SignUpViewController.swift
//  Anywhere Fitness
//
//  Created by Michael Flowers on 5/21/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    var cc = ClientController()
//    var wc = WorkoutController()
    
    var client: Client? {
        didSet {
            print("client is set in the signup view controller")
        }
    }
    
    var isInstructor = false
    var hasTrainingCert = false

    //MARK: - Text Fields
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPwTF: UITextField!
    
    //MARK: - More IBOutlets
    @IBOutlet weak var switchProperties: UISwitch!
    @IBOutlet weak var cprButtonProperties: UIButton!
    @IBOutlet weak var trainingCertProperties: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cprButtonProperties.isEnabled = false
        trainingCertProperties.isEnabled = false
        
    }
    
    //MARK: - IBActions
    @IBAction func cprFirstAidButton(_ sender: UIButton) {
        //do something
    
    }
    
    @IBAction func trainingCertButton(_ sender: UIButton) {
        hasTrainingCert = true
    }
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            isInstructor = true
            cprButtonProperties.isEnabled = true
            trainingCertProperties.isEnabled = true
        } else {
            isInstructor = false
            cprButtonProperties.isEnabled = false
            trainingCertProperties.isEnabled = false
        }
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        guard let name = firstNameTF.text, !name.isEmpty, let lastName = lastNameTF.text, !lastName.isEmpty,let email = emailTF.text, !email.isEmpty, let password = confirmPwTF.text, !password.isEmpty else { return }
        
        let client = Client(username: name, password: password, instructor: switchProperties.isOn)
        
        cc.signIn(with: client) { (error) in
            if let error = error {
                print("Sign in did not work - function call: \(error.localizedDescription)")
                return
            }
            DispatchQueue.main.async {
                print("Sign in worked")
                self.view.backgroundColor = .magenta
                if client.instructor {
                    self.client = client
                    print("SIGN IN: insiide the dispatchQ trying to assign client who is instructor")

                    self.performSegue(withIdentifier: "InstructorSegue", sender: self)
                } else {
                    self.client = client
                    print("SIGN IN: insiide the dispatchQ trying to assign client who is instructor")

                    self.performSegue(withIdentifier: "ClientSegue", sender: self)
                }

            }
        }
    }
    
    @IBAction func signUPButtonPressed(_ sender: UIButton) {
        
        guard let name = firstNameTF.text, !name.isEmpty, let lastName = lastNameTF.text, !lastName.isEmpty,let email = emailTF.text, !email.isEmpty, let password = confirmPwTF.text, !password.isEmpty else { return }
        
        let client = Client(username: name, password: password, instructor: switchProperties.isOn)
        cc.signUp(client: client) { (error) in
            if let error = error {
                print("Error with signUp function call: \(error.localizedDescription)")
                return
            }
            DispatchQueue.main.async {
                print("Print It worked")
                self.view.backgroundColor = .green
                if self.isInstructor && self.hasTrainingCert {
                    self.client = client
                    print("insiide the dispatchQ trying to assign client who is instructor")
                    self.performSegue(withIdentifier: "InstructorSegue", sender: self)
                } else {
                    self.client = client
                    print("insiide the dispatchQ trying to assign client who is aint an instructor")
                    self.performSegue(withIdentifier: "ClientSegue", sender: self)
                }
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        //pass the client to the appropriate place
        if segue.identifier == "InstructorSegue" {
            guard let instructorVC = segue.destination as? InstructorHomeViewController, let client = client else {
                print("segue error going to instructor's side")
                return }
            instructorVC.client = client
//            instructorVC.wc = wc
            instructorVC.cc = cc
        }
        
        if segue.identifier == "ClientSegue" {
            guard let workoutListVC = segue.destination as? WorkoutListViewController, let client = client else {
                print("segue error going to client's side")
                return }
            workoutListVC.client = client
            workoutListVC.cc = cc
//            workoutListVC.wc = wc
        }
    }
   

}
