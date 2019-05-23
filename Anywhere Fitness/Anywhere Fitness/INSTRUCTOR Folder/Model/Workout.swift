//
//  Workout.swift
//  Anywhere Fitness
//
//  Created by Michael Flowers on 5/22/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

struct Workout: Codable {
    let id: Int?
    let name: String
    let schedule: String
    let location: String
    let image: String?
    let instructorID: Int?  //api doc has instructor_id will have to use decodingKeys
    
//    //a workout may or may not have clients signed up for it
    let punchPass: PunchPass?
    let clients: [Client]?
}

extension Workout: Equatable {
    static func == (lhs: Workout, rhs: Workout) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.instructorID == rhs.instructorID && lhs.type == rhs.type
    }
    
    
}
