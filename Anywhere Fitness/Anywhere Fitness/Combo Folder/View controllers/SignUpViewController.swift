//
//  SignUpViewController.swift
//  Anywhere Fitness
//
//  Created by Michael Flowers on 5/21/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    
    //MARK: - Text Fields
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPwTF: UITextField!
    
    
    
    
    //MARK: - More IBOutlets
    @IBOutlet weak var switchProperties: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func testButton(_ sender: UIButton) {
        guard let name = firstNameTF.text, !name.isEmpty, let password = confirmPwTF.text, !password.isEmpty else { return }
       
        
    }
    
    //MARK: - IBActions
    @IBAction func switchValueChanged(_ sender: UISwitch) {
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func confirmButtonPressed(_ sender: UIButton) {
        
        //TAKES YOU BACK TO THE LANDING PAGE SO THAT THE USER CAN SIGNIN
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
