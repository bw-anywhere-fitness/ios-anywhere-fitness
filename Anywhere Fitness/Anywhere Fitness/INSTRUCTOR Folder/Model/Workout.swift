//
//  Workout.swift
//  Anywhere Fitness
//
//  Created by Michael Flowers on 5/22/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

struct Workout: Codable {
    let location: Location
    let instructor: Instructor
    let punchPass: PunchPass?
    
    //a workout may or may not have clients signed up for it
    let clients: [Client]?
}
