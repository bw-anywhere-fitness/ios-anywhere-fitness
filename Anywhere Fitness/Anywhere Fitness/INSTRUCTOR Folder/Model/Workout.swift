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
    let instructorId: Int?  //api doc has instructor_id will have to use decodingKeys
    
//    //a workout may or may not have clients signed up for it
    let punchPass: PunchPass?
    let clients: [Client]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case schedule
        case location
        case image
        case instructorId = "instructor_id"
        case punchPass
        case clients
    }
}

extension Workout: Equatable {
    static func == (lhs: Workout, rhs: Workout) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.instructorId == rhs.instructorId
    }
    
    
}
