//
//  InstructorsAttendanceTableViewCell.swift
//  Anywhere Fitness
//
//  Created by Michael Flowers on 5/22/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class InstructorsAttendanceTableViewCell: UITableViewCell {

    var workout: Workout?
    var client: Client?
    var cc: ClientController?
    
    @IBOutlet weak var nameOfClientLabel: UILabel!
    @IBOutlet weak var hereButtonProperties: UIButton!
    @IBOutlet weak var paidButtonProperties: UIButton!

    @IBAction func attendenceButton(_ sender: UIButton) {
    }
    @IBAction func paidButtonPressed(_ sender: UIButton) {
        //ignore the paid button its a stretch
    }
    
    func udpateViews(){
        guard let client = client else { return }
        nameOfClientLabel.text = client.username
        
    }
    
}
