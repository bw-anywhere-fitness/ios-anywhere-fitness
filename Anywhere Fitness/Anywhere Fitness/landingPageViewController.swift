//
//  landingPageViewController.swift
//  Anywhere Fitness
//
//  Created by Michael Flowers on 5/21/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class landingPageViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var trainerCodeTF: UITextField!
    @IBOutlet weak var signInProperties: UIButton!
    @IBOutlet weak var signUPProperties: UIButton!
    
    
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
    
    //MARK: - IBActions
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        //CHECK TO SEE IF TEXTFIELDS ARE ENTERED, CHECK THE ENTERED DATA, ONCE CHECKED AND CONFIRMED SEGUE TO "COLLECTION VIEW OF CLASSES"
        
    }
    @IBAction func signInButtonPressed(_ sender: UIButton) {
       //REALLY DON'T NEED THIS BUTTON. WHEN PRESSED IT WILL SEGUE TO THE SIGNUP SCENE
        
    }
    
}
