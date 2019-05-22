//
//  Instructor.swift
//  Anywhere Fitness
//
//  Created by Michael Flowers on 5/22/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

struct Instructor: Codable {
    //does everything below here have to be on the api documentation for parsing purposes?

    let username: String
    let password: String
    let id: Int?
    let instructor: Bool
    let workouts: [Workout]?
}
